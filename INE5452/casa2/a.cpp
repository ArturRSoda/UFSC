#include <bits/stdc++.h>


using namespace std;

void permute(vector<string>& vec, string a, int l, int r) { 
    if (l == r) 
        vec.push_back(a);
    else
    { 
        for (int i = l; i <= r; i++) 
        { 
            swap(a[l], a[i]); 

            permute(vec, a, l+1, r); 

            swap(a[l], a[i]); 
        } 
    } 
}

int main() {

    string code;

    while (1) {
        cin >> code;
        if (code == "#") {
            break;
        }

        if (next_permutation(code.begin(), code.end())) {
            cout << code << endl;
        } else {
            cout << "No Successor" << endl;
        }

    }
    return 0;
}
