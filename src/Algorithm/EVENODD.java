package Algorithm; /**
 * Created by xf123 on 12/12/17.
 */

import java.io.File;
import java.io.FileOutputStream;
import java.io.RandomAccessFile;
import FSOpt.FileOperation;
import Model.FileInfo;

public class EVENODD {
    public FileInfo fileInfo;
    public int zeroNum;
    public int logicBlockSize;
    public int pNum;
    private FileOperation fop;
    private int optFileSize = 0;
    private int realRowNum = 0;
    private int realColNum = 0;
    private int stripeNum = 0;
    private int[] bandWidth;


    public EVENODD(int p, FileInfo fileInfo, FileOperation ufop,int logicBlockSize){
        pNum = p;
        this.realColNum = p+2;
        this.realRowNum = p-1;
        this.fileInfo = fileInfo;
        this.logicBlockSize=logicBlockSize;
        this.bandWidth = new int[pNum+3];

        fop = ufop;

        long realSize = this.fileInfo.getFileSize();
        this.stripeNum = (int)(realSize/(logicBlockSize*(pNum-1)*pNum));
        if(realSize%(logicBlockSize*(pNum-1)*pNum)!=0){
            this.stripeNum += 1;
        }
        this.zeroNum = (int)(realSize%(logicBlockSize*(pNum-1)*pNum));

        System.out.println("EEEEEEEEEEEEEEE "+this.stripeNum+" real "+realSize);
       // this.logicBlockSize = (int)((this.fileInfo.getFileSize()+zeroNum)/(pNum*(pNum-1)));
    }

    public int getRealRowNum(){
        return this.realRowNum;
    }

    public int getStripeNum(){ return this.stripeNum; }

    public int getLogicBlockSize() {
        return logicBlockSize;
    }

    public void setLogicBlockSize(int logicBlockSize) {
        this.logicBlockSize = logicBlockSize;
    }

    public int getRealColNum(){
        return this.realColNum;
    }

//    public EVENODD(int p, String path, FileOperation ufop){
//        pNum = p;
//        filePath = path;
//        File f = new File(path);
//        fileName = f.getName();
//        fileSize = f.length();
//        System.out.println("Real up length "+fileSize);
//        fileType = fileName.substring(fileName.lastIndexOf("."), fileName.length());
//        fileName = fileName.substring(0, fileName.lastIndexOf("."));
//
//        fop = ufop;
//
//        if(fileSize%(pNum*(pNum-1))==0){
//            zeroNum = 0;
//        }
//        else{
//            zeroNum = (int)(((fileSize/(pNum*(pNum-1)))+1)*(pNum*(pNum-1))-fileSize);
//        }
//        logicBlockSize = (int)((fileSize+zeroNum)/(pNum*(pNum-1)));
//    }

