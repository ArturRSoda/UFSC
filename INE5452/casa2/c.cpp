#include "bits/stdc++.h"

using namespace std;

struct Task {
    int start;
    int end;
};

bool comp(Task a, Task b) {
    return a.start < b.start;
}

int main() {

    int n, m;
    while (1) {
        cin >> n >> m;

        if ((n == 0) and (m == 0)) break;

        vector<Task> tasks;

        int s, e, r;
        for (int i = 0; i < n; i++) {
            cin >> s >> e;
            tasks.push_back({s, e});
        }
        for (int i = 0; i < m; i++) {
            cin >> s >> e >> r;
            while (s <= 1000000) {
                tasks.push_back({s, e});
                s += r;
                e += r;
            }
        }

        sort(tasks.begin(), tasks.end(), comp);

        bool flag = true;
        for (int i = 0; i<tasks.size()-1; i++) {
            Task t1 = tasks[i];
            Task t2 = tasks[i+1];

            if (t2.start < t1.end) {
                cout << "CONFLICT" << endl;
                flag = false;
                break;
            }
        }
        if (flag) cout << "NO CONFLICT" << endl;

    }

    return 0;
}
