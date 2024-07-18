<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import = "java.sql.*"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Field Information</title>
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
	%>
	<%	//-------------------------------------------------
		//	�۾� ����
		//------------------------------------------------- %>
	<label>������ �Ϸ��� �մϱ�? : </label>
	<select id="show" class="show" name="show">
	<option>Field</option>
	<option>Vineyard</option>
	</select>
	<button onclick="OnDisplay()">����</button>  <input type="button" Onclick="location.href='main.jsp'" value="��������">
	<%	//-------------------------------------------------
		//	������ ���ΰ�ħ
		//------------------------------------------------- %>

		<script>
			function OnDisplay(){
				var selectOption = document.getElementById("show");
				selectOption = selectOption.options[selectOption.selectedIndex].value;
				if(selectOption == 'Field') {
					document.getElementById("field").style.display="block";
					document.getElementById("fieldinformation").style.display="none";
					document.getElementById("vineyard").style.display="none";
					document.getElementById("vineyardinformation").style.display="none";
					
				}
				else if(selectOption == 'Vineyard') {
					document.getElementById("field").style.display="none";
					document.getElementById("fieldinformation").style.display="none";
					document.getElementById("vineyard").style.display="block";
					document.getElementById("vineyardinformation").style.display="none";
				}
			}
			function Displayfieldinformation(){
				document.getElementById("field").style.display="none";
				document.getElementById("fieldinformation").style.display="block";
			}
			function DisplayVineyardinformation(){
				document.getElementById("vineyard").style.display="none";
				document.getElementById("vineyardinformation").style.display="block";
			}
		</script>
		
	<%	//-------------------------------------------------
		//	Field ���� ����
		//------------------------------------------------- %>
	
	<div id="field" style="display:none">
	
	<div>
		<h1>�� ����</h1>
	</div>
	
	<table border = "1">
		<tr>
			<td>�� ID</td>
			<td>�� �̸�</td>
		</tr>
	<%
		String query1 = "SELECT * FROM Field ORDER BY FieldID ASC;";
		
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
	%>
		<tr>
			<td><%= result.getInt("FieldID") %></td>
			<td><%= result.getString("Fieldname") %></td>
		</tr>
	<%} %>
	</table>
	
	<button onclick="Displayfieldinformation()">�� ���� ���</button>
	</div> <% // �� �⺻ div �� %>
	
	<div id="fieldinformation" style="display:none">
	<form action="editfield.jsp">
	<h1>�� ��ü �� ����</h1>
	
	<table border = "1">
		<tr>
			<td>�� ID</td>
			<td>�� �̸�</td>
			<td>���</td>
			<td>�� ũ��</td>
			<td>����ϴ� ����</td>
			<td>������ ID</td>
			<td>�����ϱ�</td>
		</tr>
		<%
		
		result = stmt.executeQuery(query1);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getInt("FieldID") %></td>
			<td><%= result.getString("Fieldname") %></td>
			<td><%= result.getString("location") %></td>
			<td><%= result.getInt("area") %></td>
			<td><%= result.getString("variety") %></td>
			<td><%= result.getInt("VineyardID") %></td>
			<% String Fieldid = result.getString("FieldID"); %>
			<td><input type=radio name="radio1" value="<%= Fieldid%>"></td>
		</tr>
	<% }%>
	</table>
	
		<div>
			<input type=submit value = "�� ���� �����ϱ�">
		</div>
	</form>
	</div> <% // �� ���� ���̺� �κ� �� %>
	
	
	<div id = "vineyard" style="display:none">
	<form action="VineyardInformation.jsp">
	<div> <h1>���� ���� ����</h1> </div>
	<table border = "1">
		<tr>
			<td>���� ID</td>
			<td>���� �̸�</td>
			<td>���� ����</td>
			<td>�����ϱ�</td>
		</tr>
		<%
		String query2 = "SELECT * FROM Vineyard ORDER BY VineyardID ASC;";
		
		result = stmt.executeQuery(query2);
		
		while(result.next())
		{
		%>
		<tr>
			<td><%= result.getInt("VineyardID") %></td>
			<td><%= result.getString("Vineyardname") %></td>
			<td><%= result.getString("owner") %></td>
			<% String VineyardID =  result.getString("VineyardID"); %>
			<td><input type=radio name="radio3" value='<%= VineyardID%>'></td>
		</tr>
	<% }%>
	</table>
		<div>
			<input type=submit value = "�������� ���� ��ȸ�ϱ�">
		</div>
	</form>
	
	<div>
	<div>
		<h1>���� ���� ��� ����</h1>
	</div>
	<div>
	<table border = "1">
		<tr>
			<td>���� �̸�</td>
			<td>�� ���� ���귮</td>
			<td>�� ���� �Ǹŷ�</td>
		</tr>
		<%
		
		String find_field = "SELECT * FROM field;";
		String find_vineyard = "SELECT * FROM Vineyard;";
		String find_grapeproduce = null;
		int[] amount_produce = null;
		int[] amount_sell = null;
		int length_fieldid = 0;
		int length_vineyardid = 0;
		int origin_fieldid_size = 0;
		int i = 0;
		
		List<String> fieldid = new ArrayList<String>();
		List<String> vineyardid = new ArrayList<String>();
		List<String> vineyardname = new ArrayList<String>();
		
		result = stmt.executeQuery(find_vineyard);
		while(result.next()){
			vineyardid.add(result.getString("VineyardID"));
			vineyardname.add(result.getString("Vineyardname"));
			length_vineyardid = vineyardid.size();
		}
		
		amount_produce = new int[length_vineyardid];
		amount_sell = new int[length_vineyardid];
		for(i = 0; i < length_vineyardid; i++) {
			result = stmt.executeQuery(find_field);
			while(result.next()){
				origin_fieldid_size = fieldid.size();
				fieldid.add(result.getString("FieldID"));
				
				length_fieldid = fieldid.size() - origin_fieldid_size;
			}	
				for(int j = 0; j < length_fieldid; j++) {
					find_grapeproduce = "SELECT * FROM grapeproduce WHERE FieldID = '" + fieldid.get(i) + "';";
					result2 = stmt.executeQuery(find_grapeproduce);
					while(result2.next()){
						amount_produce[i] = amount_produce[i] + result2.getInt("amount");
				}
			}
		}
			
		for(i = 0; i < length_vineyardid; i++) {
			find_grapeproduce = "SELECT * FROM grapetrade WHERE VineyardID = '" + vineyardid.get(i) + "';";
			result = stmt.executeQuery(find_grapeproduce);
			while(result.next()){
				amount_sell[i] = amount_sell[i] + result.getInt("amount");
			}
		}
		
		for (i = 0; i < length_vineyardid; i++) {
		%>
		<tr>
			<td><%=vineyardname.get(i) %></td>
			<td><%=amount_produce[i] %></td>
			<td><%=amount_sell[i] %></td>
		</tr>
	<%	} %>
	</table>
	</div>
	</div>
	</div>
	
	<%	//-------------------------------------------------
		//Vineyard ��
		//------------------------------------------------- %>
	
</body>
</html>