    public Boolean Encoding() throws Exception{
        // horizontal redundant
        //reset
        setOptFileSize(0);
        clearBandWidth();
        int realSize = 0;
        boolean stillHaveContent = true;

        for(int s=0; s<stripeNum; s++) {
            for (int i = 0; i < (pNum - 1); i++) {
                byte[] tempData = new byte[logicBlockSize];
                for (int j = 0; j < (pNum); j++) {
                    byte[] bs = new byte[logicBlockSize];
                    if (!stillHaveContent) {
                        for (int l = 0; l < logicBlockSize; l++) {
                            bs[l] = 0;
                        }
                    } else {
                        RandomAccessFile r = new RandomAccessFile(this.fileInfo.getFilePath(), "r");
                        r.seek((s * pNum * (pNum - 1) + i * (pNum) + j) * logicBlockSize);
                        if ((s == stripeNum - 1) && (zeroNum != 0) && (realSize + logicBlockSize) > fileInfo.getFileSize()) {
                            byte[] tempbs = new byte[(int) fileInfo.getFileSize() - realSize];
                            r.read(tempbs);
                            for (int l = 0; l < logicBlockSize; l++) {
                                if (l < ((int) fileInfo.getFileSize() - realSize)) {
                                    bs[l] = tempbs[l];
                                } else {
                                    bs[l] = 0;
                                }
                            }
                            stillHaveContent = false;
                        } else {
                            r.read(bs);
                        }
                        //累加文件总长度
                        realSize += logicBlockSize;
                        r.close();
                    }
                    if (!WriteToFile(s, i, j, bs))
                        return false;
                    for (int k = 0; k < logicBlockSize; k++) {
                        tempData[k] = (byte) (tempData[k] ^ bs[k]);
                    }
                }
                if (!WriteToFile(s, i, pNum, tempData))
                    return false;
            }
        }
        for(int s=0; s<stripeNum; s++) {
            // diagonal redundant
            // calculate Svalue
            byte[] sValue = new byte[logicBlockSize];
            for(int i=0; i<(pNum-1); i++){
                byte[] bs = new byte[logicBlockSize];
                RandomAccessFile r = new RandomAccessFile(this.fileInfo.getFilePath(), "r");
                r.seek((s*pNum*(pNum-1)+(i*pNum)+(pNum-i-1))*logicBlockSize);
                int tempRealSize = (s*pNum*(pNum-1)+(i*pNum)+(pNum-i-1))*logicBlockSize;
                if ((s == stripeNum - 1) && (zeroNum != 0)) {
                    if(tempRealSize>fileInfo.getFileSize()){
                        for (int l = 0; l < logicBlockSize; l++) {
                            bs[l] = 0;
                        }
                    }
                    else if((tempRealSize+logicBlockSize) > fileInfo.getFileSize()){
                        byte[] tempbs = new byte[(int) fileInfo.getFileSize() - tempRealSize];
                        r.read(tempbs);
                        for (int l = 0; l < logicBlockSize; l++) {
                            if (l < ((int) fileInfo.getFileSize() - realSize)) {
                                bs[l] = tempbs[l];
                            } else {
                                bs[l] = 0;
                            }
                        }
                    }
                    else {
                        r.read(bs);
                    }
                }
                else {
                    r.read(bs);
                }
                r.close();
                for(int k=0; k<logicBlockSize; k++){
                    sValue[k] = (byte)(sValue[k]^bs[k]);
                }
            }
            // calculate diagonal redundant
            for(int loop=0; loop<(pNum-1); loop++){
                byte[] tempData = new byte[logicBlockSize];
                for(int i=0; i<(pNum-1); i++){
                    byte[] bs = new byte[logicBlockSize];
                    int j = (loop-i+pNum)%pNum;
                    RandomAccessFile r = new RandomAccessFile(this.fileInfo.getFilePath(), "r");
                    r.seek((s*pNum*(pNum-1)+(i*pNum)+j)*logicBlockSize);
                    //r.seek((s*pNum*(pNum-1)+(i*pNum)+(pNum-i-1))*logicBlockSize);
                    int tempRealSize = (s*pNum*(pNum-1)+(i*pNum)+j)*logicBlockSize;
                    //int tempRealSize = (s*pNum*(pNum-1)+(i*pNum)+(j))*logicBlockSize;
                    if ((s == stripeNum - 1) && (zeroNum != 0)) {
                        if(tempRealSize>fileInfo.getFileSize()){
                            for (int l = 0; l < logicBlockSize; l++) {
                                bs[l] = 0;
                            }
                        }
                        else if((tempRealSize+logicBlockSize) > fileInfo.getFileSize()){
                            byte[] tempbs = new byte[(int) fileInfo.getFileSize() - tempRealSize];
                            r.read(tempbs);
                            for (int l = 0; l < logicBlockSize; l++) {
                                if (l < ((int) fileInfo.getFileSize() - realSize)) {
                                    bs[l] = tempbs[l];
                                } else {
                                    bs[l] = 0;
                                }
                            }
                        }
                        else {
                            r.read(bs);
                        }
                    }
                    else {
                        r.read(bs);
                    }
                    for(int k=0; k<logicBlockSize; k++){
                        tempData[k] = (byte)(tempData[k]^bs[k]);
                    }
                }
                for(int k=0; k<logicBlockSize; k++){
                    tempData[k] = (byte)(tempData[k]^sValue[k]);
                }
                if(!WriteToFile(s, loop, pNum+1, tempData))
                    return false;
            }
        }
        return true;
    }

