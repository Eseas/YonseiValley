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
	<label>������ �Ϸ��� �մϱ�? : </label>
	<select id="show" class="show" name="show">
	<option>Vineyard information</option>
	<option>Vineyard trade</option>
	</select>
	<button onclick="OnDisplay()">����</button><input type="button" Onclick="location.href='main.jsp'" value="��������">

	
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
		<h1>���� ���� ����</h1>
	</div>
	<div>
	<form action="editvineyard.jsp">
	<table border = "1">
		<tr>
			<td>���� ID</td>
			<td>���� �̸�</td>
			<td>���� ����</td>
			<td>����ó</td>
			<td>red grape ���</td>
			<td>white grape ���</td>
			<td>���� �ڻ�</td>
			<td>�����ϱ�</td>
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
			<input type="submit" value = "���� ���� �����ϱ�">
		</div>
	</form>
	</div>
	</div>
	
	
	<div id="informationtradegrape" style="display:none">
	<h1>���� �Ǹ� ����</h1>
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
		
		// vineyardid�� ������ field�� ã��, �� �ʵ��� id�� ���귮�� ã�ƾ���
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
			<td>�� �̸�</td>
			<td>�⵵</td>
			<td>���귮</td>
			<td>�����ϱ�</td>
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
		<input type="submit" value="�����ϱ�">
	</div>
	</form>
	</div>
</body>
</html>