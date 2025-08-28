#include <bits/stdc++.h>
using namespace std;

// Convert substring [l, r] (1-indexed) to integer
long long toNum(const string &s, int l, int r) {
    long long val = 0;
    for (int i = l; i <= r; i++) {
        val = (val << 1) | (s[i - 1] - '0');
    }
    return val;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);
    
    int t;
    cin >> t;
    while (t--) {
        string s;
        cin >> s;
        int n = s.size();
        
        // Strategy: Find earliest position where there is '0', start second substring there
        int shift = -1;
        for (int i = 1; i < n; i++) {
            if (s[i] == '0') { // 0-based index
                shift = i + 1; // 1-indexed position
                break;
            }
        }
        
        if (shift == -1) {
            // All 1's → just take smallest possible different substrings
            cout << 1 << " " << n-1 << " " << 2 << " " << n << "\n";
            continue;
        }
        
        // Try aligning s[1..n] with s[shift..n], equal length
        int len = n - shift + 1;
        int l1 = 1, r1 = len;
        int l2 = shift, r2 = n;
        
        // Adjust if needed to keep inside bounds
        if (r1 > n) r1 = n;
        
        cout << l1 << " " << r1 << " " << l2 << " " << r2 << "\n";
    }
}

