package kr.or.connect.heatmap.controller;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.connect.heatmap.config.ApplicationConfig;
import kr.or.connect.heatmap.dao.HeatMapFormDao;
import kr.or.connect.heatmap.dto.HeatMapFormData;

@Controller
public class ListController {
   
   @GetMapping("/myList")
   public String mylist() { //회원이 자신의 리스트를 볼때
      return "myList";
   }
   
   @GetMapping("/result")
   public String result() { //관리자가 리스트를 볼때
      return "result";
   }
   
   @PostMapping("/result2")
   public String result2() { //게시판에서 검색시
      return "result";
   }
   
   
   // 엑셀저장구현 부분
   @RequestMapping(value ="/result3", produces = "application/text; charset = utf8", method = RequestMethod.POST)
   public  String result3(HttpServletRequest request, HttpServletResponse response) throws Exception {
      ApplicationContext ac = new AnnotationConfigApplicationContext(ApplicationConfig.class);
      HeatMapFormDao formdao3 = ac.getBean(HeatMapFormDao.class);
      
      List<HeatMapFormData> list = null;
      
      String s_type = request.getParameter("s_type");
      String s_value = request.getParameter("s_value");
      
      if(s_type != null && s_type.trim().length()>0){
         list = formdao3.selectForSearch(s_type, s_value);
      } else list = formdao3.selectAll();
      
      XSSFRow row = null;
      XSSFCell cell = null;
      
      //String [] sKey = {"측정날짜", "측정시간", "측정지", "배정번호", "온도", "기상상태", "사진"};
      
       XSSFWorkbook workBook = new XSSFWorkbook();

       XSSFSheet sheet = workBook.createSheet("시트명");
       
       if( list.isEmpty() == false && list.size() > 0 ){
          
          /* byte[] 적용 -> 엑셀파일 다운받을 때 getOutputStream() 중복호출 방지
          File file = resource.getFile();

               return ResponseEntity.ok()
                       .header(HttpHeaders.CONTENT_DISPOSITION, file.getName())
                       .header(HttpHeaders.CONTENT_LENGTH, String.valueOf(file.length()))
                       .header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM.toString())
                       .body(resource);
           */
          
          row = sheet.createRow(0);
          
          cell = row.createCell(0);
          cell.setCellValue( "측정날짜" );
          cell = row.createCell(1);
          cell.setCellValue( "측정시간" );
          cell = row.createCell(2);
          cell.setCellValue( "측정지" );
          cell = row.createCell(3);
          cell.setCellValue( "배정번호" );
          cell = row.createCell(4);
          cell.setCellValue( "온도" );
          cell = row.createCell(5);
          cell.setCellValue( "기상상태" );
          cell = row.createCell(6);
          cell.setCellValue( "사용자id" );
          cell = row.createCell(7);
          cell.setCellValue( "사진URL" );
          
          
         
          

          for(int i = 1; i < list.size()+1; i++){

          // 1.row에 시트를 생성

          row = sheet.createRow(i);



          



         // 2.생성된 Row에 Cell생성
          
         Date from = list.get(i-1).getDate();
         SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
         String to = transFormat.format(from);
         Time time =list.get(i-1).getTime();
         SimpleDateFormat transFormat2 = new SimpleDateFormat("HH:mm:ss");
         String to2 = transFormat2.format(time);

         

         

         cell = row.createCell(0);
         cell.setCellValue( to );
         cell = row.createCell(1);
         cell.setCellValue( to2 );
         cell = row.createCell(2);
         cell.setCellValue( list.get(i-1).getArea1() );
         cell = row.createCell(3);
         cell.setCellValue( list.get(i-1).getAssignmentNum() );
         cell = row.createCell(4);
         cell.setCellValue( list.get(i-1).getTemperatures() );
         cell = row.createCell(5);
         cell.setCellValue( list.get(i-1).getWeather() );
         cell = row.createCell(6);
         cell.setCellValue( list.get(i-1).getId() );
         cell = row.createCell(7);
         cell.setCellValue( list.get(i-1).getUrl());
         

         

         }

          }



          //FileOutputStream fileOutPut = new FileOutputStream("D:\\ProjectExcel");
       	 response.setContentType("ms-vnd/excel");
         //response.setHeader("Content-Disposition", "attachment;filename=test.xls");
         response.setHeader("Content-Disposition", "attachment;filename=test.xlsx");
         
         ServletOutputStream out = response.getOutputStream();
         workBook.write(out);
         out.close();



         //workBook.write(response.getOutputStream());


      
      return null;
   }
   
   

}