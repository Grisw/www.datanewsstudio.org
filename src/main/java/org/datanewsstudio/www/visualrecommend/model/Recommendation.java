package org.datanewsstudio.www.visualrecommend.model;

import java.io.Serializable;
import java.util.List;

public class Recommendation implements Serializable {

    private String[] chartTypes;
    private List<String> axisData;
    private List<double[]> data;

    public Recommendation(String[] chartTypes, List<String> axisData, List<double[]> data) {
        this.chartTypes = chartTypes;
        this.axisData = axisData;
        this.data = data;
    }

    public String[] getChartTypes() {
        return chartTypes;
    }

    public void setChartTypes(String[] chartTypes) {
        this.chartTypes = chartTypes;
    }

    public List<String> getAxisData() {
        return axisData;
    }

    public void setAxisData(List<String> axisData) {
        this.axisData = axisData;
    }

    public List<double[]> getData() {
        return data;
    }

    public void setData(List<double[]> data) {
        this.data = data;
    }
}
