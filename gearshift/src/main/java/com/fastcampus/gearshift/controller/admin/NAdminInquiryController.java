//NAdminInquiryController.java --> 관리자 시점 문의관리
package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.AdminDto;
import com.fastcampus.gearshift.dto.InquiryCommentDto;
import com.fastcampus.gearshift.dto.InquiryDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.InquiryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin/inquiry")
public class NAdminInquiryController {

    @Autowired
    private InquiryService inquiryService;

    @GetMapping({"", "/"})
    public String getList(Model model, HttpSession session) {
        AdminDto admin = (AdminDto)session.getAttribute("adminUser");

        if (admin == null) {
            session.setAttribute("redirectAfterLogin", "/admin/inquiry");
            return "redirect:/login.do";
        }

        Integer adminId = admin.getAdminId();
        List<InquiryDto> list = inquiryService.inquiryList();
        model.addAttribute("inquiryList", list);

        return "admin/adminInquiry";
    }

    @GetMapping("/read")
    public String read(@RequestParam("inquiryId") Integer inquiryId, Model model,HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("adminUser");

        if (admin == null) {
            session.setAttribute("redirectAfterLogin", "/admin/inquiry");
            return "redirect:/login.do";  // 관리자 로그인 페이지 경로
        }
        Integer adminId = ((AdminDto) session.getAttribute("adminUser")).getAdminId();
        InquiryDto inquiry = inquiryService.getInquiryById(inquiryId);
        model.addAttribute("inquiry", inquiry);
        model.addAttribute("commentList", inquiry.getComments());
        return "admin/adminInquiryDetail";
    }

    @PostMapping("/reply")
    public String writeReply(@RequestParam("inquiryId") Integer inquiryId,
                             @RequestParam("commentContent") String commentContent,
                             HttpSession session,
                             RedirectAttributes rattr) {
        AdminDto admin = (AdminDto) session.getAttribute("adminUser");

        if (admin == null) {
            session.setAttribute("redirectAfterLogin", "/admin/inquiry");
            return "redirect:/login.do";  // 관리자 로그인 페이지 경로
        }

        try {
            Integer adminId = ((AdminDto) session.getAttribute("adminUser")).getAdminId();
            InquiryCommentDto comment = new InquiryCommentDto();
            comment.setInquiryId(inquiryId);
            comment.setAdminId(adminId);
            comment.setCommentContent(commentContent);

            inquiryService.writeComment(comment);
            rattr.addFlashAttribute("msg", "REPLY_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "REPLY_ERR");
        }
        return "redirect:/admin/inquiry/read?inquiryId=" + inquiryId;
    }

    @PostMapping("/delete")
    public String remove(@RequestParam("inquiryId") Integer inquiryId, RedirectAttributes rattr,HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("adminUser");

        if (admin == null) {
            session.setAttribute("redirectAfterLogin", "/admin/inquiry");
            return "redirect:/login.do";  // 관리자 로그인 페이지 경로
        }
        Integer adminId = ((AdminDto) session.getAttribute("adminUser")).getAdminId();
        try {
            int result = inquiryService.delete(inquiryId, null); // 관리자 삭제 시 userId는 null
            if (result != 1) throw new Exception("Delete failed");
            rattr.addFlashAttribute("msg", "DELETE_OK");
        } catch (Exception e) {
            e.printStackTrace();
            rattr.addFlashAttribute("msg", "DELETE_ERR");
        }
        return "redirect:/admin/inquiry";
    }
}




