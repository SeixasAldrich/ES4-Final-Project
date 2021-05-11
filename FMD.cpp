#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int main(int argc, char *argv[]) {
    
    vector<string> temp_values;
    vector<string> output_values;
    
    ifstream infile(argv[1]);
    
    if (infile.fail()) {
        cerr << "ERROR: The file " << argv[1] << " failed to open correctly." << endl;
        exit(EXIT_FAILURE);
    }
    
    string temp = "";
    
    while (!infile.eof()) {
        
        infile >> temp;
        temp_values.push_back(temp);
        infile.ignore(256, '\n');
        
    }
    
    for(int i = 0; i < temp_values.size(); i++) {
        output_values.push_back("when 32d\"" + to_string(i) + "\" => data <= \"" + temp_values[i] + "\";");
    }
    
    for(int i = 0; i < output_values.size(); i++) {
        cout << output_values[i];
        cout << endl;
    }
    
    return 0;
}
