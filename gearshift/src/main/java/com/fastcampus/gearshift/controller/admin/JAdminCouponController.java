package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.CouponDto;
import com.fastcampus.gearshift.service.JAdminCouponService;
import com.fastcampus.gearshift.service.JIssuedCouponService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.beans.PropertyEditorSupport;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
@RequestMapping("/admin/coupons")
@RequiredArgsConstructor
public class JAdminCouponController {

    private final JAdminCouponService jAdminCouponService;
    private final JIssuedCouponService jIssuedCouponService;


    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(LocalDate.class, new PropertyEditorSupport() {
            @Override
            public void setAsText(String text) throws IllegalArgumentException {
                if (text != null && !text.isEmpty()) {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    setValue(LocalDate.parse(text, formatter));
                }
            }
        });
    }


    // 1. 전체 쿠폰 목록 조회 (뷰 렌더링)
    @GetMapping("/list")
    public String getAllCoupons(Model model) {
        List<CouponDto> coupons = jAdminCouponService.getAllCoupons();

//        System.out.println("Coupons: " + coupons); // 쿠폰 리스트 로그 출력

        model.addAttribute("coupons", coupons);
        return "admin/couponList";
    }
    // 2. 쿠폰 생성 폼 페이지
    @GetMapping("/create")
    public String createCouponForm(@ModelAttribute("couponDto") CouponDto couponDto) {
        System.out.println("createCouponForm");
        return "admin/couponForm";
    }


    // 3. 쿠폰 생성 처리
    @PostMapping("/create")
    public String createCoupon(@ModelAttribute("couponDto") CouponDto couponDto) {
//        System.out.println("couponDto 생성컨트롤러 = " + couponDto); // couponDto 출력

        jAdminCouponService.createCoupon(couponDto);
        return "redirect:/admin/coupons/list"; // 생성 후 목록으로 이동
    }


    // 4. 쿠폰 수정 폼 페이지
    @GetMapping("/edit/{couponId}")
    public String editCouponForm(@PathVariable Integer couponId, Model model) {
        CouponDto couponDto = jAdminCouponService.getCouponById(couponId);
        model.addAttribute("couponDto", couponDto);
        return "admin/couponEdit";
    }

    // 5. 쿠폰 수정 처리
    @PostMapping("/edit/{couponId}")
    public String updateCoupon(@PathVariable Integer couponId, @ModelAttribute CouponDto couponDto) {
        couponDto.setCouponId(couponId);
        jAdminCouponService.updateCoupon(couponDto);
        return "redirect:/admin/coupons/list"; // 수정 후 목록으로 이동
    }

    // 6. 쿠폰 삭제 처리
    @GetMapping("/delete/{couponId}")
    public String deleteCoupon(@PathVariable Integer couponId) {
        jAdminCouponService.deleteCoupon(couponId);
        return "redirect:/admin/coupons/list"; // 삭제 후 목록으로 이동
    }

    // 7. 모든 사용자에게 쿠폰 일괄 발급
    @PostMapping("/issueSelected")
    public String issueCouponToAllUsers(@RequestParam Integer couponId) {
        System.out.println("전체발급 후  = " + couponId);

        jIssuedCouponService.issueCouponToAllUsers(couponId);
        return "redirect:/admin/coupons/list"; // 발급 후 목록으로 이동
    }



}
