// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation

@main
struct GenerateAlphabet: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Creates a string of unique UTF-8 characters.",
        usage: "GenerateAlphabet",
        discussion: "Produces a string of characters of a specified length, with a specified prefix, to a specified output.",
    )
    
    @Option( name: .shortAndLong, help: "The number of characters in the generated string." )
    var length: Int = 1024
    
    @Option( name: .shortAndLong, help: "A prefix for the generated string." )
    var prefix: String?
    
    @Option( name: .shortAndLong, help: "The path to the file where the generated string is to be stored." )
    var outFile: String?
    
    @Flag( name: .shortAndLong, help: "Show help information." )
    var stdout: Bool = false
    
    mutating func validate() throws {
        if stdout == true {
            if outFile != nil {
                throw ValidationError(
                    "-stdout and -outFile are mutually exclusive." )
            }
        } else if outFile != nil {
            let filename = "unicode_\(length)_chars.txt"
            let url = URL( fileURLWithPath: FileManager.default.currentDirectoryPath )
                .appendingPathComponent( filename )
            outFile = url.path
        }
        
        if prefix == nil {
            let digits = "0123456789"
            let lower = "abcdefghijklmnopqrstuvwxyz"
            let upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            prefix = digits + lower + upper   // 62 characters
        }
        
        if length < prefix!.count {
            throw ValidationError( "The length must be at least as long as the prefix." )
        }
    }

    mutating func run() throws {
        print("Hello, world!")
    }
}
