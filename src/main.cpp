#include <iostream>
#include <fstream>
#include <string>

#include "CustomerSegment.h"

int main()
{
    // Open the file adtAsciiArtLogo.txt and print its content to the screen
    std::ifstream file("adtAsciiArtLogo.txt");

    if (file.is_open()) {
        std::cout << "\n\n";
        
        // Read the file line by line and print each line
        std::string line;
        while (std::getline(file, line)) {
            std::cout << line << '\n';
        }
        
        file.close();
        std::cout << "\n\n";
    } else {
        std::cerr << "Error: Unable to open file 'adtAsciiArtLogo.txt'.\n";
    }

    return 0;
}
