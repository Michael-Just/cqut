package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Player;
import entity.Team;
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

public class TeamServlet extends HttpServlet {
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
            String sqllist = "select tname,t.cno,cname,tcity,ttime from team t join coach c on t.cno=c.cno limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Team> list = DBUtils.QueryBeanList(sqllist, Team.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            String cno = req.getParameter("cno");
            String tcity = req.getParameter("tcity");
            String ttime = req.getParameter("ttime");
            String sql = "insert into team (tname,cno, tcity,ttime) values(?,?,?,?)";
            if (DBUtils.Update(sql, tname, cno, tcity, ttime) > 0) {
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
            String tname = req.getParameter("tname");
            String sql = "select count(*) from team where tname = ?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, tname).toString());
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
            String tname = req.getParameter("tname");
            String sql = "delete from team where tname = ?";
            if (DBUtils.Update(sql, tname) > 0) {
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
            String tname = req.getParameter("tname");
            String sql = "select * from team where tname = ?";
            Team team = DBUtils.QueryBean(sql, Team.class, tname);
            ResultData rd = new ResultData();
            if (team != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(team);
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
            String tname = req.getParameter("tname");
            String cno = req.getParameter("cno");
            String tcity = req.getParameter("tcity");
            String ttime = req.getParameter("ttime");
            String sql = "update team set tname = ? , cno=?,tcity=? , ttime=? where tname = ?";
            if (DBUtils.Update(sql, tname, cno, tcity, ttime, tname) > 0) {
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
            String sqlcount = "select count(*) from team t join coach c on t.cno=c.cno where tname like '%" + value + "%' or t.cno like '%" + value + "%' or t.cno like '%" + value + "%' or" +
                    " tcity like '%" + value + "%' or ttime like '%" + value + "%'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select tname,t.cno,cname,tcity,ttime from team t join coach c on t.cno=c.cno where tname like '%" + value + "%' or t.cno like '%" + value + "%' or" +
                    " tcity like '%" + value + "%' or ttime like '%" + value + "%' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Team> list = DBUtils.QueryBeanList(sqllist, Team.class);
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
            String sqlcount = "select count(*) from player where pteam ='"+tname+"'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select pno,pname,page,pheight,pweight from player where pteam ='"+tname+"' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Player> list = DBUtils.QueryBeanList(sqllist, Player.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
