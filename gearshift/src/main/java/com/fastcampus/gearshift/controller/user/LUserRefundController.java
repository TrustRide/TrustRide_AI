package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.LRefundAbleListDTO;
import com.fastcampus.gearshift.dto.LRefundDTO;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.LRefundService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user/orders")
public class LUserRefundController {

    private final LRefundService refundService;

    // 환불 할 수 있는 상품 목록 조회
    @GetMapping("/refundable")
    public String getRefundableOrdersPage(Model model, HttpSession session) throws Exception{

        // 세션에 저장된 userId 가져오기
        UserDto userDto =  (UserDto)session.getAttribute("loginUser");

        // 사용자 정보가 없으면 예외처리
        if (userDto == null) {
            throw new IllegalStateException("로그인 정보가 없습니다. 다시 로그인해주세요.");
        }

        Integer userId = userDto.getUserId();

        List<LRefundAbleListDTO> refundAbleListDTO = refundService.getRefundAbleList(userId);

        model.addAttribute("refundAbleList", refundAbleListDTO);

        return "/user/userRefundHistory";
    }

    // 선택한 환불 상품 조회
    @GetMapping("/select/refund")
    public String selectRefund(@ModelAttribute LRefundDTO refundDTO, Model model) throws Exception{

        // 선택한 상품의 주문 아이디
        Integer orderId = refundDTO.getOrderId();

        // 주문 ID 누락 확인
        if (orderId == null) {
            throw new IllegalArgumentException("주문 ID가 누락되었습니다.");
        }

        // dto에 주문 아이디를 넣어준다.
        LRefundDTO refundInfo = refundService.selectRefundProduct(orderId);

        // 환불 정보가 없을 경우 예외 처리
        if (refundInfo == null) {
            throw new IllegalArgumentException("해당 주문의 환불 정보를 찾을 수 없습니다. 주문 ID: " + orderId);
        }

        model.addAttribute("refundInfo", refundInfo);
        model.addAttribute("refundDTO", refundDTO);

        return "/user/userRefundDetail";

    }

    // 선택한 상품 환불 등록
    @PostMapping("/register/refund")
    public String  registerRefund(@ModelAttribute LRefundDTO refundDTO, Model model) throws Exception{

        // 환불 선택한 상품 주문 아이디
        Integer orderId = refundDTO.getOrderId();

        // 주문 ID 누락 확인
        if (orderId == null) {
            throw new IllegalArgumentException("주문 ID가 누락되었습니다.");
        }

        // dto에 주문 아이디를 넣어준다.
        LRefundDTO refundInfo = refundService.selectRefundProduct(orderId);

        if (refundInfo == null) {
            throw new IllegalArgumentException("해당 주문의 환불 정보를 찾을 수 없습니다. 주문 ID: " + orderId);
        }

        refundInfo.setRefundReason(refundDTO.getRefundReason());

        // 주문 테이블 환불 상태 업데이트
        refundService.modifyOrder(refundDTO);

        refundService.registerRefund(refundInfo);

        model.addAttribute("refundInfo", refundInfo);
        model.addAttribute("refundDTO", refundDTO);

        return "/user/userOrderCancelComplete";
    }

    // 이 컨트롤러에서 발생한 모든 예외 처리
    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        model.addAttribute("errorMessage", "요청 처리 중 오류가 발생했습니다. 상세: " + e.getMessage());
        return "user/errorPage"; // 오류 페이지로 이동
    }
}