    public boolean Decoding(int[] errorPos) throws Exception{
        //reset
        setOptFileSize(0);
        clearBandWidth();
        boolean res = false;
        System.out.println("ERRRRRRRRRRRRRRRRRR"+errorPos[0]);
        if (errorPos.length>2) {
            System.out.println("Too many errors to recover!");
            return res;
        }
        else if(errorPos.length<=0 || (errorPos.length==2 && errorPos[0]>=errorPos[1])){
            System.out.println("Invalid errorPos");
            return res;
        }
        else{
            // single disk failure
            if(errorPos.length == 1){
                System.out.println("Recover from single disk failure.");
                if(errorPos[0]<0 || errorPos[0]>pNum+1){
                    System.out.println("Invalid errorPos");
                    return res;
                }
                else if(errorPos[0]<pNum){
                    System.out.println("Recover from data disk failure");
                    for(int s=0; s<stripeNum; s++){
                        for(int i=0; i<(pNum-1); i++){
                            byte[] temp = new byte[logicBlockSize];
                            for(int j=0; j<pNum+1; j++){
                                if(j!=errorPos[0]){
                                    byte[] nowBlock = ReadFromFile(s, i, j);
                                    for(int k=0; k<logicBlockSize; k++){
                                        temp[k] = (byte)(temp[k]^nowBlock[k]);
                                    }
                                }
                            }
                            WriteToFile(s, i, errorPos[0], temp);
                        }
                    }
                }
                else if(errorPos[0] == pNum){
                    System.out.println("Recover from horizontal redundant disk failure");
                    for(int s=0; s<stripeNum; s++){
                        for(int i=0; i<pNum-1; i++){
                            byte[] temp = new byte[logicBlockSize];
                            for(int j=0; j<pNum; j++){
                                byte[] nowBlock = ReadFromFile(s, i, j);
                                for(int k=0; k<logicBlockSize; k++){
                                    temp[k] = (byte)(temp[k]^nowBlock[k]);
                                }
                            }
                            WriteToFile(s, i, pNum, temp);
                        }
                    }
                }
                else{
                    System.out.println("Recover from diagonal redundant disk failure");
                    for(int s=0; s<stripeNum; s++){
                        // calculate S
                        byte[] sValue = new byte[logicBlockSize];
                        for(int i=0; i<(pNum-1); i++){
                            byte[] bs = ReadFromFile(s, i, pNum-i-1);
                            for(int k=0; k<logicBlockSize; k++){
                                sValue[k] = (byte)(sValue[k]^bs[k]);
                            }
                        }
                        // calculate diagonal redundant disk
                        for(int loop=0; loop<(pNum-1); loop++){
                            byte[] tempData = new byte[logicBlockSize];
                            for(int i=0; i<(pNum-1); i++){
                                int j = (loop-i+pNum)%pNum;
                                byte[] bs = ReadFromFile(s, i, j);
                                for(int k=0; k<logicBlockSize; k++){
                                    tempData[k] = (byte)(tempData[k]^bs[k]);
                                }
                            }
                            for(int k=0; k<logicBlockSize; k++){
                                tempData[k] = (byte)(tempData[k]^sValue[k]);
                            }
                            WriteToFile(s, loop, pNum+1, tempData);
                        }
                    }
                }
            }
            // double disk failures
            else{
                // two data disks failed
                if(errorPos[0]<pNum && errorPos[1]<pNum){
                    System.out.println("Recover from two data disks failed.");
                    for(int s=0; s<stripeNum; s++){
                        byte[] sValue = new byte[logicBlockSize];
                        // calculate S
                        for(int i=0; i<(pNum-1); i++){
                            byte[] temp1 = ReadFromFile(s, i, pNum);
                            byte[] temp2 = ReadFromFile(s, i, pNum+1);
                            for(int k=0; k<logicBlockSize; k++){
                                temp1[k] = (byte)(temp1[k]^temp2[k]);
                            }
                            for(int k=0; k<logicBlockSize; k++){
                                sValue[k] = (byte)(temp1[k]^sValue[k]);
                            }
                        }
                        int iniI = errorPos[1]-errorPos[0]-1;
                        int iniJ = errorPos[0];
                        for(int loop=0; loop<(pNum-1); loop++){
                            int modNum = (iniI+iniJ)%(pNum);
                            byte[] diaR = new byte[logicBlockSize];
                            byte[] reBlock_dia = new byte[logicBlockSize];
                            System.out.println("cal block "+iniI +" "+ errorPos[0]);
                            if(modNum!=pNum-1){
                                System.out.println("yes");
                                diaR = ReadFromFile(s, modNum, pNum+1);
                                for(int k=0; k<logicBlockSize; k++){
                                    reBlock_dia[k] = (byte)(sValue[k]^diaR[k]);
                                }
                            }
                            else {
                                for(int k=0; k<logicBlockSize; k++){
                                    reBlock_dia[k] = sValue[k];
                                }
                            }
                            for(int loop2=0; loop2<(pNum-1); loop2++){
                                if((modNum-((iniI+loop2)%(pNum-1))+pNum)%pNum==errorPos[0]){

                                }
                                else{
                                    System.out.println("other block "+(iniI+loop2)%(pNum-1)+" "+(modNum-((iniI+loop2)%(pNum-1))+pNum)%pNum);
                                    byte[] otherBlock = ReadFromFile( s,(iniI+loop2)%(pNum-1), (modNum-((iniI+loop2)%(pNum-1))+pNum)%pNum);
                                    for(int k=0; k<logicBlockSize; k++){
                                        reBlock_dia[k] = (byte)(reBlock_dia[k]^otherBlock[k]);
                                    }
                                }
                            }
                            WriteToFile(s, iniI, errorPos[0], reBlock_dia);
                            byte[] reBlock_hor = new byte[logicBlockSize];
                            for(int j=0; j<pNum+1; j++){
                                if(j!=errorPos[1]){
                                    byte[] otherBlock = ReadFromFile(s, iniI, j);
                                    for(int k=0; k<logicBlockSize; k++){
                                        reBlock_hor[k] = (byte)(reBlock_hor[k]^otherBlock[k]);
                                    }
                                }
                            }
                            WriteToFile(s, iniI, errorPos[1], reBlock_hor);
                            iniI = (iniI+(errorPos[1]-errorPos[0]))%(pNum);
                        }
                    }
                }
                // one data disk and horizontal redundant disk failed
                else if(errorPos[0]<pNum && errorPos[1]==pNum){
                    System.out.println("Recover from one data disk and horizontal redundant disk failed.");
                    for(int s=0; s<stripeNum; s++){
                        // calculate S
                        byte[] sValue = new byte[logicBlockSize];
                        int iniI = 0;
                        int iniJ = (errorPos[0]-1+pNum)%pNum;
                        if(iniJ!=(pNum-1)){
                            byte[] diagRedundant = ReadFromFile(s, iniJ, pNum+1);
                            for(int k=0; k<logicBlockSize; k++){
                                sValue[k] = (byte)(sValue[k]^diagRedundant[k]);
                            }
                        }
                        for(int loop=0; loop<(pNum-1); loop++){
                            byte[] tempBlock = ReadFromFile(s, iniI, iniJ);
                            for(int k=0; k<logicBlockSize; k++){
                                sValue[k] = (byte)(sValue[k]^tempBlock[k]);
                            }
                            iniI = (iniI+1)%(pNum-1);
                            iniJ = (iniJ-1+pNum)%pNum;
                        }
                        for(int i=0; i<(pNum-1); i++){
                            byte[] reBlock_dia = new byte[logicBlockSize];
                            for(int k=0; k<logicBlockSize; k++){
                                reBlock_dia[k] = sValue[k];
                            }
                            iniI = (i+1)%(pNum-1);
                            iniJ = (pNum+errorPos[0]+i-iniI)%pNum;
                            if((iniI+iniJ)%(pNum-1)!=0 || iniJ==0){
                                byte[] dia_red = ReadFromFile( s,(i+errorPos[0])%pNum, pNum+1);
                                for(int k=0; k<logicBlockSize; k++){
                                    reBlock_dia[k] = (byte)(reBlock_dia[k]^dia_red[k]);
                                }
                            }
                            for(int loop=0; loop<(pNum-2); loop++){
                                byte[] otherBlock = ReadFromFile(s, iniI, iniJ);
                                for(int k=0; k<logicBlockSize; k++){
                                    reBlock_dia[k] = (byte)(reBlock_dia[k]^otherBlock[k]);
                                }
                                iniI = (iniI+1)%(pNum-1);
                                iniJ = (pNum+errorPos[0]+i-iniI)%pNum;
                            }
                            WriteToFile(s, i, errorPos[0], reBlock_dia);
                            byte[] reBlock_hor=new byte[logicBlockSize];
                            for(int j=0; j<pNum; j++){
                                byte[] otherBlock = ReadFromFile(s, i, j);
                                for(int k=0; k<logicBlockSize; k++){
                                    reBlock_hor[k] = (byte)(reBlock_hor[k]^otherBlock[k]);
                                }
                            }
                            WriteToFile(s, i, pNum, reBlock_hor);
                        }
                    }
                }
                // one data disk and diagonal redundant disk failed
                else if(errorPos[0]<pNum && errorPos[1]==(pNum+1)){
                    System.out.println("Recover from one data disk and diagonal redundant disk failed.");
                    for(int s=0; s<stripeNum; s++){
                        // calculate data disk
                        for(int i=0; i<(pNum-1); i++){
                            byte[] reBlock_hor = new byte[logicBlockSize];
                            for(int j=0; j<(pNum+1); j++){
                                if(j!=errorPos[0]){
                                    byte[] otherBlock = ReadFromFile(s, i, j);
                                    for(int k=0; k<logicBlockSize; k++){
                                        reBlock_hor[k] = (byte)(reBlock_hor[k]^otherBlock[k]);
                                    }
                                }
                            }
                            WriteToFile(s, i, errorPos[0], reBlock_hor);
                        }
                        // calculate S
                        byte[] sValue = new byte[logicBlockSize];
                        for(int i=0; i<(pNum-1); i++){
                            byte[] bs = ReadFromFile(s, i, pNum-i-1);
                            for(int k=0; k<logicBlockSize; k++){
                                sValue[k] = (byte)(sValue[k]^bs[k]);
                            }
                        }
                        // calculate redundant
                        for(int loop=0; loop<(pNum-1); loop++){
                            byte[] tempData = new byte[logicBlockSize];
                            for(int i=0; i<(pNum-1); i++){
                                int j = (loop-i+pNum)%pNum;
                                byte[] bs = ReadFromFile(s, i, j);
                                for(int k=0; k<logicBlockSize; k++){
                                    tempData[k] = (byte)(tempData[k]^bs[k]);
                                }
                            }
                            for(int k=0; k<logicBlockSize; k++){
                                tempData[k] = (byte)(tempData[k]^sValue[k]);
                            }
                            WriteToFile(s, loop, pNum+1, tempData);
                        }
                    }
                }
                // two redundant disks failed
                else{
                    System.out.println("Recover from two redundant disks failed.");
                    for(int s=0; s<stripeNum; s++){
                        // calculate horizontal redundant disk
                        for(int i=0; i<(pNum-1); i++){
                            byte[] tempData = new byte[logicBlockSize];
                            for(int j=0; j<(pNum); j++){
                                byte[] bs = ReadFromFile(s, i, j);
                                for(int k=0; k<logicBlockSize; k++){
                                    tempData[k] = (byte)(tempData[k]^bs[k]);
                                }
                            }
                            WriteToFile(s, i, pNum, tempData);
                        }
                        // calculate S
                        byte[] sValue = new byte[logicBlockSize];
                        for(int i=0; i<(pNum-1); i++){
                            byte[] bs = ReadFromFile(s, i, pNum-i-1);
                            for(int k=0; k<logicBlockSize; k++){
                                sValue[k] = (byte)(sValue[k]^bs[k]);
                            }
                        }
                        // calculate diagonal redundant disk
                        for(int loop=0; loop<(pNum-1); loop++){
                            byte[] tempData = new byte[logicBlockSize];
                            for(int i=0; i<(pNum-1); i++){
                                int j = (loop-i+pNum)%pNum;
                                byte[] bs = ReadFromFile(s, i, j);
                                for(int k=0; k<logicBlockSize; k++){
                                    tempData[k] = (byte)(tempData[k]^bs[k]);
                                }
                            }
                            for(int k=0; k<logicBlockSize; k++){
                                tempData[k] = (byte)(tempData[k]^sValue[k]);
                            }
                            WriteToFile(s, loop, pNum+1, tempData);
                        }
                    }
                }
            }
        }
        res = true;
        return res;
    }

