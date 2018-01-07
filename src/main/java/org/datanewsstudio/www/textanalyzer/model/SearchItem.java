package org.datanewsstudio.www.textanalyzer.model;

import java.io.Serializable;

public class SearchItem implements Serializable {
    private String title;
    private String time;
    private String content;
    private String filename;
    private String[] keywords;
    private double sentiment;

    public SearchItem(String title, String time, String content, String filename, String[] keywords, double sentiment) {
        this.title = title;
        this.time = time;
        this.content = content;
        this.filename = filename;
        this.keywords = keywords;
        this.sentiment = sentiment;
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

    public String[] getKeywords() {
        return keywords;
    }

    public void setKeywords(String[] keywords) {
        this.keywords = keywords;
    }

    public double getSentiment() {
        return sentiment;
    }

    public void setSentiment(double sentiment) {
        this.sentiment = sentiment;
    }
}
