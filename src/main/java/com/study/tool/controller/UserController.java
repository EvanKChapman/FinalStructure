package com.study.tool.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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

import com.study.tool.model.Addresses;
import com.study.tool.model.PaymentMethod;
import com.study.tool.model.PhoneBook;
import com.study.tool.model.Products;
import com.study.tool.model.Role;
import com.study.tool.model.Users;
import com.study.tool.repository.AddressRepository;
import com.study.tool.repository.PaymentMethodRepository;
import com.study.tool.repository.PhoneBookRepository;
import com.study.tool.repository.RoleRepository;
import com.study.tool.repository.UserRepository;
import com.study.tool.utils.DataValidation;
import com.study.tool.utils.States;
import com.study.tool.utils.WebUtils;

@Controller
@SessionAttributes({"loggedInuser", "role"})
public class UserController {
	
	@Autowired
	private UserRepository userRepository;
	
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
	
	public String register(@ModelAttribute("users") Users user, Model model, BindingResult result, RedirectAttributes red) {
		
		dataValidation.validate(user, result);
		
		if (result.hasErrors()) {
			model.addAttribute("profile", "active");
			return "signup";
		}
		
		// save users and put the in session/login
				//user.setRole("USER");
		 userRepository.saveAndFlush(user);
		    user.setRoles(new HashSet<Role>(Arrays.asList(roleRepository.findByRole("USER"))));
			
			model.addAttribute("msg","Profile");
			model.addAttribute("user_account", user);
			model.addAttribute("loggedInuser", user.getEmail());
			model.addAttribute("role", user.getRole());
				
				return "profile";


	}
	
	
	@GetMapping("profile") 
	  String profile(@SessionAttribute(required = false) String loggedInuser, Model model) {
	     try {
	    	 model.addAttribute("page", "Profile");
	    	 //if user is not in session return login page expired session
			if(loggedInuser.isEmpty() || loggedInuser ==null) {
				 model.addAttribute("error", "Expired session, please Login");
				 return "login"; 
			 }
			//populate user details from database 
			userRepository.findByEmail(loggedInuser).ifPresent(a->{
				 model.addAttribute("user_account", a);
				 //model.addAttribute("image", Base64.getEncoder().encodeToString(a.getData()));
				 if(a.getAddress()!=null) {
					 model.addAttribute("address", a.getAddress());	 
				 }
			 });
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
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
	 
	 
	 
	 @ModelAttribute("states")
	    public List<States> populateStates(){    	
	        return Arrays.asList(States.values());
	    }	

	
	
	
	 @PostMapping("login")
		String login(RedirectAttributes redirect, Model model, @RequestParam String email, @RequestParam String password){
		  // login user
		  Optional<Users> user= userRepository.login(email, password);
		 //add user email and role in session
		  if(user.isPresent()) {
			  model.addAttribute("loggedInuser", email);
			  model.addAttribute("role", user.get().getRole()); 
			  
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
			userRepository.deleteById(id);
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
			userRepository.delete(userRepository.findByEmail(email).get());
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
	            @RequestParam(value = "size", defaultValue = "4", required = false) Integer size) {
	        
	        try {
	        model.addAttribute("users", "active");
	        Page<Users> findAllPagable = userRepository.findAll(PageRequest.of(page, size, Sort.by("fname")));
	model.addAttribute("list", findAllPagable);
	model.addAttribute("msg"," Users found");
	  } catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
	} 

	return "admin";

	}
	
	
	@PostMapping("updateUsers")
	public String update(@ModelAttribute Users user, Model model, RedirectAttributes red) {
		
		try {
//		userRepository.findById(user.getId()).ifPresent(a->{
//			a.setFname(user.getFname());
//				a.setLname(user.getLname());
				
				userRepository.save(user);
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
			Users user=userRepository.findById(addresses.getId()).get();
			user.setFname(addresses.getUser().getFname());
			user.setLname(addresses.getUser().getLname());
			addresses.setUser(user);
			addresses.setCreatedon(new Date());
			addressRepository.save(addresses);
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
	String removeCard(@RequestParam Long id, RedirectAttributes red) {
		try {
			paymentMethodRepository.deleteById(id);
			red.addFlashAttribute("msg", "Card Removed");
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
			Users user=userRepository.findById(id).get();	
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
	
	
	
	
	@PostMapping("search") 
	public String search(Model model, @RequestParam String keyword) {
		model.addAttribute("list", userRepository.findByUser(keyword));
		model.addAttribute("msg", "Users found");
		
		return "admin";
	}
	
	
	
	
	@PostMapping("editrole")
	public String search(Model model, @RequestParam String role, @RequestParam Long id) {
		
//		userRepository.findById(id).ifPresent(a -> {
//			a.setRole(role);
//			userRepository.save(a);
//		});
		
		userRepository.findById(id).
		ifPresent(a->{	
			a.setRole(role);
			if(role.equals("ADMIN")) {
				a.setRoles(new HashSet<Role>(roleRepository.findAll()));
				userRepository.save(a);
			}
			else {
				a.setRoles(new HashSet<Role>(Arrays.asList(roleRepository.findByRole(role))));
				userRepository.save(a);
			}				
		});
		
		return "redirect:admin";
	}
	
	// not sure if I need to edit above - we're going too damn fast and no one can keep up 
	
	
	
	
	@PostMapping("searchByemailOrlastname")
	public String searchByemailOrlastname(Model model, @RequestParam String lname, @RequestParam String email) {
		Page<Users> users=userRepository.customeseacher(lname, email, PageRequest.of(0, 4, Sort.by("id")));
		model.addAttribute("list", users);
		model.addAttribute("msg", "Users found");
		return "admin";
	}
	
	
	@ModelAttribute("user")
	Users user() {
		
		return new Users();
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
