package utils;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

public class DBUtils {
    /**
     * 使用dbUtils测试增删改
     * @return
     * @throws SQLException
     */
    public static int Update(String sql,Object...params) {
        Connection connection=null;
        try {
            //1.建立连接
            connection = DruidUtils.getConnection();
            //2.创建执行sql增删改查的对象
            QueryRunner queryRunner=new QueryRunner();
            //3.执行
            int update = queryRunner.update(connection,sql,params);
            return update;
        }catch(Exception e) {
            throw new RuntimeException(e);
        }finally {
            DruidUtils.close(null, null, connection);
        }
    }

    /**
     * 通用的，使用dbUtils测试查询单个记录
     * @param sql
     * @param params
     * @throws Exception
     */
    public static Object QueryScalar(String sql,Object...params){
        Connection connection=null;
        try {
            //1.建立连接
            connection = DruidUtils.getConnection();
            //2.创建执行sql增删改查的对象
            QueryRunner queryRunner=new QueryRunner();
            //3.执行
            Object obj= queryRunner.query(connection, sql, new ScalarHandler(),params);
            return obj;
        }catch(Exception e) {
            throw new RuntimeException(e);
        }finally {
            DruidUtils.close(null, null, connection);
        }
    }

    /**
     * 通用的使用dbUtils测试查询一条记录
     * @param <T>
     * @param sql
     * @param clazz
     * @param params
     * @return
     * @throws SQLException
     */
    public static <T> T QueryBean(String sql,Class<T> clazz,Object...params) throws SQLException {
        //1.建立连接
        Connection connection = DruidUtils.getConnection();
        //2.创建执行sql增删改查的对象
        QueryRunner queryRunner=new QueryRunner();
        //3.执行
        T query = queryRunner.query(connection, sql, new BeanHandler<T>(clazz) , params);
        return query;
    }

    /**
     * 通用的，使用dbUtils测试查询多条条记录
     * @param sql
     * @param params
     * @throws Exception
     */
    public static <T> List<T> QueryBeanList(String sql,Class<T> clazz,Object...params) throws SQLException {
        Connection connection=null;
        try {
            //1.建立连接
            connection = DruidUtils.getConnection();
            //2.创建执行sql增删改查的对象
            QueryRunner queryRunner=new QueryRunner();
            //3.执行
            List<T> list = queryRunner.query(connection,sql, new BeanListHandler<T>(clazz),params);
            return list;
        }catch(Exception e) {
            throw new RuntimeException(e);
        }finally {
            DruidUtils.close(null, null, connection);
        }
    }
}

