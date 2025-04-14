<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>상품 상세페이지</title>


    <link rel="stylesheet" href="<c:url value='/resources/css/user/userCarDetail.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">


</head>
<body>

<%@ include file="/WEB-INF/views/user/include/header.jsp" %>




<div class="container">
    <!-- 🔺 이미지 영역 -->
    <div class="image-box">
        <c:choose>
            <c:when test="${not empty carDto.images}">
                <img id="mainImage" class="main-image"
                     src="${pageContext.request.contextPath}${carDto.images[0].imageUrl}" />
            </c:when>
            <c:otherwise>
                <img id="mainImage" class="main-image"
                     src="${pageContext.request.contextPath}/resources/img/자동차7.png" />
            </c:otherwise>
        </c:choose>

        <div class="thumbnail-container">
            <c:forEach var="img" items="${carDto.images}">
                <img src="${pageContext.request.contextPath}${img.imageUrl}"
                     onclick="changeMainImage(this)"
                     alt="썸네일" />
            </c:forEach>
        </div>
    </div>

    <!-- 🔻 차량 정보 영역 -->
    <div class="info-section">
        <div class="badge">무료배송</div>
        <div class="car-title">${carDto.modelName}</div>
        <div>${carDto.manufactureYear}년식 · ${carDto.mileage}km · ${carDto.fuelType}</div>
        <hr>

        <div class="price-box">
            <div>차량가격: <strong><fmt:formatNumber value="${carDto.carPrice}" type="number" />만원</strong></div>
            <div>이전등록비: <strong><fmt:formatNumber value="${carDto.previousRegistrationFee}" type="number" />만원</strong></div>
            <div>등록대행수수료: <strong><fmt:formatNumber value="${carDto.agencyFee}" type="number" />만원</strong></div>
            <div>배송비: <strong><fmt:formatNumber value="0" type="number" />만원</strong></div>

            <div class="total-price">
                총 합계: <fmt:formatNumber value="${carDto.carAmountPrice}" type="number" />만원
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/titleHolder?carInfoId=${carDto.carInfoId}" class="home-btn"></a>
    </div>
</div>



<div class="description-section">
    <div class="desc-title">현재 보고 계시는 차량의 기본정보를 알려드릴게요</div>
    <div class="desc-content">
        <strong> ${carDto.manufactureYear}</strong>년식 의 주행거리 <strong>${carDto.mileage}km</strong><br>
        배기량 <strong>${carDto.engineCapacity}cc</strong>  연료는 ${carDto.fuelType}, 변속기는 ${carDto.transmission}이고<br>
        색상은 <strong>${carDto.color}</strong> 이에요.
    </div>
</div>

<div class="description-section">
    <div class="desc-title">이 차에는 다음과 같은 특징 및 세부항목이 있습니다.</div>
    <div class="desc-content">

        * Trust Ride에서 신차 구매하여 주기적으로 관리하고 진단까지 마친 차량입니다.<br>
        * Trust Ride의 프리미엄 정비 상품을 이용한 차량으로, 이동정비팀이 정기적으로 철저히 관리했습니다.<br><br>

        ▶ 차량 세부내용<br>
        - 차종:${carDto.modelName} <br>
        - 배기량: ${carDto.engineCapacity}cc<br>
        - 연식: ${carDto.manufactureYear}식<br>
        - 색상: ${carDto.color}<br>
        - 주행거리: ${carDto.mileage}km<br>
        <hr>
        차량 설명<br>

        ${carDto.description}

        <hr>



        ▶ 영업시간: 월~토요일 (AM 9:00~18:00, 공휴일 휴무)<br>
        ▶ 차량문의<br>
        - 차량위치: 서울 강남구 강남대로 364 (역삼동) 10층<br>
        - 전화: 0000-0000
    </div>

    <div style="max-width: 1200px; margin: 30px auto; text-align: center;">
        <a href="${pageContext.request.contextPath}/titleHolder?carInfoId=${carDto.carInfoId}"
           class="home-btn"
           style="
           display: inline-block;
           background-color: #8B0000;
           color: #fff;
           padding: 16px 0;
           width: 300px;
           border-radius: 10px;
           text-decoration: none;
           font-size: 18px;
           font-weight: bold;
           text-align: center;
       ">
            다음
        </a>
    </div>
</div>


<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

<script>
    function changeMainImage(thumbnail) {
        const mainImage = document.getElementById("mainImage");
        if (mainImage && thumbnail) {
            mainImage.src = thumbnail.src;
        }
    }
</script>


</body>
</html>