package Model;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

public class PerInfo {
    private String fileName;
    private String algName;
    private String optType;
    private int optUsedBytes;
    private String sizeinms;//单位时间处理的文件大小
    private String msinsize;//处理单位大小文件的时间
    private String optLastTime;
    private String optTime;
    private int[] bandWidth;


    public PerInfo(String fileName, String algName, String optType, int optUsedBytes, String sizeinms, String optLastTime, String optTime, String msinsize, int[] bandWidth) {
        this.fileName = fileName;
        this.algName = algName;
        this.optType = optType;
        this.optUsedBytes = optUsedBytes;

        this.sizeinms = sizeinms;
        this.optLastTime = optLastTime;
        this.msinsize = msinsize;
        this.optTime = optTime;
        this.bandWidth = bandWidth;
    }

    public String getFileName() {
        return fileName;

    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getAlgName() {
        return algName;
    }

    public void setAlgName(String algName) {
        this.algName = algName;
    }

    public String getOptType() {
        return optType;
    }

    public void setOptType(String optType) {
        this.optType = optType;
    }

    public int getOptUsedBytes() {
        return optUsedBytes;
    }

    public void setOptUsedBytes(int optUsedBytes) {
        this.optUsedBytes = optUsedBytes;
    }

    public String getSizeinms() {
        return sizeinms;
    }

    public void setSizeinms(String sizeinms) {
        this.sizeinms = sizeinms;
    }

    public String getOptLastTime() {
        return optLastTime;
    }

    public void setOptLastTime(String optLastTime) {
        this.optLastTime = optLastTime;
    }

    public String getMsinsize() {
        return msinsize;
    }

    public void setMsinsize(String msinsize) {
        this.msinsize = msinsize;
    }

    public String getOptTime() {
        return optTime;
    }

    public void setOptTime(String optTime) {
        this.optTime = optTime;
    }

    public int[] getBandWidth() {
        return bandWidth;
    }

    public void setBandWidth(int[] bandWidth) {
        this.bandWidth = bandWidth;
    }

    public void writeOnePerInfo() throws Exception {
        //write to file
        File f = new File("E:/testHDFS/perInfo.txt");
        FileWriter fw = new FileWriter(f, true);
        PrintWriter pw = new PrintWriter(fw);
        pw.print(fileName + "|" + algName + "|" + optType + "|" + optTime + "|" + optLastTime + "|" + optUsedBytes + "|" + sizeinms + "|" + msinsize);
        if (bandWidth != null) {
            for (int i = 0; i < bandWidth.length; i++) {
                pw.print("|" + bandWidth[i]);
            }
        }
        pw.println();
        pw.flush();
        pw.close();


        File f0 = new File("E:/testHDFS/tempperInfo.txt");
        FileWriter fw0 = new FileWriter(f0, true);
        PrintWriter pw0 = new PrintWriter(fw0);
        pw0.print(fileName + "|" + algName + "|" + optType + "|" + optTime + "|" + optLastTime + "|" + optUsedBytes + "|" + sizeinms + "|" + msinsize);
        if (bandWidth != null) {
            for (int i = 0; i < bandWidth.length; i++) {
                pw0.print("|" + bandWidth[i]);
            }
        }
        pw0.println();
        pw0.flush();
        pw0.close();
    }
}


