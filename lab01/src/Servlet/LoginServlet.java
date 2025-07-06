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
import java.sql.*;

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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmode", "root", "1234");
            String sql = "select * from dbo where username=? and password=?";
            PreparedStatement pstmt = con.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            ResultSet rs = pstmt.executeQuery();
            ResultData rd = new ResultData();
            if (rs.next()) {
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                rd.setCode("201");
                rd.setMsg("登录成功");
            } else {
                rd.setCode("4041");
                rd.setMsg("用户名或密码有误");
            }
            out.write(JSON.toJSONString(rd));
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
        PrintWriter out = resp.getWriter();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbmode", "root", "1234");
            String sql = "insert into dbo (username,password,phonenumber) values(?,?,?)";
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

}
