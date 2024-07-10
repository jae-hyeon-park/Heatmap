package kr.or.connect.heatmap.controller;

import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.List;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.or.connect.heatmap.config.ApplicationConfig;
import kr.or.connect.heatmap.dao.MemberDao;
import kr.or.connect.heatmap.dto.Member;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


@Controller
public class JoinController {
	

	//회원가입 페이지이동
	@GetMapping("/join")
	public String join1() {
		return "join";
	}
	
	//비밀번호 수정 페이지이동
	@GetMapping("/ChangePassword")
	public String changepassword() {
		return "ChangePassword";
	}
	
	//회원탈퇴 페이지 이동
	@GetMapping("/memberDelete")
	public String memberDelete() {
		return "memberDelete";
	}
	
	//로그인 페이지 이동
	@GetMapping("/Login")
	public String login() {
		return "Login";
	}
	
	//비밀번호 찾기 페이지 이동
	@GetMapping("/PasswordSearch")
	public String PasswordSearch() { //비밀번호 찾기 페이지 이동시키기
		return "PasswordSearch";
	}
	
	//비밀번호 수정
	@PostMapping("/ChangePasswordControl") //비밀번호 변경
	public String passwordChange(@ModelAttribute Member member, HttpServletResponse response, HttpServletRequest request) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = response.getWriter();
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		MemberDao formdao3 = ac.getBean(MemberDao.class);
		
