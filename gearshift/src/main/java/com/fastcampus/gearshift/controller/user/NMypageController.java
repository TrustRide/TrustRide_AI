package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.UserDto;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

@Controller
public class NMypageController {

    @GetMapping("/user/mypage")
    public String mypage(HttpSession session, Model model) {
        UserDto loginUser = (UserDto) session.getAttribute("loginUser");

        if (loginUser == null) {
            // 로그인 안 된 경우 로그인 페이지로 리다이렉트
            session.setAttribute("redirectAfterLogin", "/user/mypage");
            return "redirect:/login.do";
        }

        // 사용자 정보 전달 (JSP에서 ${loginUser.userName} 등 사용 가능)
        model.addAttribute("loginUser", loginUser);

        // /WEB-INF/views/user/mypage.jsp 로 forward
        return "user/mypage";
    }
}