    public Boolean WriteToFile(int s, int i, int j, byte[] fileContent) throws Exception{
        String targetPath = "/testdir/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+"_S"+s+"_"+i+"_"+j+".txt";
        addOptFileSize(fileContent.length);
        addBandWidth(j, fileContent.length);
        return   fop.CreateAndWriteToFile(targetPath, fileContent);
    }

    public Boolean WriteToFile(int i, int j, byte[] fileContent) throws Exception{
        String targetPath = "/testdir/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+"_"+i+"_"+j+".txt";
        addOptFileSize(fileContent.length);
      return   fop.CreateAndWriteToFile(targetPath, fileContent);
    }

    public byte[] ReadFromFile(int s, int i, int j) throws Exception{
        String targetPath = "/testdir/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+"_S"+s+"_"+i+"_"+j+".txt";
        addOptFileSize(logicBlockSize);
        addBandWidth(j, logicBlockSize);
        return fop.ReadFromFile(targetPath, logicBlockSize);
    }

    public byte[] ReadFromFile(int i, int j) throws Exception{
        String targetPath = "/testdir/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+"_"+i+"_"+j+".txt";
        addOptFileSize(logicBlockSize);
        return fop.ReadFromFile(targetPath, logicBlockSize);
    }

    // rebuild source file and download to target path with file name
//    public void RebuildFile(String targetPath, String fileName) throws Exception{
//        System.out.println("Rebuild begin!");
//        int[] errPos = GetErrorPos();
//        // do decode first if some disks failed
//        if(errPos.length > 0) {
//            Decoding(errPos);
//        }
//        else{
//            // compose real file path
//            targetPath = targetPath+"/"+fileName+"."+this.fileInfo.getFileType();
//            File resFile = new File(targetPath);
//            FileOutputStream out = new FileOutputStream(resFile);
//            int sumSize = 0;
//            for( int i=0; i<(pNum-1); i++){
//                for(int j=0; j<(pNum); j++){
//                    byte[] tempFile = ReadFromFile(i, j);
//                    byte[] realTempFile = null;
//
//                    if(i==pNum-2 && j==pNum-1 && zeroNum != 0){
//                        realTempFile = new byte[logicBlockSize - zeroNum];
//
//                        System.arraycopy(tempFile, 0, realTempFile, 0, logicBlockSize - zeroNum);
//                    } else{
//                        realTempFile = tempFile;
//                    }
//                    System.out.println("One get " + i + " " + j + " " + realTempFile.length);
//                    sumSize = sumSize + realTempFile.length;
//                    out.write(realTempFile);
//                }
//            }
//            System.out.println("Real recv length " + sumSize);
//            out.close();
//        }
//    }

