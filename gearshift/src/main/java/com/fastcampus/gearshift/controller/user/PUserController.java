package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.*;

import com.fastcampus.gearshift.service.JWishlistService;
import com.fastcampus.gearshift.service.PCateService;
import com.fastcampus.gearshift.service.PHolderService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
@RequiredArgsConstructor
public class PUserController {



    private final PCateService cateService;

    @Autowired
    JWishlistService wishlistService;


    private final PHolderService pHolderService;


    //메인
    @GetMapping("/")
    public String index(){

        return "user/userIndex";

    }



    //상품 리스트
    @RequestMapping(value = "/userList", method = RequestMethod.GET)
    public String getCarList(@RequestParam(defaultValue = "1") int page,
                          @RequestParam(required = false) String cateCode,
                          Model model, HttpSession session) throws Exception {

        int pageSize = 9; // 한 페이지에 표시할 상품 개수

        // 전체 상품 개수 조회
        int totalCount = (cateCode == null) ? pHolderService.getCarCount() : pHolderService.getCarCountByCate(cateCode);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize); // 총 페이지 수 계산


        List<CarListDto> userCarList;

        if (cateCode == null) {
            userCarList = pHolderService.carPageSelect(page, pageSize);
        } else {
            userCarList = pHolderService.carselectByCate(cateCode, page, pageSize);
        }


        //  로그인 유저
        UserDto user = (UserDto) session.getAttribute("loginUser");
        Integer userId = (user != null) ? user.getUserId() : null;

        // isLogin 으로 로그인 안 되어있을 때 안보이도록
        boolean isLogin = userId != null;

        if(userId != null) {
            // 각 차량에 대해 isWished 설정
            for (CarListDto car : userCarList) {
                boolean wished = wishlistService.isWished(userId, car.getCarInfoId());
                car.setIsWished(wished);
            }
        }
        model.addAttribute("userCarList", userCarList);

        // 카테고리 목록 가져오기
        List<CategoryDto> cateList = cateService.cateList();
        if (cateList == null || cateList.isEmpty()) {
            throw new RuntimeException("cateList 데이터가 비어있습니다!");
        }

        // 모델에 데이터 추가
        model.addAttribute("cateList", cateList);
        model.addAttribute("userCarList", userCarList);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
        model.addAttribute("isLogin", isLogin);

        return "user/userCarList";

    }


    //배송지 입력 화면
    @GetMapping("/user/delivery")
    public String showDeliveryForm(
            @RequestParam("carInfoId") Integer carInfoId,
            @RequestParam("title") String title,
            @RequestParam("isJointHolder") Boolean isJointHolder,
            HttpSession session,
            Model model
    ) throws Exception {

        // 세션 체크
        UserDto userDto = (UserDto) session.getAttribute("loginUser");
        if (userDto == null) {
            return "redirect:/login.do";
        }

        Integer userId = userDto.getUserId();
        UserDto selectedUser = pHolderService.userSelect(userId);
        CarInfoDto carInfoDto = pHolderService.carDetailSelect(carInfoId);

        // DTO에 값 세팅
        carInfoDto.setOwnershipType(title);                   // 명의 타입
        carInfoDto.setIsJointOwnership(isJointHolder);        // 공동 명의 여부




        model.addAttribute("userDto", selectedUser);
        model.addAttribute("carDto", carInfoDto);

        return "user/deliveryInformation";
    }



    //차량 상세페이지 이동
    @GetMapping("/carDetail")
    public String showCarDetail(@RequestParam("carInfoId") Integer carInfoId, Model model,CarInfoDto dto) throws Exception {
        CarInfoDto carInfoDto = pHolderService.carDetailSelect(carInfoId);



        model.addAttribute("carDto", carInfoDto);
        model.addAttribute("dto", dto);

        return "user/userCarDetail";

    }


    //차량 명의
    @GetMapping("/titleHolder")
    public String getHolder(
            @RequestParam("carInfoId") Integer carInfoId,
            Model model,
            HttpSession session
    ) throws Exception {

        // 여기를 "loginUser"로 변경해야 세션에서 제대로 꺼낼 수 있음

        CarInfoDto carInfoDto = pHolderService.carDetailSelect(carInfoId);

        model.addAttribute("carDto", carInfoDto);

        return "user/userTitleHolder";

    }


    //메인화면 + 상품리스트 검색
    @GetMapping("/searchCar")
    public String searchCar(@RequestParam("searchQuery") String searchQuery,Model model) throws Exception{

        //페이지 크기 설정(예:10)

        List<CarListDto> searchResults = pHolderService.searchCarsByTitle(searchQuery);

        model.addAttribute("userCarList",searchResults);

        return "user/userCarList";

    }



}
