#include <bits/stdc++.h>

using namespace std;

int main() {
    int t;
    cin >> t;

    for (int i=1; i<=t; ++i) {
        int c, d;
        cin >> c >> d;

        printf("Case %d: %.2f\n", i, c + (d * 5.0 / 9.0));
    }

    return 0;
}
