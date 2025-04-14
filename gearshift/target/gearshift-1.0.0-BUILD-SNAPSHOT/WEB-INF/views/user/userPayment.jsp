<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Title</title>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
</head>

<body>

<script>
  $(function(){
    var IMP = window.IMP;
    IMP.init('import');
    IMP.request_pay({
      pg : 'html5_inicis',
      pay_method : 'card', //카드결제
      merchant_uid : 'merchant_' + new Date().getTime(),
      name : `${carInfo.modelName}`,
      amount :`${carInfo.carAmountPrice}`,
      buyer_email : `${userInfo.userEmail}`,
      buyer_name : `${userInfo.userName}`,
      buyer_tel : `${userInfo.userPhoneNumber}`,
      buyer_addr : '인천시 부평구 삼산동',
    }, function(rsp) {
      if ( rsp.success ) {
        pay_info(rsp);

      } else {

        location.href="/gearshift/user/payment/select";
      }
    });

    function pay_info(rsp){
      var form = document.createElement('form');
      var objs;

      // 자동차 ID
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'carInfoId');
      objs.setAttribute('value', `${carInfo.carInfoId}`);
      form.appendChild(objs);

      // 배송비
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'deliveryFee');
      objs.setAttribute('value', `${carDetailDto.deliveryFee}`);
      form.appendChild(objs);

      // 배송 기사 전화번호
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'driverPhoneNumber');
      objs.setAttribute('value', `${carDetailDto.driverPhoneNumber}`);
      form.appendChild(objs);

      // 희망배송일
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'preferredDate');
      objs.setAttribute('value', `${carDetailDto.preferredDate}`);
      form.appendChild(objs);

      // 배송요청 사항
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'deliveryRequest');
      objs.setAttribute('value', `${carDetailDto.deliveryRequest}`);
      form.appendChild(objs);

      // 배송 기사 이름
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'deliveryDriverName');
      objs.setAttribute('value', `${carDetailDto.deliveryDriverName}`);
      form.appendChild(objs);

      // 결제금액
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'carAmountPrice');
      objs.setAttribute('value', rsp.paid_amount);
      form.appendChild(objs);

      // 명의자 이름
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderName');
      objs.setAttribute('value', `${carDetailDto.holderName}`);
      form.appendChild(objs);

      // 명의자 전화번호
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderPhoneNumber');
      objs.setAttribute('value', `${carDetailDto.holderPhoneNumber}`);
      form.appendChild(objs);

      // 명의자 주민등록번호
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderResident');
      objs.setAttribute('value', `${carDetailDto.holderResident}`);
      form.appendChild(objs);

      // 명의자 우편주소
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderAddr1');
      objs.setAttribute('value', `${carDetailDto.holderAddr1}`);
      form.appendChild(objs);

      //명의자 도로명주소
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderAddr2');
      objs.setAttribute('value', `${carDetailDto.holderAddr2}`);
      form.appendChild(objs);

      //명의자 상세주소
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderAddr3');
      objs.setAttribute('value', `${carDetailDto.holderAddr3}`);
      form.appendChild(objs);

      // 명의자 면허증
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'holderLicense');
      objs.setAttribute('value', `${carDetailDto.holderLicense}`);
      form.appendChild(objs);

      // 결제수단
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'paymentMethod');
      objs.setAttribute('value', "신용카드");
      form.appendChild(objs);

      // 소유 형태
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'ownershipType');
      objs.setAttribute('value', `${carDetailDto.ownershipType}`);
      form.appendChild(objs);

      // 공동명의 여부
      objs = document.createElement('input');
      objs.setAttribute('type', 'hidden');
      objs.setAttribute('name', 'isJointOwnership');
      objs.setAttribute('value', `${carDetailDto.isJointOwnership}`);
      form.appendChild(objs);

      form.setAttribute('method', 'post');
      form.setAttribute('action', "/gearshift/user/orders/status/credit");
      document.body.appendChild(form);
      form.submit();
    }

  });
</script>

</body>
</html>

