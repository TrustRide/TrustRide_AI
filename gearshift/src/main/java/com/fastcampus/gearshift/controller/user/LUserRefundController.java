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
    public String getRefundableOrdersPage(Model model, HttpSession session) {

        // 세션에 저장된 userId 가져오기
        UserDto userDto =  (UserDto)session.getAttribute("loginUser");
        Integer userId = userDto.getUserId();

        List<LRefundAbleListDTO> refundAbleListDTO = refundService.getRefundAbleList(userId);

        model.addAttribute("refundAbleList", refundAbleListDTO);

        return "/user/userRefundHistory";
    }

    // 선택한 환불 상품 조회
    @GetMapping("/select/refund")
    public String selectRefund(@ModelAttribute LRefundDTO refundDTO, Model model) {

        // 선택한 상품의 주문 아이디
        Integer orderId = refundDTO.getOrderId();

        // dto에 주문 아이디를 넣어준다.
        LRefundDTO refundInfo = refundService.selectRefundProduct(orderId);

        model.addAttribute("refundInfo", refundInfo);
        model.addAttribute("refundDTO", refundDTO);

        return "/user/userRefundDetail";

    }

    // 선택한 상품 환불 등록
    @PostMapping("/register/refund")
    public String  registerRefund(@ModelAttribute LRefundDTO refundDTO, Model model) {

        // 환불 선택한 상품 주문 아이디
        Integer orderId = refundDTO.getOrderId();


        // dto에 주문 아이디를 넣어준다.
        LRefundDTO refundInfo = refundService.selectRefundProduct(orderId);
        refundInfo.setRefundReason(refundDTO.getRefundReason());

        // 주문 테이블 환불 상태 업데이트
        refundService.modifyOrder(refundDTO);

        refundService.registerRefund(refundInfo);

        model.addAttribute("refundInfo", refundInfo);
        model.addAttribute("refundDTO", refundDTO);

        return "/user/userOrderCancelComplete";
    }
}
