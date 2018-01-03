package org.datanewsstudio.www.textanalyzer.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.Sort;
import org.apache.lucene.search.highlight.*;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.datanewsstudio.www.textanalyzer.model.FileUploadResponse;
import org.datanewsstudio.www.textanalyzer.model.NlpResult;
import org.datanewsstudio.www.textanalyzer.model.SearchResult;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import java.io.*;
import java.nio.file.Path;
import java.util.*;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

@Service
public class TextAnalyzeService {

    private static final Logger LOGGER = Logger.getLogger(TextAnalyzeService.class);

    /**
     * 进程池大小
     */
    private static final int POOL_SIZE = 1;

    /**
     * 查询每页返回结果数
     */
    private static final int RESULT_PER_PAGE = 10;

    /**
     * 创建Map用于保存"lang->进程池"的映射关系
     */
    private static Map<String, BlockingQueue<Process>> pyQueue;

    /**
     * 保存词法分析器对象
     */
    private static Map<String, Analyzer> analyzers;

    /**
     * 开始分析文本，保存结果，并通知执行情况
     *
     * @param sessionData 将处理结果存储到Map里
     * @param file 要分析的文本文件
     * @param lang 分析使用的语言，支持的种类见 src/webapp/WEB-INF/nlp_system 下的目录名
     * @return 返回执行情况
     */
    public FileUploadResponse analyze(Map<String, NlpResult> sessionData, File file, String lang) throws InterruptedException, IOException {
        //判断指定语言的分析器是否存在
        if(pyQueue.containsKey(lang)){
            //从进程池中请求一个处理程序
            LOGGER.info("Request process '" + lang + "' for " + file.getName());
            Process process = pyQueue.get(lang).take();

            OutputStream writer = process.getOutputStream();
            Scanner reader = new Scanner(process.getInputStream(),"utf-8");
            writer.write((file.getAbsolutePath()+"\n").getBytes());
            writer.flush();
            JSONObject result;
            try{
                result = JSON.parseObject(reader.nextLine());
            }catch (NoSuchElementException e){
                return new FileUploadResponse(FileUploadResponse.Code.FORMAT_ERROR, file.getName());
            }

            //归还处理程序
            LOGGER.info("Return process '" + lang + "'.");
            pyQueue.get(lang).put(process);

            FileUploadResponse.Code code = FileUploadResponse.Code.getCode(result.getIntValue("code"));

            //成功则将结果存入sessionData
            if(code == FileUploadResponse.Code.SUCCESS){
                JSONObject data = result.getJSONObject("data");
                JSONArray keywords = data.getJSONArray("keywords");
                NlpResult.Keyword[] keywordArray = new NlpResult.Keyword[keywords.size()];
                for(int i = 0; i < keywords.size(); i++){
                    JSONObject jo = (JSONObject) keywords.get(i);
                    keywordArray[i] = new NlpResult.Keyword(jo.getString("word"), jo.getDoubleValue("frequency"));
                }
                sessionData.put(result.getString("name"),
                        new NlpResult(data.getString("title"),
                                data.getString("time"),
                                data.getString("abstract"),
                                keywordArray,
                                data.getDoubleValue("sentiment")));
            }
            return new FileUploadResponse(code, result.getString("name"));
        }else{  //不存在指定语言的分析程序
            return new FileUploadResponse(FileUploadResponse.Code.UNKNOWN_LANG, lang);
        }
    }

    /**
     * 获取对应语言的词法分析器
     *
     * @param lang 分析使用的语言，支持的种类见 src/webapp/WEB-INF/nlp_system 下的目录，
     *             每个语言种类目录中的 analyzer.lucene 文件中存储对应的词法分析类路径
     * @return 该语言的词法分析器，如果 analyzer.lucene 文件不存在，或发生其他异常，返回{@link StandardAnalyzer}的对象
     */
    public Analyzer getLuceneAnalyzer(String lang){
        if(analyzers.containsKey(lang)){
            return analyzers.get(lang);
        }else{
            return new StandardAnalyzer();
        }
    }

