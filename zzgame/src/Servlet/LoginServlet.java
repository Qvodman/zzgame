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
		//������Ӧ�ı�ͷ��Ϣ����������Ϊtext/html��
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");

		// ��ȡ������� �û���������
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		// ��֤
  		userDAO userDAO = new userDAO();
  		user user = userDAO.login(username,password);
		if(user==null) {
			out.print("<script>alert('�û��������ڻ��������');location.href='login.html';</script>");
		} else {
			// ��½�ɹ�
			// ��user�������������ض���
			request.getSession().setAttribute("user", user);
			response.sendRedirect("index.jsp");
		}
	}
}
