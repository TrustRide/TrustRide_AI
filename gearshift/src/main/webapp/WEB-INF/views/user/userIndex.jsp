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



</main>

<!--  채널톡 스크립트 (고정 아이콘 포함) -->
<a href="/chat">
  <script>
    (function(){
      var w=window;
      if(w.ChannelIO){return w.console.error("ChannelIO script included twice.");}
      var ch=function(){ch.c(arguments);};ch.q=[];ch.c=function(args){ch.q.push(args);};
      w.ChannelIO=ch;
      function l(){
        if(w.ChannelIOInitialized){return;}
        w.ChannelIOInitialized=true;
        var s=document.createElement("script");
        s.type="text/javascript";s.async=true;
        s.src="https://cdn.channel.io/plugin/ch-plugin-web.js";
        var x=document.getElementsByTagName("script")[0];
        if(x.parentNode){x.parentNode.insertBefore(s,x);}
      }
      if(document.readyState==="complete"){l();}
      else{w.addEventListener("DOMContentLoaded",l);w.addEventListener("load",l);}
    })();

    ChannelIO('boot', {
      "pluginKey": "c908baf0-72dc-4f83-886e-e07a18a35760"
    });
  </script>
</a>

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
  
</script>
</body>
</html>
