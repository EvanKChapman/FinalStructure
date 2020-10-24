package com.study.tool;

import java.util.HashSet;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.study.tool.model.Role;
import com.study.tool.model.Accounts;

import com.study.tool.repository.RoleRepository;
import com.study.tool.repository.UserRepository;

@SpringBootApplication
public class ToolApplication implements CommandLineRunner{
	
	@Autowired 
	private UserRepository userRepository; 
	
	@Autowired 
	private RoleRepository roleRepository; 
	
	public static void main(String[] args) {
		SpringApplication.run(ToolApplication.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		
		 Optional<Accounts> usr= userRepository.findByEmail("admin@email.com");
		
		if(!usr.isPresent()) {
			Accounts user=new Accounts();
			user.setFname("Admin");
			user.setLname("Manager");
			user.setEmail("admin@email.com");
			user.setPassword("123");
			//user.setRole("ADMIN");
			user.setRoles(new HashSet<Role>(roleRepository.findAll()));
	        userRepository.save(user);
	       
		}
		
	}
	
}