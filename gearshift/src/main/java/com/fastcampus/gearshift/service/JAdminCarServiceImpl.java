package com.fastcampus.gearshift.service;

import com.fastcampus.gearshift.dao.JAdminCarDao;
import com.fastcampus.gearshift.dto.CarDto;
import com.fastcampus.gearshift.dto.ImageDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class JAdminCarServiceImpl implements JAdminCarService {

    private final JAdminCarDao carDao;

    /*
     - 관리자 차량 목록 조회
     - 차량 리스트 + 썸네일 이미지 정보까지 포함해서 반환
     */
    @Override
    public List<CarDto> getCarList() {
        List<CarDto> carList = carDao.getCarList(); // 차량 목록 + 이미지 목록까지 조인 조회

        for (CarDto car : carList) {
            if (car.getImages() != null) {
                // 썸네일 이미지만 추출해서 DTO에 따로 세팅
                car.getImages().stream()
                        .filter(ImageDto::getIsThumbnail)
                        .findFirst()
                        .ifPresent(thumbnail -> {
                            car.setThumbnailUrl(thumbnail.getImageUrl());
                            car.setThumbnailImageId(thumbnail.getImageId());
                        });
            }
        }

        return carList;
    }

    /*
     - 특정 차량의 썸네일 이미지 정보 조회
     */
    public ImageDto getThumbnailByCarId(int carInfoId) {
        return carDao.getThumbnailByCarId(carInfoId);
    }

    /*
     - 차량 등록 + 이미지 업로드 처리
     - 차량 정보 등록
     - 이미지 파일 저장
     - 썸네일 여부 판단 후 DB 저장
     */

    @Transactional
    @Override
    public void registerCarWithFiles(CarDto carDto, List<MultipartFile> imageFiles, Integer thumbnailIndex) {
        // 1) 차량 기본 정보 등록 (car_info + car_basic)
        carDao.insertCarInformation(carDto); // 차량 ID (PK) 생성
        carDao.insertCarBasicInfo(carDto);

        // 2) 이미지 처리
        if (imageFiles != null && !imageFiles.isEmpty()) {
            for (int i = 0; i < imageFiles.size(); i++) {
                MultipartFile file = imageFiles.get(i);
                if (!file.isEmpty()) {
                    try {
                        // 원본 파일명 가져오기
                        String originalName = file.getOriginalFilename();
                        if (originalName == null) continue;

                        // UUID 생성 + 파일명 중복 방지
                        String uuid = UUID.randomUUID().toString();
                        String savedName = uuid + "_" + originalName;

                        // 실제 서버에 파일 저장
                        File dest = new File("C:/upload/" + savedName); // 로컬 업로드 경로
                        file.transferTo(dest);

                        // 이미지 DTO 생성 및 세팅
                        ImageDto imageDto = new ImageDto();
                        imageDto.setCarInfoId(carDto.getCarInfoId());
                        imageDto.setImageUuid(uuid);
                        imageDto.setImageUrl("/uploads/" + savedName); // 웹에서 접근 가능한 경로

                        imageDto.setImageType(file.getContentType());

                        // 썸네일 여부 설정 ( 처음으로 오는 썸네일인덱스는 0이므로 첫번째 이미지만을 썸네일로 set)
                        imageDto.setIsThumbnail(i == thumbnailIndex);

                        // DB에 이미지 정보 저장
                        carDao.insertCarImage(imageDto);
                    } catch (IOException e) {
                        e.printStackTrace(); // 에러 로그 출력
                    }
                }
            }
        }

    }

    /*
     - 차량 상세 정보 조회
     */
    @Override
    public CarDto getCarById(Integer carInfoId) {
        return carDao.getCarById(carInfoId);
    }

    /*
     - 차량 정보 수정
     - 2가지를 같이 업데이트
     */

    @Transactional
    @Override
    public void updateCar(CarDto carDto) {
        carDao.updateCarInformation(carDto);
        carDao.updateCarBasicInfo(carDto);
    }



    @Transactional
    @Override
    public void deleteCar(Integer carInfoId) {
        carDao.deleteCar(carInfoId);
    }
}
