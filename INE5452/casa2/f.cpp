#include "bits/stdc++.h"

using namespace std;

bool comp(int a, int b) {
    return a > b;
}

int main() {
    int n;

    while (true) {
        cin >> n;
        if (n == 0) break;

        map<vector<int>, int> mm;
        for (int frosh=0; frosh < n; frosh++) {

            vector<int> courses(5);
            for (int i=0; i<5; i++) {
                cin >> courses[i];
            }

            sort(courses.begin(), courses.end());

            mm[courses]++;
        }



        int max = 0;
        int acc = 0;
        for (auto x : mm) {
            if (max < x.second) {
                acc = x.second;
                max = x.second;
            }
            else if (max == x.second) {
                acc += x.second;
            }
        }
        cout << acc << endl;
    }


}
