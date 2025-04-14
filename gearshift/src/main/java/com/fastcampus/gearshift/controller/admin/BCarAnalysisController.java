package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.service.JAdminCarService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin")
public class BCarAnalysisController {

    private final JAdminCarService carService;

    // (1) 차량 데이터 분석 페이지
    @GetMapping("/main")
    public String showCarAnalysis(Model model) {
        List<CarDto> carList = carService.getCarList();
        model.addAttribute("carList", carList);
        return "admin/main"; // JSP 파일명
    }

}
