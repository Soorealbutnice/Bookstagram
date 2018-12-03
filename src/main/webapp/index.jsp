<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.dnb.member.model.MemberDto"%>
<%
String root = request.getContextPath();

response.sendRedirect(root + "/login/login.dnb");
%> 
