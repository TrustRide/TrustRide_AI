<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>문의 목록</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userInquiry.css' />">


</head>

<%
    request.setAttribute("hideSearch", true);
%>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>

<body>
<main class="inquiry-main">
<div class="container">
    <section class="inquiry-header">
    <h2>📋 문의 목록</h2>
        <a href="${pageContext.request.contextPath}/user/inquiry/write"
           style="display:inline-block; padding:10px 20px; background-color:#e60023; color:#fff; font-size:16px; font-weight:600; border-radius:8px; text-decoration:none; box-shadow:0 4px 8px rgba(0,0,0,0.1); transition:background-color 0.3s ease;">
            ＋ 새 문의 작성
        </a>
    </section>

<c:if test="${empty inquiryList}">
    <section class="inquiry-empty">
    <div class="empty-message">
                😢 등록된 문의가 없습니다. <br>문의하고 싶은 내용을 작성해 주세요!
            </div>
    </section>
</c:if>
    <c:if test="${not empty inquiryList}">
    <section class="inquiry-table">
            <table>
                <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>문의유형</th>
                    <th>작성자</th>
                    <th>상태</th>
                    <th>작성일</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="inq" items="${inquiryList}">
                    <tr onclick="location.href='${pageContext.request.contextPath}/user/inquiry/read/${inq.inquiryId}'">
                        <td data-label="번호">${inq.inquiryId}</td>
                        <td data-label="제목">${inq.inquiryName}</td>
                        <td data-label="문의유형">${inq.inquiryType}</td>
                        <td data-label="작성자">${inq.userName}</td>
                        <td data-label="상태">
                            <c:choose>
                                <c:when test="${inq.inquiryStatus eq '처리완료'}">
                                    <span class="status completed">✔ 처리완료</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status pending">⏳ 처리중</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td data-label="작성일">${inq.createdAt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
    </section>
    </c:if>
</div>
</main>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
