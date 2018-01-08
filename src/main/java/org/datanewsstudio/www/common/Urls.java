package org.datanewsstudio.www.common;

public abstract class Urls {

    public static final String index = "index.jsp";

    public static abstract class TextAnalyzer {
        public static final String index = "text_analyzer";
        public static final String analyze = "text_analyzer/analyze";
        public static final String result = "text_analyzer/result";
        public static final String search = "text_analyzer/search";
        public static final String content = "text_analyzer/content";
    }

    public static abstract class VisualRecommend {
        public static final String index = "visual_recommend";
        public static final String charts = "visual_recommend/charts";
    }

    public static abstract class EventMap {
        public static final String index = "todo";
    }
}
