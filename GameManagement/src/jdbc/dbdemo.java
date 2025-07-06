package jdbc;

import entity.Site;
import utils.DBUtils;

public class dbdemo {
    public static void main(String[] args) throws Exception {   //下面方法有不同的异常，我直接抛出一个大的异常
//
//        //1、导入驱动jar包
//        //2、注册驱动
//        Class.forName("com.mysql.jdbc.Driver");
//
//        //3、获取数据库的连d接对象
//        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/JDBC_study", "root", "1234");
//
//        //4、定义sql语句
//        String sql = "update account set balance =500 where id=1";
//
//        //5、获取执行sql语句的对象
//        Statement stat = con.createStatement();
//
//        //6、执行sql并接收返回结果
//        int count = stat.executeUpdate(sql);
//
//        //7、处理结果
//        System.out.println(count);
//
//        //8、释放资源
//        stat.close();
//        con.close();
        try {
            String sql = "select * from site where Sname = ?";
            Site g = DBUtils.QueryBean(sql, Site.class,"一号场地");
            System.out.println(g.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}