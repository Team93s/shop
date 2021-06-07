package com.igeek.shop.controller;

import com.igeek.shop.entity.Product;
import com.igeek.shop.service.CategoryService;
import com.igeek.shop.service.ProductService;
import com.igeek.shop.vo.PageVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @version 1.0
 * @Description TODO
 * @Author chenmin
 * @Date 2021/6/7 9:26
 */
@WebServlet(name="ProductServlet",urlPatterns = "/product")
public class ProductServlet extends BasicServlet{

    private ProductService productService = new ProductService();
    private CategoryService categoryService = new CategoryService();

    //展示首页
    public void index(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        //热门数据
        List<Product> hotProducts = productService.findHotProducts();

        //最新数据
        List<Product> newProducts = productService.findNewProducts();

        //跳转至页面中
        request.setAttribute("hotProducts",hotProducts);
        request.setAttribute("newProducts",newProducts);
        request.getRequestDispatcher("index.jsp").forward(request,response);
    }

    //通过商品类别和商品名称的分页查询列表
    public void findProducts(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
        String cid = request.getParameter("cid");
        String name = request.getParameter("pname");
        String page = request.getParameter("pageNow");

        //通过cid查询cname，并且放至请求域，供导航条使用
        if(cid!=null && !cid.equals("")){
            String cname = categoryService.findCname(cid);
            if(cname!=null){
                request.setAttribute("cname",cname);
            }
        }

        //搜索时的商品名称
        String pname = "";
        if(name==null){
            pname = "";
        }else{
            pname = name;
        }

        //分页的当前页码
        int pageNow = 1;
        if(page==null){
            pageNow = 1;
        }else{
            pageNow = Integer.parseInt(page);
        }

        //查询商品列表
        PageVO<Product> vo = productService.findProducts(cid, pname, pageNow);
        request.setAttribute("vo",vo);

        //请求转发
        request.getRequestDispatcher("product_list.jsp").forward(request,response);
    }

}
