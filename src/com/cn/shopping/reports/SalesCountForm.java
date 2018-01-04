package com.cn.shopping.reports;

import java.awt.Font;  
import java.awt.RenderingHints;  
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.util.Introspection;
import org.jfree.chart.*;  
import org.jfree.chart.ChartFrame;  
import org.jfree.chart.ChartUtilities;  
import org.jfree.chart.JFreeChart;  
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;  
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.renderer.category.StandardBarPainter;
import org.jfree.chart.title.TextTitle;  
import org.jfree.data.category.CategoryDataset;  
import org.jfree.data.category.DefaultCategoryDataset;

import com.cn.shopping.Product;
import com.cn.shopping.util.DB; 

public class SalesCountForm {
	
	public  static void getData() {
		 CategoryDataset dataset = getDataSet();  
		 
		   // 创建主题样式
	        StandardChartTheme standardChartTheme = new StandardChartTheme("CN");
	        // 设置标题字体
	        standardChartTheme.setExtraLargeFont(new Font("隶书", Font.BOLD, 15));
	        // 设置图例的字体
	        standardChartTheme.setRegularFont(new Font("宋书", Font.PLAIN, 12));
	        // 设置轴向的字体
	        standardChartTheme.setLargeFont(new Font("宋书", Font.PLAIN, 12));
	        // 应用主题样式
	        ChartFactory.setChartTheme(standardChartTheme);
	        // 2. 构造chart  
	        JFreeChart chart = ChartFactory.createBarChart3D(  
	                "產品銷量圖", // 图表标题  
	                "產品", // 目录轴的显示标签--横轴  
	                "銷量", // 数值轴的显示标签--纵轴  
	                dataset, // 数据集  
	                PlotOrientation.HORIZONTAL, // 图表方向：水平、  
	                true, // 是否显示图例(对于简单的柱状图必须  
	                true, // 是否生成工具  
	                true // 是否生成URL链接  
	                );  
	        chart.setBackgroundPaint(ChartColor.WHITE);
	        
	        // 3. 处理chart中文显示问题  
	        processChart(chart);  
	  
	        // 4. chart输出图片  
	        writeChartAsImage(chart);  
	  
	        // 5. chart 以swing形式输出  
//	        ChartFrame pieFrame = new ChartFrame("產品銷量圖", chart);  
//	        pieFrame.pack();  
//	        pieFrame.setVisible(true);  
	  
	}

	
	private static CategoryDataset getDataSet() {  
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();  
        Connection conn = null;
		ResultSet rs = null;
		conn = DB.getConn();
		String sql ="select p.name , sum(pcount) , c.name from  product p join salesitem si on (p.id = si.productid)  join shopping.category c on(c.id = p.categoryid) group by p.id";
		rs = DB.executeQuery(conn, sql);
		try {
			while(rs.next()) {
				dataset.addValue((rs.getDouble("sum(pcount)")), rs.getString("c.name"), rs.getString("p.name"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.closeRs(rs);
			DB.closeConn(conn);
		}
        return dataset;  
    }  
  
    /** 
     * 解决图表汉字显示问题 
     *  
     * @param chart 
     */  
    private static void processChart(JFreeChart chart) {  
        CategoryPlot plot = chart.getCategoryPlot();  
        plot.setBackgroundPaint(ChartColor.WHITE); //背景設白設
        
        CategoryAxis domainAxis = plot.getDomainAxis();  
        ValueAxis rAxis = plot.getRangeAxis();  
        chart.getRenderingHints().put(RenderingHints.KEY_TEXT_ANTIALIASING,  
                RenderingHints.VALUE_TEXT_ANTIALIAS_OFF);  
        TextTitle textTitle = chart.getTitle();  
        textTitle.setFont(new Font("宋体", Font.PLAIN, 20));  
        domainAxis.setTickLabelFont(new Font("sans-serif", Font.PLAIN, 11));  
        domainAxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));  
        rAxis.setTickLabelFont(new Font("sans-serif", Font.PLAIN, 12));  
        rAxis.setLabelFont(new Font("宋体", Font.PLAIN, 12));  

        chart.getLegend().setItemFont(new Font("宋体", Font.PLAIN, 12));  
        
        BarRenderer mRenderer = new BarRenderer();  
        mRenderer.setBaseItemLabelGenerator(new StandardCategoryItemLabelGenerator()); //柱圖顯示數值
        mRenderer.setDrawBarOutline(true);
        mRenderer.setBaseOutlinePaint(ChartColor.BLACK);
        mRenderer.setBaseItemLabelsVisible(true, true); //柱圖顯示數值
        plot.setRenderer(mRenderer); 
    }  
  
    /** 
     * 输出图片 
     *  
     * @param chart 
     */  
    private static void writeChartAsImage(JFreeChart chart) {  
        FileOutputStream fos_jpg = null ;  
        try {  
            fos_jpg = new FileOutputStream("C:\\Users\\LiuXin\\workspace\\Shopping01\\WebContent\\images\\SalesCountForm\\fruit.jpg");  
            ChartUtilities.writeChartAsJPEG(fos_jpg, 1, chart, 400, 400 );  
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            try {  
                fos_jpg.close();  
            } catch (Exception e) {  
            }  
        }  
    }  
    public static void main(String[] args) {
    	//getData();
	}
}
