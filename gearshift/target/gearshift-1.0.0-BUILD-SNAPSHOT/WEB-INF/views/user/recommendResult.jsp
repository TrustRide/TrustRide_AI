<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8" />
    <title>중고차 추천 결과</title>
    <style>
        body {
            font-family: "Segoe UI", sans-serif;
            background-color: #f5f7fa;
            color: #333;
            padding: 30px;
            max-width: 800px;
            margin: auto;
        }
        h1 {
            text-align: center;
            color: #e67e22;
        }
        .card {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            margin: 20px 0;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card h2 {
            margin: 0 0 5px 0;
            color: #e67e22;
        }
        .price {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #d35400;
        }
        .car-image {
            display: block;
            margin: 10px 0;
            max-width: 100%;
            height: auto;
        }
        .link-btn {
            display: inline-block;
            text-decoration: none;
            background-color: #e67e22;
            color: #fff;
            padding: 10px 15px;
            border-radius: 6px;
            transition: background-color 0.3s;
            margin-top: 10px;
        }
        .link-btn:hover {
            background-color: #d35400;
        }
        .no-result {
            text-align: center;
            font-size: 18px;
            margin-top: 40px;
            color: #b30000;
        }
        .reason-block {
            text-align: center;
            font-size: 16px;
            font-style: italic;
            color: #555;
            margin-top: 40px;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
    </style>
</head>
<body>

<h1>🚗 중고차 추천 결과 (TOP 3)</h1>

<c:choose>
    <c:when test="${not empty results}">
        <c:forEach var="car" items="${results}">
            <div class="card">
                <h2>${car.modelInfo}</h2>
                <div class="price">💰 가격: ${car.price}만원</div>

                <c:choose>
                    <c:when test="${not empty car.imageUrl}">
                        <img class="car-image" src="${car.imageUrl}" alt="차량 이미지" />
                    </c:when>
                    <c:otherwise>
                        <p style="font-style: italic;">이미지 없음</p>
                    </c:otherwise>
                </c:choose>

                <c:choose>
                    <c:when test="${not empty car.detailLink}">
                        <a class="link-btn" href="${car.detailLink}" target="_blank">상세 보기</a>
                    </c:when>
                    <c:otherwise>
                        <p style="font-style: italic;">상세 링크 없음</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:forEach>

    </c:when>
    <c:otherwise>
        <div class="no-result">추천 결과가 없습니다.</div>
    </c:otherwise>
</c:choose>

<div style="text-align: center; margin-top: 40px;">
    <a class="link-btn" href="http://localhost:8080/gearshift/userList">상품 목록으로 가기</a>
</div>

</body>
</html>
