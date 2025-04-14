<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품관리</title>
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>

<!-- 본문 컨텐츠 -->
<main class="content">
    <h2>상품관리</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>상품명</th>
            <th>설명</th>
            <th>가격</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        <c:forEach var="product" items="${products}">
            <tr>
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.description}</td>
                <td>${product.price}</td>
                <td><a href="product_edit.jsp?id=${product.id}">수정</a></td>
                <td>
                    <form action="/products/delete/${product.id}" method="post">
                        <input type="submit" value="삭제">
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
    <a href="carRegisterForm.jsp">새 상품 추가</a>
</main>
</body>
</html>