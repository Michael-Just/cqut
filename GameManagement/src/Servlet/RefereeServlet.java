package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Referee;
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

public class RefereeServlet extends HttpServlet {
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
            String sqlcount = "select count(*) from referee";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from referee limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Referee> list = DBUtils.QueryBeanList(sqllist, Referee.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String rno = req.getParameter("rno");
            String rage = req.getParameter("rage");
            String rgrade = req.getParameter("rgrade");
            String rname = req.getParameter("rname");
            String sql = "insert into referee (rno, rage, rgrade,rname) values(?,?,?,?)";
            if (DBUtils.Update(sql, rno, rage, rgrade,rname) > 0) {
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
            String rno = req.getParameter("rno");
            String sql = "select count(*) from referee where rno = ?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, rno).toString());
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
            String rno = req.getParameter("rno");
            String sql = "delete from referee where rno = ?";
            if (DBUtils.Update(sql, rno) > 0) {
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
            String rno = req.getParameter("rno");
            String sql = "select * from referee where rno = ?";
            Referee referee = DBUtils.QueryBean(sql, Referee.class, rno);
            ResultData rd = new ResultData();
            if (referee != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(referee);
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
            String rno = req.getParameter("rno");
            String rage = req.getParameter("rage");
            String rgrade = req.getParameter("rgrade");
            String rname = req.getParameter("rname");
            String sql = "update referee set rno = ? , rage=?,rgrade=?,rname=? where rno = ?";
            if (DBUtils.Update(sql, rno, rage,rgrade, rname,rno) > 0) {
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
            String sqlcount = "select count(*) from referee where rno like '%" + value + "%' or rage like '%" + value + "%' or" +
                    " rgrade like '%" + value + "%' or rname like '%" + value + "%'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from referee where rno like '%" + value + "%' or rage like '%" + value + "%' or" +
                    " rgrade like '%" + value + "%' or rname like '%" + value + "%' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Referee> list = DBUtils.QueryBeanList(sqllist, Referee.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
