<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert Vineyard data in database</title>
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
		String[] checkbox1 = null;
		checkbox1 = request.getParameterValues("checkbox1");
		
		String VineyardID = null;
		String Vineyardname = request.getParameter("Vineyardname");
		String owner = request.getParameter("owner");
		String telnumber = request.getParameter("tel_number");
		int stock_red = Integer.parseInt(request.getParameter("stock_red"));
		int stock_white = Integer.parseInt(request.getParameter("stock_white"));
		int money = Integer.parseInt(request.getParameter("money"));
		
		String insert_value = "INSERT INTO Vineyard(Vineyardname, owner, tel_number, stock_red, stock_white, money) VALUES ('" + Vineyardname + "', '" + owner + "', '" + telnumber + "', '" + stock_red + "', '" + stock_white + "', '" + money + "');";
		
		String setfieldowner;
		
		stmt.executeUpdate(insert_value);
		
		String find_vineyardid = "SELECT VineyardID FROM Vineyard WHERE Vineyardname = '"+ Vineyardname + "' && owner = '" + owner + "' && tel_number = '" + telnumber + "' && stock_red = " + stock_red + " && stock_white = " + stock_white + " && money = " + money + ";";
		
		result = stmt.executeQuery(find_vineyardid);
		while(result.next()){
			VineyardID = result.getString("VineyardID");
		}
		
		for(int i = 0; i < checkbox1.length; i++) {
			setfieldowner = "UPDATE Field SET VineyardID = " + VineyardID + " WHERE FieldID = '" + checkbox1[i] + "';";
			stmt.executeUpdate(setfieldowner);
		}
	%>
	<div>
	<h1>결과</h1>
	<p>전송된 내용은 다음과 같습니다.</p>
	<p>
		농장 ID : <%=VineyardID %> <br>
		농장 이름 : <%=Vineyardname %> <br>
		소유주 : <%=owner %> <br>
		연락처 : <%=telnumber %> <br>
		red grape 재고 : 	<%=stock_red %> <br>
		white grape 재고 : <%= stock_white%> <br>
		보유 자금 : <%=money %> <br>
	<%	for(int i = 0; i < checkbox1.length; i++) {%>
		소유한 밭 : <%=checkbox1[i] %>
		<%}%>
	</p>
	</div>
</body>
</html>