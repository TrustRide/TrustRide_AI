package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.*;
import com.fastcampus.gearshift.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@RequiredArgsConstructor
@Controller
@RequestMapping("/user/orders")
public class LUserOrderController {

    private final LOrderService orderService;

    private final LRefundService refundService;

    // 현금 결제 후 주문내역/배송조회 페이지 이동
    @PostMapping("/status/cash")
    public String getOrderHistory(@ModelAttribute LOrderDTO lOrderDTO, @ModelAttribute PaymentProcessDTO paymentProcessDTO,
                                  @ModelAttribute LHolderDTO lHolderDTO, @ModelAttribute DeliveryDTO deliveryDTO, HttpSession session) throws Exception {

        // userId를 session에서 꺼내주기
        UserDto userDto = (UserDto) session.getAttribute("loginUser");
        Integer userId = userDto.getUserId();

        // 유저 정보가 없으면 예외처리
        if (userDto == null) {
            throw new IllegalStateException("로그인 정보가 없습니다. 다시 로그인해주세요.");
        }

        // 전체 주문 처리 로직을 서비스로 위임
        orderService.processCashOrder(lOrderDTO, paymentProcessDTO, lHolderDTO, deliveryDTO, userId);

        return "redirect:/user/orders/status/orderList";
    }

    // 신용카드 결제 후 주문내역/배송조회 페이지 이동
    @PostMapping("/status/credit")
    public String getOrderHistory2(@ModelAttribute LOrderDTO lOrderDTO, @ModelAttribute PaymentProcessDTO paymentProcessDTO,
                                   @ModelAttribute LHolderDTO lHolderDTO, @ModelAttribute DeliveryDTO deliveryDTO, HttpSession session) throws Exception {

        // userId를 session에서 꺼내주기
        UserDto userDto = (UserDto) session.getAttribute("loginUser");
        Integer userId = userDto.getUserId();

        // 유저 정보가 없으면 예외처리
        if (userDto == null) {
            throw new IllegalStateException("로그인 정보가 없습니다. 다시 로그인해주세요.");
        }

        orderService.processCashOrder(lOrderDTO, paymentProcessDTO, lHolderDTO, deliveryDTO, userId);

        return "redirect:/user/orders/status/orderList";
    }

    // 주문 목록 리스트
    @GetMapping("/status/orderList")
    public String getOrderList(HttpSession session, Model model) throws Exception {

        // userId를 session에서 꺼내주기
        UserDto userDto = (UserDto) session.getAttribute("loginUser");
        Integer userId = userDto.getUserId();

        // 유저 정보가 없으면 예외처리
        if (userDto == null) {
            throw new IllegalStateException("로그인 정보가 없습니다. 다시 로그인해주세요.");
        }

        // 주문 목록 조회
        List<LOrderListDTO> orderListDTO = orderService.getLOrderList(userId);
        model.addAttribute("orderList", orderListDTO);

        // 반품목록
        List<LRefundDTO> refundDTOList = refundService.getRefundList(userId);
        model.addAttribute("refundList", refundDTOList);

        return "user/userOrderHistory";
    }

    // 이 컨트롤러에서 발생한 모든 예외 처리
    @ExceptionHandler(Exception.class)
    public String handleException(Exception e, Model model) {
        model.addAttribute("errorMessage", "요청 처리 중 오류가 발생했습니다. 상세: " + e.getMessage());
        return "user/errorPage"; // 오류 페이지로 이동
    }
}
