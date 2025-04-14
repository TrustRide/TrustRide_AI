package com.fastcampus.gearshift.dao;

import com.fastcampus.gearshift.dto.ImageDto;
import com.fastcampus.gearshift.dto.ReviewCommentDto;
import com.fastcampus.gearshift.dto.ReviewDto;

import java.util.List;

public interface SReviewDao {
    int countAllReviews();
    List<ReviewDto> selectReviewsWithPagingFiltered(int offset, int limit, Boolean isAnswered);
    ReviewDto findById(Integer id);
    void insertReview(ReviewDto reviewDto);
    void deleteReview(Integer reviewId);
    void deleteReviewCommentByReviewId(Integer reviewId);
    void deleteImageByReviewId(Integer reviewId);
    void insertComment(ReviewCommentDto reviewCommentDto);
    void deleteComment(Integer reviewCommentId);
    Integer selectReviewId(ReviewDto reviewDto);
    void insertReviewImage(ImageDto imageDto);
}
