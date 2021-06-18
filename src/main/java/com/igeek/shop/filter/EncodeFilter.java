package com.igeek.shop.filter;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

//编码集过滤器
@WebFilter(filterName = "f1" , urlPatterns = "/*" ,
    initParams = @WebInitParam(name="encode",value = "utf-8"))
public class EncodeFilter implements Filter {

    private String encode;

    public void destroy() {
    }

    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest request = (HttpServletRequest)req;

        //对所有的静态资源放行
        //将所有请求路径中的 静态资源  部分，不要包含在此编码集过滤器处理中
        if(request.getRequestURI().contains("css") || request.getRequestURI().contains("js")
        || request.getRequestURI().contains("products") || request.getRequestURI().contains("fonts")
        || request.getRequestURI().contains("image") || request.getRequestURI().contains("images")
        || request.getRequestURI().contains("img")){
            chain.doFilter(request, resp);
        }else{
            req.setCharacterEncoding(encode);
            resp.setContentType("text/html;charset="+encode);
            chain.doFilter(req, resp);
        }

    }

    public void init(FilterConfig config) throws ServletException {
        encode = config.getInitParameter("encode");
    }

}
