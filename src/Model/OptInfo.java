package Model;

import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;

public class OptInfo {
    private String fileName;
    private long fileSize;
    private String userName;
    private String algName;
    private String optType;
    private String optTime;
    // encoding or decoding time
    private String optLastTime;
    // upload to master or download to client time
    private String optPartTime;
    private int optUsedBytes;
    private int[] bandWidth;

    public OptInfo(String fileName, long fileSize,String userName, String algName, String optType, String optTime, String optLastTime, String optPartTime, int optUsedBytes){
        this.fileName = fileName;
        this.fileSize=fileSize;
        this.userName = userName;
        this.algName = algName;
        this.optType = optType;
        this.optTime = optTime;
        this.optLastTime = optLastTime;
        this.optPartTime = optPartTime;
        this.optUsedBytes = optUsedBytes;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public void setFileSize(long fileSize) {
        this.fileSize = fileSize;
    }

    public void setUserName(String userName){
        this.userName = userName;
    }

    public void setAlgName(String algName){
        this.algName = algName;
    }

    public void setOptType(String optType){
        this.optType = optType;
    }

    public void setOptTime(String optTime){
        this.optTime = optTime;
    }

    public void setOptLastTime(String optLastTime){
        this.optLastTime = optLastTime;
    }

    public void setOptPartTime(String optPartTime) { this.optPartTime = optPartTime; }

    public void setOptUsedBytes(int optUsedBytes){
        this.optUsedBytes = optUsedBytes;
    }

    public void setBandWidth(int[] bandWidth){
        this.bandWidth = bandWidth;
    }

    public String getFileName() {
        return fileName;
    }

    public long getFileSize() {
        return fileSize;
    }

    public String getUserName(){
        return userName;
    }

    public String getAlgName(){
        return algName;
    }

    public String getOptType(){
        return optType;
    }

    public String getOptTime() {
        return optTime;
    }//

    public String getOptLastTime() {
        return optLastTime;
    }//

    public String getOptPartTime() { return optPartTime; }//

    public int getOptUsedBytes(){
        return optUsedBytes;
    }

    public int[] getBandWidth(){
        return this.bandWidth;
    }

    public void printBandWidth(){
        for(int i=0; i<bandWidth.length; i++){
            System.out.println(bandWidth[i]);
        }
    }

    public void writeOneOptInfo() throws Exception{
        //write to file
        File f = new File("/home/luke/optInfo.txt");
        FileWriter fw = new FileWriter(f, true);
        PrintWriter pw = new PrintWriter(fw);
        pw.println(userName+"||"+fileName+"|"+algName+"|"+optType+"|"+optTime+"|"+optLastTime+"|"+optPartTime+"|"+optUsedBytes+"|"+fileSize);
        pw.flush();
        pw.close();
    }
}
