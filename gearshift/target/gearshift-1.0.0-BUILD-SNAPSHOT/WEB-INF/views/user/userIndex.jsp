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
  <style>
    #chatbot-fab {
      position: fixed;
      bottom: 24px;
      right: 24px;
      width: 60px;
      height: 60px;
      background-color: #9a88f8;
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

<!--  푸터 영역 -->
<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

<!-- 슬라이드 이미지 전환 스크립트 -->
<script>
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
