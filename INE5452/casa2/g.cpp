#include <bits/stdc++.h>
using namespace std;

int main() {
    int T; 
    if (!(cin >> T)) return 0;

    for (int tc = 1; tc <= T; ++tc) {
        int N; 
        cin >> N;

        // Deduplicate stamps per friend
        vector<unordered_set<int>> have(N);
        for (int i = 0; i < N; ++i) {
            int M; 
            cin >> M;
            for (int j = 0; j < M; ++j) {
                int a; 
                cin >> a;
                have[i].insert(a);  // remove duplicates within the same friend
            }
        }

        // Count how many friends own each stamp type
        unordered_map<int,int> freq;
        freq.reserve(10007);
        for (int i = 0; i < N; ++i)
            for (int a : have[i])
                ++freq[a];

        // Count uniques per friend and total
        vector<int> uniq(N, 0);
        int total_unique = 0;
        for (int i = 0; i < N; ++i) {
            for (int a : have[i]) {
                if (freq[a] == 1) {
                    ++uniq[i];
                    ++total_unique;
                }
            }
        }

        cout << "Case " << tc << ":";
        for (int i = 0; i < N; ++i) {
            double p = (total_unique == 0) ? 0.0 : (uniq[i] * 100.0) / total_unique;
            cout << " " << fixed << setprecision(6) << p << "%";
        }
        cout << "\n";
    }
    return 0;
}

