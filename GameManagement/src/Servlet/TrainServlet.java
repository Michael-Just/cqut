package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Train;
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

public class TrainServlet extends HttpServlet {
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
            String sqlcount = "select count(*) from train";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from train limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Train> list = DBUtils.QueryBeanList(sqllist, Train.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String sname = req.getParameter("sname");
            String tname = req.getParameter("tname");
            String tstarttime = req.getParameter("tstarttime");
            String tendtime = req.getParameter("tendtime");
            String sql = "insert into train (sname, tname, tstarttime,tendtime) values(?,?,?,?)";
            if (DBUtils.Update(sql, sname, tname, tstarttime,tendtime) > 0) {
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
            String sname = req.getParameter("sname");
            String tname = req.getParameter("tname");
            String sql = "select count(*) from train where sname = ? and tname = ?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, sname, tname).toString());
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
            int tno = Integer.parseInt(req.getParameter("tno"));
            String sql = "delete from train where tno = ?";
            if (DBUtils.Update(sql, tno) > 0) {
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
            int tno = Integer.parseInt(req.getParameter("tno"));
            String sql = "select * from train where tno = ?";
            Train train = DBUtils.QueryBean(sql, Train.class, tno);
            ResultData rd = new ResultData();
            if (train != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(train);
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
            int tno = Integer.parseInt(req.getParameter("tno"));
            String sname = req.getParameter("sname");
            String tname = req.getParameter("tname");
            String tstarttime = req.getParameter("tstarttime");
            String tendtime = req.getParameter("tendtime");
            String sql = "update train set sname = ? , tname=?,tstarttime=? , tendtime=? where tno = ?";
            if (DBUtils.Update(sql, sname, tname,tstarttime,tendtime, tno) > 0) {
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
            String sqlcount = "select count(*) from train where sname like '%" + value + "%' or tname like '%" + value + "%' or" +
                    " tstarttime like '%" + value + "%' or tendtime like '%" + value + "%'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from train where sname like '%" + value + "%' or tname like '%" + value + "%' or" +
                    " tstarttime like '%" + value + "%' or tendtime like '%" + value + "%' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Train> list = DBUtils.QueryBeanList(sqllist, Train.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
