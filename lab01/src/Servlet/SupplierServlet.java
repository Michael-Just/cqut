package Servlet;

import com.alibaba.fastjson.JSON;
import entity.Supplier;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;

import utils.DBUtils;
import utils.ResultData;

public class SupplierServlet extends HttpServlet {
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
            String sqlcount = "select count(*) from supplier";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from supplier limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Supplier> list = DBUtils.QueryBeanList(sqllist, Supplier.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void add(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            PrintWriter out = resp.getWriter();
            String supplierno = req.getParameter("supplierno");
            String suppliername = req.getParameter("suppliername");
            String address = req.getParameter("address");
            String number = req.getParameter("number");
            String sql = "insert into supplier (supplierno, suppliername, address, number) values(?,?,?,?)";
            if (DBUtils.Update(sql, supplierno, suppliername, address, number) > 0) {
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
            String supplierno = req.getParameter("supplierno");
            String sql = "select count(*) from supplier where supplierno = ?";
            int count = Integer.parseInt(DBUtils.QueryScalar(sql, supplierno).toString());
            if (count == 1) {
//                out.write(JSON.toJSONString(new ResultData("201","供应商编码已经存在！")));
                out.write("false");
            } else {
//                out.write(JSON.toJSONString(new ResultData("301","供应商编码不存在！")));
                out.write("true");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    protected void delete(HttpServletRequest req, HttpServletResponse resp) {
        try {
            PrintWriter out = resp.getWriter();
            String supplierno = req.getParameter("supplierno");
            String sql = "delete from supplier where supplierno = ?";
            if (DBUtils.Update(sql, supplierno) > 0) {
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
            String supplierno = req.getParameter("supplierno");
            String sql = "select * from supplier where supplierno = ?";
            Supplier supplier = DBUtils.QueryBean(sql, Supplier.class, supplierno);
            ResultData rd = new ResultData();
            if (supplier != null) {
                rd.setCode(String.valueOf(resp.getStatus()));
                rd.setMsg("获取成功");
                rd.setData(supplier);
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
            String supplierno = req.getParameter("supplierno");
            String suppliername = req.getParameter("suppliername");
            String address = req.getParameter("address");
            String number = req.getParameter("number");
            String sql = "update supplier set suppliername=?, address=?, number=? where supplierno = ?";
            if (DBUtils.Update(sql, suppliername, address, number, supplierno) > 0) {
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
            String sqlcount = "select count(*) from supplier where supplierno like '%"+value+"%' or suppliername like '%"+value+"%' or" +
                    " address like '%"+value+"%' or number like '%"+value+"%'";
            int total = Integer.parseInt(DBUtils.QueryScalar(sqlcount).toString());
            map.put("total", total);
            String sqllist = "select * from supplier where supplierno like '%"+value+"%' or suppliername like '%"+value+"%' or" +
                    " address like '%"+value+"%' or number like '%"+value+"%' limit " + (pageIndex - 1) * pageSize + "," + pageSize;
            List<Supplier> list = DBUtils.QueryBeanList(sqllist, Supplier.class);
            map.put("rows", list);
            out.write(JSON.toJSONString(map));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
