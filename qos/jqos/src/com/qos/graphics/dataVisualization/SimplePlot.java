package com.qos.graphics.dataVisualization;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.jfree.ui.ApplicationFrame;
import org.jfree.ui.RefineryUtilities;

/**
 * Copyright 2017 Yulin Wu, University of Science and Technology of China.
 * mail4ywu@gmail.com/mail4ywu@icloud.com
 * Created on 26/05/2017.
 */
public class SimplePlot extends ApplicationFrame{
    private XYSeriesCollection data;
    public String xLabel;
    public String yLabel;
    public String chartTitle;

    public SimplePlot(String xLabel, String yLabel, String frameTitle, String chartTitle){
        super(frameTitle);
        this.xLabel = xLabel;
        this.yLabel = yLabel;
        this.chartTitle = chartTitle;
        data = new XYSeriesCollection();
    }
    public void addDataSet(float[] y){
        float[] x = new float[y.length];
        for (int i=0; i < y.length; i++){
            x[i] = i + 1;
        }
        addDataSet(x, y, "");
    }
    public void addDataSet(double[] y){
        double[] x = new double[y.length];
        for (int i=0; i < y.length; i++){
            x[i] = i + 1;
        }
        addDataSet(x, y, "");
    }
    public void addDataSet(float[] y, String legend){
        float[] x = new float[y.length];
        for (int i=0; i < y.length; i++){
            x[i] = i + 1;
        }
        addDataSet(x, y, legend);
    }
    public void addDataSet(double[] y, String legend){
        double[] x = new double[y.length];
        for (int i=0; i < y.length; i++){
            x[i] = i + 1;
        }
        addDataSet(x, y, legend);
    }
    public void addDataSet(float[] x, float[] y){
        addDataSet(x, y, "");
    }
    public void addDataSet(double[] x, double[] y){
        addDataSet(x, y, "");
    }
    public void addDataSet(float[] x, float[] y, String legend){
        XYSeries series = new XYSeries(legend);
        int i;
        for (i=0;i<x.length;i++){
            series.add(x[i], y[i]);
        }
        this.data.addSeries(series);
    }
    public void addDataSet(double[] x, double[] y, String legend){
        XYSeries series = new XYSeries(legend);
        int i;
        for (i=0;i<x.length;i++){
            series.add(x[i], y[i]);
        }
        this.data.addSeries(series);
    }
    public void plot(){
        JFreeChart chart = ChartFactory.createXYLineChart(
                chartTitle,xLabel,yLabel,
                data,PlotOrientation.VERTICAL,
                true, true, false);
        ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));
        setContentPane(chartPanel);

        pack();
        RefineryUtilities.centerFrameOnScreen(this);
        setVisible(true);
    }
    /*
    public SimplePlot(double[] x, double[] y){
        super("Simple Plot");
        String legend = "";
        XYSeries series = new XYSeries(legend);
        int i;
        for (i=0;i<x.length;i++){
            series.add(x[i], y[i]);
        }
        XYSeriesCollection data = new XYSeriesCollection(series);
        JFreeChart chart = ChartFactory.createXYLineChart(
                "Simple Plot",
                "X",
                "Y",
                data,
                PlotOrientation.VERTICAL,
                true,
                true,
                false
        );
        ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));
        setContentPane(chartPanel);
    }
    public SimplePlot(double[] x, double[] y, String legend){
        super("Simple Plot");
        XYSeries series = new XYSeries(legend);
        int i;
        for (i=0;i<x.length;i++){
            series.add(x[i], y[i]);
        }
        XYSeriesCollection data = new XYSeriesCollection(series);
        JFreeChart chart = ChartFactory.createXYLineChart(
                "Simple Plot",
                "X",
                "Y",
                data,
                PlotOrientation.VERTICAL,
                true,
                true,
                false
        );
        ChartPanel chartPanel = new ChartPanel(chart);
        chartPanel.setPreferredSize(new java.awt.Dimension(500, 270));
        setContentPane(chartPanel);
    }
    private void makePlot(){

    }
    */
}
