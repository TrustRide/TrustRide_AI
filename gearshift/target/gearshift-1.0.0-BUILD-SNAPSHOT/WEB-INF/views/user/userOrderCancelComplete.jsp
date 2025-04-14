<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>취소 신청 완료</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userOrderCancelComplete.css' />">
</head>
<body>

<%
    request.setAttribute("hideSearch", true);
%>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>

    <main class="refund-complete-main">

        <!-- 취소 신청 완료 내용 -->
        <section class="cancel-summary-box">
            <h3>취소 신청이 완료되었습니다.</h3>

            <div class="product-summary">
                <p class="product-label">취소 상품</p>
                <div class="product-info">
                    <img src="${pageContext.request.contextPath}${refundInfo.thumbnailImageUrl}" class="product-img" />
                    <div class="product-text">
            <p>${refundDTO.modelName}</p>
            <p>${refundInfo.totalAmount} 만원</p>
            </div>
            </div>
            </div>
        </section>
        <section class="button-row">
            <button onclick="window.location.href='/gearshift/user/orders/status/orderList'">신청내역 확인하기</button>
            <button onclick="window.location.href='/gearshift/userList'">쇼핑 계속하기</button>
        </section>
    </main>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
