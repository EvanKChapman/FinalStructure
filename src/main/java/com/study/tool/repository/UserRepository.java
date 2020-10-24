package com.study.tool.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.study.tool.model.Accounts;


public interface UserRepository extends JpaRepository<Accounts, Long> {
	
	String search="SELECT u FROM Accounts u WHERE u.email =:email AND " +
	  		  "u.fname LIKE (CONCAT('%',:name, '%')) OR u.lname =:name";
	
	String searchusers="SELECT u FROM Accounts u WHERE u.email =:name OR " +
	  		  "u.fname LIKE (CONCAT('%',:name, '%')) OR u.lname LIKE (CONCAT('%',:name, '%'))";
	
	Optional<Accounts> findByEmail(String email);
	
	@Query("FROM Accounts u WHERE u.email=?1 AND u.password=?2")
	Optional<Accounts> login(String email, String password);
	
	@Query("FROM Accounts WHERE lname=?1 OR fname=?1 OR email=?1")
	List<Accounts> findByName(String name);
	
	@Query(searchusers)
	Page<Accounts> search(@Param("name") String name, Pageable pageable);
	
	@Query("FROM Accounts WHERE lname=?1 AND email=?2")
	List<Accounts> findByName(String lname, String email);
		
	@Query(search)
	Page<Accounts> customeseacher(@Param("name") String name, @Param("email") String email, Pageable pageable);
	
}


