package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.NUserFormService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Map;

@Controller
@RequestMapping("/user/userForm")
public class NUserFormController {

    @Autowired
    private NUserFormService userFormService;

    @Autowired
    private PasswordEncoder passwordEncoder;


    // 사용자 프로필 조회
    @GetMapping("")
    public String getUserForm(HttpSession session, Model model) {

        UserDto loginUser = (UserDto)session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("redirectAfterLogin", "/user/userForm");
            return "redirect:/login.do";
        }

        Integer userId = loginUser.getUserId();
        UserDto userForm = userFormService.getUserFormById(userId);

        if (userForm == null) {
            throw new RuntimeException("사용자 정보가 존재하지 않습니다!");
        }

        model.addAttribute("user", userForm);
        return "user/userForm";
    }

    // 사용자 정보 수정 --이름 빼고 다 변경 가능
    @PostMapping("/update")
    public String updateUserForm(HttpSession session,
                                 @RequestParam("currentPassword") String currentPassword,
                                 @ModelAttribute UserDto updatedUserForm,
                                 RedirectAttributes redirectAttributes) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");
        if (loginUser == null) {
            session.setAttribute("redirectAfterLogin", "/user/userForm");
            return "redirect:/login.do";
        }


        Integer userId = loginUser.getUserId();
        updatedUserForm.setUserId(userId); // ✅ 핵심 추가
        updatedUserForm.setUserPassword(passwordEncoder.encode(updatedUserForm.getUserPassword()));
        try {
            userFormService.updateUserForm(userId, updatedUserForm);

            // ✅ 세션 갱신: 최신 사용자 정보로 다시 조회해서 저장
            session.setAttribute("loginUser", userFormService.getUserFormById(userId));

            redirectAttributes.addFlashAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "회원 정보 수정에 실패했습니다.");
        }

        return "redirect:/user/userForm";
    }


    // 사용자 탈퇴 처리
    @PostMapping("/delete")
    public String deleteUser(HttpSession session,
                             @RequestParam("currentPassword") String currentPassword,
                             RedirectAttributes redirectAttributes) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            session.setAttribute("redirectAfterLogin", "/user/userForm");
            return "redirect:/login.do";
        }

        Integer userId = loginUser.getUserId();
        try {
            userFormService.deleteUser(userId);
            session.invalidate(); // 세션 제거
            redirectAttributes.addFlashAttribute("message", "회원 탈퇴가 완료되었습니다.");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("message", "회원 탈퇴에 실패했습니다.");

        }

        return "redirect:/"; // 명확히 메인 페이지로 이동
    }

    //비밀번호 검증 API
    @PostMapping("/check-password")
    @ResponseBody
    public Map<String, Boolean> checkPassword(HttpSession session, @RequestBody Map<String, String> body) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");

        if(loginUser == null) {
            return Map.of("verified", false);
        }

        String rawPassword = body.get("password");
        String encodedPassword = loginUser.getUserPassword();
        boolean verified = passwordEncoder.matches(rawPassword, encodedPassword);

        return Map.of("verified", verified);
    }



}
