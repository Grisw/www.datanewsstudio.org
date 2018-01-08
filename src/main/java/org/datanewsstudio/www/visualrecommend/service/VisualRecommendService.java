package org.datanewsstudio.www.visualrecommend.service;

import com.alibaba.fastjson.JSONArray;
import org.apache.log4j.Logger;
import org.datanewsstudio.www.common.Utils;
import org.datanewsstudio.www.visualrecommend.model.Recommendation;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class VisualRecommendService {

    private static final Logger LOGGER = Logger.getLogger(VisualRecommendService.class);

    /**
     * 获取推荐图表数据及图表推荐排序
     *
     * @param originData 原始数据，从Handsontable传入。
     * @return 图表推荐数据及排序
     */
    public Recommendation getRecommendation(JSONArray originData){
        //整理数据
        List<String> axisData = new ArrayList<>();
        List<double[]> processedData = new ArrayList<>();
        try{
            for(int i = 0; i < originData.size(); i++){
                JSONArray iArray = originData.getJSONArray(i);
                if(i == 0){
                    //第一行是坐标轴
                    for(int j = 0; j < iArray.size(); j++){
                        if(iArray.getString(j) != null && !iArray.getString(j).trim().isEmpty()){
                            axisData.add(iArray.getString(j));
                        }else{
                            break;
                        }
                    }
                }else{
                    //第二行以后是数据
                    double[] data = new double[axisData.size()];
                    boolean isAllNull = true;
                    for(int j = 0; j < axisData.size(); j++){
                        if(iArray.getString(j) != null && !iArray.getString(j).trim().isEmpty()){
                            isAllNull = false;
                            try{
                                data[j] = Double.parseDouble(iArray.getString(j));
                            }catch (NumberFormatException e){
                                return null;
                            }
                        }else{
                            data[j] = 0;
                        }
                    }
                    if(isAllNull){
                        break;
                    }else{
                        processedData.add(data);
                    }
                }
            }
        }catch (Exception ignore){
            //格式错误
            return null;
        }

        //推荐算法
        Map<String, Integer> types = new HashMap<>();
        types.put("bar", 0);
        types.put("line", 0);
        types.put("scatter", 0);
        types.put("pie", 0);
        if (processedData.size() == 1) {
            double[] data = processedData.get(0);

            //只有出现一个Y值的情况
            types.put("bar", types.get("bar"));
            types.put("line", types.get("line"));
            types.put("pie", types.get("pie") + 3);
            types.put("scatter", types.get("scatter") + 2);

            //求出所有数字的总和
            double total = 0;
            for (double aData : data) {
                total += aData;
            }
            //总和等于100或者总和等于1，是饼状图一个非常重要的特征
            if (total == 100 || total == 1) {
                types.put("bar", types.get("bar"));
                types.put("line", types.get("line"));
                types.put("pie", types.get("pie") + 2);
                types.put("scatter", types.get("scatter"));
            }
        }

        //超过10个数据
        if (axisData.size() >= 10) {
            types.put("bar", types.get("bar"));
            types.put("line", types.get("line") + 2);
            types.put("pie", types.get("pie"));
            types.put("scatter", types.get("scatter") + 2);
        }

        //如果X维度是数字
        boolean isDigits = true;
        for(String x : axisData){
            try{
                Double.parseDouble(x);
            }catch (NumberFormatException ignore){
                isDigits = false;
                break;
            }
        }
        if(isDigits){
            types.put("bar", types.get("bar"));
            types.put("line", types.get("line") + 2);
            types.put("pie", types.get("pie"));
            types.put("scatter", types.get("scatter") + 2);
        }

        //如果X维度是时间
        boolean isTime = true;
        for(String x : axisData){
            if(!Utils.isDateFormat(x)){
                isTime = false;
                break;
            }
        }
        if(isTime){
            types.put("bar", types.get("bar"));
            types.put("line", types.get("line") + 1);
            types.put("pie", types.get("pie"));
            types.put("scatter", types.get("scatter") + 1);
        }

        //对推荐图表列表按权值排序
        List<Map.Entry<String, Integer>> entries = new ArrayList<>(types.entrySet());
        Collections.sort(entries, new Comparator<Map.Entry<String, Integer>>() {
            @Override
            public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                return o2.getValue().compareTo(o1.getValue());
            }
        });
        String[] recommendList = new String[entries.size()];
        for(int i = 0; i < entries.size(); i++){
            recommendList[i] = entries.get(i).getKey();
        }

        return new Recommendation(recommendList, axisData, processedData);
    }
}
