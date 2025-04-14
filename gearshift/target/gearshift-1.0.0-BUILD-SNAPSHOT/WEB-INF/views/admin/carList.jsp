<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>차량 목록</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link href="https://fonts.googleapis.com/css2?family=Pretendard&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/styles.css">
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
    </style>

    <script>
        function confirmDelete(carInfoId) {
            if (confirm('정말 삭제하시겠습니까?')) {
                window.location.href = '${pageContext.request.contextPath}/admin/cars/'+carInfoId+'/delete';
            }
        }
    </script>
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>


<main class="content">
    <h1>🚗 차량 목록</h1>

    <a href="${pageContext.request.contextPath}/admin/cars/register" class="register-btn">+ 차량 등록</a>

<div class="table-container">
    <table>
        <thead>
        <tr>
            <th>상품 코드</th>
            <th>상품명</th>
            <th>판매가</th>
            <th>상태</th>
            <th>연료 종류</th>
            <th>상품 이미지</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        </thead>


        <tbody>
        <c:forEach var="car" items="${carList}">
            <tr onclick="location.href='${pageContext.request.contextPath}/admin/cars/${car.carInfoId}'" style="cursor: pointer;">
                <td>${car.carInfoId}</td>
                <td>${car.modelName}</td>
                <td>${car.carPrice}만원</td>
                <td>${car.soldStatus}</td>
                <td>${car.fuelType}</td>
                <td>
                    <c:if test="${not empty car.thumbnailUrl}">
                        <img src="${pageContext.request.contextPath}${car.thumbnailUrl}" width="100" height="70" alt="썸네일" />
                    </c:if>
                </td>
                <td class="action-buttons">
                    <a href="${pageContext.request.contextPath}/admin/cars/${car.carInfoId}/edit" class="edit-btn">수정</a>
                </td>
                <td class="action-buttons">
                    <a href="javascript:void(0);" onclick="event.stopPropagation(); confirmDelete('${car.carInfoId}');" class="delete-btn">삭제</a>
                </td>

            </tr>
        </c:forEach>
        </tbody>

        </table>
    </div>
</main>


</body>
</html>
