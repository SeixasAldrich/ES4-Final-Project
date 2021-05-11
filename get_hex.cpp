// Compile: g++ get_hex.cpp -o get_hex -Wall -Wextra
// Run: ./get_hex *filename*

#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

string hex_to_binary(string hex_num);

int main(int argc, char *argv[]) {
    
    vector<string> hex_values;
    vector<string> bi_values;
    
    ifstream infile(argv[1]);
    
    if (infile.fail()) {
        cerr << "ERROR: The file " << argv[1] << " failed to open correctly." << endl;
        exit(EXIT_FAILURE);
    }
    
    string temp = "0000";
    
    while (!infile.eof()) {
        
        infile.ignore(256, '\t');
        infile >> temp;
        hex_values.push_back(temp);
        infile.ignore(256, '\n');
        
    }
    
    for(int i = 0; i < hex_values.size(); i++) {
        bi_values.push_back(hex_to_binary(hex_values[i]));
    }
    
    for(int i = 0; i < bi_values.size(); i++) {
        cout << bi_values[i];
        cout << endl;
    }
    
    return 0;
}

string hex_to_binary(string hex_num) {
    string output = "";
    for(int i = 0; i < hex_num.length(); i++) {
        switch (hex_num[i]) {
            case '0':
                output += "0000";
                break;
            case '1':
                output += "0001";
                break;
            case '2':
                output += "0010";
                break;
            case '3':
                output += "0011";
                break;
            case '4':
                output += "0100";
                break;
            case '5':
                output += "0101";
                break;
            case '6':
                output += "0110";
                break;
            case '7':
                output += "0111";
                break;
            case '8':
                output += "1000";
                break;
            case '9':
                output += "1001";
                break;
            case 'a':
                output += "1010";
                break;
            case 'b':
                output += "1011";
                break;
            case 'c':
                output += "1100";
                break;
            case 'd':
                output += "1101";
                break;
            case 'e':
                output += "1110";
                break;
            case 'f':
                output += "1111";
                break;
        }
    }
    
    return output;
}
