<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>오류 처리 페이지</title>

    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    
</head>
<body>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<main>
    <div class="error-container">
        <h2 style="color: red;">⚠ 오류가 발생했습니다</h2>
        <p>${errorMessage}</p>
        <a href="${pageContext.request.contextPath}">홈으로 돌아가기</a>
    </div>
</main>

<!--  푸터 영역 -->
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

</body>
</html>
