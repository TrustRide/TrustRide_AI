package com.fastcampus.gearshift.auth.handler;

import com.fastcampus.gearshift.dto.AdminDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.SAdminService;
import com.fastcampus.gearshift.service.SUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collection;

@Component
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

    @Autowired
    private SUserService userService;

    @Autowired
    private SAdminService adminService;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

        String email = authentication.getName();
        String contextPath = request.getContextPath();

        for (GrantedAuthority auth : authorities) {
            if (auth.getAuthority().equals("ROLE_ADMIN")) {
                AdminDto admin = adminService.findUserByEmail(email);
                request.getSession().setAttribute("adminUser", admin);
                response.sendRedirect(contextPath + "/admin/main");
                return;
            } else if (auth.getAuthority().equals("ROLE_USER")) {
                UserDto user = userService.findUserByEmail(email);
                request.getSession().setAttribute("loginUser", user);
                response.sendRedirect(contextPath + "/");
                return;
            }
        }

        response.sendRedirect("/"); // fallback
    }
}
