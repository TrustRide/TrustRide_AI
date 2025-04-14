<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>문의 상세</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 40px 20px;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.08);
        }

        h2, h3 {
            color: #212529;
            margin-bottom: 20px;
        }

        .detail-group {
            margin-bottom: 15px;
        }

        .label {
            font-weight: bold;
            color: #495057;
            display: inline-block;
            width: 120px;
        }

        .value {
            color: #212529;
        }

        .status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 20px;
            display: inline-block;
            font-size: 13px;
        }

        .completed {
            background-color: #198754;
            color: #fff;
        }

        .pending {
            background-color: #ffc107;
            color: #212529;
        }

        .content-box {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            white-space: pre-wrap;
            line-height: 1.5;
            margin-top: 5px;
        }

        .comment-box {
            border: 1px solid #dee2e6;
            background-color: #ffffff;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 10px;
        }

        .comment-date {
            font-size: 13px;
            color: #868e96;
            margin-top: 8px;
        }

        .empty-comment {
            color: #868e96;
            font-style: italic;
            margin-top: 10px;
        }

        .back-link {
            display: inline-block;
            margin-top: 30px;
            text-decoration: none;
            color: #0d6efd;
            font-weight: bold;
            transition: color 0.3s ease;
        }

        .back-link:hover {
            color: #0a58ca;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>📄 문의 상세</h2>

    <div class="detail-group">
        <span class="label">문의 ID:</span>
        <span class="value">${inquiry.inquiryId}</span>
    </div>
    <div class="detail-group">
        <span class="label">제목:</span>
        <span class="value">${inquiry.inquiryName}</span>
    </div>
    <div class="detail-group">
        <span class="label">모델명:</span>
        <span class="value">${inquiry.modelName}</span>
    </div>
    <div class="detail-group">
        <span class="label">문의 유형:</span>
        <span class="value">${inquiry.inquiryType}</span>
    </div>
    <div class="detail-group">
        <span class="label">문의 내용:</span>
        <div class="content-box">${inquiry.inquiryContent}</div>
    </div>
    <div class="detail-group">
        <span class="label">작성자:</span>
        <span class="value">${inquiry.userName}</span>
    </div>
    <div class="detail-group">
        <span class="label">상태:</span>
        <span class="status ${inquiry.inquiryStatus eq '처리완료' ? 'completed' : 'pending'}">
            ${inquiry.inquiryStatus}
        </span>
    </div>
    <div class="detail-group">
        <span class="label">작성일:</span>
        <span class="value">${inquiry.createdAt}</span>
    </div>
    <div class="detail-group">
        <span class="label">수정일:</span>
        <span class="value">${inquiry.updatedAt}</span>
    </div>

    <h3>🗨️ 관리자 답변</h3>

    <c:choose>
        <c:when test="${not empty inquiry.comments}">
            <c:forEach var="comment" items="${inquiry.comments}">
                <div class="comment-box">
                    <div>${comment.commentContent}</div>
                    <div class="comment-date">작성일: ${comment.createdAt}</div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <p class="empty-comment">아직 관리자의 답변이 없습니다.</p>
        </c:otherwise>
    </c:choose>

    <a href="${pageContext.request.contextPath}/user/inquiry" class="back-link">← 목록으로 돌아가기</a>
</div>
</body>
</html>
