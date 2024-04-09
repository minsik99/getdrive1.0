package com.project.getdrive.drive.handler;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.nio.ByteBuffer;
import java.nio.file.Paths;

import org.springframework.web.multipart.MultipartFile;

import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.core.sync.ResponseTransformer;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.CreateBucketRequest;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;
import software.amazon.awssdk.services.s3.model.S3Exception;

public class Aws {

    private final S3Client s3Client;

    // 아마존 액세스 API 키
    private final String accessKey = "AKIAYS2NXNON3FNNTRVI";
    private final String secretKey = "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";

    // 생성자
    public Aws() {
        AwsBasicCredentials awsCredentials = AwsBasicCredentials.create(accessKey, secretKey);
        this.s3Client = S3Client.builder()
            .credentialsProvider(StaticCredentialsProvider.create(awsCredentials))
            .region(Region.AP_NORTHEAST_2) // 여기에 원하는 리전을 설정합니다.
            .build();
    }

    // 파일 변환 메서드
    public File convertMultiPartToFile(MultipartFile file) throws IOException {
        File convertedFile = new File(file.getOriginalFilename());
        FileOutputStream fos = new FileOutputStream(convertedFile);
        fos.write(file.getBytes());
        fos.close();
        return convertedFile;
    }

    // 버킷 생성
    public void createBucket(String bucketName) {
        try {
            CreateBucketRequest createBucketRequest = CreateBucketRequest.builder()
                    .bucket(bucketName)
                    .build();
            s3Client.createBucket(createBucketRequest);
            System.out.format("Bucket %s has been created successfully.\n", bucketName);
        } catch (S3Exception e) {
            System.err.println("Bucket creation failed: " + e.awsErrorDetails().errorMessage());
        }
    }

    // 폴더 생성
    public void createFolder(String bucketName, String folderName) {
        try {
            // 폴더 이름에 슬래시('/')를 추가하여 폴더를 나타냅니다.
            PutObjectRequest request = PutObjectRequest.builder()
                    .bucket(bucketName)
                    .key(folderName + "/") // 폴더 이름에 슬래시를 추가하여 폴더를 나타냅니다.
                    .build();

            // 빈 객체를 업로드합니다. 빈 내용의 ByteBuffer를 사용합니다.
            ByteBuffer data = ByteBuffer.wrap(new byte[0]);
            s3Client.putObject(request, RequestBody.fromByteBuffer(data));
            System.out.format("Folder %s has been created successfully.\n", folderName);
        } catch (S3Exception e) {
            System.err.println("Folder creation failed: " + e.awsErrorDetails().errorMessage());
        }
    }

    // 파일 업로드
    public void uploadFile(String bucketName, String folderName, File file) {
        try {
            s3Client.putObject(PutObjectRequest.builder()
                .bucket(bucketName)
                .key(folderName + "/" + file.getName())
                .build(), file.toPath());
            System.out.format("File %s has been uploaded successfully.\n", file.getName());
        } catch (S3Exception e) {
            System.err.println("File upload failed: " + e.awsErrorDetails().errorMessage());
        }
    }

    // 파일 다운
    public void downloadFile(String bucketName, String objectKey, String downloadFilePath) throws IOException {
        try {
            GetObjectRequest getObjectRequest = GetObjectRequest.builder()
                    .bucket(bucketName)
                    .key(objectKey)
                    .build();

            // 파일을 다운로드하고 지정된 경로에 저장합니다.
            s3Client.getObject(getObjectRequest, ResponseTransformer.toFile(Paths.get(downloadFilePath)));

            System.out.format("File %s has been downloaded successfully.\n", downloadFilePath);
        } catch (S3Exception e) {
            System.err.println("File download failed: " + e.awsErrorDetails().errorMessage());
        }
    }

    // 파일 다운로드용 URL
    public URL generateFileUrl(String bucketName, String objectKey) {
        String region = "ap-northeast-2"; // 예시로 아시아 태평양(서울) 리전 사용
        String urlString = String.format("https://s3-%s.amazonaws.com/%s/%s", region, bucketName, objectKey);
        try {
            return new URL(urlString);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
}
