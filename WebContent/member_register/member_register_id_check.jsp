<%@ page language="java" contentType="text/plain; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%
String sid = request.getParameter("sid");
int count = Integer.parseInt(request.getParameter("cnt"));
if(count == 0) {
%>
<b><%=sid %></b><font color="blue">�� ��� �����մϴ�.</font>
<%
} else {
%>
<b><%=sid %></b><font color="red">�� ������Դϴ�. �ٸ� ���̵�� �˻��ϼ���.</font>
<%
}
%>