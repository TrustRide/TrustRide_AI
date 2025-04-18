<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="loginId" value="${sessionScope.userId}" />

<html>
<head>
  <title>${newsDto.newsTitle}</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      background-color: #ffffff;
      color: #222;
    }

    .header {
      background-color: #888;
      padding: 40px 20px;
      color: #fff;
    }

    .header .category {
      font-size: 14px;
      margin-bottom: 10px;
    }

    .header .title {
      font-size: 36px;
      font-weight: bold;
      line-height: 1.3;
    }

    .header .meta {
      font-size: 14px;
      margin-top: 10px;
      color: #eee;
    }

    .container {
      max-width: 900px;
      margin: 40px auto;
      padding: 0 20px;
    }

    .content {
      font-size: 16px;
      line-height: 1.8;
      white-space: pre-line;
      margin-bottom: 40px;
    }

    .news-images img {
      width: 100%;
      max-width: 500px;
      height: auto;
      margin-left: 230px;
      object-fit: contain;
      border-radius: 8px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.08);
    }

    .btn-back, .btn-delete {
      margin-top: 20px;
      display: inline-block;
      padding: 10px 20px;
      font-size: 14px;
      border-radius: 6px;
      text-decoration: none;
      cursor: pointer;
    }

    .btn-back {
      background-color: #007bff;
      color: white;
    }

    .btn-back:hover {
      background-color: #0056b3;
    }

    .btn-delete {
      background-color: #dc3545;
      color: white;
      margin-left: 10px;
    }

    .btn-delete:hover {
      background-color: #c82333;
    }
  </style>
  <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">
</head>
<body>

<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<div class="header">
  <div class="category">car 매거진</div>
  <div class="title">${newsDto.newsTitle}</div>
  <div class="meta">관리자 ·
    <fmt:formatDate value="${newsDto.newsRegDate}" pattern="yyyy.MM.dd" />
  </div>
</div>

<div class="container">

  <!-- 본문 내용 -->
  <div class="content">
    <c:out value="${newsDto.newsContent}" escapeXml="false"/>
  </div>

  <!-- 다중 이미지 출력 (에디터 외 별도 이미지가 있을 경우) -->
  <c:if test="${not empty imageList}">
    <div class="news-images">
      <c:forEach var="img" items="${imageList}">
        <img src="${pageContext.request.contextPath}${img.newsImageUrl}" alt="뉴스 이미지">
      </c:forEach>
    </div>
  </c:if>

  <!-- 버튼 영역 -->
  <div>
    <a class="btn-back" href="javascript:history.back()">← 목록으로</a>

  </div>
</div>



<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
