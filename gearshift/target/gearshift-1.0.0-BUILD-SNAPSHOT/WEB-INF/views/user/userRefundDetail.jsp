<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>환불 상세 내역</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userRefundDetail.css' />">
</head>
<body>

<%
    request.setAttribute("hideSearch", true);
%>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>

<main>
    <!-- ① 선택한 상품 -->
    <section>
        <h3>선택한 상품 </h3>
        <img src="${pageContext.request.contextPath}${refundInfo.thumbnailImageUrl}" style="width: 100%; max-width: 320px; border-radius: 8px; margin-bottom: 15px;" />
        <p>${refundDTO.modelName}</p>
        <p>${refundInfo.totalAmount} 만원</p>
    </section>

    <!-- ② 선택한 사유 -->
    <section>
        <h3>선택한 사유</h3>
        <p>${refundDTO.refundReason}</p>
    </section>

    <!-- ③ 환불 안내 -->
    <section>
        <h3>환불 정보를 확인해 주세요</h3>
        <div>
            <h4>환불안내</h4>
            <p>상품금액: ${refundInfo.orderAmount} 만원</p>
            <p>배송비: ${refundDTO.deliveryFee} 원</p>
            <p>반품비: ${refundDTO.refundFee} 원</p>
        </div>
    </section>

    <!-- ④ 환불 예상금액 -->
    <section>
        <h4>환불 예상금액</h4>
        <p>${refundInfo.totalAmount} 만원</p>
    </section>

    <!-- 선택한 상품 환불 등록 -->
    <form action="/gearshift/user/orders/register/refund" method="post">
        <input type="hidden" name="orderId" value="${refundInfo.orderId}">
        <input type="hidden" name="modelName" value="${refundDTO.modelName}">
        <input type="hidden" name="refundReason" value="${refundDTO.refundReason}">
        <input type="hidden" name="totalAmount" value="${refundInfo.totalAmount}">
    <section>
        <button type="submit">신청하기</button>
    </section>
    </form>
</main>

    <%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
