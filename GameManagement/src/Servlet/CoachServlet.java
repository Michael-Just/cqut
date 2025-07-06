package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Coach;
import utils.DBUtils;
import utils.ResultData;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

public class CoachServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String action = req.getParameter("action") == null ? "" : req.getParameter("action");
        switch (action) {
            case "getdglist":
                getdglist(req, resp);
                break;
            case "add":
                add(req, resp);
                break;
            case "exists":
                exists(req, resp);
                break;
            case "delete":
                delete(req, resp);
                break;
            case "getone":
                getone(req, resp);
                break;
            case "update":
                update(req, resp);
                break;
            case "search":
                search(req, resp);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void getdglist(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from coach";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from coach limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Coach> list = DBUtils.QueryBeanList(sqllist, Coach.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String cno = req.getParameter("cno");
            String cname = req.getParameter("cname");
            String cage = req.getParameter("cage");
            String sql = "insert into coach (cno, cname, cage) values(?,?,?)";
            if (DBUtils.Update(sql, cno, cname, cage) > 0) {
                out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
            } else {
                out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
        }
    }

    protected void exists(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String cno = req.getParameter("cno");
            String sql = "select count(*) from coach where cno = ?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, cno).toString());
            if (count == 1) {
                out.write("false");
            } else {
                out.write("true");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void delete(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String cno = req.getParameter("cno");
            String sql = "delete from coach where cno = ?";
            if (DBUtils.Update(sql, cno) > 0) {
                out.write(JSON.toJSONString(new ResultData("200", "删除成功！")));
            } else {
                out.write(JSON.toJSONString(new ResultData("500", "删除失败！")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getone(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String cno = req.getParameter("cno");
            String sql = "select * from coach where cno = ?";
            Coach coach = DBUtils.QueryBean(sql, Coach.class, cno);
            ResultData rd = new ResultData();
            if (coach != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(coach);
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

    protected void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String cno = req.getParameter("cno");
            String cname = req.getParameter("cname");
            String cage = req.getParameter("cage");
            String sql = "update coach set cno = ? , cname=?,cage=? where cno = ?";
            if (DBUtils.Update(sql, cno, cname,cage, cno) > 0) {
                out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
            } else {
                out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
        }
    }

    protected void search(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            String value = req.getParameter("value");
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from coach where cno like '%" + value + "%' or cname like '%" + value + "%' or" +
                    " cage like '%" + value + "%'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from coach where cno like '%" + value + "%' or cname like '%" + value + "%' or" +
                    " cage like '%" + value + "%' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Coach> list = DBUtils.QueryBeanList(sqllist, Coach.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
