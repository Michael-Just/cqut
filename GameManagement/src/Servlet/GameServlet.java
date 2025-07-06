package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Game;
import entity.Grade;
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
import java.util.Objects;

public class GameServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=utf-8");
        req.setCharacterEncoding("utf-8");

        String action = req.getParameter("action") == null ? "" : req.getParameter("action");
        switch (action) {
            case "getdglista":
                getdglista(req, resp);
                break;
            case "getdglistb":
                getdglistb(req, resp);
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
            case "getgradea":
                getgradea(req, resp);
                break;
            case "addgradea":
                addgradea(req, resp);
                break;
            case "deletegradea":
                deletegradea(req, resp);
                break;
            case "getgradeb":
                getgradeb(req, resp);
                break;
            case "addgradeb":
                addgradeb(req, resp);
                break;
            case "deletegradeb":
                deletegradeb(req, resp);
                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    protected void getdglista(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from game where tname in (select tname from gradea)";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select gno,tname,tname2,sname,r.rno,r.rname,gtime,gscore from game g join referee r on g.rno=r.rno where tname in (select tname from gradea) limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Game> list = DBUtils.QueryBeanList(sqllist, Game.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getdglistb(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from game where tname in (select tname from gradeb)";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select gno,tname,tname2,sname,r.rno,r.rname,gtime,gscore from game g join referee r on g.rno=r.rno where tname in (select tname from gradeb) limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Game> list = DBUtils.QueryBeanList(sqllist, Game.class);
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
            String sname = req.getParameter("sname");
            String rno = req.getParameter("rno");
            String tname2 = req.getParameter("tname2");
            String gtime = req.getParameter("gtime");
            String gscore = req.getParameter("gscore");
            if (Objects.equals(tname, tname2)) {
                out.write(JSON.toJSONString(new ResultData("501", "对战球队一致，请修改")));
            } else {
                String sql = "insert into game (tname,tname2, sname, rno,gtime,gscore) values(?,?,?,?,?,?)";
                if (DBUtils.Update(sql, tname, tname2, sname, rno, gtime, gscore) > 0) {
                    out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
                } else {
                    out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
                }
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
        }
    }

    protected void exists(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            String sname = req.getParameter("sname");
            String rno = req.getParameter("rno");
            String tname2 = req.getParameter("tname2");
            String gtime = req.getParameter("gtime");
            String sql = "select count(*) from game where tname=? and tname2=? and sname=? and rno=? and gtime=?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, tname, tname2, sname, rno, gtime).toString());
            if (count >= 1) {
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
            int gno = Integer.parseInt(req.getParameter("gno"));
            String sql = "delete from game where gno=?";
            if (DBUtils.Update(sql, gno) > 0) {
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
            int gno = Integer.parseInt(req.getParameter("gno"));
            String sql = "select * from game where gno=?";
            Game game = DBUtils.QueryBean(sql, Game.class, gno);
            ResultData rd = new ResultData();
            if (game != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(game);
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
            int gno = Integer.parseInt(req.getParameter("gno"));
            String tname = req.getParameter("tname");
            String sname = req.getParameter("sname");
            String rno = req.getParameter("rno");
            String tname2 = req.getParameter("tname2");
            String gtime = req.getParameter("gtime");
            String gscore = req.getParameter("gscore");
            String sql = "update game set tname=?,tname2=?, sname=?, rno=?,gtime=?,gscore=? where gno=?";
            if (DBUtils.Update(sql, tname, tname2, sname, rno, gtime, gscore, gno) > 0) {
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
            String sqlcount = "select count(*) from game where tname like '%" + value + "%' or tname2 like '%" + value + "%' " +
                    "or sname like '%" + value + "%' or rno like '%" + value + "%' or gtime like '%" + value + "%' " +
                    " or gscore like '%" + value + "%'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select tname,tname2,sname,r.rno,r.rname,gtime,gscore from game g join referee r on g.rno=r.rno where tname like '%" + value + "%' or tname2 like '%" + value + "%' " +
                    "or sname like '%" + value + "%' or rno like '%" + value + "%' or gtime like '%" + value + "%' " +
                    "or gscore like '%" + value + "%' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Game> list = DBUtils.QueryBeanList(sqllist, Game.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getgradea(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from gradea";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from gradea limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Grade> list = DBUtils.QueryBeanList(sqllist, Grade.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void addgradea(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            String sql = "insert into gradea (tname) values(?)";
            if (DBUtils.Update(sql, tname) > 0) {
                out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
            } else {
                out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
        }
    }

    protected void deletegradea(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            String sql = "delete from gradea where tname=?";
            if (DBUtils.Update(sql, tname) > 0) {
                out.write(JSON.toJSONString(new ResultData("200", "删除成功！")));
            } else {
                out.write(JSON.toJSONString(new ResultData("500", "删除失败！")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void getgradeb(HttpServletRequest req, HttpServletResponse resp) {
        try {
            int pageIndex = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));
            int pageSize = req.getParameter("rows") == null ? 10 : Integer.parseInt(req.getParameter("rows"));
            PrintWriter out = resp.getWriter();
            HashMap<String, Object> map = new HashMap<>();
            String sqlcount = "select count(*) from gradeb";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from gradeb limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Grade> list = DBUtils.QueryBeanList(sqllist, Grade.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void addgradeb(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            String sql = "insert into gradeb (tname) values(?)";
            if (DBUtils.Update(sql, tname) > 0) {
                out.write(JSON.toJSONString(new ResultData(String.valueOf(resp.getStatus()), "保存成功")));
            } else {
                out.write(JSON.toJSONString(new ResultData("501", "保存失败")));
            }
        } catch (Exception e) {
            resp.getWriter().write(JSON.toJSONString(new ResultData("501", "数据有误，无法保存")));
        }
    }

    protected void deletegradeb(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String tname = req.getParameter("tname");
            String sql = "delete from gradeb where tname=?";
            if (DBUtils.Update(sql, tname) > 0) {
                out.write(JSON.toJSONString(new ResultData("200", "删除成功！")));
            } else {
                out.write(JSON.toJSONString(new ResultData("500", "删除失败！")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
