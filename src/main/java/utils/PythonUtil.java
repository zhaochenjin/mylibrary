package utils;

import java.io.DataInputStream;
import java.io.InputStream;

public class PythonUtil {

    public static void executePython(Integer userID, String command){
        try {
            // 进行一个python的调用
            String exe = "python";
            String userId = String.valueOf(userID);//userID  int -->userId string
            String[] cmdArr = new String[]{exe, command, userId};//新建数组对象cmdArr
//            System.out.println(exe);//python
//            System.out.println(command);//C:\Users\jin\Desktop\4\mylibrary\src\main\resources\also_borrow_recommendation_func.py
//            System.out.println(userId);//50000004
//            System.out.println(cmdArr);//[Ljava.lang.String;@377dca04

            Process process = Runtime.getRuntime().exec(cmdArr);//实现了调用服务器命令脚本来执行功能需要
//            System.out.println(process);//Process[pid=9572, exitValue="not exited"]
            InputStream is = process.getInputStream();//得到一个输入流，客户端的Socket对象上的getInputStream方法得到输入流其实就是从服务器端发回的数据。
//            System.out.println(is);//java.io.BufferedInputStream@1de0aca6
            DataInputStream dis = new DataInputStream(is);//创建数据输入流对象
//            System.out.println(dis);//java.io.DataInputStream@255316f2
            String str = dis.readLine();//从数据流或控制台读取一行输入
            System.out.println(str);
            process.waitFor();//当前线程等待，直到该对象的进程结束，才返回调用。
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        Integer userId = 50000004;
//        String command="C:\\Users\\jin\\Desktop\\4\\mylibrary\\src\\main\\resources\\also_borrow_recommendation_func.py";
        String command="D:\\毕业项目\\4\\mylibrary\\src\\main\\resources\\also_borrow_recommendation_func.py";
        executePython(userId, command);
    }
}
