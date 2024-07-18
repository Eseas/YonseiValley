<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>manage winery</title>
</head>
<body>
	<label>무엇을 하려고 합니까? : </label>
	<select id="show" class="show" name="show">
	<option>Winery</option>
	<option>Winery Edit</option>
	<option>Trade Grape</option>
	<option>Produce Wine</option>
	<option>Trade Wine</option>
	<option>wine trade information</option>
	</select>
	<button onclick="OnDisplay()">실행</button><input type="button" Onclick="location.href='main.jsp'" value="메인으로">

	
		<script>
			function OnDisplay(){
				var selectOption = document.getElementById("show");
				selectOption = selectOption.options[selectOption.selectedIndex].value;
				
				if(selectOption == 'Winery') {
					document.getElementById("winery").style.display="block";
					document.getElementById("editwinery").style.display="none";
					document.getElementById("tradegrape").style.display="none";
					document.getElementById("producewine").style.display="none";
					document.getElementById("winetradeinmormation").style.display="none";
				}
				else if(selectOption == 'Winery Edit') {
					document.getElementById("winery").style.display="none";
					document.getElementById("editwinery").style.display="block";
					document.getElementById("tradegrape").style.display="none";
					document.getElementById("producewine").style.display="none";
					document.getElementById("winetradeinmormation").style.display="none";
				}
				else if(selectOption == 'Trade Grape') {
					document.getElementById("winery").style.display="none";
					document.getElementById("editwinery").style.display="none";
					document.getElementById("tradegrape").style.display="block";
					document.getElementById("producewine").style.display="none";
					document.getElementById("winetradeinmormation").style.display="none";
				}
				else if(selectOption == 'Produce Wine') {
					document.getElementById("winery").style.display="none";
					document.getElementById("editwinery").style.display="none";
					document.getElementById("tradegrape").style.display="none";
					document.getElementById("producewine").style.display="block";
					document.getElementById("winetradeinmormation").style.display="none";
				}
				else if(selectOption == 'Trade Wine') {
					document.getElementById("winery").style.display="none";
					document.getElementById("editwinery").style.display="none";
					document.getElementById("tradegrape").style.display="none";
					document.getElementById("producewine").style.display="none";
					document.getElementById("tradewine").style.display="block";
				}
			}
			
			function Onwineryinformation() {
				document.getElementById("winery").style.display="none";
				document.getElementById("wineryinformation").style.display="block";
			}
		</script>
	<%
		String jdbcDriver = "jdbc:mariadb://localhost:3306/Lab";
		String dbUser = "root";
		String dbPass = "a1234";

		Connection conn = null;
		Statement stmt = null;
		ResultSet result = null;
		ResultSet result2 = null;
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		stmt = conn.createStatement();
	%>
	
	<div id="winery" style="display:none">
	<div>
		<h1>와인 생산소 정보</h1>
	</div>
	<form action="wineryinf.jsp">
	<div>
	<table border = "1">
		<tr>
			<td>와인 생산소 ID</td>
			<td>와인 생산소 이름</td>
			<td>검색하기</td>
		</tr>
		<%
		String query1 = "SELECT * FROM Winery ORDER BY WineryID ASC;";
		
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getString("WineryID") %></td>
			<td><%= result.getString("Wineryname") %></td>
			<% String WineryID = result.getString("WineryID"); %>
			<td><input type=radio name="radio1" value='<%= WineryID%>'></td>
		</tr>
	<% }%>
	</table>
	<input type="submit" value="상세 정보">
	</div>
	</form>
	</div>
	
	
	<div id="editwinery" style="display:none">
	<h1>수정하기</h1>
	<form action="editwinery.jsp">
	<table border = "1">
		<tr>
			<td>와인 생산소 ID</td>
			<td>와인 생산소 이름</td>
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
			<% String WineryID = result.getString("WineryID"); %>
			<td><input type=radio name="radio2" value='<%= WineryID%>'></td>
		</tr>
	<% }%>
	</table>
		<input type=submit value="수정하기">
	</form>
	</div>
	
	<div id="tradegrape" style="display:none">
	<h1>포도 구매하기</h1>
		<form action="grapeTrade.jsp">
			<table border = "1">
		<tr>
			<td>와인 생산소 ID</td>
			<td>와인 생산소 이름</td>
			<td>구매하기</td>
		</tr>
		<%
		
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getString("WineryID") %></td>
			<td><%= result.getString("Wineryname") %></td>
			<% String WineryID = result.getString("WineryID"); %>
			<td><input type=radio name="radio3" value='<%= WineryID%>'></td>
		</tr>
	<% }%>
	</table>
	<div>
		<input type="submit" value="구매하기">
	</div>
	</form>
	</div>
	
	<div id="tradewine" style="display:none">
	<h1>와인 판매하기</h1>
		<form action="winetrade.jsp">
			<table border = "1">
		<tr>
			<td>와인 생산소 ID</td>
			<td>와인 생산소 이름</td>
			<td>판매하기</td>
		</tr>
		<%
		
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getString("WineryID") %></td>
			<td><%= result.getString("Wineryname") %></td>
			<% String WineryID = result.getString("WineryID"); %>
			<td><input type=radio name="radio4" value='<%= WineryID%>'></td>
		</tr>
	<% }%>
	</table>
	<div>
		<input type="submit" value="판매하기">
	</div>
	</form>
	</div>
	
	<div id="producewine" style="display:none">
	<h1>와인 생산하기</h1>
		<form action="producewine.jsp">
			<table border = "1">
		<tr>
			<td>와인 생산소 ID</td>
			<td>와인 생산소 이름</td>
			<td>생산하기</td>
		</tr>
		<%
		
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getString("WineryID") %></td>
			<td><%= result.getString("Wineryname") %></td>
			<% String WineryID = result.getString("WineryID"); %>
			<td><input type=radio name="radio4" value='<%= WineryID%>'></td>
		</tr>
	<% }%>
	</table>
	<div>
		<input type="submit" value="생산하기">
	</div>
	</form>
	</div>
	
	<div id="winetradeinmormation" style="display:none">
	<div>
		<h1>와인 생산소 통계 정보</h1>
	</div>
	<div>
	<table border = "1">
		<tr>
			<td>와인 생산소 이름</td>
			<td>총 포도 구매량</td>
			<td>총 와인 생산량</td>
			<td>총 와인 판매량</td>
		</tr>
		<%
		
		String find_winery = "SELECT * FROM Winery;";
		String find_buy_grape = null;
		String find_produce = null;
		String find_trade = null;
		int[] amount_buy_grape = null;
		int[] amount_produce = null;
		int[] amount_sell = null;
		int length_wineryid = 0;
		int origin_wineryid_size = 0;
		
		List<String> wineryid = new ArrayList<String>();
		List<String> wineryname = new ArrayList<String>();
		
		result = stmt.executeQuery(find_winery);
		while(result.next()){
			wineryid.add(result.getString("WineryID"));
			wineryname.add(result.getString("Wineryname"));
		}
		length_wineryid = wineryid.size();
		
		amount_buy_grape = new int[length_wineryid];
		amount_produce = new int[length_wineryid];
		amount_sell = new int[length_wineryid];
		
		for(int i = 0; i < length_wineryid; i++) {
			find_buy_grape = "SELECT * FROM grapetrade WHERE WineryID = '" + wineryid.get(i) + "';";
			result2 = stmt.executeQuery(find_buy_grape);
			while(result.next()){
				amount_buy_grape[i] = amount_buy_grape[i] + result.getInt("amount");
			}
		}
		
		for(int i = 0; i < length_wineryid; i++) {
			find_produce = "SELECT * FROM wineproduction WHERE WineryID = '" + wineryid.get(i) + "';";
			result = stmt.executeQuery(find_produce);
			while(result.next()){
				amount_produce[i] = amount_produce[i] + result.getInt("amount");
			}
		}
		
		for(int i = 0; i < length_wineryid; i++) {
			find_trade = "SELECT * FROM winetrade WHERE WineryID = '" + wineryid.get(i) + "';";
			result = stmt.executeQuery(find_trade);
			while(result.next()){
				amount_sell[i] = amount_sell[i] + result.getInt("amount");
			}
		}
		
		for (int i = 0; i < length_wineryid; i++) {
		%>
		<tr>
			<td><%=wineryname.get(i) %></td>
			<td><%=amount_buy_grape[i] %></td>
			<td><%=amount_produce[i] %></td>
			<td><%=amount_sell[i] %></td>
		</tr>
	<%	} %>
	</table>
	</div>
	</div>
</body>
</html>