package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.InquiryDto;
import com.fastcampus.gearshift.dto.NInquiryDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.NInquiryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user/inquiry")
public class NUserInquiryController {

    @Autowired
    private NInquiryService inquiryService;

    // 1. 목록 조회
    @GetMapping
    public String getList(HttpSession session, Model model, HttpServletRequest request) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            return "redirect:/login.do";
        }

        List<NInquiryDto> list = inquiryService.findByUserId(loginUser.getUserId());
        model.addAttribute("inquiryList", list);
        return "user/userInquiry";
    }

    // 2. 작성 폼
    @GetMapping("/write")
    public String writeForm(HttpSession session, HttpServletRequest request, Model model) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            return "redirect:/login.do";
        }

        model.addAttribute("inquiry", new NInquiryDto());
        return "user/userInquiryForm";
    }

    // 3. 작성 처리
    @PostMapping("/write")
    public String write(NInquiryDto dto, HttpSession session, HttpServletRequest request, RedirectAttributes rattr) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            session.setAttribute("redirectAfterLogin", request.getRequestURI());
            return "redirect:/login.do";
        }

        dto.setUserId(loginUser.getUserId());
        dto.setUserName(loginUser.getUserName());

        try {
            inquiryService.create(dto);
            rattr.addFlashAttribute("msg", "WRT_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "WRT_ERR");
        }

        return "redirect:/user/inquiry";
    }

    @GetMapping("/read/{inquiryId}")
    public String readInquiry(@PathVariable Integer inquiryId, Model model) {
        NInquiryDto inquiry = inquiryService.getById(inquiryId);
        model.addAttribute("inquiry", inquiry);
        return "user/userInquiryDetail";
    }



    // 5. 수정 폼 진입
    @GetMapping("/modify")
    public String modifyForm(@RequestParam("inquiryId") Integer inquiryId, HttpSession session, Model model) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login.do";

        NInquiryDto dto = inquiryService.getById(inquiryId);
        model.addAttribute("inquiry", dto);
        return "user/userInquiryEditForm";
    }

    // 6. 수정 처리
    @PostMapping("/modify")
    public String modify(NInquiryDto dto, HttpSession session, RedirectAttributes rattr) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) return "redirect:/login.do";

        dto.setUserId(loginUser.getUserId()); // 보안상 확인 용도

        try {
            inquiryService.update(dto);
            rattr.addFlashAttribute("msg", "MOD_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "MOD_ERR");
        }

        return "redirect:/user/inquiry/read?inquiryId=" + dto.getInquiryId();
    }



}
