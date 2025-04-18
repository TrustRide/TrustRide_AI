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

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;


@Controller
@RequiredArgsConstructor
public class PUserController {



    private final PCateService cateService;

    @Autowired
    JWishlistService wishlistService;


    private final PHolderService pHolderService;

    private static final Logger logger = LoggerFactory.getLogger(PUserController.class);


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
        //세션 로그인 유저 확인
        Object loginUser = session.getAttribute("loginUser");
        if(loginUser == null){
            //로그인 x 면 로그인 페이지 이동
           return "redirect:http://localhost:8080/gearshift/login.do";
        }
        //차량 정보 조회
        CarInfoDto carInfoDto = pHolderService.carDetailSelect(carInfoId);
        model.addAttribute("carDto", carInfoDto);

        return "user/userTitleHolder";

    }



    //메인화면 + 상품리스트 검색
    @GetMapping("/searchCar")
    public String searchCar(@RequestParam("searchQuery") String searchQuery,Model model) throws Exception{

        //페이지 크기 설정(예:10)

        List<CarListDto> searchResults = pHolderService.searchCarsByTitle(searchQuery);

        //검색 결과 없으면 메시지
        if(searchResults == null || searchResults.isEmpty()){
            model.addAttribute("errorMessage","검색 결과가 없습니다.");
        }else{
            model.addAttribute("userCarList",searchResults);
        }

        return "user/userCarList";

    }

    @GetMapping("/testError")
    public String testError() throws Exception {
        throw new Exception("테스트용 예외 발생!");
    }


//    //예외 메서드
//    @ExceptionHandler(Exception.class)
//    public String handleSearchException(Exception ex, Model model){
//   logger.error("PUserController 내부 예외 발생: {}",ex.getMessage(),ex);
//   model.addAttribute("errorMessage","죄송합니다. 요청 처리 중 문제가 발생했어요. 다시 시도 해주세요.");
//        return "error/404";
//    }


    //요약 테스트
    @GetMapping("/news2")
    public String news(){
        return "user/newsDetail";
    }


    @GetMapping("/newsList")
    public String newsList(Model model,
                           @RequestParam(defaultValue = "1") int page,
                           @RequestParam(defaultValue = "9") int pageSize) {

        int offset = (page - 1) * pageSize;

        List<NewsDto> list = pHolderService.getPagedNewsList(offset, pageSize);
        int totalNewsCount = pHolderService.getNewsCount();
        int totalPages = (int) Math.ceil((double) totalNewsCount / pageSize);

        model.addAttribute("list", list);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);

        return "user/newsList";
    }


    //상세 조회
    @GetMapping("/newsDetail")
    public String read(@RequestParam("newsId") Integer newsId, Model model) throws Exception {
        NewsDto newsDto = pHolderService.newsRead(newsId);
        List<NewsImageDto> imageList = pHolderService.getImagesByNewsId(newsId); // ✅ 다중 이미지 조회

        model.addAttribute("newsDto", newsDto);
        model.addAttribute("imageList", imageList);

        return "user/newsContent";
    }





}
