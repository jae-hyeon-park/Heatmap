package kr.or.connect.heatmap.controller;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Calendar;
import java.util.List;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;

import org.apache.commons.io.FileUtils;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.transfer.TransferManager;
import com.amazonaws.services.s3.transfer.TransferManagerBuilder;

import kr.or.connect.heatmap.config.ApplicationConfig;
import kr.or.connect.heatmap.dao.HeatMapFormDao;
import kr.or.connect.heatmap.dao.SetTimeDao;
import kr.or.connect.heatmap.dto.HeatMapFormData;
import kr.or.connect.heatmap.dto.SetTimeData;

@Controller
public class SurveyFormController {
	// 응답폼 작성 페이지로 이동
	@GetMapping("/surveyform")
	public String surveyform() {
		return "surveyform";
	}

	// 응답폼 제출 전 미리보기 페이지 이동
	@GetMapping("/surveyformUploadCheck")
	public String uploadcheck() {
		return "surveyformUploadCheck";
	}

	// surveyform.jsp에서 작성한 내용을 surveyformUploadCheck.jsp로 보내주고
	// 미리보기(surveyformUploadCheck.jsp)로 이동
	@PostMapping("/surveyformCheck")
	public String uploadCheck(@ModelAttribute("data") HeatMapFormData data) {
		// base64를 이용한 사진 미리보기 기능의 인코딩은 HeatMapFormData 내에 setFile1메소드에 있습니다.
		return "surveyformUploadCheck";
	}

	// 미리보기 페이지(surveyformUploadCheck.jsp)에서 제출버튼 누르면 db에 데이터와 사진 저장.(사진은 s3)
	@PostMapping("/surveyformUpload")
	public String upload(@ModelAttribute HeatMapFormData data, HttpServletRequest request,
			HttpServletResponse response) {
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		HeatMapFormDao formdao = ac.getBean(HeatMapFormDao.class);

		HttpSession session = request.getSession();
		String id = null;
		int idNum;
		String url = null;

		// 세션에서 id를 가져와 id값 입력.
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
			data.setId(id);
		}

		// 세션에서 idNum을 가져와 id_num입력.
		if (session.getAttribute("idNum") != null) {
			idNum = Integer.parseInt(String.valueOf(session.getAttribute("idNum")));
			System.out.println("idNum 보기 보기보기:" + idNum);
			data.setIdNum(idNum);
		}

		// 제출전 시간제한 확인 코드
		SetTimeDao settimedao = ac.getBean(SetTimeDao.class);

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = null;
		
		try {
			script = response.getWriter();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

		TimeZone.setDefault(TimeZone.getTimeZone("Asia/Seoul"));
		java.util.Date utilDate = new java.util.Date();
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

		List<SetTimeData> settimedata = null;
		settimedata = settimedao.setTimeList();

		int checkPoint = -1;

		for (int i = 0; i < settimedao.getCount(); i++) {
			Date data1 = settimedata.get(i).getDateSet();
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String to1 = transFormat.format(data1);

			String to2 = transFormat.format(sqlDate);

			if (to2.equals(to1)) {
				checkPoint = 1;
				List<SetTimeData> timelist = settimedao.timeCheckList(data1);
				for (int j = 0; j < settimedao.getTimeCheckListCount(data1); j++) {
					java.util.Date Date1 = new java.sql.Date(settimedata.get(i).getDateSet().getTime());
					java.sql.Timestamp Time1 = new java.sql.Timestamp(timelist.get(j).getTimeSet().getTime());
					SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
					// timeFormat.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));, Locale.KOREA
					String timeStr = timeFormat.format(Time1);
					String dateStr = transFormat.format(Date1);

					String setStr = dateStr + " " + timeStr;
					String finishStr = null;

					try {
						SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
						java.util.Date dateTime = dateFormat.parse(setStr);

						String utilDateStr = dateFormat.format(utilDate);
						utilDate = dateFormat.parse(utilDateStr);

						Calendar cal = Calendar.getInstance();
						cal.setTime(dateTime);
						cal.add(Calendar.MINUTE, 30);

						finishStr = dateFormat.format(cal.getTime());
						java.util.Date finishTime = dateFormat.parse(finishStr);

						boolean after = utilDate.after(dateTime);
						boolean before = utilDate.before(finishTime);
						System.out.println(dateTime + " " + finishTime);
						System.out.println(utilDate);
						System.out.println(before + " " + after);
						if (before && after) {
							break;
						} else if (j + 1 == settimedao.getTimeCheckListCount(data1)) {
							script.println("<script>alert('측정 시간이 아닙니다.');location.href = '/heatmap/'; </script>");
							script.close();
							return "main";
						}

					} catch (ParseException e) {
						e.printStackTrace();
					}
				}
			}
		}

		if (checkPoint == -1) {
			script.println("<script>alert('측정 시간이 아닙니다.');location.href = '/heatmap/'; </script>");
			script.close();
			return "main";
		}
		//시간 제한코드 끝

		// 사진 경로 저장.
		url = "https://imgheatmap-bucket.s3.ap-northeast-2.amazonaws.com/" + data.getDate() + "%5B"
				+ data.getAssignmentNum() + "%5D";
		data.setUrl(url);

		// insert 메소드 사용해서 DB에 데이터 저장
		int count = formdao.insert(data);

		response.setContentType("text/html; charset=UTF-8");
		if (count == -1) {
			try {
				script = response.getWriter();
				script.println("<script>alert('입력된 배정번호입니다.'); history.go(-1);</script>");
				script.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		String fname = data.getDate() + "[" + data.getAssignmentNum() + "]";
		String decfile1 = data.getEncfile1();

		// base64 디코딩
		byte[] decodeBytes1 = DatatypeConverter.parseBase64Binary(decfile1);

		// 여기서부터 s3 사진 코드: 키 값이랑 비밀번호 버킷 이름 삽입해야 함.
		if (count != -1) {
			AmazonS3 amazonS3 = null;
			String bucket = null;

			// s3 키값, 비밀번호 삽입
			AWSCredentials creds = new BasicAWSCredentials("S3키값",
					"비밀번호 부분");
			amazonS3 = AmazonS3ClientBuilder.standard().withCredentials(new AWSStaticCredentialsProvider(creds))
					.withRegion(Regions.AP_NORTHEAST_2) // region
					.withForceGlobalBucketAccessEnabled(true) // access
					.build();
			// s3 버킷 이름 삽입
			bucket = "imgheatmap-bucket";
			TransferManager tm = TransferManagerBuilder.standard().withS3Client(amazonS3).build();

			PutObjectRequest objrequest;
			try {
				ObjectMetadata metadata = new ObjectMetadata();
				metadata.setCacheControl("604800"); // 60*60*24*7 일주일
				metadata.setContentType("image/jpeg");
				metadata.setContentLength(decodeBytes1.length);

				objrequest = new PutObjectRequest(bucket, fname, new ByteArrayInputStream(decodeBytes1), metadata)
						.withCannedAcl(CannedAccessControlList.PublicRead);
				amazonS3.putObject(objrequest);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		try {
			script = response.getWriter();
			script.println("<script>alert('정상처리 되었습니다.');location.href = '/heatmap/'; </script>");
			script.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return "main";
	}
}
