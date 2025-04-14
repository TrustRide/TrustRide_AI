<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>상품 리스트</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/user/userCarList.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
    <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">

</head>
<body>

<!-- 🔷 헤더 영역 -->
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>


<!-- 🔶 메인 콘텐츠 영역 -->
<main>

    <!-- 🔹 배너 영역 -->
    <section class="banner">
        내 차 20만원 할인 받는 법!
    </section>

    <!-- 🔹 차량 리스트와 카테고리 필터 레이아웃 -->
    <section class="car-page-layout">

        <!-- 왼쪽 카테고리 필터 -->
        <aside class="category-container">
            <h2>국산·수입 제조사/모델</h2>
            <ul class="category-list">
                <c:forEach var="cate" items="${cateList}">
                    <c:choose>
                        <c:when test="${cate.tier == 1}">
                            <li class="category-tier-1" onclick="toggleCategory('tier2-${cate.cateCode}')">${cate.cateName}</li>
                            <ul id="tier2-${cate.cateCode}" class="hidden category-list"></ul>
                        </c:when>
                        <c:when test="${cate.tier == 2}">
                            <c:set var="parentId" value="tier2-${cate.cateParent}" />
                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    var parentElement = document.getElementById("${parentId}");
                                    if (parentElement) {
                                        parentElement.innerHTML += '<li class="category-tier-2" onclick="toggleCategory(\'tier3-${cate.cateCode}\')">${cate.cateName}</li>' +
                                            '<ul id="tier3-${cate.cateCode}" class="hidden category-list"></ul>';
                                    }
                                });
                            </script>
                        </c:when>
                        <c:when test="${cate.tier == 3}">
                            <c:set var="parentId" value="tier3-${cate.cateParent}" />
                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    var parentElement = document.getElementById("${parentId}");
                                    if (parentElement) {
                                        parentElement.innerHTML += '<li class="category-tier-3">' +
                                            '<a href="${pageContext.request.contextPath}/userList?cateCode=${cate.cateCode}" style="text-decoration:none; color:#333;">${cate.cateName}</a>' +
                                            '</li>';
                                    }
                                });
                            </script>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </ul>
        </aside>

        <!-- 오른쪽 차량 리스트 -->
        <section class="car-section">
            <h2>홈서비스 타임딜</h2>

            <c:if test="${not empty userCarList}">
                <div class="car-grid">
                    <c:forEach var="car" items="${userCarList}">
                        <div class="car-card">
                            <a href="/gearshift/carDetail?carInfoId=${car.carInfoId}" class="car-card">
                                <c:choose>
                                    <c:when test="${not empty car.thumbnailUrl}">
                                        <img src="${pageContext.request.contextPath}${car.thumbnailUrl}" alt="Car Image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/resources/img/자동차7.png" alt="기본 이미지">
                                    </c:otherwise>
                                </c:choose>
                                <div class="car-card-content">
                                    <h2>${car.modelName}</h2>
                                    <h4>${car.manufactureYear}년식 · ${car.mileage}km · ${car.fuelType}</h4>
                                    <h1><fmt:formatNumber value="${car.carPrice}" type="number" />만원</h1>
                                </div>
                            </a>

                            <c:if test="${isLogin}">
                                <div style="text-align: center; margin: 10px 0;">
                                    <c:choose>
                                        <c:when test="${car.isWished}">
                                            <button id="btn-${car.carInfoId}" style="background: none; border: none; font-size: 20px;" onclick="cancelWishlist(${car.carInfoId})">❤️ 찜 해제</button>
                                        </c:when>
                                        <c:otherwise>
                                            <button id="btn-${car.carInfoId}" style="background: none; border: none; font-size: 20px;" onclick="addWishlist(${car.carInfoId})">🤍 찜하기</button>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>

                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!--  페이징-->
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="/gearshift/userList?page=${currentPage - 1}">« 이전</a>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="page">
                    <a href="/gearshift/userList?page=${page}" class="${currentPage == page ? 'active' : ''}">${page}</a>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <a href="/gearshift/userList?page=${currentPage + 1}">다음 »</a>
                </c:if>
            </div>
        </section>
    </section>
</main>

<!-- 🔷 푸터 -->
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

<!-- 🔷 JS: 카테고리 토글 -->
<script>

    function toggleCategory(id) {
        var element = document.getElementById(id);
        if (element) {
            element.classList.toggle("hidden");
        }
    }

    // 1. 동기  -->  비동기
    function addWishlist(carInfoId) {
        // 2. 액션 시 URL을 컨트롤러에 보내고 JSON형식, POST로  carInfoId보냄
        fetch("${pageContext.request.contextPath}/user/wishlist/add", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(carInfoId)
        })
            // jsp -> 컨트롤러 ->DB -> 컨트롤러 -> jsp

            // 3. 백단에서 에러없이 return으로 왔다면 success로 응답하도록
            // res.text() === success 인거고   data = "success"
            // 실패를 했으면 res.text()가 success가 아님
            .then(res => res.text())
            .then(data => {
                if (data === "success") {
                    const btn = document.getElementById('btn-' + carInfoId);
                    btn.innerText = "❤️ 찜 해제";
                    btn.setAttribute("onclick", "cancelWishlist(" + carInfoId + ")");
                } else {
                    // 실패
                    alert('작업에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error("오류:", error);
                alert("서버 오류로 작업에 실패했습니다.");
            });
    }

    function cancelWishlist(carInfoId) {
        fetch("${pageContext.request.contextPath}/user/wishlist/remove", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(carInfoId)
        })
            .then(aaa => {
                if (aaa.ok) {
                    const btn = document.getElementById('btn-' + carInfoId);
                    btn.innerText = "🤍 찜하기";
                    btn.setAttribute("onclick", "addWishlist(" + carInfoId + ")");
                } else {
                    // 실패
                    alert('작업에 실패했습니다.');
                }
            })
            .catch(error => {
                console.error("오류:", error);
                alert("서버 오류로 작업에 실패했습니다.");
            });
    }
</script>

</body>
</html>
