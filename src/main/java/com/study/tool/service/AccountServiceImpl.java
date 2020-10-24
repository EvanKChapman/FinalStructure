package com.study.tool.service;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Optional;
import java.util.Date;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.study.tool.model.Accounts;
import com.study.tool.model.Addresses;
import com.study.tool.repository.RoleRepository;
import com.study.tool.repository.UserRepository;
import com.study.tool.model.Role;

@Service
@Transactional
public class AccountServiceImpl implements AccountService {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired 
	RoleRepository roleRepository;

	@Override
	public Optional<Accounts> findByEmail(String email) {		
		return userRepository.findByEmail(email);
	}

	@Override
	public Optional<Accounts> login(String email, String password) {		
		return userRepository.login(email, password);
	}

	@Override
	public List<Accounts> findByName(String name) {
		return userRepository.findByName(name);
	}

	@Override
	public Page <Accounts> search(String name, Pageable pageable) {
		return userRepository.search(name, pageable);
	}

	@Override
	public List<Accounts> findByName(String lname, String email) {
		return userRepository.findByName(lname, email);
	}
	
	

	@Override
	public Page<Accounts> customeseacher(String name, String email, Pageable pageable) {
		return userRepository.customeseacher(name, email, pageable);
	}
	
	

	@Override
	public void saveAccount(Accounts accounts) {
		userRepository.save(accounts);
	}

	@Override
	public void deleteAccounts(Long id) {
		userRepository.deleteById(id);
	}
	
	

	@Override
	public Page<Accounts> findAll(Pageable pageable) {		
		return userRepository.findAll(pageable);
	}

	@Override
	public Optional<Accounts> findById(Long id) {
		return userRepository.findById(id);
	}

	@Override
	public void editRoles(String role, Long id) {		
		//userRepository.findById(id).get().setRole(role);
		userRepository.findById(id).
		ifPresent(a->{
			if(role.equals("ADMIN")) {
				a.setRoles(new HashSet<Role>(roleRepository.findAll()));
			}
			else {
				a.setRoles(new HashSet<Role>(Arrays.asList(roleRepository.findByRole(role))));
			}				
		});

		
	}

	@Override
	public void updatecontact(Addresses addresses) {
		
		addresses.setCreatedon(new Date());
		Accounts user=findById(addresses.getId()).get();
		user.setFname(addresses.getUser().getFname());
		user.setLname(addresses.getUser().getLname());
		user.setAddress(addresses);
	}

}
