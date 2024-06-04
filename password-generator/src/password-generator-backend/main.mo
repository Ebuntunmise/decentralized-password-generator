import Random "mo:base/Random";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
import Blob "mo:base/Blob";
import Nat "mo:base/Nat";
import Nat8 "mo:base/Nat8";
actor PasswordGenerator {

    // Character sets
    let lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    let upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let digits = "0123456789";
    let specialCharacters = "!@#$%^&*()_+-=[]{}|;':,.<>?";

    // Define difficulty levels
    public type Difficulty = {
        #Easy;
        #Medium;
        #Hard;
    };

    // Function to generate a random password based on length and difficulty
    public func generatePassword(length: Nat, difficulty: Difficulty): async Text {
        

        var allCharacters = lowerCaseLetters;

        switch (difficulty) {
            case (#Easy) {
                // Use only lowercase letters
                allCharacters := lowerCaseLetters;
            };
            case (#Medium) {
                // Use lowercase and uppercase letters
                allCharacters := lowerCaseLetters # upperCaseLetters;
            };
            case (#Hard) {
                // Use lowercase, uppercase letters, digits, and special characters
                allCharacters := lowerCaseLetters # upperCaseLetters # digits # specialCharacters;
            };
        };

        var password = "";
        let charCount = allCharacters.size();
        // Generate password
        for (_ in Iter.range(0, length - 1)) {
              let randomByte = Blob.toArray((await Random.blob()))[0];
            let randIndex = Nat8.toNat(randomByte) % charCount;
            password := password # Text.fromChar(Text.toArray(allCharacters)[randIndex]);
        };

        return password;
    };
}
