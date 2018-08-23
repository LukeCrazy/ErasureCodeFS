package WebHandler;


import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Model.OptInfo;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;

import FSOpt.DataOperation;

public class ExportData extends HttpServlet{
    public void doGet(HttpServletRequest req, HttpServletResponse res){
        doPost(req, res);
    }

    public void doPost(HttpServletRequest req, HttpServletResponse res){
        ArrayList<OptInfo> optList = (ArrayList<OptInfo>) req.getSession().getAttribute("optList");
        System.out.println("in real export");
        try{
            boolean flag1 = DataOperation.generateExcel(optList);
            boolean flag2 = DataOperation.downloadData("exportData","/home/luke/exportData.xlsx", res);
            if (flag1 && flag2) {
                req.getSession().setAttribute("message", "success");
                System.out.println("real export success");
            } else {
                req.getSession().setAttribute("message", "failure");
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
