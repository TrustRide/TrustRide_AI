<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>뉴스 작성</title>
  <style>
    * {
      box-sizing: border-box;
    }
    body {
      margin: 0;
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #fff;
      color: #333;
    }

    /* ✅ 수정된 부분 */
    .container {
      max-width: 1000px;
      margin: 80px 0 0 220px; /* 헤더와 사이드바 공간 확보 */
      padding: 0 20px;
    }

    .title-input {
      font-size: 28px;
      font-weight: 300;
      width: 100%;
      border: none;
      border-bottom: 1px solid #ddd;
      padding: 12px 0;
      margin-bottom: 16px;
    }
    .title-input:focus {
      outline: none;
      border-color: #aaa;
    }
    .tag-input {
      font-size: 14px;
      color: #888;
      border: none;
      margin-bottom: 20px;
      width: 100%;
    }


    .tag-input:focus {
      outline: none;
    }
    .content-area {
      width: 100%;
      height: 400px;
      border: none;
      resize: none;
      font-size: 16px;
      padding: 10px 0;
      border-top: 1px solid #eee;
    }
    .content-area:focus {
      outline: none;
    }
    .button-group {
      display: flex;
      justify-content: flex-end;
      margin-top: 20px;
      gap: 10px;
    }
    .btn {
      padding: 10px 20px;
      font-size: 14px;
      border-radius: 30px;
      border: none;
      cursor: pointer;
    }
    .btn-save {
      background-color: #fff;
      color: #333;
      border: 1px solid #ccc;
    }
    .btn-save:hover {
      background-color: #f2f2f2;
    }
    .btn-submit {
      background-color: #000;
      color: #fff;
    }
    .btn-submit:hover {
      background-color: #222;
    }


    /* 헤더 */
    .header {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 60px;
      background-color: #333;
      color: #fff;
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 0 10px;
      z-index: 1000;
    }
    .logo {
      font-size: 20px;
      font-weight: bold;
      position: absolute;
      left: 50%;
      transform: translateX(-50%);
    }
    form{
      display: block;
      margin-left: 450px;
      margin-top: 0em;
      unicode-bidi: isolate;
    }
    .user-info {
      margin-left: auto;
      display: flex;
      align-items: center;
      gap: 15px;
      margin-right: 20px;
    }
    .logout-btn {
      background-color: #555;
      color: #fff;
      border: none;
      padding: 8px 14px;
      cursor: pointer;
      border-radius: 5px;
      font-size: 14px;
      white-space: nowrap;
      transition: background-color 0.3s;
    }
    .logout-btn:hover {
      background-color: #777;
    }

    /* 사이드바 */
    .sidebar {
      position: fixed;
      top: 60px;
      left: 0;
      width: 200px;
      height: calc(100vh - 60px);
      background: #222;
      color: #fff;
      padding: 20px;
      box-sizing: border-box;
      z-index: 999;
    }
    .sidebar ul {
      list-style: none;
      padding: 0;
    }
    .sidebar li {
      padding: 10px;
    }
    .sidebar li:hover {
      background: #444;
    }
    .sidebar ul li a {
      text-decoration: none;
      color: #fff;
      display: block;
      cursor: pointer;
    }
    .sidebar-logo {
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      margin: 20px 0;
    }
    .sidebar-logo a {
      text-decoration: none;
      color: #fff;
      text-align: center;
    }

    .divider {
      border-top: 1px solid #eee;
      margin: 30px 0;
    }

  </style>


</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>

<div class="container">
  <form action="/gearshift/newsRegister" method="post" enctype="multipart/form-data">

  <!-- 제목 -->
    <input type="text" name="newsTitle" class="title-input" placeholder="제목 입력 " required />

    <!-- 태그 -->
    <input type="text" name="tags" class="tag-input" placeholder="#태그 입력 " />

    <!-- 내용 -->
    <textarea name="newsContent" class="content-area" placeholder="내용을 입력하세요" required></textarea>

    <div class="divider"></div>

    <!-- 이미지-->
    <label>이미지 첨부</label>
    <input type="file" name="imageFiles" multiple accept="image/*" />

    <!-- 버튼 -->
    <div class="button-group">
      <button type="button" class="btn btn-save">임시저장</button>
      <button type="submit" class="btn btn-submit">완료</button>
    </div>
  </form>
</div>






</body>
</html>
