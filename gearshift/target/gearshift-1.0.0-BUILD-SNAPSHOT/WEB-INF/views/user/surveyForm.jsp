<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>중고차 추천 설문</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f5f7fa;
            color: #333;
            padding: 30px;
            max-width: 700px;
            margin: auto;
        }
        h1 {
            text-align: center;
            color: #d35400;
        }
        fieldset {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        legend {
            font-weight: bold;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        .submit-btn {
            background-color: #e67e22; /* 주황색 */
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
        }
        .submit-btn:hover {
            background-color: #d35400;
        }
        #result {
            margin-top: 30px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<h1>🚗 라이프스타일 기반 중고차 추천 설문</h1>

<form id="survey-form" action="/gearshift/survey/submit" method="post">

    <fieldset>
        <legend>1. 연령대를 선택해주세요</legend>
        <label><input type="radio" name="age" value="20" required> 20대</label>
        <label><input type="radio" name="age" value="30"> 30대</label>
        <label><input type="radio" name="age" value="40"> 40대 </label>
        <label><input type="radio" name="age" value="50"> 50대</label>
        <label><input type="radio" name="age" value="60"> 60대 이상</label>
    </fieldset>

    <fieldset>
        <legend>2. 성별을 선택해주세요</legend>
        <label><input type="radio" name="gender" value="남성" required> 남성</label>
        <label><input type="radio" name="gender" value="여성"> 여성</label>
    </fieldset>

    <fieldset>
        <legend>3. 예산 범위를 선택해주세요</legend>
        <label><input type="radio" name="budget" value="0-500" required> 500만원 미만</label>
        <label><input type="radio" name="budget" value="500-999"> 500만원 ~ 1000만원</label>
        <label><input type="radio" name="budget" value="1000-1499"> 1000만원 ~ 1500만원</label>
        <label><input type="radio" name="budget" value="1500-1999"> 1500만원 ~ 2000만원</label>
        <label><input type="radio" name="budget" value="2000-2999"> 2000만원 ~ 3000만원</label>
        <label><input type="radio" name="budget" value="3000-9999"> 3000만원 이상</label>
        <label><input type="radio" name="budget" value="0-9999"> 상관없음</label>
    </fieldset>

    <fieldset>
        <legend>4. 주 사용 목적을 선택해주세요</legend>
        <label><input type="radio" name="purpose" value="commute" required> 출퇴근용</label>
        <label><input type="radio" name="purpose" value="travel"> 여행/장거리 운전</label>
        <label><input type="radio" name="purpose" value="nearby"> 근거리/장보기</label>
    </fieldset>

    <fieldset>
        <legend>5. 선호하는 차량 브랜드 유형은?</legend>
        <label><input type="radio" name="brand_type" value="국산" required> 국산차</label>
        <label><input type="radio" name="brand_type" value="수입"> 수입차</label>
        <label><input type="radio" name="brand_type" value="상관없음"> 상관없음</label>
    </fieldset>

    <div style="text-align: center;">
        <button type="submit" class="submit-btn">🚀 추천받기</button>
    </div>

</form>

<div id="result"></div>

</body>
</html>
