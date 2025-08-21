#include <bits/stdc++.h>
using namespace std;

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int N;
    cin >> N;
    vector<int> a(N);
    for (int i = 0; i < N; i++) cin >> a[i];

    vector<int> bitCount(31, 0);
    for (int x : a) {
        for (int b = 0; b <= 30; b++) {
            if (x & (1 << b)) bitCount[b]++;
        }
    }

    vector<int> res(N, 0);

    for (int b = 30; b >= 0; b--) {
        int cnt = bitCount[b];
        for (int i = 0; i < cnt; i++) {
            res[i] |= (1 << b);
        }
    }

    for (int i = 0; i < N; i++) {
        cout << res[i] << (i + 1 == N ? '\n' : ' ');
    }
}

