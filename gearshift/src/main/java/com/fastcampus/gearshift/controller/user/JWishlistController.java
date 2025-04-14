package com.fastcampus.gearshift.controller.user;


import com.fastcampus.gearshift.dto.CarListDto;
import com.fastcampus.gearshift.dto.UserDto;
import com.fastcampus.gearshift.service.JWishlistService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
@RequiredArgsConstructor
@RequestMapping("/user/wishlist")
public class JWishlistController {

    private final JWishlistService wishlistService;


    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<String> addWishlist(@RequestBody Integer carInfoId, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("loginUser");
        wishlistService.addWishlist(user.getUserId(), carInfoId);
        return ResponseEntity.ok("success");
    }

    @PostMapping("/remove")
    @ResponseBody
    public ResponseEntity<String> removeWishlist(@RequestBody Integer carInfoId, HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("loginUser");
        wishlistService.removeWishlist(user.getUserId(), carInfoId);
        return ResponseEntity.ok("success");
    }

    // [A] 찜 등록
    @PostMapping("/add2")
    public String addWishlist2(@RequestParam("carInfoId") Integer carInfoId,
                               HttpSession session) {

        UserDto user = (UserDto) session.getAttribute("loginUser");
        System.out.println("user 컨트롤러 = " + user);

        if (user == null) {
            return "redirect:/login.do";
        }
        wishlistService.addWishlist(user.getUserId(), carInfoId);
        // 등록 후 어디로 이동할지(차량 상세나 목록) 결정
        return "redirect:/userList"; // 혹은 carDetail?carInfoId=carInfoId
    }

    // [B] 찜 해제
    @PostMapping("/remove2")
    public String removeWishlist2(@RequestParam("carInfoId") Integer carInfoId,
                                  HttpSession session) {
        UserDto user = (UserDto) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login.do";
        }
        wishlistService.removeWishlist(user.getUserId(), carInfoId);
        return "redirect:/user/wishlist"; // 취향에 맞게
    }

    // [C] 내 찜 목록 페이지
    @GetMapping
    public String myWishlist(HttpSession session, Model model) {
        UserDto user = (UserDto) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login.do";
        }
        List<CarListDto> wishlistCars = wishlistService.getWishlistCars(user.getUserId());
        model.addAttribute("wishlistCars", wishlistCars);
        return "user/myWishlist";
    }
}
