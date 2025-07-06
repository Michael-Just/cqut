package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Manager;
import entity.User;
import utils.DBUtils;
import utils.ResultData;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

public class MyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String action = req.getParameter("action") == null ? "" : req.getParameter("action");
        switch (action) {
            case "getuser":
                getuser(req, resp);
                break;
            case "updateuser":
                updateuser(req, resp);
                break;
            case "getmanager":
                getmanager(req, resp);
                break;
            case "updatemanager":
                updatemanager(req, resp);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void getuser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter out = resp.getWriter();
            String username = req.getParameter("username");
            String sql = "select * from userlogin where username = ?";
            User user = DBUtils.QueryBean(sql, User.class, username);
            ResultData rd = new ResultData();
            if (user != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(user);
                out.write(JSON.toJSONString(rd));
            } else {
                rd.setCode("501");
                rd.setMsg("获取失败");
                out.write(JSON.toJSONString(rd));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void updateuser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter out = resp.getWriter();
            String username = req.getParameter("username");
            String password = req.getParameter("password");
            String phonenumber = req.getParameter("phonenumber");
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
            } else if (!isValidInput(phonenumber)) {
                ResultData rd = new ResultData();
                rd.setCode("400");
                rd.setMsg("请输入正确的电话");
                out.write(JSON.toJSONString(rd));
                return;
            }

            String sql = "update userlogin set username = ? , password=?,phonenumber=? where username = ?";
            if (DBUtils.Update(sql, username, password, phonenumber, username) > 0) {
                out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
                HttpSession session = req.getSession();
                session.setAttribute("username", username);
            } else {
                out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
        }
    }

    protected void getmanager(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter out = resp.getWriter();
            String managername = req.getParameter("managername");
            String sql = "select * from managerlogin where managername = ?";
            Manager manager = DBUtils.QueryBean(sql, Manager.class, managername);
            ResultData rd = new ResultData();
            if (manager != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(manager);
                out.write(JSON.toJSONString(rd));
            } else {
                rd.setCode("501");
                rd.setMsg("获取失败");
                out.write(JSON.toJSONString(rd));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void updatemanager(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            PrintWriter out = resp.getWriter();
            String managername = req.getParameter("managername");
            String password = req.getParameter("password");
            String phonenumber = req.getParameter("phonenumber");
            // 验证输入是否包含非法字符
            if (!isValidInput(managername)) {
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
            } else if (!isValidInput(phonenumber)) {
                ResultData rd = new ResultData();
                rd.setCode("400");
                rd.setMsg("请输入正确的电话");
                out.write(JSON.toJSONString(rd));
                return;
            }

            String sql = "update managerlogin set managername = ? , password=?,phonenumber=? where managername = ?";
            if (DBUtils.Update(sql, managername, password, phonenumber, managername) > 0) {
                out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
                HttpSession session = req.getSession();
                session.setAttribute("username", managername);
            } else {
                out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
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
