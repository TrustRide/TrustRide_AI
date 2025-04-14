<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/custom.css">
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>

<main class="content">
    <h2>주문 관리</h2>

    <c:choose>
        <c:when test="${empty orderList}">
            <p style="text-align: center; font-size: 16px; color: gray;">주문 내역이 없습니다.</p>
        </c:when>
        <c:otherwise>
            <table class="table">
                <thead>
                <tr>
                    <th>회원이름</th>
                    <th>회원코드</th>
                    <th>주문코드</th>
                    <th>주문가격</th>
                    <th>주문상태</th>
                    <th>주문일자</th>
                    <th>배달상태</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orderList}">
                    <tr>
                        <td>${order.userName}</td>
                        <td>${order.userId}</td>
                        <td>${order.orderId}</td>
                        <td>${order.totalPrice}</td>
                        <td>${order.orderStatus}</td>
                        <td>${order.orderCompletedDate}</td>
                        <td>
                            <select class="delivery-status-select" data-order-id="${order.orderId}">
                                <option value="배송준비중" <c:if test="${order.deliveryStatus == '배송준비중'}">selected</c:if>>배송준비중</option>
                                <option value="배송중" <c:if test="${order.deliveryStatus == '배송중'}">selected</c:if>>배송중</option>
                                <option value="배송완료" <c:if test="${order.deliveryStatus == '배송완료'}">selected</c:if>>배송완료</option>
                            </select>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</main>

<!-- jQuery CDN -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- 배송상태 Ajax 처리 -->
<script>
    $(document).ready(function () {
        $('.delivery-status-select').change(function () {
            const newStatus = $(this).val();
            const orderId = $(this).data('order-id');

            $.ajax({
                url: '${pageContext.request.contextPath}/admin/orderList/updateDeliveryStatus',
                type: 'POST',
                data: {
                    orderId: orderId,
                    deliveryStatus: newStatus
                },
                success: function (response) {
                    alert('배송 상태가 "' + newStatus + '"로 변경되었습니다.');
                },
                error: function () {
                    alert('배송 상태 변경에 실패했습니다.');
                }
            });
        });
    });
</script>

</body>
</html>