    /**
     * 对指定文件建立索引并写入IndexWriter
     *
     * @param indexWriter 要写入索引的IndexWriter
     * @param file 要建立索引的文件
     */
    public void indexFile(IndexWriter indexWriter, File file){
        BufferedReader reader = null;
        try {
            reader = new BufferedReader(new FileReader(file));
            String title = reader.readLine();
            String time = reader.readLine();
            StringBuilder content = new StringBuilder();
            String buf;
            while((buf = reader.readLine())!=null){
                content.append(buf).append("\n");
            }
            if(title == null || time == null){
                LOGGER.error("File " + file.getAbsolutePath() + " format error, skip indexing.");
            }else{
                Document doc = new Document();
                doc.add(new Field("title", HtmlUtils.htmlEscape(title), TextField.TYPE_STORED));
                doc.add(new Field("time", HtmlUtils.htmlEscape(time), TextField.TYPE_STORED));
                doc.add(new Field("content", HtmlUtils.htmlEscape(content.toString()), TextField.TYPE_STORED));
                doc.add(new Field("filename", HtmlUtils.htmlEscape(file.getName()), TextField.TYPE_STORED));
                indexWriter.addDocument(doc);
            }
        } catch (IOException e) {
            LOGGER.error("An error occurred while reading file: " + file.getAbsolutePath() + ", skip indexing.", e);
        }finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    LOGGER.error("An error occurred while closing file: " + file.getAbsolutePath(), e);
                }
            }
        }
    }

    public List<SearchResult> search(Path indexPath, String keyword, int page, String lang){
        List<SearchResult> result = new ArrayList<>();
        DirectoryReader reader = null;
        Directory fsDirectory = null;
        try {
            //读取索引
            Analyzer analyzer = getLuceneAnalyzer(lang);
            fsDirectory = FSDirectory.open(indexPath);
            reader = DirectoryReader.open(fsDirectory);
            IndexSearcher searcher = new IndexSearcher(reader);

            //创建查询语句
            QueryParser parser = new QueryParser(null, analyzer);
            String escapeKeyword = "\"" + QueryParser.escape(keyword) + "\"";
            Query query = parser.parse("title:"+escapeKeyword+" OR time:"+escapeKeyword+" OR content:"+escapeKeyword);

            //着色
            SimpleHTMLFormatter simpleHTMLFormatter = new SimpleHTMLFormatter("<span class='text-danger'>", "</span>");
            Highlighter highlighter = new Highlighter(simpleHTMLFormatter, new QueryScorer(query));
            highlighter.setTextFragmenter(new SimpleFragmenter(200));

            //查询
            ScoreDoc[] hits;
            if(page < 1){
                return result;
            }else if(page == 1){
                hits = searcher.search(query, RESULT_PER_PAGE, Sort.RELEVANCE).scoreDocs;
            }else{
                ScoreDoc[] lastDocs = searcher.search(query, RESULT_PER_PAGE * (page - 1), Sort.RELEVANCE).scoreDocs;
                hits = searcher.searchAfter(lastDocs[lastDocs.length-1], query, RESULT_PER_PAGE, Sort.RELEVANCE).scoreDocs;
            }

            //遍历命中结果
            for(ScoreDoc hit : hits){
                Document doc = searcher.doc(hit.doc);
                String title = highlighter.getBestFragment(analyzer, "title", doc.getField("title").stringValue());
                String time = highlighter.getBestFragment(analyzer,"time",doc.getField("time").stringValue());
                String content = highlighter.getBestFragment(analyzer,"content",doc.getField("content").stringValue());
                if(title == null)
                    title = doc.getField("title").stringValue();
                if(time == null)
                    time = doc.getField("time").stringValue();
                SearchResult item = new SearchResult(title, time, content, doc.getField("filename").stringValue());
                result.add(item);
            }
        } catch (IOException e) {
            LOGGER.error("Failed to open Lucene Index File: index.lucene.", e);
        } catch (ParseException e) {
            LOGGER.error("Failed to parse query.", e);
        } catch (InvalidTokenOffsetsException e) {
            LOGGER.error("Failed to get fragments of result.", e);
        } finally {
                try {
                    if(reader != null)
                        reader.close();
                    if(fsDirectory != null)
                        fsDirectory.close();
                } catch (IOException e) {
                    LOGGER.error("An error occurred while closing DirectoryReader or FSDirectory.", e);
                }
        }
        return result;
    }

    @SuppressWarnings("ConstantConditions")
    @PostConstruct
    private void init() throws IOException, InterruptedException {
        LOGGER.info("Initializing TextAnalyzerService...");

        pyQueue = new HashMap<>();
        analyzers = new HashMap<>();

        //获取WEB-INF/nlp_system目录下所有文件(目录)lang
        File[] nlpSystemFiles = new File(getClass().getClassLoader().getResource("../nlp_system").getPath()).listFiles();
        for(File nlpLang : nlpSystemFiles){
            //创建分析进程
            BlockingQueue<Process> queue = new ArrayBlockingQueue<>(POOL_SIZE);
            for(int i = 0; i < POOL_SIZE; i++){
                queue.put(Runtime.getRuntime().exec("python -u "+nlpLang.getAbsolutePath()+"/main.py"));
                LOGGER.info("Create process lang: " + nlpLang.getName() + "/" + i);
            }
            pyQueue.put(nlpLang.getName(), queue);

            //初始化词法分析器
            Analyzer analyzer = new StandardAnalyzer();
            File analyzerFile = new File(nlpLang, "analyzer.lucene");
            if(analyzerFile.exists()){
                BufferedReader reader = null;
                String content = "<Unknown Class>";
                try {
                    //读取文件内容
                    reader = new BufferedReader(new FileReader(analyzerFile));
                    content = reader.readLine();

                    //反射获取类
                    Class analyzerClass = Class.forName(content);
                    Object obj = analyzerClass.newInstance();
                    if(obj instanceof Analyzer){
                        analyzer = (Analyzer) obj;
                        LOGGER.info("Create analyzer " + content +".");
                    }else{
                        LOGGER.error("Class " + content + " is not a subclass of org.apache.lucene.analysis.Analyzer.");
                    }
                } catch (IOException e) {
                    LOGGER.error("an error occurred while reading analyzer.lucene.", e);
                } catch (ClassNotFoundException e) {
                    LOGGER.error("Class " + content + " not found.", e);
                } catch (IllegalAccessException e) {
                    LOGGER.error("Nullary constructor of Class " + content + " is not accessible.", e);
                } catch (InstantiationException e) {
                    LOGGER.error("Class " + content + " has no nullary constructor.", e);
                } finally {
                    if(reader != null)
                        reader.close();
                }
            }else{
                LOGGER.warn("File " + analyzerFile.getAbsolutePath() + " not exists, use StandardAnalyzer instead.");
            }
            analyzers.put(nlpLang.getName(), analyzer);
        }
        LOGGER.info("Initialized TextAnalyzerService.");
    }

    @PreDestroy
    private void destroy() throws InterruptedException {
        LOGGER.info("Destroying TextAnalyzerService...");
        Set<Map.Entry<String, BlockingQueue<Process>>> entries = pyQueue.entrySet();
        for(Map.Entry<String, BlockingQueue<Process>> entry : entries){
            int count = 0;
            while(!entry.getValue().isEmpty()){
                entry.getValue().take().destroy();
                LOGGER.info("Killed process lang: " + entry.getKey() + "/" + count++);
            }
        }
        LOGGER.info("Destroyed TextAnalyzerService.");
    }
}