		List<Member> list = formdao3.selectAll();// sql의 회원정보 다 갖고오는 작업
		
		
		for(Member member1 : list) {
			if(member1.getId().equals(member.getId())) {// id 일치시 (일치할때까지 for문 돌림)
				
				MessageDigest md = MessageDigest.getInstance("SHA-256");
				md.update(member.getPassword().getBytes());
				String hex = String.format("%064x", new BigInteger(1, md.digest()));
				
				if(member1.getPassword().equals(hex)) { //id,비번 일치
					
					
					if(member.getChangepassword().equals(member.getChangepassword2())) {  //변경할 비밀번호 일치 확인
						md.update(member.getChangepassword().getBytes());
						String hex2 = String.format("%064x", new BigInteger(1, md.digest()));  //바뀐 비밀번호 해시함수로 변경
						
						Member mem = new Member();  // 수정을 위한 하나의 객체 생성
						mem.setPassword(hex2);  // 수정할 비번
						mem.setId(member1.getId());  // id일치를 위한 코드
						formdao3.update(mem);  //수정 
						
						script.println("<script>alert('변경 성공.'); location.href = '/heatmap/';</script>");
						script.close();
						break;
					}

					else {  //변경할 비번 확인이 틀릴때
					
					
					script.println("<script>alert('비밀번호 확인이 일치하지 않습니다.'); history.back();</script>");
					script.close();
					break;  //확인 되었으니 탈출
					}
					
				}
				else {//비번 불일치 (ID에서 일치확인후 비밀번호 확인이기 때문에 for문 영향X)
					script.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
					script.close();
					break;
					
				}
			}
			
			
			
		}
		//  아이디 없을시(리스트 목록 다 둘러보고 없는것을 확인)
		script.println("<script>alert('ID를 다시 확인해주세요.'); history.back();</script>");
		script.close();
		
		
		return "Login";
	}

	
	
	//회원가입
	@PostMapping("/JoinControl") //회원가입
	public String uploadMember(@ModelAttribute Member member, HttpServletResponse response, HttpServletRequest request) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = response.getWriter();
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		MemberDao formdao2 = ac.getBean(MemberDao.class);
		List<Member> list = formdao2.selectAll();
		
		//이메일 정규화
		String pattern1 = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])";
		//String pattern2 = "^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$";
		String IdStatus = "true";
		
		for(Member member1 : list) {
			if(member1.getId().equals(member.getId())) {
				IdStatus = "false";   //id중복임을 나타내는 변수
				script.println("<script>alert('아이디가 이미 있습니다.'); history.go(-1);</script>");
				script.close();
				//IdStatus = "false";
				break;
			}
		}
		
		if(member.getId() == null || member.getPassword() == null || member.getEmail() == null ||  member.getPassword2() == null) {
			
			//PrintWriter script = response.getWriter();
			script.println("<script>alert('미입력 정보있음.'); history.go(-1);</script>");
			script.close();
			
		}
		else if((member.getPassword().equals(member.getPassword2())) != true){ //비밀번호 불일치
			

			script.println("<script>alert('비밀번호 불일치.'); history.go(-1);</script>");
			script.close();
			
			
		}
		else if(!(Pattern.matches(pattern1, member.getEmail()))) {
			script.println("<script>alert('이메일 형식 불일치.'); history.go(-1);</script>");
			script.close();
			
		}
		else if(IdStatus.equals("false")) {  //아이디 중복확인을 거친후 해당 문구가 없으면 db등록 
			script.println("<script> history.go(-1);</script>");
			script.close();
			
		}
		
		
		else {   // 페이지에서 받아온 정보들은 insert전 확인 작업을 통해 확인이 되면 그때 dao객체 관련을 생성하여 넣어야함 (아니면 넣고 확인하는 작업이라 의미X)
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(member.getPassword().getBytes());
			String hex = String.format("%064x", new BigInteger(1, md.digest()));
			member.setPassword(hex);
			
			
			formdao2.insert2(member, "user");   //insert를 통해 sql에 추가 부분
			
			

			
			script.println("<script>alert('회원가입 완료.'); location.href = '/heatmap/Login';</script>");
			script.close();
			
		}
		
		
		
		return "main"; //else를 통해 마무리시 메인 화면으로
	}
	
	//회원 탈퇴
	@PostMapping("/DeleteMemberControl")  //회원탈퇴
	public String deleteMember(@ModelAttribute Member member, HttpServletResponse response, HttpServletRequest request, HttpSession session) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = response.getWriter();
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		MemberDao formdao3 = ac.getBean(MemberDao.class);
		
		List<Member> list = formdao3.selectAll();// sql의 회원정보 다 갖고오는 작업
		
		
		for(Member member1 : list) {
			if(member1.getId().equals(member.getId())) {// id 일치시 (일치할때까지 for문 돌림)
				
				MessageDigest md = MessageDigest.getInstance("SHA-256");
				md.update(member.getPassword().getBytes());
				String hex = String.format("%064x", new BigInteger(1, md.digest()));  //db에는 해시함수형태 비번임으로 변경해서 확인작업 필요
				
				if(member1.getPassword().equals(hex)) { //id,비번 일치
					
					formdao3.delete(member1.getId());
					session.invalidate();
					script.println("<script>alert('정상처리 되었습니다.'); location.href = '/heatmap/';</script>");
					script.close();
					break;
					
					
				}
				else {//비번 불일치 (ID에서 일치확인후 비밀번호 확인이기 때문에 for문 영향X)
					script.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
					script.close();
					break;
					
				}
			}
			
			
			
		}
		//  아이디 없을시(리스트 목록 다 둘러보고 없는것을 확인)
		script.println("<script>alert('ID를 다시 확인해주세요.'); history.back();</script>");
		script.close();
		
		
		return null;
	}

	//로그아웃
	@RequestMapping("/logout")  //로그아웃부분
    public ModelAndView logout(HttpSession session, HttpServletResponse response) throws Exception {
		//PrintWriter script = response.getWriter();
        session.invalidate();  //세션 초기화
       /* response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		script.println("<script>alert('logout complete.');</script>");
		script.close();
		*/
        ModelAndView mv = new ModelAndView("redirect:/");   //돌아가기
        return mv;
        
    }

	//로그인 기능 
	@PostMapping("/LoginControl") //로그인 부분
	public String loginCon(@ModelAttribute Member member, HttpServletResponse response, HttpServletRequest request) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = response.getWriter();
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		MemberDao formdao3 = ac.getBean(MemberDao.class);
		
		List<Member> list = formdao3.selectAll();// sql의 회원정보 다 갖고오는 작업
		
		
		for(Member member1 : list) {
			if(member1.getId().equals(member.getId())) {// id 일치시 (일치할때까지 for문 돌림)
				
				MessageDigest md = MessageDigest.getInstance("SHA-256");
				md.update(member.getPassword().getBytes());
				String hex = String.format("%064x", new BigInteger(1, md.digest()));
				
				if(member1.getPassword().equals(hex)) { //id,비번 일치
					HttpSession session = request.getSession();
					
					if(member1.getMtype().equals("admin")) {
						session.setAttribute("idNum", member1.getIdNum());
						System.out.println("idNum 보기 보기보기admin:"+member1.getIdNum()+":::"+member.getId());
						session.setAttribute("id", member.getId());
						session.setAttribute("mtype", member1.getMtype());
						script.println("<script>alert('로그인 성공.'); location.href = '/heatmap/';</script>");
						script.close();
						break;
					}

					else {
					System.out.println("idNum 보기 보기보기user:"+member1.getIdNum());
					session.setAttribute("idNum", member1.getIdNum());
					session.setAttribute("id", member.getId()); //일치동시에 해당 id 세션에 넘김
					session.setAttribute("mtype", member1.getMtype());
					
					script.println("<script>alert('로그인 성공.'); location.href = '/heatmap/';</script>");
					script.close();
					break;  //확인 되었으니 탈출
					}
					
				}
				else {//비번 불일치 (ID에서 일치확인후 비밀번호 확인이기 때문에 for문 영향X)
					script.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
					script.close();
					break;
					
				}
			}
			
			
			
		}
		//  아이디 없을시(리스트 목록 다 둘러보고 없는것을 확인)
		script.println("<script>alert('존재하지 않는 ID입니다.'); history.back();</script>");
		script.close();
		
		
		return "Login";
	}
	
	//비밀번호찾기 기능
	@PostMapping("/PasswordSearchCon") //비밀번호 찾기
	public String passwordSearch(@ModelAttribute Member member, HttpServletResponse response, HttpServletRequest request) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter script = response.getWriter();
		
		ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
		MemberDao formdao3 = ac.getBean(MemberDao.class);
		
		List<Member> list = formdao3.selectAll();// sql의 회원정보 다 갖고오는 작업
		
		
		for(Member member1 : list) {
			if(member1.getId().equals(member.getId())) {// id 일치시 (일치할때까지 for문 돌림)
				
				
				
				if(member1.getEmail().equals(member.getEmail())) { //이메일 일치시
					//////// 임의선
					String pw = "";
					for (int i = 0; i < 12; i++) {  //비번 랜덤생성
						pw += (char) ((Math.random() * 26) + 97);
					}
					
					MessageDigest md = MessageDigest.getInstance("SHA-256");
					md.update(pw.getBytes());
					String hex = String.format("%064x", new BigInteger(1, md.digest()));
					Member mem = new Member();  // 수정을 위한 하나의 객체 생성
					mem.setPassword(hex);  // 수정할 비번
					mem.setId(member1.getId());  // id일치를 위한 코드
					formdao3.update(mem);  //수정
					
					String FROM = "메일받았을 때 상대에게 보여지는 주소";//받았을때 보이는 송신자 이메일 주소
					String FROMNAME = "천안시 열지도";
				     String TO = member1.getEmail();
				     String SMTP_USERNAME = "열지도쪽 이메일";  //송신자 이메일 주소 (보내는 사람 이메일)
				     String SMTP_PASSWORD = "해당 이메일의 비밀번호"; // 송신자의 비번 (보내는 사람 이메일 비번) 필수!!!!!!!!!!!!!! 
				   //위의 SMTP_USERNAME 및 PASSWORD 사용시 네이버에서 SMTP 설정이 필요함.
				     
				    String HOST = "smtp.naver.com";  //어디껄로 사용할지
				     int PORT = 587;   //네이버의 경우 587 다른곳은 따로 찾아봐야함
				    
				     String SUBJECT = "비밀번호 찾기에 관한 조치입니다.";  //메일제목
				    
				     String BODY = String.join(
				        System.getProperty("line.separator"),
				        "<h1>비밀번호 찾기에 관한 조치 사항입니다.</h1>",
				        "<p>비밀번호는 " + pw + " 입니다. </p>"
				    );
					
					Properties props = System.getProperties();
			        props.put("mail.transport.protocol", "smtp");
			        props.put("mail.smtp.port", PORT); 
			        props.put("mail.smtp.starttls.enable", "true");
			        props.put("mail.smtp.auth", "true");
			        
			        Session session = Session.getDefaultInstance(props);
			        MimeMessage msg = new MimeMessage(session);
			        msg.setFrom(new InternetAddress(FROM, FROMNAME));
			        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
			        msg.setSubject(SUBJECT);
			        msg.setContent(BODY, "text/html;charset=euc-kr");
			        
			        Transport transport = session.getTransport();
			        try {
			            System.out.println("Sending...");
			            
			            transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
			            transport.sendMessage(msg, msg.getAllRecipients());
			            System.out.println("Email sent!");
			            script.println("<script>alert('비밀번호 찾기 완료'); location.href = '/heatmap/';</script>");
			    		script.close();
			        } catch (Exception ex) {
			            ex.printStackTrace();
			        } finally {
			            transport.close();
			            
			        }
					break;
					///////////////////
					
				}
				else {//이메일 불일치 (ID에서 일치확인후 비밀번호 확인이기 때문에 for문 영향X)
					script.println("<script>alert('등록하신 이메일이 일치하지 않습니다.'); history.back();</script>");
					script.close();
					break;
					
				}
			}
			
			
			
		}
		//  아이디 없을시(리스트 목록 다 둘러보고 없는것을 확인)
		script.println("<script>alert('ID를 다시 확인해주세요.'); history.back();</script>");
		script.close();
		
		
		return "PasswordSearch";
	}

}
