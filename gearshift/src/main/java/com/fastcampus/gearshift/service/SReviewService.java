package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dto.ReviewCommentDto;
import com.fastcampus.gearshift.dto.ReviewDto;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface SReviewService {
    int getTotalReviewCount();
    List<ReviewDto> getReviewsWithPagingFiltered(int offset, int limit, Boolean isAnswered);
    ReviewDto getReviewById(Integer id);
    void registerReview(ReviewDto reviewDto, MultipartFile image);
    void deleteReview(Integer reviewId);
    void insertComment(ReviewCommentDto reviewCommentDto);
    void deleteComment(Integer reviewCommentId);
}
