package org.datanewsstudio.www.textanalyzer.model;

import java.io.Serializable;

public class SearchResult implements Serializable {
    private String title;
    private String time;
    private String content;
    private String filename;

    public SearchResult(String title, String time, String content, String filename) {
        this.title = title;
        this.time = time;
        this.content = content;
        this.filename = filename;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
}
