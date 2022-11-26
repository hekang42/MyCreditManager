//
//  main.swift
//  MyCreditManager
//
//  Created by A11948 on 2022/11/26.
//

import Foundation

protocol myCreditManager {
    func 학생추가()
    func 학생삭제()
    func 성적추가()
    func 성적삭제()
    func 평점보기()
    func 종료()
}

struct 학생 {
    let name: String
    let subject: [Subject]
    
    var grades: [Double] { subject.map { Score[$0.score] ?? 0 } }
    var grade: Double { grades.reduce(0.0, +) / Double(subject.count) }
}

struct Subject {
    let title: String
    let score: String
}

let Score: [String: Double] = [
    "A+": 4.5, "A": 4.0,
    "B+": 3.5, "B": 3.0,
    "C+": 2.5, "C": 2.0,
    "D+": 1.5, "D": 1.0,
    "F": 0
]

enum Order: String {
    case 학생추가 = "1"
    case 학생삭제 = "2"
    case 성적추가 = "3"
    case 성적삭제 = "4"
    case 평점보기 = "5"
    case 종료 = "X"
}

class main: myCreditManager {
    let students: [학생] = []
    
    func 학생추가() {
    }
    
    func 학생삭제() {
        
    }
    
    func 성적추가() {
        
    }
    
    func 성적삭제() {
        
    }
    
    func 평점보기() {
        
    }
    
    func 종료() {
        exit(0)
    }
    func error() {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
    }
    
    func run() {
        while true {
            // 입력받기
            print("원하는 기능을 입력해주세요")
            print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5:평점보기, X: 종료")
            guard let input = readLine() else { break }
            let order = Order(rawValue: input)
            switch order {
            case .학생추가:
                학생추가()
            case .학생삭제:
                학생삭제()
            case .성적추가:
                성적추가()
            case .성적삭제:
                성적삭제()
            case .평점보기:
                평점보기()
            case .종료:
                종료()
            case .none:
                error()
            }
        }
    }
}


main().run()
