package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.*;
import com.fastcampus.gearshift.service.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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

        orderService.processCashOrder(lOrderDTO, paymentProcessDTO, lHolderDTO, deliveryDTO, userId);

        return "redirect:/user/orders/status/orderList";
    }

    // 주문 목록 리스트
    @GetMapping("/status/orderList")
    public String getOrderList(HttpSession session, Model model) throws Exception {

        // userId를 session에서 꺼내주기
        UserDto userDto = (UserDto) session.getAttribute("loginUser");
        Integer userId = userDto.getUserId();

        // 주문 목록 조회
        List<LOrderListDTO> orderListDTO = orderService.getLOrderList(userId);
        model.addAttribute("orderList", orderListDTO);

        // 반품목록
        List<LRefundDTO> refundDTOList = refundService.getRefundList(userId);
        model.addAttribute("refundList", refundDTOList);

        return "user/userOrderHistory";
    }
}
