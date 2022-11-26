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
    var subject: [Subject]
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
    var students: [학생] = []
    
    func 학생추가() {
        print("추가할 학생의 이름을 입력해주세요")
        guard let name = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        if students.contains(where: { $0.name == name }) {
            print("\(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            students.append(학생(name: name, subject: []))
            print("\(name) 학생을 추가했습니다.")
        }
    }
    
    func 학생삭제() {
        print("삭제할 학생의 이름을 입력해주세요")
        guard let name = readLine() else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        if students.contains(where: { $0.name == name }) {
            students = students.filter { $0.name != name }
            print("\(name) 학생을 삭제하였습니다.")
        } else {
            print("\(name) 학생을 찾지 못했습니다.")
        }
    }
    
    func 성적추가() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등) 을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift A+")
        print("만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        
        guard let strings = readLine()?.components(separatedBy: " "), strings.count == 3, Score.keys.contains(strings[2])
        else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        let inputName = strings[0]
        let inputSubject = Subject(title: strings[1], score: strings[2])
        
        if let index = students.firstIndex(where: { $0.name == inputName }) {
            students[index].subject = students[index].subject.filter { $0.title != inputSubject.title }
            students[index].subject.append(inputSubject)
            print("\(inputName) 학생의 \(inputSubject.title) 과목이 \(inputSubject.score)로 추가(변경)되었습니다.")
        } else {
            print("\(inputName) 학생을 찾지 못했습니다.")
        }
    }
    
    func 성적삭제() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.")
        print("입력예) Mickey Swift")
        
        guard let strings = readLine()?.components(separatedBy: " "), strings.count == 2 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        let inputName = strings[0]
        let inputSubjectTitle = strings[1]
        
        if let index = students.firstIndex(where: { $0.name == inputName }) {
            students[index].subject = students[index].subject.filter { $0.title != inputSubjectTitle }
            print("\(inputName) 학생의 \(inputSubjectTitle) 과목의 성적이 삭제되었습니다.")
        } else {
            print("\(inputName) 학생을 찾지 못했습니다.")
        }
    }
    
    func 평점보기() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        
        guard let strings = readLine()?.components(separatedBy: " "), strings.count == 1 else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            return
        }
        let inputName = strings[0]
        if let index = students.firstIndex(where: { $0.name == inputName }) {
            _ = students[index].subject.map {
                print("\($0.title): \($0.score)")
            }
            print("평점 : \(students[index].grade)")
        } else {
            print("\(inputName) 학생을 찾지 못했습니다.")
        }
    }
    
    func 종료() {
        print("프로그램을 종료합니다...")
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
