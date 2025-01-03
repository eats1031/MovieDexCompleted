//
//  LoginViewDelegate.swift
//  MovieDex
//
//  Created by Luis Becerra on 5/12/24.
//

protocol LoginViewDelegate: AnyObject {
    func submitValidatedFields(email: String, password: String)
}
