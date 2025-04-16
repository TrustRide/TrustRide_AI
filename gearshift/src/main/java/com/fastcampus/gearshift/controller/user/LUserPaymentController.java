package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.CarDetailDto;
import com.fastcampus.gearshift.dto.CarInfoDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.PHolderService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user/payment")
public class LUserPaymentController {

    private final PHolderService holderService;

    // 결제수단 선택페이지 이동
    @PostMapping("/select")
    public String selectPayment(CarDetailDto carDetailDto, Model model) throws Exception{

        // carInfoId로 다시 조회해서 carInfo 채움
        CarInfoDto carInfo = holderService.carDetailSelect(carDetailDto.getCarInfoId());

        // 조회할 차량의 정보가 없으면 예외처리
        if (carInfo == null) {
            throw new IllegalStateException("차량 정보를 찾을 수 없습니다. (ID: " + carDetailDto.getCarInfoId() + ")");
        }

        // 자동차 정보 데이터
        model.addAttribute("carInfo", carInfo);

        // 자동차 정보 이외에 넘겨야 할 데이터
        model.addAttribute("carDetailDto", carDetailDto);

        return "user/userChoosePayment";
    }


    // 결제 상세 페이지 이동
    @PostMapping("/detail")
    public String getPaymentDetail(CarDetailDto carDetailDto, Model model) throws Exception{

        // carInfoId로 다시 조회해서 carInfo 채움
        CarInfoDto carInfo = holderService.carDetailSelect(carDetailDto.getCarInfoId());

        // 조회할 차량의 정보가 없으면 예외처리
        if (carInfo == null) {
            throw new IllegalStateException("차량 정보를 찾을 수 없습니다. (ID: " + carDetailDto.getCarInfoId() + ")");
        }

        // 자동차 정보 데이터
        model.addAttribute("carInfo", carInfo);

        // 자동차 정보 이외에 넘겨야 할 데이터
        model.addAttribute("carDetailDto", carDetailDto);

        return "user/userPaymentDetail";
    }

    // 카드 결제 페이지 이동
    @PostMapping("/creditCard")
    public String goToPayment(CarDetailDto carDetailDto, Model model, HttpSession session) throws  Exception {

        // 세션에 저장된 userId 가져오기
        UserDto userDto =  (UserDto)session.getAttribute("loginUser");

        // 유저의 정보가 없으면 예외처리
        if (userDto == null) {
            throw new IllegalStateException("로그인 정보가 없습니다. 다시 로그인해주세요.");
        }

        CarInfoDto carInfo = holderService.carDetailSelect(carDetailDto.getCarInfoId());

        // 조회할 차량이 없으면 예외처리
        if (carInfo == null) {
            throw new IllegalStateException("해당 차량 정보를 찾을 수 없습니다. ID: " + carDetailDto.getCarInfoId());
        }

        // 자동차 정보 데이터
        model.addAttribute("carInfo", carInfo);

        // 자동차 정보 이외에 넘겨야 할 데이터
        model.addAttribute("carDetailDto", carDetailDto);

        // 유저 정보
        model.addAttribute("userInfo", userDto);

        return "user/userPayment";
    }

    @GetMapping("/error")
    public String testError() {
        throw new RuntimeException("테스트용 에러가 발생했습니다!");
    }

    // 이 컨트롤러에서 발생한 모든 예외 처리
    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        model.addAttribute("errorMessage", "요청 처리 중 오류가 발생했습니다. 상세: " + e.getMessage());
        return "user/errorPage"; // 오류 페이지로 이동
    }

}
