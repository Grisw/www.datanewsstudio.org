package org.datanewsstudio.www.textanalyzer.model;

import java.io.Serializable;

public class NlpResult implements Serializable {
    private String title;
    private String time;
    private String abstracts;
    private Keyword[] keywords;
    private double sentiment;

    public NlpResult(String title, String time, String abstracts, Keyword[] keywords, double sentiment) {
        this.title = title;
        this.time = time;
        this.abstracts = abstracts;
        this.keywords = keywords;
        this.sentiment = sentiment;
    }

    public double getSentiment() {
        return sentiment;
    }

    public void setSentiment(double sentiment) {
        this.sentiment = sentiment;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Keyword[] getKeywords() {
        return keywords;
    }

    public void setKeywords(Keyword[] keywords) {
        this.keywords = keywords;
    }

    public static class Keyword implements Serializable{
        private String word;
        private double frequency;

        public Keyword(String word, double frequency) {
            this.word = word;
            this.frequency = frequency;
        }

        public double getFrequency() {
            return frequency;
        }

        public void setFrequency(double frequency) {
            this.frequency = frequency;
        }

        public String getWord() {
            return word;
        }

        public void setWord(String word) {
            this.word = word;
        }
    }
}
