package org.datanewsstudio.www.textanalyzer.controller;

import org.apache.log4j.Logger;
import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.datanewsstudio.www.common.FileSystem;
import org.datanewsstudio.www.textanalyzer.model.FileUploadResponse;
import org.datanewsstudio.www.textanalyzer.model.NlpResult;
import org.datanewsstudio.www.textanalyzer.model.SearchResult;
import org.datanewsstudio.www.textanalyzer.service.TextAnalyzeService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyEmitter;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.*;

@Controller
@RequestMapping("/text_analyzer")
public class TextAnalyzerController {

    private static final Logger LOGGER = Logger.getLogger(TextAnalyzerController.class);

    /**
     * 上传文件存放位置
     */
    private static final String UPLOAD_PATH = "C:\\Users\\MissingNo\\IdeaProjects\\www.datanewsstudio.org\\upload\\";

    @Resource
    private TextAnalyzeService textAnalyzeService;

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "text_analyzer/index";
    }

    @RequestMapping(value = "/analyze", method = RequestMethod.POST)
    public ResponseBodyEmitter analyze(final HttpSession session,
                                       @RequestParam("files") final MultipartFile[] files,
                                       @RequestParam("lang") final String lang) {
        //使用ResponseBodyEmitter以随时通知浏览器上传和分析进度
        final ResponseBodyEmitter emitter = new ResponseBodyEmitter();

        new Thread(new Runnable() {
            public void run() {
                if(files != null && files.length > 0 && lang != null){
                    //清除旧数据
                    session.removeAttribute("data");

                    //以sessionId为区分用户的标识
                    //也用于区分上传的文件，即放到以sessionId为名的目录
                    String sessionId = session.getId();
                    File directory = new File(UPLOAD_PATH + sessionId);

                    //判断directory是否是目录
                    //如果是则先清空
                    //否则创建一个
                    if(directory.isDirectory()){
                        File errorFile = FileSystem.removeDirectory(directory);
                        if(errorFile != null){
                            LOGGER.error("Failed to delete file: " + errorFile.getAbsolutePath());
                            emitter.complete();
                            return;
                        }
                    }else{
                        if(!directory.mkdir()){
                            LOGGER.error("Failed to create directory: " + directory.getAbsolutePath());
                            emitter.complete();
                            return;
                        }
                    }

                    //初始化搜索引擎索引信息
                    Analyzer analyzer = textAnalyzeService.getLuceneAnalyzer(lang);
                    IndexWriterConfig config = new IndexWriterConfig(analyzer);
                    Directory fsDirectory;
                    IndexWriter indexWriter;
                    try {
                        fsDirectory = FSDirectory.open(Paths.get(directory.getAbsolutePath(),"index.lucene"));
                        indexWriter = new IndexWriter(fsDirectory, config);
                    } catch (IOException e) {
                        LOGGER.error("Failed to create Lucene Index File: index.lucene.", e);
                        emitter.complete();
                        return;
                    }

                    //用于保存分析结果
                    Map<String, NlpResult> sessionData = new HashMap<>();

                    try{
                        //开始处理上传的文件
                        for (MultipartFile file : files) {
                            String fileName = file.getOriginalFilename();

                            //文件后缀名验证
                            //只能上传txt文件
                            if(fileName.endsWith(".txt")){
                                File transferredFile = new File(directory, fileName);
                                try {
                                    //转移文件
                                    file.transferTo(transferredFile);
                                } catch (IOException ignore) {
                                    try {
                                        emitter.send(new FileUploadResponse(FileUploadResponse.Code.UPLOAD_FAILED, fileName));
                                    } catch (IOException e) {
                                        LOGGER.error("Emit message failed.", e);
                                        emitter.complete();
                                        return;
                                    }
                                }   //转移结束

                                //建立索引
                                textAnalyzeService.indexFile(indexWriter, transferredFile);

                                //开始分析
                                try {
                                    emitter.send(textAnalyzeService.analyze(sessionData, transferredFile, lang));
                                } catch (IOException e) {
                                    LOGGER.error("Emit message failed.", e);
                                    emitter.complete();
                                    return;
                                } catch (InterruptedException e) {
                                    LOGGER.error("Analyze failed.", e);
                                    emitter.complete();
                                    return;
                                }
                            }else{  //若后缀不是txt
                                try {
                                    emitter.send(new FileUploadResponse(FileUploadResponse.Code.TYPE_ERROR, fileName));
                                } catch (IOException e) {
                                    LOGGER.error("Emit message failed.", e);
                                    emitter.complete();
                                    return;
                                }
                            }
                        }
                    }finally {
                        //存储并关闭IndexWriter和Directory
                        try {
                            indexWriter.commit();
                            indexWriter.close();
                            fsDirectory.close();
                        } catch (IOException e) {
                            LOGGER.error("An error occurred while closing IndexWriter.", e);
                        }
                    }

                    //设置session
                    session.setAttribute("data", sessionData);
                }else{  //参数错误
                    try {
                        if(lang == null){
                            emitter.send(new FileUploadResponse(FileUploadResponse.Code.PARAM_ERROR, "lang"));
                        }else{
                            emitter.send(new FileUploadResponse(FileUploadResponse.Code.PARAM_ERROR, "files"));
                        }
                    } catch (IOException e) {
                        LOGGER.error("Emit message failed.", e);
                        emitter.complete();
                        return;
                    }
                }
                emitter.complete();
            }
        }).start();

        return emitter;
    }

    @RequestMapping(value = "/result", method = RequestMethod.GET)
    public ModelAndView result(HttpSession session){
        //如果不存在session则返回404页面
        if(session.getAttribute("data") == null){
            return new ModelAndView("text_analyzer/404");
        }

        ModelAndView mv = new ModelAndView("text_analyzer/result");
        Map<String, NlpResult> sessionData = (Map<String, NlpResult>) session.getAttribute("data");
        Collection<NlpResult> nlpResults = sessionData.values();

        //用于计算平均词频，[0]表示统计词频，[1]表示统计次数
        Map<String, double[]> _keywords = new HashMap<>();
        //散点图和玫瑰图数据。[0]: time, [1]: sentiment, [2]: title.
        List<String[]> scatters = new ArrayList<>();
        for(NlpResult i : nlpResults){
            //统计Keywords
            for(NlpResult.Keyword keyword : i.getKeywords()){
                if(_keywords.containsKey(keyword.getWord())){
                    double[] freq = _keywords.get(keyword.getWord());
                    freq[0] += keyword.getFrequency();
                    freq[1]++;
                }else{
                    _keywords.put(keyword.getWord(), new double[]{keyword.getFrequency(), 1});
                }
            }

            //散点和玫瑰数据
            scatters.add(new String[]{i.getTime(), i.getSentiment()+"", i.getTitle()});
        }

        //平均词频
        Map<String, Double> keywords = new HashMap<>();
        Set<Map.Entry<String, double[]>> entries = _keywords.entrySet();
        for(Map.Entry<String, double[]> entry : entries){
            keywords.put(entry.getKey(), entry.getValue()[0] / entry.getValue()[1]);
        }

        mv.addObject("keywords",keywords);
        mv.addObject("scatters",scatters);
        return mv;
    }

    @RequestMapping(value = "/search", method = RequestMethod.GET)
    public ModelAndView search(HttpSession session,
                               @RequestParam("keyword") String keyword,
                               @RequestParam("page") int page,
                               @RequestParam("lang") String lang){
        //如果不存在session则返回404页面
        if(session.getAttribute("data") == null){
            return new ModelAndView("text_analyzer/404");
        }

        List<SearchResult> resultList = textAnalyzeService.search(Paths.get(UPLOAD_PATH + session.getId(),"index.lucene"), keyword, page, lang);

        for (SearchResult searchResult : resultList){
            LOGGER.info(searchResult.getTitle() + "/" + searchResult.getTime() + "/" + searchResult.getContent() + "/" + searchResult.getFilename());
        }
        return new ModelAndView("text_analyzer/index");//TODO 这里需要返回带结果的ModelAndView
    }
}
