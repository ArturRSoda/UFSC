#include <bits/stdc++.h>

using namespace std;

int main() {
    bool f = false;;
    while (1) {
        int n, k;

        cin >> n;
        if (n == 0) break;
        cin >> k;

        if (f) cout << endl;
        f = true;

        vector<pair<int, int>> players(n+1, pair<int, int>(0, 0));
        for (int i=0; i<k*n*(n - 1)/2; i++) {
            int p1, p2;
            string m1, m2;

            cin >> p1 >> m1 >> p2 >> m2;

            if (m1 == m2) continue;
            if (((m1 == "rock") and (m2 == "scissors")) or ((m1 == "scissors") and (m2 == "paper")) or ((m1 == "paper") and (m2 == "rock"))) {
                players[p1].first++;
                players[p2].second++;
            } else {
                players[p2].first++;
                players[p1].second++;
            }
        }

        for (int i = 1; i<=n; i++) {
            if (players[i].first+players[i].second == 0)
                cout << "-" << endl;
            else
                printf("%.3f\n", (double)players[i].first/(players[i].first+players[i].second));
        }
    }

    return 0;
}

