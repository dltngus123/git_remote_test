package com.lsh.exam.demo.vo;

import lombok.Getter;

public class ResultData<DT> {

	@Getter
	private String resultCode;

	@Getter
	private String msg;

	@Getter
	private DT data1;

	@Getter
	// "id" id ,"article" article
	private String data1Name;

	@Getter
	private Object data2;

	@Getter
	// "id" id ,"article" article
	private String data2Name;

	// 생성자 만들어서 객체 생성못하게?
	// private ResultData() {
	// }

	public static ResultData from(String rsultCode, String msg) {

		return from(rsultCode, msg, null, null);
	}

	public static <DT> ResultData<DT> from(String resultCode, String msg, String data1Name, DT data1) {
		ResultData<DT> rd = new ResultData<DT>();
		rd.resultCode = resultCode;
		rd.msg = msg;
		rd.data1Name = data1Name;
		rd.data1 = data1;

		return rd;
	}

	public static <DT> ResultData<DT> newData(ResultData oldRd, String data1Name, DT data1) {

		return from(oldRd.getResultCode(), oldRd.getMsg(), data1Name, data1);
	}

	public boolean isSuccess() {
		// S-로 시작하면 성공
		return resultCode.startsWith("S-");
	}

	public boolean isFail() {
		// F-로 시작하면 실패
		return isSuccess() == false;
	}

	public void setData2(String dataName, Object data) {
		data2Name = dataName;
		data2 = data;

	}

}
