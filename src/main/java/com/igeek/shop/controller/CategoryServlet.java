package com.igeek.shop.controller;

import com.google.gson.Gson;
import com.igeek.common.utils.JedisPoolUtils;
import com.igeek.shop.entity.Category;
import com.igeek.shop.service.CategoryService;
import redis.clients.jedis.Jedis;

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
 * @Date 2021/6/7 10:22
 */
@WebServlet(name="CategoryServlet",urlPatterns = "/category")
public class CategoryServlet extends BasicServlet{

    private CategoryService categoryService = new CategoryService();
    
    //查询商品分类的列表
    public void findAllCategories(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        //先从缓存中读取数据
        Jedis jedis = JedisPoolUtils.getJedis();
        String categoryListJson = jedis.get("categoryListJson");

        //若未读到数据，则发起数据库查询
        if(categoryListJson==null){
            System.out.println("----------------------");
            //发起至数据库中查询数据
            List<Category> categories = categoryService.findAllCategories();

            //json数据
            Gson gson = new Gson();
            categoryListJson = gson.toJson(categories);

            //将json数据添加至redis中
            jedis.set("categoryListJson",categoryListJson);
        }

        //将json数据响应至客户端
        response.getWriter().write(categoryListJson);
    }

}