    // rebuild source file and download to target path
    public boolean RebuildFile(String targetPath) throws Exception{
        System.out.println("Rebuild begin!");
        //reset
        setOptFileSize(0);
        clearBandWidth();
        int[] errPos = GetErrorPos();
        // do decode first if some disks failed
        if(errPos.length > 0){
            return false;
            //Decoding(errPos);
        }
        else {
            // compose real file path
            targetPath = targetPath+"/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+this.fileInfo.getFileType();
            File resFile = new File(targetPath);
            FileOutputStream out = new FileOutputStream(resFile);
            int sumSize = 0;
            boolean stillHaveContent = true;
            for(int s=0; s<stripeNum; s++){
                for (int i = 0; i < (pNum - 1); i++) {
                    for (int j = 0; j < (pNum); j++) {
                        byte[] tempFile = ReadFromFile(s, i, j);
                        byte[] realTempFile = null;
                        if(stillHaveContent){
                            if (sumSize+logicBlockSize > fileInfo.getFileSize()) {
                                realTempFile = new byte[(int)fileInfo.getFileSize()-sumSize];
                                System.arraycopy(tempFile, 0, realTempFile, 0, (int)fileInfo.getFileSize()-sumSize);
                                stillHaveContent = false;
                            } else {
                                realTempFile = tempFile;
                            }
                            System.out.println("One get " + s +" "+ i + " " + j + " " + realTempFile.length);
                            sumSize = sumSize + realTempFile.length;
                            out.write(realTempFile);
                        }
                    }
                }
            }
            System.out.println("Real recv length " + sumSize);
            out.close();
            return true;
        }
    }

