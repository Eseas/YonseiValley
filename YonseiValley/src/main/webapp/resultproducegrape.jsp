<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<h1>���</h1>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
		
		String VineyardID = request.getParameter("VineyardID");
		String year = request.getParameter("year");
		String Fieldname = "0";
		String produceamount = request.getParameter("produce");
		
		String find_field = "SELECT * FROM Field WHERE VineyardID = '" + VineyardID + "';";
		
		result = stmt.executeQuery(find_field);
		
		while(result.next()) {
			int FieldID = result.getInt("FieldID");
			Fieldname = result.getString("Fieldname");
			
			String insert_value = "INSERT INTO grapeproduce(year, amount, FieldID) values('" + year + "', " + produceamount + "', "
								+ FieldID + "')";
			stmt.executeUpdate(insert_value);
			%>
			<div>
	
				<p>���۵� ������ ������ �����ϴ�.</p>
				<p>
					<%=Fieldname %>�� ���귮 : <%= produceamount %> <br>
				</p>
			</div>
	<%	}
	%>
	
	
</body>
</html>