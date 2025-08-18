#include <bits/stdc++.h>

using namespace std;


int main() {
    int l, c;
    cin >> l >> c;

    vector<vector<char>> m(l);
    for (int i=0; i<l; i++) {
        string s;
        cin >> s;
        for (char x : s) {
            m[i].push_back(x);
        }
    }

    int n;
    cin >> n;

    vector<string> words;
    for (int i=0; i<n; i++) {
        string s;
        cin >> s;
        sort(s.begin(), s.end());
        words.push_back(s);
    }

    vector<vector<vector<int>>> cells(l, vector<vector<int>>(c, vector<int>(words.size(), 0)));
    for (int i=0; i<l; i++) {
        for (int j=0; j<c; j++) {
            for (int id=0; id<words.size(); id++) {
                string word = words[id];
                int word_size = word.size();

                if (j+word_size <= c) {
                    string s;
                    for (int k=0; k<word_size; k++) {
                        s += m[i][j+k];
                    }
                    sort(s.begin(), s.end());

                    if (s == word) {
                        for (int k=0; k<word_size; k++) {
                            cells[i][j+k][id] = 1;
                        }
                    }
                }


                if (i+word_size <= l) {
                    string s;
                    for (int k=0; k<word_size; k++) {
                        s += m[i+k][j];
                    }
                    sort(s.begin(), s.end());

                    if (s == word) {
                        for (int k=0; k<word_size; k++) {
                            cells[i+k][j][id] = 1;
                        }
                    }
                }

                if ((i+word_size <= l) and (j+word_size <= c)){
                    string s;
                    for (int k=0; k<word_size; k++) {
                        s += m[i+k][j+k];
                    }
                    sort(s.begin(), s.end());

                    if (s == word) {
                        for (int k=0; k<word_size; k++) {
                            cells[i+k][j+k][id] = 1;
                        }
                    }
                }

                if ((i+word_size <= l) and (j-word_size >= -1)){
                    string s;
                    for (int k=0; k<word_size; k++) {
                        s += m[i+k][j-k];
                    }
                    sort(s.begin(), s.end());

                    if (s == word) {
                        for (int k=0; k<word_size; k++) {
                            cells[i+k][j-k][id] = 1;
                        }
                    }
                }
            }
        }
    }

    int counter = 0;
    for (auto x : cells) {
        for (auto y : x) {
            int sum = 0;
            for (auto z : y) {
                sum += z;
            }

            if (sum > 1) counter++;
        }
    }

    cout << counter << endl;
}

