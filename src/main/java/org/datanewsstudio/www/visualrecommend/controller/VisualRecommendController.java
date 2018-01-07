package org.datanewsstudio.www.visualrecommend.controller;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/visual_recommend")
public class VisualRecommendController {
    private static final Logger LOGGER = Logger.getLogger(VisualRecommendController.class);

    @RequestMapping(method = RequestMethod.GET)
    public String index() {
        return "visual_recommend/index";
    }

}
