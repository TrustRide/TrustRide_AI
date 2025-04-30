<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header>
    <div class="container header-content">
        <div class="logo-container">
            <a href="${pageContext.request.contextPath}">
                <img src="<c:url value='/resources/img/logo.png' />" alt="Trust Ride Logo" class="logo-img">
            </a>
         <img src="<c:url value='/resources/img/letter.png' />" alt="Trust Ride Logo Text" class="logo-img-text">
        </div>

        <nav>
            <ul style="position: relative;">
                <li style="position: relative; display: inline-block;">
                    <a href="#" id="sellCarMenu" style="cursor:pointer;">내차팔기</a>

                    <!-- 내차팔기 메뉴에 드롭다운 메뉴 추가 -->
                    <div id="sellCarDropDown" class="dropdown-content">
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/sellcar">&#128663;내차 팔면 얼마일까?</a></li>
                        </ul>
                    </div>
                </li>


                <li><a href="${pageContext.request.contextPath}/userList">내차사기</a></li>
                <li><a href="${pageContext.request.contextPath}/review">상품리뷰</a></li>
                <li><a href="/gearshift/newsList">매거진</a></li>

                <c:if test="${not empty sessionScope.loginUser}">
                    <li><strong>${sessionScope.loginUser.userName}</strong>님</li>
                    <li><a href="${pageContext.request.contextPath}/user/orders/status/orderList">마이페이지</a></li>
                    <li><a href="#" onclick="logout()">로그아웃</a></li>
                </c:if>

                <c:if test="${empty sessionScope.loginUser}">
                    <li><a href="${pageContext.request.contextPath}/login.do">로그인</a></li>
                    <li><a href="${pageContext.request.contextPath}/register">회원가입</a></li>
                </c:if>
            </ul>


        </nav>

        <!-- 검색 input, form 없이 처리 -->
        <c:if test="${not hideSearch}">
        <div style="display: flex; align-items: center;">
            <input type="text" id="searchQuery" placeholder="🔍차량을 검색하세요." class="search-bar"
                   style="padding: 10px; border-radius: 4px; border: 1px solid #ddd; flex: 1;"
                   onkeypress="if(event.key === 'Enter') searchCar()">
            <button type="button" class="search-btn" onclick="searchCar()">검색</button>
        </div>
        </c:if>
    </div>
</header>

<!-- jquery 사용 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
    // 로그아웃 기능 (POST + CSRF)
    function   logout() {
        fetch('${pageContext.request.contextPath}/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'X-CSRF-TOKEN': '${_csrf.token}'
            },
            body: ''
        })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else {
                    window.location.reload();
                }
            })
            .catch(error => {
                console.error('로그아웃 실패:', error);
            });
    }

    // 검색 기능 (form 없이 GET 요청 전송)
    function searchCar() {
        const query = document.getElementById('searchQuery').value.trim();
        if (query !== '') {
            const url = '${pageContext.request.contextPath}/searchCar?searchQuery=' + encodeURIComponent(query);
            window.location.href = url;
        }
    }

    // 내차팔기 클릭시 드롭다운 메뉴 토글

    $(document).ready(function(){
        // 마우스 올리면 드롭다운 보이기
        $("#sellCarMenu").mouseenter(function(){
            $("#sellCarDropDown").stop(true, true).fadeIn(150);
        });

        // 메뉴 전체를 감싸는 li 영역을 벗어나면 드롭다운 숨기기
        $("#sellCarMenu").closest("li").mouseleave(function(){
            $("#sellCarDropDown").stop(true, true).fadeOut(150);
        });
    });

</script>

