package com.project.getdrive.drive.handler;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;

import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.client.builder.AwsClientBuilder;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AbortMultipartUploadRequest;
import com.amazonaws.services.s3.model.AmazonS3Exception;
import com.amazonaws.services.s3.model.Bucket;
import com.amazonaws.services.s3.model.CopyObjectRequest;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ListMultipartUploadsRequest;
import com.amazonaws.services.s3.model.ListObjectsRequest;
import com.amazonaws.services.s3.model.ListObjectsV2Request;
import com.amazonaws.services.s3.model.ListObjectsV2Result;
import com.amazonaws.services.s3.model.MultipartUpload;
import com.amazonaws.services.s3.model.MultipartUploadListing;
import com.amazonaws.services.s3.model.ObjectListing;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.services.s3.model.S3ObjectSummary;

public class AwsS3 {
	private final String endPoint = "https://kr.object.ncloudstorage.com";
    private final String regionName = "kr-standard";
    private final String accessKey = "FKp75tWcIyf4yjKkOKRg";
    private final String secretKey = "P4cL7nReqqmzI6sNVnHJudivwGd0OUjWGpCZ66OK";

    private final AmazonS3 s3;

    // new 생성자로 생성될 때 api 연동
    public AwsS3() {
        s3 = AmazonS3ClientBuilder.standard()
            .withEndpointConfiguration(new AwsClientBuilder.EndpointConfiguration(endPoint, regionName))
            .withCredentials(new AWSStaticCredentialsProvider(new BasicAWSCredentials(accessKey, secretKey)))
            .build();
    }