    public int[] GetErrorPos() throws Exception{
        int[] errPos = new int[0];
        for(int s=0; s<stripeNum; s++){
            for(int j=0; j<pNum+2; j++){
                for(int i=0; i<pNum-1; i++){
                    String path = "/testdir/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+"_S"+s+"_"+i+"_"+j+".txt";
                    boolean flag = fop.IsExisted(path);
                    if (!flag){
                        System.out.println(" doesn't exist??????????? "+path);
                        boolean hasEle = false;
                        for(int t=0; t<errPos.length; t++){
                            if(errPos[t]==j)
                                hasEle = true;
                        }
                        if(!hasEle){
                            int[] tempErrPos = new int[errPos.length+1];
                            System.arraycopy(errPos, 0, tempErrPos, 0, errPos.length);
                            tempErrPos[tempErrPos.length-1] = j;
                            errPos = tempErrPos;
                        }
                    }
                }
            }
        }
        return errPos;
    }

    public Boolean DeleteFile() throws Exception{
        Boolean flag=true;
        //delete doesn't need file transition
        setOptFileSize(0);
        clearBandWidth();
        for(int s=0; s<stripeNum; s++){
            for (int i = 0; i < (pNum - 1); i++) {
                for (int j = 0; j < (pNum+2); j++) {
                    String targetPath = "/testdir/"+this.fileInfo.getUserName()+"_"+this.fileInfo.getFileName()+"_S"+s+"_"+i+"_"+j+".txt";
                    if(!fop.DeleteFile(targetPath))
                        flag=false;
                }
            }
        }
        return flag;
    }

    public void setOptFileSize(int size){
        this.optFileSize = size;
    }

    public int getOptFileSize(){
        return this.optFileSize;
    }

    public void addOptFileSize(int size){
        this.optFileSize += size;
    }

    public void clearBandWidth(){
        for(int i=0; i<pNum+2; i++){
            this.bandWidth[i] = 0;
        }
    }

    public int[] getBandWidth(){
        return this.bandWidth;
    }

    public void addBandWidth(int j, int size){
        this.bandWidth[j] += size;
    }

    public boolean checkParam(){
        if((pNum+"").equals("")){
            return false;
        }
        else if(pNum<=0){
            return false;
        }
        else if(!isPrime(pNum)){
            return false;
        }
        else {
            return true;
        }
    }

    private static boolean isPrime(int p){
        boolean flag = true;
        for(int i=2;i<=p/2;i++){
            if(p%i==0){
                flag = false;
                break;
            }
        }
        return flag;
    }
}
