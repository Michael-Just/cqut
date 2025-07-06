package Servlet;

import com.alibaba.fastjson.JSON;
import entity.*;
import utils.DBUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

public class GetServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String action = req.getParameter("action") == null ? "" : req.getParameter("action");
        switch (action) {
            case "gettname":
                gettname(req, resp);
                break;
            case "gettnamea":
                gettnamea(req, resp);
                break;
            case "gettnameb":
                gettnameb(req, resp);
                break;
            case "getsname":
                getsname(req, resp);
                break;
            case "getrno":
                getrno(req, resp);
                break;
            case "getcno":
                getcno(req, resp);
                break;
            case "getteam":
                getteam(req, resp);
                break;
            default:
                break;
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void gettname(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select tname from team";
            List<Team> list = DBUtils.QueryBeanList(sqllist, Team.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void gettnamea(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select tname from team where tname in (select tname from gradea)";
            List<Team> list = DBUtils.QueryBeanList(sqllist, Team.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void gettnameb(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select tname from team where tname in (select tname from gradeb)";
            List<Team> list = DBUtils.QueryBeanList(sqllist, Team.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getsname(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select sname from site";
            List<Site> list = DBUtils.QueryBeanList(sqllist, Site.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getrno(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select rno from referee";
            List<Referee> list = DBUtils.QueryBeanList(sqllist, Referee.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getcno(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select cno from coach where cno not in (select cno from team)";
            List<Coach> list = DBUtils.QueryBeanList(sqllist, Coach.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getteam(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String sqllist = "select tname from team where tname not in (select tname from gradea) and tname not in (select tname from gradeb)";
            List<Grade> list = DBUtils.QueryBeanList(sqllist, Grade.class);
            out.write(JSON.toJSONString(list));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
