#include <bits/stdc++.h>

using namespace std;

int main() {
    string line;

    vector<int> vec;
    while (getline(cin, line)) {
        vec.push_back(stoi(line));
        sort(vec.begin(), vec.end());


        int s = vec.size();
        int i = s/2;

        if (s%2 != 0) {
            cout << vec[i] << endl;
        } else {
            cout << (vec[i-1]+(vec[i]))/2 << endl;
        }
    }



}
