<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>차량 수정</title>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap');

    body {
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      background-color: #f0f4f8;
      margin: 0;
      padding: 40px 0;
    }

    .container {
      width: 450px;
      height: 650px;
      background: #ffffff;
      padding: 30px;
      border-radius: 15px;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
      overflow-y: auto;
    }
    h1 {
      text-align: center;
      position: sticky;
      top: 0;
      background: white;
      padding-bottom: 10px;
      z-index: 100;
      border-bottom: 2px solid #f0f0f0;
    }

    label {
      font-weight: 500;
      display: block;
      margin-top: 15px;
      color: #555;
      font-size: 15px;
    }

    input, select {
      width: 100%;
      padding: 10px 12px;
      margin-top: 5px;
      border: 1px solid #ddd;
      border-radius: 8px;
      transition: border-color 0.3s, box-shadow 0.3s;
      font-size: 14px;
    }

    input:focus, select:focus {
      border-color: #ff6b6b;
      box-shadow: 0 0 8px rgba(255, 107, 107, 0.2);
      outline: none;
    }

    button {
      width: 100%;
      padding: 12px;
      margin-top: 25px;
      background: linear-gradient(to right, #ff6b6b, #f06595);
      color: white;
      font-size: 16px;
      font-weight: 700;
      cursor: pointer;
      border: none;
      border-radius: 10px;
      box-shadow: 0 5px 10px rgba(255, 107, 107, 0.3);
      transition: transform 0.2s, box-shadow 0.2s;
    }

    button:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 15px rgba(255, 107, 107, 0.35);
    }

    ::-webkit-scrollbar {
      width: 6px;
    }

    ::-webkit-scrollbar-track {
      background: transparent;
    }

    ::-webkit-scrollbar-thumb {
      background-color: #ff6b6b;
      border-radius: 20px;
    }
  </style>
</head>
<body>

<!-- 헤더 포함 -->
<jsp:include page="include/header.jsp"/>

<!-- 사이드바 포함 -->
<jsp:include page="include/sidebar.jsp"/>

<div class="container">
  <h1>차량 수정</h1>

  <form action="${pageContext.request.contextPath}/admin/cars/${carDto.carInfoId}/edit" method="post" enctype="multipart/form-data">
    <input type="hidden" name="carInfoId" value="${carDto.carInfoId}" />

    <label>제안 보고서 번호</label>
    <input name="offerReportNumber" type="text" value="${carDto.offerReportNumber}" required />

    <label>차량 식별 번호</label>
    <input name="vinNumber" type="text" value="${carDto.vinNumber}" required />

    <label>설명</label>
    <input name="description" type="text" value="${carDto.description}" />

    <label>대분류</label>
    <select name="largeCateCode" id="largeCate" required>
      <option value="">대분류 선택</option>
      <c:forEach var="large" items="${largeCategories}">
        <option value="${large.cateCode}">${large.cateName}</option>
      </c:forEach>
    </select>

    <label>중분류</label>
    <select name="mediumCateCode" id="mediumCate" required>
      <option value="">중분류 선택</option>
    </select>

    <label>소분류</label>
    <select name="smallCateCode" id="smallCate" required>
      <option value="">소분류 선택</option>
    </select>

    <label>모델명</label>
    <input name="modelName" type="text" value="${carDto.modelName}" required />

    <label>주행 거리</label>
    <input name="mileage" type="text" value="${carDto.mileage}" required />

    <label>엔진 배기량</label>
    <input name="engineCapacity" type="text" value="${carDto.engineCapacity}" />

    <label>연료 유형</label>
    <input name="fuelType" type="text" value="${carDto.fuelType}" />

    <label>변속기</label>
    <input name="transmission" type="text" value="${carDto.transmission}" />

    <label>색상</label>
    <input name="color" type="text" value="${carDto.color}" />

    <label>제조 연도</label>
    <input name="manufactureYear" type="text" value="${carDto.manufactureYear}" />

    <label>이전 등록비</label>
    <input name="previousRegistrationFee" type="number" value="${carDto.previousRegistrationFee}" />

    <label>유지보수 비용</label>
    <input name="maintenanceCost" type="number" value="${carDto.maintenanceCost}" />

    <label>등록대행 수수료</label>
    <input name="agencyFee" type="number" value="${carDto.agencyFee}" />

    <label>차량 위치</label>
    <input name="carLocation" type="text" value="${carDto.carLocation}" />

    <label>소유주 변경 횟수</label>
    <input name="ownerChangeCount" type="number" value="${carDto.ownerChangeCount}" />

    <label>차량 가격</label>
    <input name="carPrice" type="number" value="${carDto.carPrice}" required />

    <label>차량 번호</label>
    <input name="carNum" type="text" value="${carDto.carNum}" />

    <label>총 차량 금액</label>
    <input name="carAmountPrice" type="number" value="${carDto.carAmountPrice}" />

    <label>판매 상태</label>
    <input name="soldStatus" type="text" value="${carDto.soldStatus}" />

    <label>새 이미지 파일 첨부</label>
    <input type="file" name="imageFiles" multiple />

    <button type="submit">차량 수정</button>
  </form>
</div>

<script>
  $(document).ready(function () {
    $('#largeCate').change(function () {
      const largeCateCode = $(this).val();
      $('#mediumCate').html('<option value="">중분류 선택</option>');
      $('#smallCate').html('<option value="">소분류 선택</option>');
      if (largeCateCode) {
        $.get('${pageContext.request.contextPath}/admin/cars/categories/medium?parentCode=' + largeCateCode, function (data) {
          $.each(data, function (index, item) {
            $('#mediumCate').append('<option value="' + item.cateCode + '">' + item.cateName + '</option>');
          });
        });
      }
    });