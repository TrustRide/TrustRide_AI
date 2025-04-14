package com.fastcampus.gearshift.controller.user;

import com.fastcampus.gearshift.dto.ReviewDto;
import com.fastcampus.gearshift.dto.SPagingDto;
import com.fastcampus.gearshift.service.SReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class SReviewController {

    @Autowired
    SReviewService reviewService;

    @GetMapping("/review")
    public String loadReviewPage(@RequestParam(defaultValue = "1") int page,
                                 Model model) {
        int totalCount = reviewService.getTotalReviewCount();
        SPagingDto paging = SPagingDto.fromGrid(page, totalCount);
        List<ReviewDto> reviews = reviewService.getReviewsWithPagingFiltered(paging.getOffset(), paging.getLimit(), null);

        model.addAttribute("reviews", reviews);
        model.addAttribute("paging", paging);
        return "user/review";
    }

    @GetMapping("/review/{id}")
    public String loadReviewDetailPage(@PathVariable("id") Integer id,
                                       @RequestParam(defaultValue = "1") int page,
                                       Model model) {
        ReviewDto review = reviewService.getReviewById(id);
        model.addAttribute("review", review);
        model.addAttribute("page", page);
        return "user/reviewDetail";
    }

}
