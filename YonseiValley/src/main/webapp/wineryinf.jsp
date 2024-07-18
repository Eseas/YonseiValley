<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>manage winery</title>
</head>
<body>
	<label>무엇을 하려고 합니까? : </label>
	<select id="show" class="show" name="show">
	<option>Winery information</option>
	<option>Wine stock</option>
	<option>Wine production</option>
	<option>Wine trade</option>
	</select>
	<button onclick="OnDisplay()">실행</button><input type="button" Onclick="location.href='main.jsp'" value="메인으로">
		<script>
			function OnDisplay(){
				var selectOption = document.getElementById("show");
				selectOption = selectOption.options[selectOption.selectedIndex].value;
				
				if(selectOption == 'Winery information') {
					document.getElementById("wineryinformation").style.display="block";
					document.getElementById("winestock").style.display="none";
					document.getElementById("wineproduction").style.display="none";
					document.getElementById("winetrade").style.display="none";
				}
				else if(selectOption == 'Wine stock') {
					document.getElementById("wineryinformation").style.display="none";
					document.getElementById("winestock").style.display="block";
					document.getElementById("wineproduction").style.display="none";
					document.getElementById("winetrade").style.display="none";
				}
				else if(selectOption == 'Wine production') {
					document.getElementById("wineryinformation").style.display="none";
					document.getElementById("winestock").style.display="none";
					document.getElementById("wineproduction").style.display="block";
					document.getElementById("winetrade").style.display="none";
				}
				else if(selectOption == 'Wine trade') {
					document.getElementById("wineryinformation").style.display="none";
					document.getElementById("winestock").style.display="none";
					document.getElementById("wineproduction").style.display="none";
					document.getElementById("winetrade").style.display="block";
				}
			}
		</script>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();

		String WineryID = request.getParameter("radio1");
		String query1 = "SELECT * FROM Winery WHERE WineryID = '" + WineryID + "';";
		String query2 = "SELECT * FROM WineStock WHERE WineryID = '" + WineryID + "';";
		String query3 = "SELECT * FROM Wineproduction WHERE WineryID = '" + WineryID + "';";
		String query4 = "SELECT * FROM Winetrade WHERE WineryID = '" + WineryID + "';";
	%>
	
	<%//----------------------------------------
	  // 와인 생산소 정보
	  //----------------------------------------%>
	
	<div id = wineryinformation style="display:block">
	<div><h1>와인 생산소 정보</h1></div>
	<form action="editwinery.jsp">
	<div>
	<table border = "1">
		<tr>
			<td>와인 생산소 ID</td>
			<td>와인 생산소 이름</td>
			<td>와인 생산소 주인</td>
			<td>연락처</td>
			<td>red grape 재고</td>
			<td>white grape 재고</td>
			<td>보유 자산</td>
			<td>생산소 등급</td>
			<td>수정하기</td>
		</tr>
		<%
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getString("WineryID") %></td>
			<td><%= result.getString("Wineryname") %></td>
			<td><%= result.getString("owner") %></td>
			<td><%= result.getString("tel_number") %></td>
			<td><%= result.getInt("stock_red") %></td>
			<td><%= result.getInt("stock_white") %></td>
			<td><%= result.getInt("money") %></td>
			<td><%= result.getString("grade_ID") %></td>
			<% String WineryID1 = result.getString("WineryID"); %>
			<td><input type=radio name="radio2" value='<%= WineryID1%>'></td>
		</tr>
	<% }%>
	</table>
	</div>
		<input type="submit" value="수정하기">
	</form>
	<div>
	<input type="button" Onclick="location.href='main.jsp'" value="메인으로">
	</div>
	</div>
	<%//----------------------------------------
	  // 와인 저장고 정보.
	  //----------------------------------------%>
	
	<div id="winestock" style="display:none">
	<div>
		<h1>와인 저장고</h1>
	</div>
	<div>
	<table border = "1">
		<tr>
			<td>와인 저장고 이름</td>
			<td>와인 종류</td>
			<td>갯수</td>
		</tr>
		<%
		
		result = stmt.executeQuery(query2);
		
		while(result.next())
		{
		%>
		<tr>
			<td> <%= result.getInt("WineStockID") %></td>
			<td> <%= result.getString("categoryID") %></td>
			<td> <%= result.getString("amount") %></td>
		</tr>
	<% }%>
	</table>
	</div>
	</div>
	<%//----------------------------------------
	  // 와인 생산 내역
	  //----------------------------------------%>
	
	<div id="wineproduction" style="display:none">
	<form action="editproducewine.jsp">
	<div>
		<h1>와인 생산 내역</h1>
	</div>
	<div>
	<table border = "1">
		<tr>
			<td>생산 번호</td>
			<td>와인 종류</td>
			<td>생산 년도</td>
			<td>갯수</td>
			<td>수정하기</td>
		</tr>
		<%
		
		result = stmt.executeQuery(query3);
		
		while(result.next())
		{
		%>
		<tr>
			<td> <%= result.getInt("WPID") %> </td>
			<td> <%= result.getString("categoryID") %> </td>
			<td> <%= result.getString("year") %> </td>
			<td> <%= result.getString("amount") %> </td>
			<% String WPID1 = result.getString("WPID"); %>
			<td><input type=radio name="radio4" value='<%= WPID1%>'></td>
		</tr>
	<% }%>
	</table>
	</div>
	<div>
		<input type="submit" value="수정하기">
	</div>
	</form>
	</div>
	<%//----------------------------------------
	  // 와인 판매 내역
	  //----------------------------------------%>
	
	<div id="winetrade" style="display:none">
		<div>
			<h1>와인 판매 내역</h1>
		</div>
	<div>
	<form action="edittradewine.jsp">
		<table border = "1">
		<tr>
			<td>판매 년도</td>
			<td>판매 와인 종류</td>
			<td>판매 갯수</td>
			<td>와인 생산소 ID</td>
			<td>수정하기</td>
		</tr>
		<%
		result = stmt.executeQuery(query4);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getString("year") %></td>
			<td><%= result.getString("amount") %></td>
			<td><%= result.getString("amount") %></td>
			<td><%= result.getString("WineryID") %></td>
			<% String WTID1 = result.getString("WTID"); %>
			<td><input type=radio name="radio3" value='<%= WTID1%>'></td>
		</tr>
	<% }%>
	</table>
	<input type="submit" value="수정하기">	
	</form>
	</div>
	</div>
	
	
</body>
</html>