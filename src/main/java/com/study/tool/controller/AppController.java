package com.study.tool.controller;

import java.util.Date;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.study.tool.model.Accounts;
//import com.study.tool.model.Users;

@Controller
public class AppController {
	
	@GetMapping({"home", "/"})
	// @ResponseBody
	public String index(Model model) {
		model.addAttribute("msg", "Welcome to Spring MVC");
		
		return "home";
	}
	
	
	@GetMapping({"test"})
	String test(Model model) {
		model.addAttribute("msg", "test");
		return "test";
	}
	
	@GetMapping({"about"})
	String about(Model model) {
		model.addAttribute("msg", "abous us");
		
		return "about";
	}
	
	@GetMapping({"contact"})
	public String contactus(Model model) {
		model.addAttribute("msg", "Contact us");
		
		return "contact";
	}
	
	
	@GetMapping({"login"})
	public String login(Model model) {
		model.addAttribute("msg", "Login");
		
		return "login";
	}
	
	
	@PostMapping("sign-in")
	public String signin (Model model, @RequestParam String email, @RequestParam String password) {
		
		model.addAttribute("msg", email+ " " + password);
		
		return "login";
	}
	
	
	@GetMapping({"signup"})
	String signUp(Model model) {
		model.addAttribute("msg", "Sign up");
		model.addAttribute("users", new Accounts());
		
		return "signup";
	}
	

	
	
	
	
	@GetMapping("myname")
	public String timen(Model model, @RequestParam String name, @RequestParam String address) {
		model.addAttribute("msg", "Hi " + name + " From " + address + " time now is " + new Date());
		return "home";
	}
	
	
	@GetMapping("name-{name}-{address}")
	public String name(Model model, @PathVariable String name, @PathVariable String address) {
		model.addAttribute("msg", "Hi " + name + " From " + address + " time now is " + new Date());
		return "home";
	}
	
	
	
//	// sending request with parameters using Get method 
//	@GetMapping("names")
//	public String name(Model mode, @RequestParam String lname, @RequestParam String fname) {
//		//mode.addAttribute("msg", "<h3> You entered " + lname + " " + fname + "<h3>");
//		
//		return "home";
//	}
	
	
	
	
	// sending request with parameters using Get 
	// using @pathVariable annotation 
	
//	@GetMapping("name-{lname}-{fname}")
//	public String names(Model mode, @PathVariable String lname, @PathVariable String fname) {
//		mode.addAttribute("msg", "<h3>You entered " + lname + " " + fname + "<h3>");
//		
//		return "home";
//	}
	
	

	
	
	

}
