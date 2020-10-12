package com.study.tool.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.study.tool.model.PaymentMethod;

public interface PaymentMethodRepository extends JpaRepository<PaymentMethod, Long>{

}
