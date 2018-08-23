package FSOpt;
import java.io.*;
import java.util.*;

import Model.OptInfo;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import Model.AlgInfo;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

// Data import and export
public class DataOperation {
    private static final String targetPath = "/home/luke/exportData.xlsx";
    private static final String EXCEL_XLS = "xls";
    private static final String EXCEL_XLSX = "xlsx";

    public static Workbook getWorkbok(File file) throws IOException{
        Workbook wb = null;
        FileInputStream in = new FileInputStream(file);
        if(file.getName().endsWith(EXCEL_XLS)){     //Excel&nbsp;2003
            wb = new HSSFWorkbook(in);
        }else if(file.getName().endsWith(EXCEL_XLSX)){    // Excel 2007/2010
            wb = new XSSFWorkbook(in);
        }
        return wb;
    }

    public static boolean downloadData(String fileName, String targetPath, HttpServletResponse res) throws Exception{
        //download to client
        boolean flag = false;
        File file = new File(targetPath);
        if(file.exists()){
            //设置相应类型让浏览器知道用什么打开  用application/octet-stream也可以，看是什么浏览器
            res.setContentType("application/x-msdownload");
            //设置头信息
            res.setHeader("Content-Disposition", "attachment;filename=\"" + fileName + "\"");
            InputStream inputStream = new FileInputStream(file);
            ServletOutputStream ouputStream = res.getOutputStream();
            byte b[] = new byte[1024];
            int n ;
            while((n = inputStream.read(b)) != -1){
                ouputStream.write(b,0,n);
            }
            //关闭流
            ouputStream.close();
            inputStream.close();
            flag = true;
        }else{
            System.out.println("file doesn't exist");
            flag = false;
        }
        return flag;
    }

    public static boolean generateExcel(ArrayList<OptInfo> optList){
        OutputStream out = null;
        try {
            // 获取总列数
            int columnNumCount = 8;
            // 读取Excel文档
            File finalXlsxFile = new File(targetPath);
            Workbook workBook = getWorkbok(finalXlsxFile);
            // sheet 对应一个工作页
            Sheet sheet = workBook.getSheetAt(0);
            /**
             * 删除原有数据，除了属性列
             */
            int rowNumber = sheet.getLastRowNum();    // 第一行从0开始算
            System.out.println("原始数据总行数，除属性列：" + rowNumber);
            for (int i = 1; i <= rowNumber; i++) {
                Row row = sheet.getRow(i);
                sheet.removeRow(row);
            }
            // 创建文件输出流，输出电子表格：这个必须有，否则你在sheet上做的任何操作都不会有效
            out =  new FileOutputStream(targetPath);
            workBook.write(out);
            /**
             * 往Excel中写新数据
             */
            for (int j = 0; j < optList.size(); j++) {
                System.out.println(" do real export");
                // 创建一行：从第二行开始，跳过属性列
                Row row = sheet.createRow(j + 1);
                // 得到要插入的每一条记录
                OptInfo oneOpt = optList.get(j);

                String algName = oneOpt.getAlgName();
                String fileName = oneOpt.getFileName();
                String userName = oneOpt.getUserName();
                String type = oneOpt.getOptType();
                String partTime = oneOpt.getOptPartTime();
                String lastTime = oneOpt.getOptLastTime();
                String time = oneOpt.getOptTime();
                int usedBytes = oneOpt.getOptUsedBytes();

                for (int k = 0; k <= columnNumCount; k++) {
                    // 在一行内循环
                    Cell oneCell = row.createCell(k);
                    switch (k){
                        case 0:
                            oneCell.setCellValue(algName);
                            break;
                        case 1:
                            oneCell.setCellValue(fileName);
                            break;
                        case 2:
                            oneCell.setCellValue(userName);
                            break;
                        case 3:
                            oneCell.setCellValue(type);
                            break;
                        case 4:
                            oneCell.setCellValue(partTime);
                            break;
                        case 5:
                            oneCell.setCellValue(lastTime);
                            break;
                        case 6:
                            oneCell.setCellValue(time);
                            break;
                        case 7:
                            oneCell.setCellValue(usedBytes);
                            break;
                    }
                }
            }
            // 创建文件输出流，准备输出电子表格：这个必须有，否则你在sheet上做的任何操作都不会有效
            out =  new FileOutputStream(targetPath);
            workBook.write(out);
            System.out.println("数据导出成功");
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally{
            try {
                if(out != null){
                    out.flush();
                    out.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
