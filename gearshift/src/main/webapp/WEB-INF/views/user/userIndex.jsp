<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
  <c:set var="_csrf" value="${_csrf}" />
</sec:authorize>

<html>
<head>
  <title>회원 메인페이지</title>
  <link rel="stylesheet" href="<c:url value='/resources/css/user/userIndex.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">



  <!-- 윈도우 스타일 팝업 -->
  <div id="window-popup" class="popup-window" style="display: none;">
    <div class="popup-titlebar" id="popup-drag">
      <span>광고</span>
      <div class="popup-btns">
        <button onclick="minimizePopup()">━</button>
        <button class="maximize-btn" onclick="maximizePopup()"><span class="square-icon"></span></button>
        <button onclick="closePopup()">✕</button>

      </div>
    </div>
    <div class="popup-body" id="popup-body">
      <a href="<c:url value='/survey/form' />">
        <img src="<c:url value='/resources/img/pop.jpg' />" alt="팝업 이미지" style="width: 100%; display: block;" />
      </a>
      <div class="popup-footer">
        <button onclick="closeToday()">오늘 하루 보지 않기</button>
      </div>
    </div>
  </div>



  <style>


    #chatbot-fab {
      position: fixed;
      bottom: 24px;
      right: 24px;
      width: 60px;
      height: 60px;
      background-color: #FF5C00;
      color: white;
      border-radius: 50%;
      border: none;
      cursor: pointer;
      font-size: 30px;
      z-index: 9998;
      box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    }

    #chatbot-iframe {
      position: fixed;
      bottom: 100px;
      right: 24px;
      width: 360px;
      height: 500px;
      border: none;
      display: none;
      z-index: 9999;
      box-shadow: 0 4px 16px rgba(0, 0, 0, 0.25);
      border-radius: 12px;
    }

    .popup-titlebar {
      background: #2d2d2d;
      color: #fff;
      padding: 0;
      height: 16px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      user-select: none;
    }
    .popup-window {
      position: fixed;
      top: 100px;
      left: 100px;
      width: 360px;
      border: 1px solid #888;
      border-radius: 6px;
      background: #fff;
      box-shadow: 0 0 10px rgba(0,0,0,0.4);
      z-index: 10000;
      font-family: 'Segoe UI', sans-serif;
    }

    .popup-titlebar {
      background: #444;
      color: #fff;
      padding: 5px 10px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      cursor: move;
    }
    .popup-btns button {
      width: 32px;
      height: 32px;
      background: transparent;
      color: white;
      border: none;
      margin-left: 4px;
      font-size: 18px;
      font-weight: bold;
      line-height: 32px;
      text-align: center;
      vertical-align: middle;
      cursor: pointer;
      transition: background 0.2s;
    }

    /* 최대화 버튼만 따로 지정하려면 클래스 부여가 좋음 */
    .popup-btns .maximize-btn {
      width: 40px;
      height: 40px;
      font-size: 22px;
      font-weight: 1500; /* 더 두껍게 */
      border-radius: 6px; /* 조금 더 둥글게 */
      background: transparent;

    }

    .square-icon {
      display: inline-block;
      width: 10px;
      height: 10px;
      border: 2px solid white;
    }

    .popup-btns button:hover {
      background: rgba(255, 255, 255, 0.15);
      border-radius: 4px;
    }

    .popup-body {
      background: #fefefe;
    }

    .popup-footer {
      text-align: right;
      padding: 4px 6px; /* 간격 줄임 */
      background: #f5f5f5;
    }

    .popup-footer button {
      padding: 3px 6px;        /* 버튼 크기 작게 */
      font-size: 11px;         /* 글자 작게 */
      margin-left: 4px;        /* 버튼 사이 간격 */
      border: none;
      background-color: #e67e22;
      color: white;
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.2s ease;
    }

    .popup-footer button:hover {
      background-color: #d35400;
    }

  </style>
</head>
<body>

<!--  헤더 영역 -->
<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<!--  메인 콘텐츠 영역 -->
<main>

  <!--  슬라이드 배너 영역 -->
  <section class="main-banner">
    <div class="image-container">
      <a id="imageLink" href="<c:url value='/userList' />">
        <img id="slideshow" class="slideshow" src="<c:url value='/resources/img/1car1.png' />" alt="슬라이드 이미지">
      </a>
    </div>
  </section>

  <!-- 챗봇 버튼 -->
  <button id="chatbot-fab">💬</button>

  <!-- 챗봇 iframe -->
  <iframe id="chatbot-iframe" src="${pageContext.request.contextPath}/chatbot/index.html"></iframe>

</main>
<!-- 팝업 배경 -->
<div id="popup-bg" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:999;"></div>

