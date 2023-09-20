//
//  Utilities.swift
//  collection
//
//  Created by Larissa Lanes on 15/09/23.
//

import Foundation

class Utilities {
    // Função para verificar se uma senha é válida com base em critérios específicos
    static func isPasswordValid(_ password: String) -> Bool {
        // Esta expressão regular verifica se a senha tem pelo menos 8 caracteres,
        // pelo menos uma letra minúscula, e pelo menos um caractere especial.
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return passwordTest.evaluate(with: password)
    }
    
    // Adicione aqui outras funções de utilitários conforme necessário
}
