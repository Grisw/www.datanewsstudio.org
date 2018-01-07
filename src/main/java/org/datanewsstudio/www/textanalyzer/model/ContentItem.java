package org.datanewsstudio.www.textanalyzer.model;

import java.io.Serializable;

public class ContentItem implements Serializable {

    public enum Code{
        UNKNOWN_ERROR(-1, "Unknown error."),
        SUCCESS(0, "Success."),
        DATA_NOT_FOUND(1, "Data not found, please upload again."),
        FILE_NOT_FOUND(2, "File not found, this file may be not uploaded.");

        private int code;
        private String message;

        Code(int code, String message) {
            this.code = code;
            this.message = message;
        }

        public int getCode() {
            return code;
        }

        public String getMessage() {
            return message;
        }
    }

    private int code;
    private String message;
    private Object object;

    public ContentItem(Code code, String title, String time, String content, String abstracts, String[] keywords) {
        this.code = code.getCode();
        this.message = code.getMessage();
        object = new InternalObject(title, time, abstracts, content, keywords);
    }

    public ContentItem(Code code) {
        if(code == null || code == Code.SUCCESS){
            this.code = Code.UNKNOWN_ERROR.getCode();
            this.message = Code.UNKNOWN_ERROR.getMessage();
        }else{
            this.code = code.getCode();
            this.message = code.getMessage();
        }
        object = null;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }

    private class InternalObject{
        private String title;
        private String time;
        private String abstracts;
        private String content;
        private String[] keywords;

        private InternalObject(String title, String time, String abstracts, String content, String[] keywords) {
            this.title = title;
            this.time = time;
            this.abstracts = abstracts;
            this.content = content;
            this.keywords = keywords;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getAbstracts() {
            return abstracts;
        }

        public void setAbstracts(String abstracts) {
            this.abstracts = abstracts;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public String[] getKeywords() {
            return keywords;
        }

        public void setKeywords(String[] keywords) {
            this.keywords = keywords;
        }
    }
}
