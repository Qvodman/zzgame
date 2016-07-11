package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet{
	public void service(HttpServletRequest request, HttpServletResponse response)
	throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		// 获得session
		HttpSession session = request.getSession();
		// 销毁session
		//session.invalidate();
		// 退出登陆应该将user对象从session域中移除
		session.setAttribute("user", null);
		// 请求重定向到首页
		response.sendRedirect("../zzgame/login.html");		
	}
}
