package com.fastcampus.gearshift.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/admin")
public class JVisualController {


    @GetMapping("/visuals")
    public String visuals() {
        return "admin/visuals";
    }

}
