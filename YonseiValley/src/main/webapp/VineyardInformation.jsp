<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Vineyard Information</title>
</head>
<body>
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
		
		String vineyardid = request.getParameter("radio3");
		
%>
	<label>무엇을 하려고 합니까? : </label>
	<select id="show" class="show" name="show">
	<option>Vineyard information</option>
	<option>Vineyard trade</option>
	</select>
	<button onclick="OnDisplay()">실행</button><input type="button" Onclick="location.href='main.jsp'" value="메인으로">

	
		<script>
			function OnDisplay(){
				var selectOption = document.getElementById("show");
				selectOption = selectOption.options[selectOption.selectedIndex].value;
				
				if(selectOption == 'Vineyard information') {
					document.getElementById("vineyardinformation").style.display="block";
					document.getElementById("informationtradegrape").style.display="none";
				}
				if(selectOption == 'Vineyard trade') {
					document.getElementById("vineyardinformation").style.display="none";
					document.getElementById("informationtradegrape").style.display="block";
				}
			}
			
		</script>
	<div id="vineyardinformation" style="display:none">
	<div>
		<h1>포도 농장 정보</h1>
	</div>
	<div>
	<form action="editvineyard.jsp">
	<table border = "1">
		<tr>
			<td>농장 ID</td>
			<td>농장 이름</td>
			<td>농장 주인</td>
			<td>연락처</td>
			<td>red grape 재고</td>
			<td>white grape 재고</td>
			<td>보유 자산</td>
			<td>수정하기</td>
		</tr>
		<%		
		String query = "SELECT * FROM Vineyard WHERE VineyardID = '" + vineyardid + "';";
		
		result = stmt.executeQuery(query);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getInt("VineyardID") %></td>
			<td><%= result.getString("Vineyardname") %></td>
			<td><%= result.getString("owner") %></td>
			<td><%= result.getString("tel_number") %></td>
			<td><%= result.getInt("stock_red") %></td>
			<td><%= result.getInt("stock_white") %></td>
			<td><%= result.getInt("money") %></td>
			<% String VineyardID = result.getString("VineyardID"); %>
			<td><input type=radio name="radio1" value='<%= VineyardID%>'></td>
		</tr>
	<% }%>
	</table>
		<div>
			<input type="submit" value = "농장 정보 수정하기">
		</div>
	</form>
	</div>
	</div>
	
	
	<div id="informationtradegrape" style="display:none">
	<h1>포도 판매 내역</h1>
	<form action="edittradegrape.jsp">
	<%
		String find_field = "SELECT * FROM field WHERE VineyardID = '" + vineyardid + "';";
		String find_vineyard = "SELECT * FROM Vineyard;";
		String find_grapeproduce = null;
		int[] amount_produce = null;
		int[] amount_sell = null;
		int length_fieldid = 0;
		int origin_fieldid_size = 0;
		
		List<String> fieldid = new ArrayList<String>();
		List<String> year = new ArrayList<String>();
		List<String> gpid = new ArrayList<String>();
		
		// vineyardid로 소유한 field를 찾고, 그 필드의 id로 생산량을 찾아야함
		result = stmt.executeQuery(find_field);
		while(result.next()){
			fieldid.add(result.getString("FieldID"));
		}
		length_fieldid = fieldid.size(); 
		
		amount_produce = new int[length_fieldid];
		
		for(int i = 0; i < length_fieldid; i++) {
			find_grapeproduce = "SELECT * FROM grapeproduce WHERE FieldID = '" + fieldid.get(i) + "';";
			result = stmt.executeQuery(find_grapeproduce);
			while(result.next()){
				year.add(result.getString("year"));
				gpid.add(result.getString("GPID"));
				amount_produce[i] = result.getInt("amount");
			}
		}
		
	%>
	
	<table border = "1">
		<tr>
			<td>밭 이름</td>
			<td>년도</td>
			<td>생산량</td>
			<td>수정하기</td>
		</tr>
		<%
		for(int i = 0; i < length_fieldid; i++)
		{
		%>
		<tr>
			<td><%=fieldid.get(i) %></td>
			<td><%=year.get(i) %>
			<td><%=amount_produce[i] %></td>
			<td><input type=radio name="radio4" value="<%= gpid.get(i)%>"></td>
		</tr>
	<%	} %>
	</table>
	<div>
		<input type="submit" value="수정하기">
	</div>
	</form>
	</div>
</body>
</html>