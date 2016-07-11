package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import DB.*;
import DAO.*;

public class LoginServlet extends HttpServlet {
	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
	throws IOException,ServletException{
		//设置响应的报头信息，内容类型为text/html。
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");

		// 获取请求参数 用户名和密码
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// 验证
  		userDAO userDAO = new userDAO();
  		user user = userDAO.login(username,password);
		if(user==null) {
			out.print("<script>alert('用户名不存在或密码错误！');location.href='login.html';</script>");
		} else {
			// 登陆成功
			// 将user存起来，请求重定向
			request.getSession().setAttribute("user", user);
			response.sendRedirect("index.jsp");
		}
	}
}
