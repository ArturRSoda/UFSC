#include <bits/stdc++.h>

using namespace std;

int get_value(int x) {
    if (x > 10) return 10;
    return x;
}

int main() {
    int n;
    cin >> n;

    int john_value = 0;
    int maria_value = 0;

    vector<int> occurrences(11, 0);

    int v;

    cin >> v;
    v = get_value(v);
    occurrences[v]++;
    john_value += get_value(v);

    cin >> v;
    v = get_value(v);
    occurrences[v]++;
    john_value += get_value(v);

    cin >> v;
    v = get_value(v);
    occurrences[v]++;
    maria_value += get_value(v);

    cin >> v;
    v = get_value(v);
    occurrences[v]++;
    maria_value += get_value(v);

    for (int i=0; i<n; i++) {
        cin >> v;
        v = get_value(v);
        occurrences[v]++;
        john_value += get_value(v);
        maria_value += get_value(v);
    }

    int maria_to_23 = 23 - maria_value;
    int john_to_burst = 24 - john_value;

    if ((maria_to_23 > 10) and (john_to_burst > 10)) {
        cout << -1 << endl;
        return 0;
    }

    int limit;
    if (maria_to_23 <= john_to_burst) {
        if (maria_to_23 == 10)
            limit = 12;
        else
            limit = 4;

        if (occurrences[maria_to_23] < limit) {
            cout << maria_to_23 << endl;
            return 0;
        }

        if (john_to_burst == 10)
            limit = 12;
        else
            limit = 4;

        while ((john_to_burst <= 10) and (john_to_burst+maria_value <= 23)) {
            if (occurrences[john_to_burst] < limit) {
                cout << john_to_burst << endl;
                return 0;
            }
            john_to_burst++;
        }
    } else {
        if (john_to_burst == 10)
            limit = 12;
        else
            limit = 4;
        while ((john_to_burst <= 10) and (john_to_burst+maria_value <= 23)) {
            if (occurrences[john_to_burst] < limit) {
                cout << john_to_burst << endl;
                return 0;
            }
            john_to_burst++;
        }

        int limit;
        if (maria_to_23 == 10)
            limit = 12;
        else
            limit = 4;

        if (occurrences[maria_to_23] < limit) {
            cout << maria_to_23 << endl;
            return 0;
        }
    }


    cout << -1 << endl;
    return 0;
}
