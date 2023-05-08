package com.lsh.exam.demo.vo;



import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	
	private int id;
	private Date regDate;
	private Date updateDate;
	private String loginId;
	private String loginPw;
	private boolean delStatues;
	private String delDate;
	private String name;
	private String nickname;
	private String email;
	private String cellphoneNo;
	private String authLevel;
	

}
