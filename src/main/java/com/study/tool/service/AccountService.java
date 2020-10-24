package com.study.tool.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.study.tool.model.Accounts;
import com.study.tool.model.Addresses;

@Service
public interface AccountService {
	
void saveAccount(Accounts accounts);
	
	void deleteAccounts(Long id);
	
    Optional<Accounts> findByEmail(String email);	
	
	Optional<Accounts> login(String email, String password);	
	
	List<Accounts> findByName(String name);	
	
	Page<Accounts> search(String name, Pageable pageable);	
	
	List<Accounts> findByName(String lname, String email);		
	
	Page<Accounts> customeseacher(String name, String email, Pageable pageable);
	
	Page<Accounts> findAll(Pageable pageable);
	
	Optional<Accounts> findById(Long id);
	
	void editRoles(String role, Long id);
	
	void updatecontact(Addresses addressess);
	
	
}
