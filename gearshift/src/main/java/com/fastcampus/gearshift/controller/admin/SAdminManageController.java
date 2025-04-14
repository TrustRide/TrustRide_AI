package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.AdminDto;
import com.fastcampus.gearshift.dto.SPagingDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.SAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class SAdminManageController {

    @Autowired
    private SAdminService adminService;


    @GetMapping("/manage")
    public String loadManagePage(@RequestParam(defaultValue = "1") int page, Model model) {
        int totalCount = adminService.getTotalUserCount();
        SPagingDto paging = SPagingDto.fromList(page, totalCount);
        List<AdminDto> admins = adminService.getUsersWithPaging(paging.getOffset(), paging.getLimit());

        model.addAttribute("admins", admins);
        model.addAttribute("paging", paging);
        return "admin/manage";
    }

    @GetMapping("/manage2")
    public String loadManagePage2(Model model) {
        List<AdminDto> admins = adminService.getAllUsers();
        model.addAttribute("admins", admins);
        return "admin/manage";
    }

    @GetMapping("/register")
    public String loadRegisterPage(Model model) {
        return "admin/register";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute AdminDto user, Model model) {
        adminService.registerUser(user);
        return "redirect:/admin/manage";
    }

    @PostMapping("/check-email")
    @ResponseBody
    public Map<String, Boolean> checkEmail(@RequestBody Map<String, String> body) {
        String userEmail = body.get("email");
        AdminDto admin = adminService.findUserByEmail(userEmail);

        Map<String, Boolean> result = new HashMap<>();
        boolean isDuplicate = (admin == null) ? false : true;
        result.put("duplicate", isDuplicate);

        return result;
    }

    @PostMapping("/deactivate")
    @ResponseBody
    public ResponseEntity<String> deactivateAdmin(@RequestBody AdminDto admin) {
        adminService.deleteUser(admin.getAdminId());
        return ResponseEntity.ok("success");
    }

    @PostMapping("/activate")
    @ResponseBody
    public ResponseEntity<String> activateAdmin(@RequestBody AdminDto admin) {
        adminService.activateUser(admin.getAdminId());
        return ResponseEntity.ok("success");
    }

}
