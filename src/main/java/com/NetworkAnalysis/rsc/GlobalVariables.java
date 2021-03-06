package com.NetworkAnalysis.rsc;

import java.net.URLEncoder;

public class GlobalVariables{

	String connection;
	String DB = "TwitterDB";
	/*
	String USER = "cgc_user";	
	String PASSWORD = "cgc_D3Access82)";
	String HOST = "fixtweetstest.coh6dv3qg5l4.us-west-2.rds.amazonaws.com";	
	String PORT = "1531";
	*/
	String USER = "maryDB";
	String PASSWORD = "Mary123!";
	String HOST = "localhost";
	String PORT = "3306";
	
	String FILE_PATH="E:\\Maestria\\Tesis\\Gephi_Test\\";
	
	public GlobalVariables() {
		//local
		//connection = "http://localhost:8080/NetworkAnalysis/";
		FILE_PATH="E:\\Maestria\\Tesis\\Gephi_Test\\";
		//amazon
		connection = "http://localhost/NetworkAnalysis/";
		//FILE_PATH="\\var\\";
	}
	
	

	public String getConnection() {
		return connection;
	}

	public void setConnection(String connection) {
		this.connection = connection;
	}

	public String getUSER() {
		return USER;
	}

	public void setUSER(String uSER) {
		USER = uSER;
	}

	public String getPASSWORD() {
		return PASSWORD;
	}

	public void setPASSWORD(String pASSWORD) {
		PASSWORD = pASSWORD;
	}

	public String getDB() {
		return DB;
	}

	public void setDB(String dB) {
		DB = dB;
	}

	public String getHOST() {
		return HOST;
	}

	public void setHOST(String hOST) {
		HOST = hOST;
	}

	public String getPORT() {
		return PORT;
	}

	public void setPORT(String pORT) {
		PORT = pORT;
	}

	public String getFILE_PATH() {
		return FILE_PATH;
	}

	public void setFILE_PATH(String fILE_PATH) {
		FILE_PATH = fILE_PATH;
	}
	
	// espacio = AND
	// " OR " = OR
	// debe estar URL encode
	public String filterSearch(String words) {
		String arrayWords[] = words.split(",");
		String tempWords="";
		
		for(int i=0;i<arrayWords.length;i++)
			tempWords +=arrayWords[i].trim() + ",";		
		
		tempWords = tempWords.substring(0, tempWords.length()-4);
		
		try{
			return URLEncoder.encode(tempWords,"UTF-8");
		}
		catch(Exception ex){
			return "ERROR";
		}				
	}
	
	// espacio = AND
	// coma = OR
	public String filterStream(String words){
		String arrayWords[] = words.split(",");
		String tempWords="";
		
		for(int i=0;i<arrayWords.length;i++)
			tempWords +=arrayWords[i].trim() + ",";		
		
		tempWords = tempWords.substring(0, tempWords.length()-1);
		
		try{
			return URLEncoder.encode(tempWords,"UTF-8");
		}
		catch(Exception ex){
			return "ERROR";
		}
	}
}

