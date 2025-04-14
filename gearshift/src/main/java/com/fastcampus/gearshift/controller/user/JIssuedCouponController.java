package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.IssuedCouponDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.JIssuedCouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user/coupons")
@RequiredArgsConstructor
public class JIssuedCouponController {

    private final JIssuedCouponService jIssuedCouponService;

    /**
     * 내 쿠폰 목록 조회
     */
    @GetMapping("/list")
    public String listUserCoupons(HttpSession session, Model model) {
        // 세션에서 로그인 사용자 객체 꺼내기
        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        if (loginUser == null) {
            // 로그인되지 않았다면 로그인 페이지로 리다이렉트
            return "redirect:/login.do";
        }

        // 로그인된 유저의 userId
        Integer userId = loginUser.getUserId();

        // 쿠폰 목록 조회
        List<IssuedCouponDto> userCoupons = jIssuedCouponService.getUserCoupons(userId);

        model.addAttribute("userCoupons", userCoupons);
        model.addAttribute("userId", userId);
        return "user/userCouponList";
    }

    /**
     * 쿠폰 사용
     */
    @PostMapping("/use")
    public String useCoupon(Integer issuedId,
                            HttpSession session,
                            RedirectAttributes redirectAttributes) {
        // 세션에서 로그인 사용자 객체 꺼내기
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login.do";
        }

        Integer userId = loginUser.getUserId();

        try {
            jIssuedCouponService.useCoupon(issuedId, userId);
            redirectAttributes.addFlashAttribute("successMessage", "쿠폰을 성공적으로 사용했습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "쿠폰 사용 중 오류가 발생했습니다.");
        }

        // 사용 후 쿠폰 리스트 페이지로 돌아가기
        return "redirect:/user/coupons/list";
    }
}
