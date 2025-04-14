<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원 관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/custom.css">
</head>
<body>

<!-- 관리자 공통 헤더/사이드바 포함 -->
<jsp:include page="include/header.jsp"/>
<jsp:include page="include/sidebar.jsp"/>

<main class="content">
    <h2>회원 관리</h2>

    <!-- Flash 메시지 알림 -->
    <c:if test="${not empty message}">
        <script>
            alert("${message}");
        </script>
    </c:if>

    <table class="table">
        <thead>
        <tr>
            <th>회원코드</th>
            <th>회원이름</th>
            <th>아이디</th>
            <th>전화번호</th>
            <th>이메일</th>
            <th>유저등록일</th>
            <th>성별</th>
            <th>관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${userList}">
            <tr>
                <td>${user.userId}</td>
                <td>${user.userName}</td>
                <td>
                    <c:choose>
                        <c:when test="${empty user.userAccount}">
                            미입력
                        </c:when>
                        <c:otherwise>
                            ${user.userAccount}
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${user.userPhoneNumber}</td>
                <td>${user.userEmail}</td>
                <td>${user.createdAt}</td>
                <td>${user.userGender}</td>
                <td>
                    <form action="${pageContext.request.contextPath}/admin/userList/delete" method="post"
                          onsubmit="return confirm('정말 삭제하시겠습니까?');">
                        <input type="hidden" name="userId" value="${user.userId}" />
                        <button type="submit" class="deactivate-btn">삭제</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</main>

</body>
</html>
