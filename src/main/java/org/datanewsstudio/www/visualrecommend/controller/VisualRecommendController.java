package org.datanewsstudio.www.visualrecommend.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import org.apache.log4j.Logger;
import org.datanewsstudio.www.visualrecommend.model.Recommendation;
import org.datanewsstudio.www.visualrecommend.service.VisualRecommendService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

@Controller
@RequestMapping("/visual_recommend")
public class VisualRecommendController {
    private static final Logger LOGGER = Logger.getLogger(VisualRecommendController.class);

    @Resource
    private VisualRecommendService visualRecommendService;

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "visual_recommend/index";
    }

    @RequestMapping(value = "/charts", method = RequestMethod.POST)
    public ModelAndView charts(@RequestParam String data){
        JSONArray array;
        try{
            array = JSON.parseArray(data);
        }catch (Exception e){
            return new ModelAndView("404");
        }

        Recommendation recommendation = visualRecommendService.getRecommendation(array);
        if(recommendation == null)
            return new ModelAndView("404");
        ModelAndView mv = new ModelAndView("visual_recommend/charts");
        mv.addObject("recommendation", recommendation);
        return mv;
    }
}
