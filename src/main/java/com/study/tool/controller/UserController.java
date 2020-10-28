package com.study.tool.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.study.tool.model.Accounts;
import com.study.tool.model.Addresses;
import com.study.tool.model.PaymentMethod;
import com.study.tool.model.PhoneBook;
import com.study.tool.model.Products;
import com.study.tool.model.Role;
//import com.study.tool.model.Users;
import com.study.tool.repository.AddressRepository;
import com.study.tool.repository.PaymentMethodRepository;
import com.study.tool.repository.PhoneBookRepository;
import com.study.tool.repository.RoleRepository;
import com.study.tool.repository.UserRepository;
import com.study.tool.service.AccountService;
import com.study.tool.utils.DataValidation;
import com.study.tool.utils.States;
import com.study.tool.utils.WebUtils;


@Controller
@SessionAttributes({"loggedInuser", "role"})
public class UserController {
	
	@Autowired
	private AccountService accountService;
	
//	@Autowired
//	private UserRepository userRepository;
	
	@Autowired 
	private WebUtils webUtils;
	
	@Autowired
	private DataValidation dataValidation;
	
	
	@Autowired 
	private AddressRepository addressRepository;
	
	
	@Autowired
	private PaymentMethodRepository paymentMethodRepository;
	
	@Autowired 
	private RoleRepository roleRepository;
	
	
	@Autowired
	private PhoneBookRepository phoneBookRepository;
	

	
	
	// Sending request using post - requesting single parameters 
	
	@PostMapping("register")
	@Transactional
	
