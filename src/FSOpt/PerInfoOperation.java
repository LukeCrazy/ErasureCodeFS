package FSOpt;
import FSOpt.PerOperation;
import Model.AlgInfo;
import Model.PerInfo;

import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;

public class PerInfoOperation {
    public static void loadUserPerInfo(String count, HttpSession session, PerOperation fsOpt) {
        ArrayList<PerInfo> perList = new ArrayList<PerInfo>();
        try {
            String pathName = "E:/testHDFS/tempperInfo.txt";
            File fileName = new File(pathName);
            InputStreamReader reader = new InputStreamReader(new FileInputStream(fileName));
            BufferedReader br = new BufferedReader(reader);
            String tempLine = "";
            tempLine = br.readLine();
            while (tempLine != null) {
                String[] temp = tempLine.split("\\|\\|\\|");
                System.out.println("count " + count + " temp0 " + temp[0]);
                if (temp[0].equals(count)) {
                    String[] tempOne = temp[1].split("\\|");
                    AlgInfo tempAlg = new AlgInfo(Integer.parseInt(tempOne[0]), Integer.parseInt(tempOne[1]), Integer.parseInt(tempOne[3]), tempOne[2]);
                    int[] bandWidth = new int[tempOne[8].length()];
                    String bdWidth = null;
                    for (int i = 0; i < tempOne[8].length(); i++) {
                        bdWidth = "" + tempOne[8].charAt(i);
                        bandWidth[i] = Integer.parseInt(bdWidth);
                    }
                    PerInfo tempFile = new PerInfo(tempOne[0], tempOne[1], tempOne[2], Integer.parseInt(tempOne[4]), tempOne[5], tempOne[3], tempOne[6], tempOne[7], bandWidth);
                    perList.add(tempFile);
                }
                tempLine = br.readLine();
            }
            session.setAttribute("perList", perList);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static void loadUserPerInfo(HttpSession session, PerOperation fsOpt) {
        ArrayList<PerInfo> perList = new ArrayList<PerInfo>();
        try {
            String pathName = "E:/testHDFS/tempperInfo.txt";
            File fileName = new File(pathName);
            InputStreamReader reader = new InputStreamReader(new FileInputStream(fileName));
            BufferedReader br = new BufferedReader(reader);
            String tempLine = "";
            tempLine = br.readLine();
            while (tempLine != null) {
                String[] temp = tempLine.split("\\|\\|\\|");

                String[] tempOne = temp[1].split("\\|");
                AlgInfo tempAlg = new AlgInfo(Integer.parseInt(tempOne[0]), Integer.parseInt(tempOne[1]), Integer.parseInt(tempOne[3]), tempOne[2]);
                int[] bandWidth = new int[tempOne[8].length()];
                String bdWidth = null;
                for (int i = 0; i < tempOne[8].length(); i++) {
                    bdWidth = "" + tempOne[8].charAt(i);
                    bandWidth[i] = Integer.parseInt(bdWidth);
                }
                PerInfo tempFile = new PerInfo(tempOne[0], tempOne[1], tempOne[2], Integer.parseInt(tempOne[4]), tempOne[5], tempOne[3], tempOne[6], tempOne[7], bandWidth);
                perList.add(tempFile);

                tempLine = br.readLine();
            }
            session.setAttribute("perList", perList);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}