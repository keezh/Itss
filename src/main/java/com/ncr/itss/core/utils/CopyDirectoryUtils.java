package com.ncr.itss.core.utils;

import java.io.*;

/**
 * @author 孙潇
 *         文件夹拷贝(文件内含有文件和文件夹)
 */
public class CopyDirectoryUtils {

    public static void main(String[] args) {
        copy("E:\\test", "D:\\test");
        System.out.println("文件拷贝完成!");
    }

    public static void copy(String src, String des) {
        File file1 = new File(src);
        File[] fs = file1.listFiles();
        File file2 = new File(des);
        if (!file2.exists()) {
            file2.mkdirs();
        }
        for (File f : fs) {
            if (f.isFile()) {
                fileCopy(f.getPath(), des + "\\" + f.getName()); //调用文件拷贝的方法
            } else if (f.isDirectory()) {
                copy(f.getPath(), des + "\\" + f.getName());
            }
        }

    }

    /**
     * 文件拷贝的方法
     */
    public static void fileCopy(String src, String des) {

        BufferedReader br = null;
        PrintStream ps = null;

        try {
            br = new BufferedReader(new InputStreamReader(new FileInputStream(src)));
            ps = new PrintStream(new FileOutputStream(des));
            String s = null;
            while ((s = br.readLine()) != null) {
                ps.println(s);
                ps.flush();
            }

        } catch (IOException e) {
            // TODO Auto-generated catch block  
            e.printStackTrace();
        } finally {

            try {
                if (br != null) br.close();
                if (ps != null) ps.close();
            } catch (IOException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }

        }
        
    }

}  