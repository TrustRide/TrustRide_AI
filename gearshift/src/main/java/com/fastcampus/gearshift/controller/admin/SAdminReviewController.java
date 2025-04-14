package com.fastcampus.gearshift.controller.admin;

import com.fastcampus.gearshift.dto.AdminDto;
import com.fastcampus.gearshift.dto.ReviewCommentDto;
import com.fastcampus.gearshift.dto.ReviewDto;
import com.fastcampus.gearshift.dto.SPagingDto;
import com.fastcampus.gearshift.service.SReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin")
public class SAdminReviewController {

    @Autowired
    SReviewService reviewService;

    @GetMapping("/review")
    public String loadReviewPage(@RequestParam(defaultValue = "1") int page,
                                 @RequestParam(required = false) Boolean isAnswered,
                                 Model model) {
        int totalCount = reviewService.getTotalReviewCount();
        SPagingDto paging = SPagingDto.fromList(page, totalCount);
        List<ReviewDto> reviews = reviewService.getReviewsWithPagingFiltered(paging.getOffset(), paging.getLimit(), isAnswered);

        model.addAttribute("reviews", reviews);
        model.addAttribute("paging", paging);
        model.addAttribute("isAnswered", isAnswered);

        return "admin/review";
    }

    @GetMapping("/review/{id}")
    public String loadReviewDetailPage(@PathVariable("id") Integer id,
                                       @RequestParam(defaultValue = "1") int page,
                                       Model model) {
        ReviewDto review = reviewService.getReviewById(id);
        model.addAttribute("review", review);
        model.addAttribute("page", page);
        return "admin/reviewDetail";
    }

    @PostMapping("/review/comment")
    @ResponseBody
    public ResponseEntity<String> registerComment(@RequestBody ReviewCommentDto reviewCommentDto, HttpSession session) {
        System.out.println(reviewCommentDto.getReviewId());
        System.out.println(reviewCommentDto.getCommentContent());
        Integer adminId = ((AdminDto) session.getAttribute("adminUser")).getAdminId();
        reviewCommentDto.setAdminId(adminId);
        reviewService.insertComment(reviewCommentDto);
        return ResponseEntity.ok("success");
    }

    @PostMapping("/review/comment/delete")
    @ResponseBody
    public ResponseEntity<String> deleteComment(@RequestBody Integer reviewCommentId) {
        reviewService.deleteComment(reviewCommentId);
        return ResponseEntity.ok("success");
    }
}