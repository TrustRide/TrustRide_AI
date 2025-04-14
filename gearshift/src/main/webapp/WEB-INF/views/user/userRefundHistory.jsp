<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>취소신청</title>
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/sidebar.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userRefundHistory.css' />">
</head>
<body>

<%
    request.setAttribute("hideSearch", true);
%>

<%-- 헤더 영역 --%>
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>
<%-- 사이드바 --%>
<%@ include file="/WEB-INF/views/user/include/sidebar.jsp" %>

<main class="refund-main">
    <form id="refundForm" method="get">

        <!--  상품 선택 -->
        <section class="refund-section">
        <h3>상품을 선택해 주세요</h3>

        <!-- 상품 선택 영역 -->
        <c:if test="${empty refundAbleList}">
            <p>환불 가능한 주문이 없습니다.</p>
        </c:if>

            <c:if test="${not empty refundAbleList}">
            <c:forEach var="refund" items="${refundAbleList}">
            <label class="product-label">
                <input type="radio" name="selectedProduct" value="${refund.modelName},${refund.orderId}">
                <img src="${pageContext.request.contextPath}${refund.thumbnailImageUrl}" class="product-img" />
                <span class="product-name">${refund.modelName}</span>
            </label>
            </c:forEach>
        </section>



            <!-- 취소 사유 선택 영역 -->
            <section class="refund-section">
                <h3>취소 사유를 선택해 주세요</h3>
                <label><input type="radio" name="refundReason" value="배송지를 잘못 입력함"> 배송지를 잘못 입력함</label><br>
                <label><input type="radio" name="refundReason" value="단순 변심"> 단순 변심</label><br>
                <label><input type="radio" name="refundReason" value="다른 상품 추가 후 재주문 예정"> 다른 상품 추가 후 재주문 예정</label>
            </section>

            <!-- Hidden 필드 -->
            <input type="hidden" name="modelName">
            <input type="hidden" name="orderId">
            <input type="hidden" name="deliveryFee" value="0">
            <input type="hidden" name="refundFee" value="0">


            <!-- ③ 다음 단계 버튼 -->
            <section class="refund-section">
                <button type="button" class="next-button" onclick="goToNextStep()">다음 단계</button>
            </section>
        </c:if>
    </form>
</main>

<script>


    // "다음 단계" 버튼 클릭 시
    function goToNextStep() {
        const selected = document.querySelector('input[name="selectedProduct"]:checked');
        if (!selected) {
            alert("상품을 선택해 주세요.");
            return;
        }

        const [modelName, orderId] = selected.value.split(',');

        document.querySelector('input[name="modelName"]').value = modelName;
        document.querySelector('input[name="orderId"]').value = orderId;

        document.getElementById('refundForm').action = '/gearshift/user/orders/select/refund';
        document.getElementById('refundForm').submit();
    }
</script>
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>