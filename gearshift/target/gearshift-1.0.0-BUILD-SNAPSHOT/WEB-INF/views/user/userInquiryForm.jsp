<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>문의 작성/조회</title>
  <style>
    body {
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f6f8;
      padding: 40px 20px;
      margin: 0;
    }

    .container {
      max-width: 700px;
      margin: auto;
      background-color: #ffffff;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
    }

    h2 {
      color: #212529;
      margin-bottom: 30px;
    }

    .form-group {
      margin-bottom: 20px;
    }

    label {
      display: block;
      font-weight: 600;
      margin-bottom: 6px;
      color: #495057;
    }

    input[type="text"],
    textarea,
    select {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #ced4da;
      border-radius: 6px;
      font-size: 14px;
      background-color: #fff;
      box-sizing: border-box;
    }

    textarea {
      resize: vertical;
    }

    .btn {
      padding: 10px 20px;
      background-color: #0d6efd;
      color: white;
      border: none;
      border-radius: 6px;
      font-weight: bold;
      font-size: 14px;
      cursor: pointer;
      transition: background-color 0.3s ease;
      margin-right: 10px;
    }

    .btn:hover {
      background-color: #0a58ca;
    }

    .info-box {
      margin-top: 30px;
      font-size: 14px;
      color: #6c757d;
    }

    .info-box strong {
      color: #495057;
    }
  </style>
</head>
<body>
<div class="container">
  <h2>${inquiry.inquiryId == null ? '✏️ 문의 작성' : '📄 문의 상세'}</h2>

  <form method="post" action="${pageContext.request.contextPath}/user/inquiry/write">
    <c:if test="${inquiry.inquiryId != null}">
      <div class="form-group">
        <label>문의 ID</label>
        <input type="text" value="${inquiry.inquiryId}" readonly />
      </div>
    </c:if>

    <div class="form-group">
      <label>제목</label>
      <input type="text" name="inquiryName" value="${inquiry.inquiryName}" required />
    </div>

    <div class="form-group">
      <label>모델명</label>
      <input type="text" name="modelName" value="${inquiry.modelName}" required />
    </div>

    <div class="form-group">
      <label>문의 내용</label>
      <textarea name="inquiryContent" rows="6" required>${inquiry.inquiryContent}</textarea>
    </div>

    <div class="form-group">
      <label>문의 유형</label>
      <select name="inquiryType" required>
        <option value="상품문의" ${inquiry.inquiryType eq '상품문의' ? 'selected' : ''}>상품문의</option>
        <option value="주문문의" ${inquiry.inquiryType eq '주문문의' ? 'selected' : ''}>주문문의</option>
        <option value="배송문의" ${inquiry.inquiryType eq '배송문의' ? 'selected' : ''}>배송문의</option>
        <option value="환불문의" ${inquiry.inquiryType eq '환불문의' ? 'selected' : ''}>환불문의</option>
        <option value="기타" ${inquiry.inquiryType eq '기타' ? 'selected' : ''}>기타</option>
      </select>
    </div>

    <c:choose>
      <c:when test="${inquiry.inquiryId != null}">
        <form method="get" action="${pageContext.request.contextPath}/user/inquiry/modify">
          <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
          <button type="submit" class="btn">수정하기</button>
        </form>
      </c:when>
      <c:otherwise>
        <button type="submit" class="btn">등록</button>
      </c:otherwise>
    </c:choose>
  </form>

  <c:if test="${inquiry.inquiryId != null}">
    <div class="info-box">
      <p><strong>상태:</strong> ${inquiry.inquiryStatus}</p>
      <p><strong>작성일:</strong> ${inquiry.createdAt}</p>
      <p><strong>수정일:</strong> ${inquiry.updatedAt}</p>
    </div>
  </c:if>
</div>
</body>
</html>
