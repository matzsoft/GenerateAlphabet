//         FILE: GenerateAlphabet.swift
//  DESCRIPTION: GenerateAlphabet - ---
//        NOTES: ---
//       AUTHOR: Mark T. Johnson, markj@matzsoft.com
//    COPYRIGHT: © 2025 MATZ Software & Consulting. All rights reserved.
//      VERSION: 1.0
//      CREATED: 11/9/25 4:31 PM

import ArgumentParser
import Foundation

@main
struct GenerateAlphabet: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "Creates a string of unique UTF-8 characters.",
        usage: "GenerateAlphabet",
        discussion: "Produces a string of characters of a specified length, with a specified prefix, to a specified output.",
    )
    
    @Option( name: .shortAndLong, help: "The number of characters desired in the generated string." )
    var length: Int = 1024
    
    @Option( name: .shortAndLong, help: "A prefix for the generated string. Defaults to digits 0 through 9, followed by lowercase letters a through z, followed by uppercase letters A through Z." )
    var prefix: String?
    
    @Option( name: .shortAndLong, help: "The path to the file where the generated string is to be stored. Defaults to 'unicode_<length>_chars.txt' in the current directory." )
    var outFile: String?
    
    @Flag( name: .shortAndLong, help: "Send the output to stdout instead of a file." )
    var stdout: Bool = false
    
    mutating func validate() throws {
        if stdout == true {
            if outFile != nil {
                throw ValidationError(
                    "-stdout and -outFile are mutually exclusive." )
            }
        } else if outFile == nil {
            let filename = "unicode_\(length)_chars.txt"
            let url = URL( fileURLWithPath: FileManager.default.currentDirectoryPath )
                .appendingPathComponent( filename )
            outFile = url.path
        }
        
        if prefix == nil {
            // 1) ASCII alphanumeric prefix (62 chars)
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
        // 2) Collect 962 standalone printable glyphs from all scripts
        var remainingChars: [String] = []
        var setOfChars = Set<Character>( prefix! )
        let need = length - prefix!.count
        var cp = 0x00A1 // start just after U+00A0 (non-breaking space)

        while remainingChars.count < need && cp <= 0x10FFFF {
            // Create UnicodeScalar safely
            if let scalar = UnicodeScalar( cp ) {
                switch scalar.properties.generalCategory {
                case .nonspacingMark, .spacingMark, .enclosingMark:
                    // Skip combining marks (M* categories)
                    break
                case .control, .format, .surrogate, .privateUse, .unassigned:
                    // Skip "C*" categories
                    break
                default:
                    // Skip whitespace characters (space, NBSP, thin space, etc.)
                    let isWhitespace = CharacterSet
                        .whitespacesAndNewlines.contains( scalar )

                    if !isWhitespace {
                        // Convert scalar to a single-character String
                        let ch = Character( scalar )
                        let normalized = String( ch )
                            .precomposedStringWithCanonicalMapping
                        if setOfChars.insert( Character( normalized ) ).inserted {
                            remainingChars.append( normalized )
                        }
                    }
                }
            }
            cp += 1
        }

        // Sanity check / fallback: ensure we found enough characters
        if remainingChars.count < need {
            fputs( "Error: unable to locate \(need) standalone printable glyphs within Unicode range.\n", stderr )
            Foundation.exit( 1 )
        }

        // 3) Build final <totalLength>-character string
        let fullString = prefix! + remainingChars.prefix( need ).joined()

        if stdout {
            print( fullString )
        } else {
            // 4) Write to UTF-8 file in path outFile
            let url = URL( fileURLWithPath: outFile! )
            
            do {
                try fullString.write( to: url, atomically: true, encoding: .utf8 )
                print( "Wrote file: \(url.path)" )
                print( "Characters written (String.count): \(fullString.count)" )
                print( "Prefix length: \(prefix!.count), additional glyphs: \(remainingChars.prefix(need).count)" )
            } catch {
                fputs( "Failed to write file: \(error)\n", stderr )
                Foundation.exit( 2 )
            }
        }
    }
}
