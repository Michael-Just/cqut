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

public class MyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");
        PrintWriter out = resp.getWriter();
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        System.out.println(username + "" + password);
        ResultData rd = new ResultData();
        if(username.length()>0 && password.length()>0){
            HttpSession session = req.getSession();
            session.setAttribute("username", username);
            rd.setCode("201");
            rd.setMsg("登录成功");
        }else {
            rd.setCode("4041");
            rd.setMsg("用户名或密码有误");
        }
        out.write(JSON.toJSONString(rd));
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
