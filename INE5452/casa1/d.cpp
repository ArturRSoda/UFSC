#include <bits/stdc++.h>

using namespace std;

int main() {
    int n;
    cin >> n;
    cin.ignore();


    vector<vector<string>> all_cases;
    vector<string> current_case;

    string line;
    while (getline(cin, line)) {
        if (line.empty()) {
            if (!current_case.empty()) {
                all_cases.push_back(current_case);
                current_case.clear();
            }
        } else {
            current_case.push_back(line);
        }
    }
    if (!current_case.empty()) {
        all_cases.push_back(current_case);
    }

    int s = all_cases.size();
    for (int k=0; k<s; k++) {
        vector<string> words = all_cases[k];
        vector<pair<string, string>> results;

        for (int i=0; i<words.size(); i++) {
            string current_word = words[i];
            current_word.erase(remove(current_word.begin(), current_word.end(), ' '), current_word.end());
            sort(current_word.begin(), current_word.end());

            for (int j=i+1; j<words.size(); j++) {
                string comparing_word = words[j];
                comparing_word.erase(remove(comparing_word.begin(), comparing_word.end(), ' '), comparing_word.end());
                sort(comparing_word.begin(), comparing_word.end());

                if (current_word == comparing_word) {
                    string a = words[i];
                    string b = words[j];
                    if (a > b) swap(a, b);
                    results.push_back(pair<string, string>(a, b));
                }
            }
        }

            sort(results.begin(), results.end());
            for (auto p : results) {
                cout << p.first << " = " << p.second << endl;
            }

        if (k < s-1) {
            cout << endl;
        }
    }
}
