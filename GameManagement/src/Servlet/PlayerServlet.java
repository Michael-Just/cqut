package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Player;
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

public class PlayerServlet extends HttpServlet {
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
            case "getteam":
                getteam(req, resp);
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
            String sqlcount = "select count(*) from team";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from team limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Player> list = DBUtils.QueryBeanList(sqllist, Player.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String pno = req.getParameter("pno");
            String pteam = req.getParameter("pteam");
            String pname = req.getParameter("pname");
            String page = req.getParameter("page");
            String pheight = req.getParameter("pheight");
            String pweight = req.getParameter("pweight");
            String sql = "insert into player (pno,pteam, pname,page,pheight,pweight) values(?,?,?,?,?,?)";
            if (DBUtils.Update(sql, pno, pteam, pname, page, pheight, pweight) > 0) {
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
            String pno = req.getParameter("pno");
            String sql = "select count(*) from player where pno = ?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, pno).toString());
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
            String pno = req.getParameter("pno");
            String pteam = req.getParameter("pteam");
            String sql = "delete from player where pno = ? and pteam = ?";
            if (DBUtils.Update(sql, pno, pteam) > 0) {
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
            String pno = req.getParameter("pno");
            String pteam = req.getParameter("pteam");
            String sql = "select * from player where pno = ? and pteam = ?";
            Player player = DBUtils.QueryBean(sql, Player.class, pno, pteam);
            ResultData rd = new ResultData();
            if (player != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(player);
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
            String pno = req.getParameter("pno");
            String pteam = req.getParameter("pteam");
            String pname = req.getParameter("pname");
            String page = req.getParameter("page");
            String pheight = req.getParameter("pheight");
            String pweight = req.getParameter("pweight");
            String sql = "update player set pno = ? , pname=? ,page=? , pheight=? ,pweight=? where pno = ? and pteam=?";
            if (DBUtils.Update(sql, pno, pname, page, pheight, pweight, pno, pteam) > 0) {
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
            String pteam = req.getParameter("pteam");
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from player where pteam='"+pteam+"' and (pno like '%" + value + "%' or pname like '%" +
                    value + "%' or page like '%" + value + "%' or pheight like '%" + value + "%' or pweight like '%" + value + "%')";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from player where pteam='"+pteam+"' and (pno like '%" + value + "%' or pname like '%" + value
                    + "%' or" + " page like '%" + value + "%' or pheight like '%" + value + "%' or pweight like '%" + value + "%') limit " +
                    (pageIndex - 1) * pageSize + "," + pageSize;
            List<Player> list = DBUtils.QueryBeanList(sqllist, Player.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getteam(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from player where pteam ='" + tname + "'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select pno,pname,page,pheight,pweight from player where pteam ='" + tname + "' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Player> list = DBUtils.QueryBeanList(sqllist, Player.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
