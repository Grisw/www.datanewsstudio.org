package org.datanewsstudio.www.common;

import org.springframework.lang.Nullable;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Utils {

    private Utils(){}

    /**
     * 删除目录，自动递归删除该目录下的所有子目录。
     *
     * @param directory 要删除的目录
     * @return 删除成功返回<code>null</code>，否则返回删除失败的文件。
     */
    public static @Nullable File removeDirectory(File directory){
        File[] expiredFiles = directory.listFiles();
        if(expiredFiles == null)
            return directory;
        for (File file : expiredFiles){
            if(file.isDirectory()){
                File errorFile = removeDirectory(file);
                if(errorFile != null){
                    return errorFile;
                }
            }
            if(!file.delete()){
                return file;
            }
        }
        return null;
    }

    public static boolean isDateFormat(String x){
        String[] dateFormat = {
                "yyyy-MM",
                "yyyy-MM-dd",
                "yyyy-MM-dd HH:mm",
                "yyyy-MM-dd HH:mm:ss",
                "MM-dd",
                "MM-dd HH:mm",
                "MM-dd HH:mm:ss",
                "HH:mm",
                "HH:mm:ss"
        };
        for(String f : dateFormat){
            try {
                new SimpleDateFormat(f).parse(x);
                return true;
            } catch (ParseException ignore) { }
        }
        return false;
    }
}
