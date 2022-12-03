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
    let mut ls: Vec<String> = Vec::new();

    for line in reader.lines() {
        ls.push(line.unwrap());
    }

    let offset = 3;

    for (index, first_line) in ls.iter().enumerate().step_by(offset) {
        let second_line = &ls[index + 1];
        let third_line = &ls[index + 2];

        for a in first_line.chars() {
            if second_line.contains(a) && third_line.contains(a) {
                lone_characters.push(a);
                break;
            }
        }
    }

    for char in lone_characters {
        let mut digit = char as u32;

        if digit >= 97 && digit <= 122 {
            digit -= 96;
        } else {
            digit -= 38;
        }

        score += digit;
    }
    println!("score: {}", score);
}
