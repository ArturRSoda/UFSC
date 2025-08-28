#include <bits/stdc++.h>

using namespace std;

int main() {
    int case_ = 1;

    while (true) {
        int n;
        cin >> n;
        if (n == 0) break;


        vector<int> vec(n);
        for (int i=0; i<n; i++) {
            cin >> vec[i];
        }

        int m;
        cin >> m;

        cout << "Case " << case_ << ":" << endl;

        for (int j = 0; j < m; j++) {
            int q;
            cin >> q;

            int best_sum;
            int diff = 99999999999999999999;
            for (int p1 = 0; p1 < n; p1++) {
                for (int p2 = p1+1; p2 < n; p2++) {
                    int s = vec[p1]+vec[p2];
                    if (diff > abs(q-s)) {
                        diff = abs(q-s);
                        best_sum = s;
                    } 
                }
            }
            cout << "Closest sum to " << q << " is " << best_sum << "." << endl;
        }

        case_++;
    }


}
