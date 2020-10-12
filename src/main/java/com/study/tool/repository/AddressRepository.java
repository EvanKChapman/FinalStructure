package com.study.tool.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.study.tool.model.Addresses;

@Repository
public interface AddressRepository extends JpaRepository<Addresses, Long> {
	Optional<Addresses> findByEmail(String email);
}
