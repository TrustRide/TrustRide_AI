package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.SReviewDao;
import com.fastcampus.gearshift.dto.ImageDto;
import com.fastcampus.gearshift.dto.ReviewCommentDto;
import com.fastcampus.gearshift.dto.ReviewDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Service
public class SReviewServiceImpl implements SReviewService {

    @Autowired
    SReviewDao reviewDao;

    final String UPLOAD_DIRECTORY = "C:/Dev/reviews";
    final String UPLOAD_URI_PATTERN = "/uploads";

    @Override
    public int getTotalReviewCount() {
        return reviewDao.countAllReviews();
    }

    @Override
    public List<ReviewDto> getReviewsWithPagingFiltered(int offset, int limit, Boolean isAnswered) {
        return reviewDao.selectReviewsWithPagingFiltered(offset, limit, isAnswered);
    }

    @Override
    public ReviewDto getReviewById(Integer id) {
        return reviewDao.findById(id);
    }

    @Override
    public void registerReview(ReviewDto reviewDto, MultipartFile image) {
        reviewDao.insertReview(reviewDto);
        Integer reviewId = reviewDao.selectReviewId(reviewDto);

        if (image != null && !image.isEmpty()) {
            try {
                ImageDto imageDto = saveImage(reviewDto, image);
                imageDto.setReviewId(reviewId);
                reviewDao.insertReviewImage(imageDto);
            } catch (IOException e) {
                throw new RuntimeException("이미지 업로드 실패", e);
            }
        }

    }

    @Transactional
    @Override
    public void deleteReview(Integer reviewId) {
        reviewDao.deleteReview(reviewId);
        reviewDao.deleteReviewCommentByReviewId(reviewId);
        reviewDao.deleteImageByReviewId(reviewId);
    }

    @Override
    public void insertComment(ReviewCommentDto reviewCommentDto) {
        reviewDao.insertComment(reviewCommentDto);
    }

    @Override
    public void deleteComment(Integer reviewCommentId) {
        reviewDao.deleteComment(reviewCommentId);
    }

    private ImageDto saveImage(ReviewDto reviewDto, MultipartFile file) throws IOException {
        if (file.isEmpty()) return null;

        // 확장자 추출 (ex: .jpg)
        String originalFilename = file.getOriginalFilename();
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));

        // 날짜 기반 파일명 생성
        String timestamp = new SimpleDateFormat("yyyyMMdd_HHmmssSSS").format(new Date());
        String fileName = timestamp + extension;

        // 사용자 ID 기반 하위 디렉토리 설정
        Integer userId = reviewDto.getUserId();
        Path savePath = Paths.get(UPLOAD_DIRECTORY, userId.toString(), fileName);
        // 디렉토리 없으면 생성
        Files.createDirectories(savePath.getParent());
        // 저장
        file.transferTo(savePath.toFile());

        ImageDto imageDto = new ImageDto();
        imageDto.setImageUuid(timestamp);
        imageDto.setImageUrl(UPLOAD_URI_PATTERN + "/" + userId + "/" + fileName); // 웹 경로로도 저장
        imageDto.setReviewId(reviewDto.getReviewId());

        return imageDto;
    }

}
