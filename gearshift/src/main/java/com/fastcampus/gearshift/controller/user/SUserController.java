package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.mail.SEmailAuthService;
import com.fastcampus.gearshift.service.SUserService;
import org.checkerframework.checker.units.qual.C;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class SUserController {

    @Autowired
    private SUserService userService;

    @Autowired
    private SEmailAuthService emailAuthService;


    @GetMapping("/register")
    public String loadRegisterPage(Model model) {
        return "user/register";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute UserDto user, RedirectAttributes redirectAttributes) {
        userService.registerUser(user);
        redirectAttributes.addFlashAttribute("completeMessage", "가입이 완료되었습니다!");
        return "redirect:/login.do";
    }

    @GetMapping("/login.do")
    public String loadLoginPage(@RequestParam(required = false) String error,
                                @RequestParam(required = false) String loginType,
                                Model model) {
        model.addAttribute("error", error);
        model.addAttribute("loginType", loginType);
        return "user/login";
    }

    @PostMapping("/check-email")
    @ResponseBody
    public Map<String, Boolean> checkEmail(@RequestBody Map<String, String> body) {
        String userEmail = body.get("email");
        UserDto user = userService.findUserByEmail(userEmail);

        Map<String, Boolean> result = new HashMap<>();
        boolean isDuplicate = (user == null) ? false : true;
        result.put("duplicate", isDuplicate);

        return result;
    }

    @PostMapping("/send-auth-email")
    @ResponseBody
    public Map<String, Boolean> sendEmail(@RequestBody Map<String, String> body, HttpServletRequest request) {
        String email = body.get("email");
        boolean success = emailAuthService.sendCode(email, request);
        return Map.of("success", success);
    }

    @PostMapping("/verify-email-code")
    @ResponseBody
    public Map<String, Boolean> verifyCode(@RequestBody Map<String, String> body) {
        String email = body.get("email");
        String code = body.get("code");
        boolean result = emailAuthService.verifyCode(email, code);
        return Map.of("verified", result);
    }

    @GetMapping("/findInfo")
    public String loadFindInfoPage(Model model) {
        return "user/findInfo";
    }

    @GetMapping("/error403")
    public String handle403() {
        return "error/403";
    }

    @GetMapping("/error404")
    public String handle404() {
        return "error/404";
    }
}
