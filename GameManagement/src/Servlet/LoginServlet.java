package Servlet;

import com.alibaba.fastjson.JSON;
import utils.ResultData;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String action = req.getParameter("action") == null ? "" : req.getParameter("action");
        switch (action) {
            case "login":
                login(req, resp);
                break;
            case "logout":
                logout(req, resp);
                break;
            case "register":
                register(req, resp);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    private void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PrintWriter out = resp.getWriter();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String managername = username;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gamemanagement", "root", "1234");

            String sql = "select * from userlogin where username=? and password=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            ResultData rd = new ResultData();

            String sql2 = "select * from managerlogin where managername=? and password=?";
            PreparedStatement pstmt2 = con.prepareStatement(sql2);
            pstmt2.setString(1, managername);
            pstmt2.setString(2, password);
            ResultSet rs2 = pstmt2.executeQuery();
            ResultData rd2 = new ResultData();

            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                rd.setCode("201");
                rd.setMsg("登录成功");
                out.write(JSON.toJSONString(rd));
            } else if (rs2.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("username", managername);
                rd2.setCode("202");
                rd2.setMsg("登录成功");
                out.write(JSON.toJSONString(rd2));
            }else {
                rd.setCode("4041");
                rd.setMsg("用户名或密码有误");
                out.write(JSON.toJSONString(rd));
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    private void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute("username");
            session.invalidate();
        }
        resp.sendRedirect("login.jsp");
    }

    private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String phonenumber = req.getParameter("phonenumber");
        int len = phonenumber.length();
        PrintWriter out = resp.getWriter();

        // 验证输入是否包含非法字符
        if (!isValidInput(username)) {
            ResultData rd = new ResultData();
            rd.setCode("400");
            rd.setMsg("请输入正确的用户名");
            out.write(JSON.toJSONString(rd));
            return;
        } else if (!isValidInput(password)) {
            ResultData rd = new ResultData();
            rd.setCode("400");
            rd.setMsg("请输入正确的密码");
            out.write(JSON.toJSONString(rd));
            return;
        } else if (!isValidInput(phonenumber)||len!=11) {
            ResultData rd = new ResultData();
            rd.setCode("400");
            rd.setMsg("请输入正确的11位数的电话");
            out.write(JSON.toJSONString(rd));
            return;
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/gamemanagement", "root", "1234");
            // 检查用户名是否已存在
            String checkSql = "SELECT COUNT(*) FROM userlogin WHERE username = ?";
            PreparedStatement checkStmt = con.prepareStatement(checkSql);
            checkStmt.setString(1, username);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    ResultData rd = new ResultData();
                    rd.setCode("409");
                    rd.setMsg("用户名已存在，请选择其他用户名进行注册");
                    out.write(JSON.toJSONString(rd));
                    return;
                }
            }

            String sql = "insert into userlogin (username,password,phonenumber) values(?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            pstmt.setString(3, phonenumber);
            ResultData rd = new ResultData();
            if (pstmt.executeUpdate() > 0) {
                rd.setCode("200");
                rd.setMsg("注册成功");
            } else {
                rd.setCode("501");
                rd.setMsg("注册失败");
            }
            out.write(JSON.toJSONString(rd));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    // 用于验证输入字符串是否只包含合法字符的辅助方法
    private boolean isValidInput(String input) {
        // 允许字母、数字和特定字符（如下划线和连字符），不允许空格和其他符号
        // 可以根据需要调整正则表达式
        String regex = "^[a-zA-Z0-9]+$";
        return input.matches(regex);
    }

}
