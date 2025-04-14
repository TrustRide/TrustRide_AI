<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>문의 관리</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/inquiry.css">
  <style>
    body {
      margin: 0;
      padding: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f5f6fa;
    }

    .content {
      max-width: 1300px;
      margin: 40px auto;
      padding: 20px 40px;
      background-color: #fff;
      border-radius: 16px;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.05);
    }

    h2 {
      font-size: 24px;
      color: #333;
      margin-bottom: 20px;
      border-bottom: 2px solid #eee;
      padding-bottom: 10px;
    }

    .inquiry-table {
      width: 100%;
      border-collapse: collapse;
      background: #fff;
      margin-top: 20px;
      font-size: 15px;
    }

    .inquiry-table th, .inquiry-table td {
      padding: 14px 16px;
      text-align: left;
      border-bottom: 1px solid #f0f0f0;
    }

    .inquiry-table thead {
      background-color: #f9fafc;
      color: #555;
    }

    .inquiry-table tr:hover {
      background-color: #f6f9fc;
      transition: background 0.2s ease;
    }

    .inquiry-table td span.status-complete {
      color: green;
      font-weight: bold;
    }

    .inquiry-table td span.status-pending {
      color: orange;
      font-weight: bold;
    }

    @media (max-width: 992px) {
      .content {
        padding: 20px;
        margin: 20px;
      }

      .inquiry-table {
        font-size: 14px;
      }
    }
  </style>
</head>
<body>

<jsp:include page="include/header.jsp"/>
<jsp:include page="include/sidebar.jsp"/>

<main class="content">
  <h2>문의관리</h2>
  <h2>고객 문의 목록</h2>

  <table class="inquiry-table">
    <thead>
    <tr>
      <th>처리상태</th>
      <th>문의유형</th>
      <th>문의제목</th>
      <th>상품번호</th>
      <th>상품명</th>
      <th>회원이름</th>
      <th>이메일</th>
      <th>작성일시</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="inquiry" items="${inquiryList}">
      <tr onclick="location.href='${pageContext.request.contextPath}/admin/inquiry/read?inquiryId=${inquiry.inquiryId}'"
          style="cursor:pointer;">
        <td>
          <c:choose>
            <c:when test="${inquiry.inquiryStatus eq '처리완료'}">
              ✅ <span class="status-complete">${inquiry.inquiryStatus}</span>
            </c:when>
            <c:otherwise>
              ⏳ <span class="status-pending">${inquiry.inquiryStatus}</span>
            </c:otherwise>
          </c:choose>
        </td>
        <td>${inquiry.inquiryType}</td>
        <td>${inquiry.inquiryName}</td>
        <td>${inquiry.carInfoId}</td>
        <td>${inquiry.modelName}</td>
        <td>${inquiry.userName}</td>
        <td>${inquiry.userEmail}</td>
        <td>${inquiry.createdAt}</td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</main>

</body>
</html>