	public String register(@ModelAttribute("users") Accounts user, Model model, BindingResult result, RedirectAttributes red) {
		
		/*
		 * dataValidation.validate(user, result);
		 * 
		 * if (result.hasErrors()) { model.addAttribute("profile", "active"); return
		 * "signup"; }
		 */
		
		// save users and put the in session/login
				//user.setRole("USER");
			try {
				webUtils.sendMail(user.getEmail(), "Hi There, Welcome to Pom Retain!", "Welcome");
				System.out.println("mail sent");
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				System.out.println("send failed");
				e.printStackTrace();
			}
		 	accountService.saveAccount(user);
		    user.setRoles(new HashSet<Role>(Arrays.asList(roleRepository.findByRole("USER"))));
			
			model.addAttribute("msg","Profile");
			model.addAttribute("user_account", user);
			model.addAttribute("loggedInuser", user.getEmail());
			model.addAttribute("role", user.getRoles().stream().map(x-> x.getRole()).distinct().collect(Collectors.toList()));
				
				return "profile";


	}
	
	
	@GetMapping("profile") 
	  String profile(@SessionAttribute(required = false) String loggedInuser, Model model) {
	     try {
	    	 //model.addAttribute("page", "Profile");
	    	 //if user is not in session return login page expired session
	    	 if(loggedInuser ==null || loggedInuser.isEmpty()) {
				 model.addAttribute("error", "Expired session, please Login");
				 return "login"; 
			 }
			//populate user details from database 
			accountService.findByEmail(loggedInuser).ifPresent(a->{
				 model.addAttribute("user_account", a);
				 //model.addAttribute("image", Base64.getEncoder().encodeToString(a.getData()));
				 if(a.getAddress()!=null) {
					 model.addAttribute("address", a.getAddress());	 
				 }
			 });
			
			model.addAttribute("page", "Profile");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	  return "profile";
	 }

	 
	 
	 
	 @PostMapping("/addimages")
		public String add(@RequestParam("file") MultipartFile file, 
				@RequestParam Long id, RedirectAttributes model) {
	    	    
			Pattern ext = Pattern.compile("([^\\s]+(\\.(?i)(png|jpg))$)");
			try {
				
				  if(file != null && file.isEmpty()){
					  model.addFlashAttribute("error", "Error No file Selected "); 
				      return "redirect:profile"; 
				      } 
				  if(file.getSize()>1073741824){
					  model.addAttribute("error","File size "+file.getSize()+"KB excceds max allowed, try another photo ");
					  return "redirect:profile"; 
				      } 
				  Matcher mtch = ext.matcher(file.getOriginalFilename());
				  
//				  if (!mtch.matches()) {
//					  model.addFlashAttribute("error", "Invalid Image type "); 
//				      return "redirect:profile";			  
//				  }
				
				   webUtils.addProfilePhoto(file, id, "users");
				
					
				model.addFlashAttribute("msg", "Upload success "+ file.getSize()+" KB");
				
			} catch (Exception e) {
				//e.printStackTrace);
			}

			return "redirect:profile";
		}
	 
	 
	
	
	 @PostMapping("login")
		String login(RedirectAttributes redirect, Model model, @RequestParam String email, @RequestParam String password){
		  // login user
		  Optional<Accounts> user= accountService.login(email, password);
		 //add user email and role in session
		  if(user.isPresent()) {
			  model.addAttribute("loggedInuser", email);
			  model.addAttribute("role", user.get().getRoles().stream().map(x-> x.getRole()).distinct().collect(Collectors.toList())); 
			  
		  }else {
			  redirect.addFlashAttribute("error", "Invalid Credentials");
			  return "redirect:/login";
		  }
		  
		return "redirect:/profile";
			
		}
	 
	 
	 @PostMapping("sendemail")
		String sendemail(@RequestParam String email, 
						 @RequestParam String name,
						 @RequestParam String subject,
						 @RequestParam String message, RedirectAttributes red) {
			
				try {
					webUtils.sendMail(email, message+" From "+ name, subject);
					red.addFlashAttribute("success", "Your message has been sent. Thank you! "+ name);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					red.addFlashAttribute("error", "Email fail! ");
				}
			
		 
		return "redirect:contact";		
		}
	 
	 
	 
	 @PostMapping("registeremail")
	 String registeremail(@RequestParam String email,
			 				@RequestParam String name,
			 				@RequestParam(required=false) String subject,
			 				@RequestParam(required=false) String message, RedirectAttributes red) {
		 
			try {
				//webUtils.sendMail(email, message+" From "+ name, subject);
				webUtils.sendMail(email, message, "Thank you for signing up with Pom Retain!"+ name + subject);
				
				red.addFlashAttribute("registered", "Thank you for signing up for Pom Retain! "+ name);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				red.addFlashAttribute("error", "Email fail! ");
			}
			return "redirect:home";
	 }

	 
	 
	 
		
	
	 @GetMapping("logout")
		String logout(Model model, SessionStatus status, HttpSession session){
			//status.setComplete();
			session.invalidate();
			model.addAttribute("loggedInuser", "");
			model.addAttribute("role", "");
			// Users user=new Users();		
			//model.addAttribute("user", user);
			model.addAttribute("msg", "You have been logged out");
		
		return "login";
			
		}

	 
	 @GetMapping("expired")
	 String expire(Model model, HttpSession session){
	 session.invalidate();
	 model.addAttribute("loggedInuser", "");
	 model.addAttribute("role", "");
	 model.addAttribute("error", "You have logged out due to inactivity");

	 return "login";

	 }
	
	 
	 
	
	
	// mapping for deleting a user (the delete by id method is built in)
	@GetMapping("deleteUser")
	public String delete(@RequestParam Long id, RedirectAttributes red) {
		
		try {
			accountService.deleteAccounts(id);
			red.addFlashAttribute("success", "Delete Success");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:admin";
	}
	
	

	@GetMapping("deleteByemail")
	public String deleteByemail(@RequestParam String email, RedirectAttributes red) {
		
		
		try {
			//accountService(accountService.findByEmail(email).get());
			red.addFlashAttribute("success", "user deleted");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			red.addFlashAttribute("error", "Sorry unexpected error - delete fail");
		}
		
		return "redirect:admin";
	}
	
	
	
	@GetMapping("admin")
	public String users(Model model, @RequestParam(value = "page", defaultValue = "0", required = false) Integer page,
	            @RequestParam(value = "size", defaultValue = "4", required = false) Integer size, @SessionAttribute(required = false) String role) {
	        
	        try {
	        	if(role.equals("USER")) {    	    		
    	    		return "redirect:profile?protected=true";
	        	}
	        	if(role ==null || role.isEmpty()) {
   	    		 model.addAttribute("error", "Please Login");
   	    		return "login";
   	    	}
	        	
	        model.addAttribute("users", "active");
	        Page<Accounts> findAllPagable = accountService.findAll(PageRequest.of(page, size, Sort.by("fname")));
	        model.addAttribute("list", findAllPagable);
	        model.addAttribute("msg"," Accounts found");
	  } catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	} 

	return "admin";

	}
	
	
	@PostMapping("updateUsers")
	public String update(@ModelAttribute Accounts user, Model model, RedirectAttributes red) {
		
		try {
			
			accountService.findById(user.getId()).ifPresent(a->{
				  a.setFname(user.getFname()); a.setLname(user.getLname());
				  a.setRole(user.getRole()); 
				  accountService.saveAccount(a);
			 });
			
//		userRepository.findById(user.getId()).ifPresent(a->{
//			a.setFname(user.getFname());
//				a.setLname(user.getLname());
				
				//userRepository.save(user);
				red.addFlashAttribute("success", "User Updated");
			// });
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
			
			//red.addFlashAttribute("error", "User Exists");
		
		return "redirect:admin";
	}
	
	@PostMapping("updatecontact")
	String update(@ModelAttribute Addresses addresses, Model model) {
	
		try {
			addresses.setCreatedon(new Date());
			Accounts user=accountService.findById(addresses.getId()).get();
			user.setFname(addresses.getUser().getFname());
			user.setLname(addresses.getUser().getLname());
			user.setAddress(addresses);
			accountService.saveAccount(user);	
			model.addAttribute("msg", "Update success");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";	
	}
	
	
	@PostMapping("addcard")
	String addcard(@ModelAttribute PaymentMethod payment, Model model) {
	
		try {
//			Users user=userRepository.findById(payment.getId()).get();	
//			payment.setUser(user);			
			paymentMethodRepository.save(payment);
			model.addAttribute("msg", "Card Added");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";	
	}

	
	@GetMapping("deletecard")
	String deleteCard(@RequestParam Long id, RedirectAttributes red) {
		try {
			paymentMethodRepository.deleteById(id);
			red.addFlashAttribute("success", "Card Deleted");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";
	}
	
	
	@PostMapping("addphone")
	String addphone(@RequestParam Long id, @RequestParam String type, 
					@RequestParam String tel, RedirectAttributes red) {
	
		try {
			PhoneBook book = new PhoneBook();
			Accounts user=accountService.findById(id).get();	
			book.setUser(user);
			book.setTel(tel);
			book.setType(type);
			phoneBookRepository.save(book);
			red.addFlashAttribute("msg", "Phone Added");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";	
		
	}
	
	@GetMapping("deletetel")
	public String deletetel(@RequestParam Long id, RedirectAttributes red) {
		
		try {
			phoneBookRepository.deleteById(id);
			red.addFlashAttribute("success", "Phone Deleted");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "redirect:profile";
	}
	
	
	@PostMapping("search") 
	public String search(Model model, @RequestParam String keyword) {
		Page<Accounts> accounts=accountService.search(keyword, PageRequest.of(0, 4, Sort.by("id")));
		model.addAttribute("list", accounts);
		model.addAttribute("msg"," Accounts found");
		
		return "admin";
	}
	
	
	
	
	@PostMapping("editrole")
	public String editrole(Model model, @RequestParam String role, @RequestParam Long id) {
		
//		userRepository.findById(id).ifPresent(a -> {
//			a.setRole(role);
//			userRepository.save(a);
//		});
		accountService.editRoles(role, id);
		
		return "redirect:admin";
	}
	
	// not sure if I need to edit above - we're going too damn fast and no one can keep up 
	
	
	
	
	@PostMapping("searchByemailOrlastname")
	public String searchByemailOrlastname(Model model, @RequestParam String lname, @RequestParam String email) {
		Page<Accounts> accounts=accountService.customeseacher(lname, email, PageRequest.of(0, 4, Sort.by("id")));
		model.addAttribute("list", accounts);
		model.addAttribute("msg"," Accounts found");
		
		return "admin";
	}
	
	
	@PostMapping("changepassword")	
	String register(@ModelAttribute Accounts user, RedirectAttributes mod) {
		String passwordRegex ="^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=])(?=\\S+$).{8,}$";
		
		    accountService.findById(user.getId()).ifPresent(a->{			
			
			if(!a.getPassword().equals(user.getPassword())) {
				mod.addFlashAttribute("error", "Password is different from current one");
			}
			
			if(!user.getPassword2().matches(passwordRegex)) { 				
				mod.addFlashAttribute("error", "Password should be at least 8 characters, lower case, upper case and a special character."); 
			}
			
			if(a.getPassword().equals(user.getPassword()) && user.getPassword2().matches(passwordRegex)) {
				a.setPassword(user.getPassword2());
				accountService.saveAccount(a);
				mod.addFlashAttribute("msg", "Password reset success");
			}
			
		});
		
		return "redirect:profile";
		
	}
	
	
	
	
	@ModelAttribute("states")
    public List<States> populateStates(){    	
        return Arrays.asList(States.values());
    }
	
	
	@ModelAttribute("user")
	Accounts user() {
		
		return new Accounts();
	}
	
	
	@ModelAttribute("address")
	Addresses address() {
		return new Addresses();
	}
	
	
	@ModelAttribute("card")
	PaymentMethod pay() {
	return new PaymentMethod();		
	}

	
	// expose product object to the form in profile.jsp page 
	@ModelAttribute("product")
	Products prod() {
	return new Products();		
	}

	
	// drop down for selecting colors and sizes 
	
	@ModelAttribute("sizes")
	public List<String> size() {
		List<String> size = new ArrayList<String>();
		size.add("S");
		size.add("M");		
		size.add("L");
		size.add("XL");
		size.add("2X");
		size.add("3X");		
		size.add("FREE SIZE");
		return size;
	}

	@ModelAttribute("cols")
	public List<String> colour() {
		List<String> col = new ArrayList<String>();
		col.add("Blue");
		col.add("Brown");
		col.add("Black");
		col.add("White");
		col.add("Green");
		col.add("Gray");
		col.add("Red");
		col.add("Yellow");
		col.add("Pink");
		col.add("Tan");
		col.add("Purple");
		col.add("Maroon");
		col.add("Gold");
		col.add("Silver");
		return col;
	}

	
	
	
	
	
	
	
	
	
	
	
	//public String register(@RequestParam("fname") String fname, 
//	
//	@RequestParam String lname, @RequestParam String tel,
//	@RequestParam String street, @RequestParam String city,
//	@RequestParam String state, Model model) {
//		model.addAttribute("msg", "Name " + fname + " " + lname + "<br>" + "Contact " + tel + " " + city + " " + state);
//		
//		return "login";
//	}
	
	
	
	

}
