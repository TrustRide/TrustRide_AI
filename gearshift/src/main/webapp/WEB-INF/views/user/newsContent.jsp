<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page session="true" %>
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
    .btn-back, .btn-summary, .btn-related {
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
    .btn-summary {
      background-color: #28a745;
      color: white;
      margin-left: 10px;
    }
    .btn-summary:hover {
      background-color: #1e7e34;
    }
    .btn-related {
      background-color: #17a2b8;
      color: white;
      margin-left: 10px;
    }
    .btn-related:hover {
      background-color: #138496;
    }
    .summary-box {
      margin-top: 30px;
      padding: 20px;
      background-color: #f0f8ff;
      border-left: 5px solid #28a745;
      border-radius: 8px;
      font-size: 16px;
      color: #333;
      line-height: 1.6;
      white-space: pre-line;
    }
    .summary-box a {
      display: block;
      margin-top: 5px;
      color: #007bff;
      text-decoration: none;
    }
    .summary-box a:hover {
      text-decoration: underline;
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
  <div class="content" id="newsContent">
    <c:out value="${newsDto.newsContent}" escapeXml="false"/>
  </div>

  <!-- 이미지 -->
  <c:if test="${not empty imageList}">
    <div class="news-images">
      <c:forEach var="img" items="${imageList}">
        <img src="${pageContext.request.contextPath}${img.newsImageUrl}" alt="뉴스 이미지">
      </c:forEach>
    </div>
  </c:if>

  <!-- 결과 박스 -->
  <div id="summaryText" class="summary-box" style="display:none;"></div>
  <div id="relatedNews" class="summary-box" style="display:none;"></div>

  <!-- 버튼 -->
  <div>
    <a class="btn-back" href="javascript:history.back()">← 목록으로</a>
    <button class="btn-summary" onclick="showSummary()">📌 요약해줘</button>
    <button class="btn-related" onclick="showRelated()">🔍 관련 뉴스 보기</button>
  </div>

</div>

<%@ include file="/WEB-INF/views/user/include/footer.jsp" %>

<script>
  let cachedData = null;

  function fetchSummaryData(callback) {
    if (cachedData) {
      callback(cachedData);
      return;
    }

    const content = document.getElementById("newsContent").innerText;

    fetch("http://localhost:8000/news-similarity", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ content: content })
    })
            .then(response => response.json())
            .then(data => {
              cachedData = data;
              callback(data);
            })
            .catch(error => {
              alert("요약 요청 중 오류 발생: " + error.message);
            });
  }

  function showSummary() {
    fetchSummaryData((data) => {
      const summaryBox = document.getElementById("summaryText");
      summaryBox.style.display = "block";
      summaryBox.innerHTML = "<b>📌 요약 결과:</b><br><p style='color: #000'>" +
              (data.summary?.trim() || "⚠ 요약 결과 없음") +
              "</p>";
    });
  }

  function showRelated() {
    fetchSummaryData((data) => {
      const relatedBox = document.getElementById("relatedNews");
      relatedBox.style.display = "block";

      const newsList = data.related_news || [];
      let html = "<b>🔍 관련 뉴스:</b><br>";
      if (newsList.length > 0) {
        html += newsList.map(item =>
                '<a href="/gearshift' + item.link + '">🔗 ' + item.title + '</a>'
        ).join("<br>");
      } else {
        html += "관련 뉴스가 없습니다.";
      }

      relatedBox.innerHTML = html;
    });
  }

</script>

</body>
</html>