<!-- 팝업창 (클릭 시 설문 폼 이동) -->
<div id="popup" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%,-50%); background:#fff; border-radius:8px; overflow:hidden; z-index:1000; cursor:pointer;"
     onclick="goToSurvey()">
  <img src="<c:url value='/resources/img/pop.jpg' />" alt="설문 팝업" style="width:100%; display:block;">
  <div style="text-align:right; padding:10px; background:#f5f5f5;">
    <button onclick="closePopup(event)">닫기</button>
    <button onclick="closeToday(event)">오늘 하루 보지 않기</button>
  </div>
</div>

<script>
  window.onload = function () {
    if (!getCookie("hidePopupToday")) {
      document.getElementById("popup").style.display = "block";
      document.getElementById("popup-bg").style.display = "block";
    }
  };

  function closePopup(e) {
    e.stopPropagation(); // 클릭 이벤트 전파 방지
    document.getElementById("popup").style.display = "none";
    document.getElementById("popup-bg").style.display = "none";
  }

  function closeToday(e) {
    e.stopPropagation();
    setCookie("hidePopupToday", "true", 1);
    closePopup(e);
  }

  function setCookie(name, value, days) {
    const date = new Date();
    date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
    document.cookie = name + "=" + value + "; path=/; expires=" + date.toUTCString();
  }

  function getCookie(name) {
    const value = "; " + document.cookie;
    const parts = value.split("; " + name + "=");
    if (parts.length === 2) return parts.pop().split(";").shift();
  }


  function goToSurvey() {
    // 팝업 내에서 버튼 클릭한 경우는 이동하지 않도록
    if (event.target.tagName !== "BUTTON") {
      location.href = "<c:url value='/survey/form' />";
    }
  }


</script>


<!--  푸터 영역 -->
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

<!-- 슬라이드 이미지 전환 스크립트 -->
<script>
  // 오늘 하루 보지 않기 - localStorage 활용
  window.onload = function () {
    const hideUntil = localStorage.getItem("popup-hide-until");
    const now = new Date().getTime();
    if (!hideUntil || now > hideUntil) {
      document.getElementById("window-popup").style.display = "block";
    }
  };

  function closePopup() {
    document.getElementById("window-popup").style.display = "none";
  }

  function closeToday() {
    const today = new Date();
    today.setHours(23, 59, 59, 999); // 오늘 자정까지
    localStorage.setItem("popup-hide-until", today.getTime());
    closePopup();
  }

  // 드래그 기능
  const popup = document.getElementById("window-popup");
  const dragArea = document.getElementById("popup-drag");
  let offsetX, offsetY, isDragging = false;

  dragArea.addEventListener('mousedown', function (e) {
    isDragging = true;
    offsetX = e.clientX - popup.offsetLeft;
    offsetY = e.clientY - popup.offsetTop;
  });

  document.addEventListener('mousemove', function (e) {
    if (isDragging) {
      popup.style.left = (e.clientX - offsetX) + "px";
      popup.style.top = (e.clientY - offsetY) + "px";
    }
  });

  document.addEventListener('mouseup', function () {
    isDragging = false;
  });

  // 최소화 / 최대화
  let isMaximized = false;
  function minimizePopup() {
    document.getElementById("popup-body").style.display = "none";
  }

  function maximizePopup() {
    const body = document.getElementById("popup-body");
    body.style.display = (body.style.display === "none") ? "block" : "none";
  }

  const images = [
    "<c:url value='/resources/img/1car1.png' />",
    "<c:url value='/resources/img/2car2.png' />",
    "<c:url value='/resources/img/3car3.png' />",
    "<c:url value='/resources/img/4car4.png' />",
    "<c:url value='/resources/img/5car5.png' />"
  ];

  const imageLinks = [
    "<c:url value='/userList' />",
    "<c:url value='/userList' />",
    "<c:url value='/userList' />",
    "<c:url value='/userList' />",
    "<c:url value='/userList' />"
  ];

  let currentIndex = 0;

  function changeImage() {
    currentIndex = (currentIndex + 1) % images.length;
    const imgElement = document.getElementById("slideshow");
    const linkElement = document.getElementById("imageLink");

    imgElement.style.opacity = 0;

    setTimeout(() => {
      imgElement.src = images[currentIndex];
      linkElement.href = imageLinks[currentIndex];
      imgElement.style.opacity = 1;
    }, 1000);
  }

  setInterval(changeImage, 5000);


  <!-- 챗봇 -->
  const fab = document.getElementById('chatbot-fab');
  const iframe = document.getElementById('chatbot-iframe');

  fab.addEventListener('click', () => {
    const isVisible = iframe.style.display === 'block';
    iframe.style.display = isVisible ? 'none' : 'block';
  });

</script>
</body>
</html>