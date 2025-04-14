<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>문의 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin/styles.css">
    <style>
        html, body {
            margin: 0;
            padding: 0;
            height: 100%;
            background-color: #f5f6fa;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            width: 100%;
            padding: 40px 5%;
            box-sizing: border-box;
        }

        h2, h3 {
            margin-top: 0;
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
            color: #333;
        }

        table.inquiry-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .inquiry-table th, .inquiry-table td {
            padding: 16px;
            border-bottom: 1px solid #eee;
            text-align: left;
        }

        .inquiry-table th {
            background-color: #f0f2f5;
            width: 160px;
            color: #333;
        }

        .status-complete {
            color: green;
            font-weight: bold;
        }

        .status-pending {
            color: orange;
            font-weight: bold;
        }

        .comment-box {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 10px;
            background-color: #ffffff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.03);
        }

        .comment-box small {
            color: #777;
        }

        .form-group {
            margin-top: 30px;
        }

        textarea {
            width: 100%;
            padding: 14px;
            border-radius: 6px;
            border: 1px solid #ccc;
            resize: vertical;
            font-size: 14px;
        }

        .button-group {
            margin-top: 20px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .button-group button {
            padding: 10px 18px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-weight: bold;
            font-size: 14px;
        }

        .btn-primary {
            background-color: #007bff;
            color: white;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        form {
            margin: 0;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>문의 상세</h2>

    <table class="inquiry-table">
        <tr>
            <th>처리상태</th>
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
        </tr>
        <tr><th>제목</th><td>${inquiry.inquiryName}</td></tr>
        <tr><th>문의내용</th><td>${inquiry.inquiryContent}</td></tr>
        <tr><th>유형</th><td>${inquiry.inquiryType}</td></tr>
        <tr><th>회원명</th><td>${inquiry.userName}</td></tr>
        <tr><th>이메일</th><td>${inquiry.userEmail}</td></tr>
        <tr><th>상품명</th><td>${inquiry.modelName}</td></tr>
        <tr><th>작성일시</th><td>${inquiry.createdAt}</td></tr>
    </table>

    <h3>답변</h3>
    <c:forEach var="comment" items="${commentList}">
        <div class="comment-box">
            <p>${comment.commentContent}</p>
            <small>${comment.createdAt}</small>
        </div>
    </c:forEach>

    <form method="post" action="${pageContext.request.contextPath}/admin/inquiry/reply" class="form-group">
        <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
        <textarea name="commentContent" rows="5" required placeholder="답변 내용을 입력하세요."></textarea>
        <div class="button-group">
            <button type="submit" class="btn-primary">답변 등록</button>
        </div>
    </form>

    <div class="button-group">
        <form method="get" action="${pageContext.request.contextPath}/admin/inquiry">
            <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
            <button type="submit" class="btn-secondary">목록으로</button>
        </form>

        <form method="post" action="${pageContext.request.contextPath}/admin/inquiry/delete" onsubmit="return confirm('정말 삭제하시겠습니까?');">
            <input type="hidden" name="inquiryId" value="${inquiry.inquiryId}" />
            <button type="submit" class="btn-danger">삭제</button>
        </form>
    </div>
</div>

</body>
</html>
