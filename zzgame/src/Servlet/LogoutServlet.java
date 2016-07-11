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
		// ���session
		HttpSession session = request.getSession();
		// ����session
		//session.invalidate();
		// �˳���½Ӧ�ý�user�����session�����Ƴ�
		session.setAttribute("user", null);
		// �����ض�����ҳ
		response.sendRedirect("../zzgame/login.html");		
	}
}
