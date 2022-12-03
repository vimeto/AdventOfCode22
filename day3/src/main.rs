use std::path::PathBuf;
use std::fs::File;
use std::io::BufReader;
use std::io::prelude::*;

fn main() {
    let mut d = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    d.push("resources/input.txt");

    let f = File::open(d).unwrap();
    let reader = BufReader::new(f);
    let mut lone_characters: Vec<char> = Vec::new();
    let mut score = 0;

    for line in reader.lines() {
        let l = line.unwrap();
        let length = l.len();

        if length % 2 != 0 {
            println!("line is not even length");
            continue;
        }

        let a = &l[0..length/2];
        let b = &l[length/2..length];

        // println!("a: {}", a);
        // println!("b: {}", b);

        let a_chars = a.chars();

        for a_char in a_chars {
            if b.contains(a_char) {
                // println!("found a match: {}", a_char);
                lone_characters.push(a_char);
                break;
            }
        }
    }

    // const RADIX: u32 = 10;

    for char in lone_characters {
        // let digit = char.to_digit(RADIX).unwrap_or(1500);
        let mut digit = char as u32;

        if digit >= 97 && digit <= 122 {
            digit -= 96;
        } else {
            digit -= 38;
        }

        score += digit;
    }

    // println!("lone characters: {:?}", lone_characters);


    // println!("{}", d.display());
    println!("score: {}", score);
}
