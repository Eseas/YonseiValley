<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert winegrade in database</title>
</head>
<body>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
	
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();

		float ratio = 0.1f;
		String title = null;
		
		ratio = Float.parseFloat(request.getParameter("ratio"));
		title = request.getParameter("title");
		
		if(ratio <= 0 || title == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('�Էµ��� ���� ���� �ֽ��ϴ�.')");
			script.println("location.href='index.jsp'");
			script.println("</script>");
		}
		
		String insert_value = "INSERT INTO winegrade(title, ratio) values('" + title + "', '" + ratio + "');";
		
		stmt.executeUpdate(insert_value);
	%>
	<div>
		<h1>�����ͺ��̽��� ���� �����Ͽ����ϴ�.</h1>
		<div>
			<input type="button" Onclick="location.href='main.jsp'" value="��������">
		</div>
	</div>
</body>
</html>