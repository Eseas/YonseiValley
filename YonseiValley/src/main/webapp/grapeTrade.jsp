<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Grape Trade</title>
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
		
		
		String wineryID = request.getParameter("radio3");
		String wineryname = "";
		String money = "";
		String Vineyard_red = "";
		String Vineyard_white = "";
		String VineyardID = "";
		
		
		
		String query1 = "SELECT * FROM Winery WHERE WineryID = '" + wineryID + "';";
		
		String find_winery = "SELECT * FROM winery WHERE Wineryid = '" + wineryID + "';";
		String find_winestock = "SELECT * FROM winestock WHERE Wineryid = '" + wineryID + "' ORDER BY WineStockID ASC;";
		
		result = stmt.executeQuery(find_winestock);
		
		result = stmt.executeQuery(query1);
	%>
		<h1>���� ����</h1>
		<form action="resulttradegrape.jsp">
		<div>
	<%
		while (result.next()){ 
			wineryname = result.getString("Wineryname");%>
			<label>�� ���� ������� ���� �ڱ��� <%=money = result.getString("money") %>�Դϴ�.</label>
			<label>�� ���� ������� �ŷ�ó�� <%= VineyardID = result.getString("VineyardID")%>�Դϴ�.</label> <br>
	<%	}
	
		String query2 = "SELECT * FROM Vineyard WHERE VineyardID = '" + VineyardID + "';";
		result = stmt.executeQuery(query2);
		
		while (result.next()){ 
		Vineyard_red = result.getString("stock_red");
		Vineyard_white = result.getString("stock_white");
	%>
		<label>�� �������忡�� red grape�� <input type="text" name="Vineyardred" value="<%=Vineyard_red%>" readonly>��,
		white grape�� <input type="text" name="vineyardwhite" value="<%=Vineyard_white%>" readonly>�� �ֽ��ϴ�.</label> <br>
		<label>�󸶳� ��ðڽ��ϱ�?</label>
<%	}
	%>
		<label>�� <input type="text" name="wineryname" value="<%=wineryname%>" readonly>���� ������ �����մϴ�.</label> <br><br>
		<label>����� �� ���Դϱ�? : <input type="text" name="year"></label> <br><br><br>
		<label>red grape : </label><input type="text" name="trade_red" id="trade_red" >
		<label>white grape : </label><input type="text" name="trade_white" id="trade_white" >
		</div>
		<input type="submit" value="�����ϱ�">
		</form>
</body>
</html>