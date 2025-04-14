<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>쿠폰 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .content {
            margin-left: 220px;
            padding: 40px;
            box-sizing: border-box;
        }

        h1 {
            text-align: center;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
        }

        .register-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            background-color: #ff6f00;
            color: white;
            padding: 12px 20px;
            border-radius: 6px;
            text-decoration: none;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
            transition: background-color 0.3s;
        }

        .register-btn:hover {
            background-color: #e65c00;
        }

        .table-container {
            max-width: 1200px;
            margin: auto;
            background-color: #ffffff;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 80px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 15px;
            text-align: center;
            border-bottom: 1px solid #f0f0f0;
        }

        th {
            background-color: #f8f9fa;
            color: #495057;
        }

        tbody tr:hover {
            background-color: #f1f3f5;
        }

        img {
            border-radius: 8px;
        }

        .action-buttons a {
            text-decoration: none;
            color: white;
            padding: 8px 12px;
            border-radius: 4px;
            font-size: 14px;
            transition: background-color 0.2s;
        }

        .edit-btn {
            background-color: #4caf50;
        }

        .delete-btn {
            background-color: #f44336;
        }

        .edit-btn:hover {
            background-color: #388e3c;
        }

        .delete-btn:hover {
            background-color: #d32f2f;
        }

        h2 {
            margin-top: 60px;
            text-align: center;
        }

        #couponSelect {
            padding: 10px;
            margin: 10px;
        }

        button {
            padding: 10px 16px;
            background-color: #007bff;
            border: none;
            border-radius: 6px;
            color: white;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>

<main class="content">
    <h1>🏷️ 쿠폰 목록</h1>

    <!-- 쿠폰 생성 버튼 -->
    <a href="${pageContext.request.contextPath}/admin/coupons/create" class="register-btn">+ 새 쿠폰 만들기</a>

    <div class="table-container">
        <table>
            <thead>
            <tr>

                <th>쿠폰명</th>
                <th>할인 금액</th>
                <th>최소 주문 금액</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${not empty coupons}">
                <c:forEach var="coupon" items="${coupons}">
                    <tr>
                        <td>${coupon.couponName}</td>
                        <td>${coupon.discountAmount}원</td>
                        <td>${coupon.minOrderAmount}원</td>
                        <td class="action-buttons">
                            <a href="${pageContext.request.contextPath}/admin/coupons/edit/${coupon.couponId}" class="edit-btn">수정</a>
                        </td>
                        <td class="action-buttons">
                            <a href="${pageContext.request.contextPath}/admin/coupons/delete/${coupon.couponId}" class="delete-btn" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </c:if>
            </tbody>
        </table>
    </div>

    <!-- 특정 쿠폰을 선택하여 전체 유저에게 발급 -->
    <h2>전체 유저에게 쿠폰 발급</h2>
    <div style="text-align:center;">
        <select id="couponSelect">
            <option value="">쿠폰 선택</option>
            <c:forEach var="coupon" items="${coupons}">
                <option value="${coupon.couponId}">${coupon.couponName}</option>
            </c:forEach>
        </select>
        <button onclick="issueSelectedCoupon()">선택한 쿠폰 발급</button>
    </div>
</main>

<script>
    function issueSelectedCoupon() {
        let couponId = document.getElementById("couponSelect").value;
        if (!couponId) {
            alert("발급할 쿠폰을 선택하세요.");
            return;
        }

        if (confirm("선택한 쿠폰을 전체 유저에게 발급하시겠습니까?")) {
            fetch('${pageContext.request.contextPath}/admin/coupons/issueSelected?couponId=' + couponId, {
                method: 'POST'
            }).then(response => {
                if (response.ok) {
                    alert("쿠폰이 성공적으로 발급되었습니다!");
                    location.reload();
                } else {
                    alert("쿠폰 발급에 실패했습니다.");
                }
            });
        }
    }
</script>

</body>
</html>