    // 버킷 생성
    public void createBucket(String bucketName) {
        try {
            // create bucket if the bucket name does not exist
            if (s3.doesBucketExistV2(bucketName)) {
                System.out.format("Bucket %s already exists.\n", bucketName);
            } else {
                s3.createBucket(bucketName);
                System.out.format("Bucket %s has been created.\n", bucketName);
            }
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 버킷 목록 조회
    public void listBuckets() {
        try {
            List<Bucket> buckets = s3.listBuckets();
            System.out.println("Bucket List: ");
            for (Bucket bucket : buckets) {
                System.out.println("name=" + bucket.getName() + ", creation_date=" + bucket.getCreationDate() + ", owner=" + bucket.getOwner().getId());
            }
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 버킷 삭제
    public void deleteBucket(String bucketName) {
        try {
            // delete bucket if the bucket exists
            if (s3.doesBucketExistV2(bucketName)) {
                // delete all objects
                ObjectListing objectListing = s3.listObjects(bucketName);
                while (true) {
                    for (Iterator<?> iterator = objectListing.getObjectSummaries().iterator(); iterator.hasNext();) {
                        S3ObjectSummary summary = (S3ObjectSummary)iterator.next();
                        s3.deleteObject(bucketName, summary.getKey());
                    }

                    if (objectListing.isTruncated()) {
                        objectListing = s3.listNextBatchOfObjects(objectListing);
                    } else {
                        break;
                    }
                }

                // abort incomplete multipart uploads
                MultipartUploadListing multipartUploadListing = s3.listMultipartUploads(new ListMultipartUploadsRequest(bucketName));
                while (true) {
                    for (Iterator<?> iterator = multipartUploadListing.getMultipartUploads().iterator(); iterator.hasNext();) {
                        MultipartUpload multipartUpload = (MultipartUpload)iterator.next();
                        s3.abortMultipartUpload(new AbortMultipartUploadRequest(bucketName, multipartUpload.getKey(), multipartUpload.getUploadId()));
                    }

                    if (multipartUploadListing.isTruncated()) {
                        ListMultipartUploadsRequest listMultipartUploadsRequest = new ListMultipartUploadsRequest(bucketName);
                        listMultipartUploadsRequest.withUploadIdMarker(multipartUploadListing.getNextUploadIdMarker());
                        multipartUploadListing = s3.listMultipartUploads(listMultipartUploadsRequest);
                    } else {
                        break;
                    }
                }

                s3.deleteBucket(bucketName);
                System.out.format("Bucket %s has been deleted.\n", bucketName);
            } else {
                System.out.format("Bucket %s does not exist.\n", bucketName);
            }
        } catch (SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 폴더 생성
    public void createFolder(String bucketName, String folderName) {
        // 폴더를 나타내는 객체 생성
        ObjectMetadata objectMetadata = new ObjectMetadata();
        objectMetadata.setContentLength(0L);
        objectMetadata.setContentType("application/x-directory");
        PutObjectRequest putObjectRequest = new PutObjectRequest(bucketName, folderName + "/", new ByteArrayInputStream(new byte[0]), objectMetadata);

        try {
            s3.putObject(putObjectRequest);
            System.out.format("Folder %s has been created.\n", folderName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }

    // 파일 업로드
    public void uploadFile(String bucketName, String folderName, String objectName, InputStream inputStream) {
        try {
            ObjectMetadata metadata = new ObjectMetadata();
            metadata.setContentLength(inputStream.available());
            s3.putObject(bucketName, folderName + "/" + objectName, inputStream, metadata);
            System.out.format("Object %s has been created.\n", objectName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    
    // 버킷의 모든 객체 조회
    public void listAllObjects(String bucketName) {
        try {
            ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
                .withBucketName(bucketName)
                .withMaxKeys(300);

            ObjectListing objectListing = s3.listObjects(listObjectsRequest);

            System.out.println("Object List:");
            while (true) {
                for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                    System.out.println("name=" + objectSummary.getKey() + ", size=" + objectSummary.getSize() + ", owner=" + objectSummary.getOwner().getId());
                }

                if (objectListing.isTruncated()) {
                    objectListing = s3.listNextBatchOfObjects(objectListing);
                } else {
                    break;
                }
            }
        } catch (AmazonS3Exception e) {
            System.err.println(e.getErrorMessage());
            System.exit(1);
        }
    }

    // 버킷의 폴더와 파일을 구분하여 조회
    public void listFoldersAndFiles(String bucketName) {
        try {
            ListObjectsRequest listObjectsRequest = new ListObjectsRequest()
                .withBucketName(bucketName)
                .withDelimiter("/")
                .withMaxKeys(300);

            ObjectListing objectListing = s3.listObjects(listObjectsRequest);

            System.out.println("Folder List:");
            for (String commonPrefixes : objectListing.getCommonPrefixes()) {
                System.out.println("name=" + commonPrefixes);
            }

            System.out.println("File List:");
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                System.out.println("name=" + objectSummary.getKey() + ", size=" + objectSummary.getSize() + ", owner=" + objectSummary.getOwner().getId());
            }
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 파일 다운로드
    public void downloadObject(String bucketName, String objectName, String downloadFilePath) {
        try {
            S3Object s3Object = s3.getObject(bucketName, objectName);
            S3ObjectInputStream s3ObjectInputStream = s3Object.getObjectContent();

            OutputStream outputStream = new BufferedOutputStream(new FileOutputStream(downloadFilePath));
            byte[] bytesArray = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = s3ObjectInputStream.read(bytesArray)) != -1) {
                outputStream.write(bytesArray, 0, bytesRead);
            }

            outputStream.close();
            s3ObjectInputStream.close();
            System.out.format("Object %s has been downloaded.\n", objectName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 폴더 삭제
    public void deleteObject(String bucketName, String objectName) {
        try {
            s3.deleteObject(bucketName, objectName);
            System.out.format("Object %s has been deleted.\n", objectName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 버킷 비우기
    public void emptyBucket(String bucketName) {
        try {
            // 버킷 내의 객체 목록 가져오기
            ObjectListing objectListing = s3.listObjects(bucketName);
            for (S3ObjectSummary objectSummary : objectListing.getObjectSummaries()) {
                // 객체 삭제
                s3.deleteObject(new DeleteObjectRequest(bucketName, objectSummary.getKey()));
            }

            System.out.format("Bucket %s emptied.\n", bucketName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 버킷 이동
    public void moveBucket(String sourceBucketName, String destinationBucketName) {
        try {
            // 새로운 위치에 새로운 버킷 생성
            if (!s3.doesBucketExistV2(destinationBucketName)) {
                s3.createBucket(destinationBucketName);
            }

            // 이전 버킷의 객체 목록 가져오기
            ListObjectsV2Result objectListing = s3.listObjectsV2(new ListObjectsV2Request().withBucketName(sourceBucketName));
            objectListing.getObjectSummaries().forEach(objectSummary -> {
                String sourceKey = objectSummary.getKey();
                String destinationKey = sourceKey;

                // 객체 복사
                CopyObjectRequest copyRequest = new CopyObjectRequest(sourceBucketName, sourceKey, destinationBucketName, destinationKey);
                s3.copyObject(copyRequest);

                // 복사가 완료되면 이전 버킷의 객체 삭제
                s3.deleteObject(new DeleteObjectRequest(sourceBucketName, sourceKey));
            });

            // 이전 버킷 삭제
            s3.deleteBucket(sourceBucketName);

            System.out.format("Bucket %s moved to %s.\n", sourceBucketName, destinationBucketName);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 폴더(오브젝트) 이동
    public void moveFolder(String sourceBucketName, String sourcePrefix, String destinationBucketName, String destinationPrefix) {
        try {
            // 폴더(오브젝트) 내의 모든 파일과 하위 폴더(오브젝트)를 복사
            s3.listObjectsV2(sourceBucketName, sourcePrefix).getObjectSummaries().forEach(objectSummary -> {
                String destinationKey = destinationPrefix + objectSummary.getKey().substring(sourcePrefix.length());
                CopyObjectRequest copyRequest = new CopyObjectRequest(sourceBucketName, objectSummary.getKey(), destinationBucketName, destinationKey);
                s3.copyObject(copyRequest);
            });

            // 복사가 완료되면 원본 폴더(오브젝트) 삭제
            s3.deleteObject(new DeleteObjectRequest(sourceBucketName, sourcePrefix));
            System.out.format("Folder %s moved to %s.\n", sourcePrefix, destinationPrefix);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 파일 이동
    public void moveFile(String sourceBucketName, String sourceKey, String destinationBucketName, String destinationKey) {
        try {
            // 파일 복사
            CopyObjectRequest copyRequest = new CopyObjectRequest(sourceBucketName, sourceKey, destinationBucketName, destinationKey);
            s3.copyObject(copyRequest);

            // 복사가 완료되면 원본 파일 삭제
            s3.deleteObject(new DeleteObjectRequest(sourceBucketName, sourceKey));
            System.out.format("File %s moved to %s.\n", sourceKey, destinationKey);
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
    
    // 객체(파일) 메타데이터 확인
    public void getObjectMetadata(String bucketName, String objectName) {
        try {
            ObjectMetadata metadata = s3.getObjectMetadata(bucketName, objectName);
            System.out.println("Object Metadata:");
            System.out.println("    Content-Length: " + metadata.getContentLength());
            System.out.println("    Content-Type: " + metadata.getContentType());
            // 필요한 경우 더 많은 메타데이터 정보를 확인할 수 있습니다.
        } catch (AmazonS3Exception e) {
            e.printStackTrace();
        } catch(SdkClientException e) {
            e.printStackTrace();
        }
    }
}
