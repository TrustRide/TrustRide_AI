<%@ page contentType="text/html;charset=UTF-8" language="java" session="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
  <title>뉴스 리스트</title>
  <link rel="stylesheet" href="<c:url value='/resources/css/user/header.css' />">
  <link rel="stylesheet" href="<c:url value='/resources/css/user/footer.css' />">

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      margin: 0;
      padding: 40px;
      background-color: #f9f9f9;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
    }

    .news-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 24px;
    }

    .news-card {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      transition: transform 0.2s ease;
      text-decoration: none;
      color: inherit;
    }

    .news-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    .news-card img {
      width: 100%;
      height: 180px;
      object-fit: cover;
    }

    .news-card-content {
      padding: 16px;
    }

    .news-title {
      font-size: 18px;
      font-weight: bold;
      margin-bottom: 10px;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      -webkit-box-orient: vertical;
      overflow: hidden;
      text-overflow: ellipsis;
      height: 48px;
    }

    .news-date {
      font-size: 14px;
      color: #888;
    }

    .no-news {
      text-align: center;
      color: #999;
      padding: 60px 0;
      font-size: 18px;
    }

    .write-btn {
      display: block;
      margin: 30px auto 10px auto;
      padding: 12px 30px;
      background-color: #000;
      color: white;
      font-size: 14px;
      text-align: center;
      text-decoration: none;
      border-radius: 30px;
      width: fit-content;
    }

    .write-btn:hover {
      background-color: #444;
    }

    .pagination {
      text-align: center;
      margin: 30px 0;
    }

    .pagination a {
      display: inline-block;
      padding: 8px 12px;
      margin: 0 4px;
      border: 1px solid #ddd;
      text-decoration: none;
      color: #333;
      border-radius: 4px;
    }

    .pagination a.active {
      background-color: #000;
      color: white;
    }

    .pagination a:hover {
      background-color: #ddd;
    }

  </style>
</head>
<body>

<%@ include file="/WEB-INF/views/user/include/header.jsp" %>

<div class="container">



  <!-- 뉴스 카드 목록 -->
  <c:choose>
    <c:when test="${empty list}">
      <div class="no-news">등록된 뉴스가 없습니다.</div>
    </c:when>
    <c:otherwise>
      <div class="news-grid">
        <c:forEach var="newsDto" items="${list}">
          <a href="<c:url value='/newsDetail?newsId=${newsDto.newsId}'/>" class="news-card">
            <c:choose>
              <c:when test="${not empty newsDto.newsThumbnailUrl}">
                <img src="${pageContext.request.contextPath}${newsDto.newsThumbnailUrl}" alt="썸네일">
              </c:when>
              <c:otherwise>
                <img src="${pageContext.request.contextPath}/resources/img/default-news.png" alt="기본 이미지">
              </c:otherwise>
            </c:choose>
            <div class="news-card-content">
              <div class="news-title">${newsDto.newsTitle}</div>
              <div class="news-date">
                <fmt:formatDate value="${newsDto.newsRegDate}" pattern="yyyy.MM.dd" />
              </div>
            </div>
          </a>
        </c:forEach>
      </div>
    </c:otherwise>
  </c:choose>

  <!-- 페이징 -->
  <div class="pagination">
    <c:if test="${currentPage > 1}">
      <a href="/gearshift/newsList?page=${currentPage - 1}">« 이전</a>
    </c:if>
    <c:forEach begin="1" end="${totalPages}" var="page">
      <a href="/gearshift/newsList?page=${page}" class="${currentPage == page ? 'active' : ''}">${page}</a>
    </c:forEach>
    <c:if test="${currentPage < totalPages}">
      <a href="/gearshift/newsList?page=${currentPage + 1}">다음 »</a>
    </c:if>
  </div>

</div>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>
</body>
</html>
