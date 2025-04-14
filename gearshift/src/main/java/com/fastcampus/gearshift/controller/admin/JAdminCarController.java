package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.CategoryDto;
import com.fastcampus.gearshift.service.JAdminCarService;
import com.fastcampus.gearshift.service.JCategoryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Controller
@RequestMapping("/admin/cars")
@RequiredArgsConstructor
public class JAdminCarController {

    private final JAdminCarService carService;
    private final JCategoryService categoryService;

    // (1) 차량 목록 페이지
    @GetMapping("/list")
    public String getCarList(Model model) {
        List<CarDto> carList = carService.getCarList();
        model.addAttribute("carList", carList);


        return "admin/carList";
    }



    // (2) 차량 등록 폼
    @GetMapping("/register")
    public String showRegisterForm(@ModelAttribute("carDto") CarDto carDto, Model model) {

        // 대분류 목록 추가
        model.addAttribute("largeCategories", categoryService.getLargeCategories());
        return "admin/carRegisterForm";
    }

    // (3) AJAX: 중분류 목록 반환
    @GetMapping("/categories/medium")
    @ResponseBody
    public List<CategoryDto> getMediumCategories(@RequestParam String parentCode) {
        return categoryService.getMediumCategories(parentCode);
    }

    // (4) AJAX: 소분류 목록 반환
    @GetMapping("/categories/small")
    @ResponseBody
    public List<CategoryDto> getSmallCategories(@RequestParam String parentCode) {
        return categoryService.getSmallCategories(parentCode);
    }


    @PostMapping("/register")
    public String registerCar(
            CarDto carDto,
            @RequestParam("imageFiles") List<MultipartFile> imageFiles,
            @RequestParam(name = "thumbnailIndex", required = false, defaultValue = "0") Integer thumbnailIndex
    ) {

        // 차량 총 합계
        carDto.setCarAmountPrice(carDto.getCarPrice()+carDto.getAgencyFee()+carDto.getPreviousRegistrationFee());


        carService.registerCarWithFiles(carDto, imageFiles, thumbnailIndex); // 실제 호출
        return "redirect:/admin/cars/list";
    }

    // ================================
    //      추가된 수정/삭제 기능
    // ================================

    // (6) 차량 수정 폼
    @GetMapping("/{carInfoId}/edit")
    public String editCarForm(@PathVariable("carInfoId") Integer carInfoId, Model model) {
        // DB에서 기존 정보를 가져온다
        CarDto carDto = carService.getCarById(carInfoId);
        // 대분류 목록
        model.addAttribute("largeCategories", categoryService.getLargeCategories());
        // 화면단에서 기존값을 보여주기 위해 model에 세팅
        model.addAttribute("carDto", carDto);
        return "admin/carEditForm";
    }

    // (7) 차량 수정 처리
    @PostMapping("/{carInfoId}/edit")
    public String updateCar(@PathVariable("carInfoId") Integer carInfoId, CarDto carDto) {

        // PK 세팅 (일반적으로 hidden form이나 PathVariable로 넘김)
        carDto.setCarInfoId(carInfoId);
        carService.updateCar(carDto);
        return "redirect:/admin/cars/list";
    }

    // (8) 차량 삭제 처리
    @GetMapping("/{carInfoId}/delete")
    public String deleteCar(@PathVariable(name = "carInfoId") Integer carInfoId) {
        carService.deleteCar(carInfoId);
        return "redirect:/admin/cars/list";
    }

    //(9}차량 상세 페이지 처리
    @GetMapping("/{carInfoId}")
    public String carDetail(@PathVariable Integer carInfoId, Model model) {
        CarDto car = carService.getCarById(carInfoId); // carService에서 차량 조회
        model.addAttribute("car", car);
        return "admin/carDetail";
    }
}
