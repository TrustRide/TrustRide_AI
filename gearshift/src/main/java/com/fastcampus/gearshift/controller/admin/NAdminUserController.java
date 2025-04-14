package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.AdminDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.NUserListService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin/userList")
public class NAdminUserController {

    @Autowired
    private NUserListService userListService;

    // 회원 목록 조회
    @GetMapping("")
    public String getList(Model model, HttpSession session) {
        AdminDto admin = (AdminDto) session.getAttribute("adminUser");

        if (admin == null) {
            session.setAttribute("redirectAfterLogin", "/admin/userList");
            return "redirect:/login.do";
        }

        List<UserDto> list = userListService.userList();
        model.addAttribute("userList", list);
        return "admin/userList";
    }

    // 관리자에 의한 회원 삭제
    @PostMapping("/delete")
    public String deleteUser(@RequestParam("userId") Integer userId,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {

        AdminDto admin = (AdminDto) session.getAttribute("adminUser");
        if (admin == null) {
            session.setAttribute("redirectAfterLogin", "/admin/userList");
            return "redirect:/login.do";
        }

        try {
            userListService.deleteUser(userId);
            redirectAttributes.addFlashAttribute("message", "회원 삭제가 완료되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "회원 삭제에 실패했습니다.");
        }

        return "redirect:/admin/userList";
    }
}
