package Servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DB.*;
import DAO.*;

public class RegisterServlet extends HttpServlet {
	public void doPost(HttpServletRequest request,
			HttpServletResponse response)
	throws IOException,ServletException{
		//������Ӧ�ı�ͷ��Ϣ����������Ϊtext/html��
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		request.setCharacterEncoding("utf-8");

		// ��ȡ������� �û�����������ǳ�
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");

		// ��֤
  		userDAO userDAO = new userDAO();
  		user user = userDAO.register(username,password,nickname);
		if(user==null) {
			out.print("<script>alert('�û������ǳ��Ѵ��ڣ�');location.href='register.html';</script>");
		} else {
			// ע��ɹ�
			// ��user�������������ض���
			out.print("<script>alert('ע��ɹ���');location.href='login.html';</script>");
			//request.getSession().setAttribute("user", user);
			//response.sendRedirect("index.jsp");
		}
	}
}

