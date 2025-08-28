#include <bits/stdc++.h>

using namespace std;

void dfs(vector<vector<int>>& tree, int node, int parent, vector<int>& colors, map<int, int>& count_colors) {
    count_colors[colors[node]]++;
    for (auto c : tree[node]) {
        if (c == parent) continue;
        dfs(tree, c, node, colors, count_colors);
    }
}

int main() {

    int n;
    cin >> n;

    vector<int> colors(n);
    for (int i = 0; i < n; i++) {
        cin >> colors[i];
    }

    vector<vector<int>> tree(n);

    for (int i = 0; i < (n-1); i++) {
        int n1, n2;
        cin >> n1 >> n2;
        tree[n1-1].push_back(n2-1);
        tree[n2-1].push_back(n1-1);
    }

    vector<int> parent(n, -2);
    parent[0] = -1;
    queue<int> q;
    q.push(0);
    while (!q.empty()) {
        int u = q.front(); q.pop();
        for (int v : tree[u]) {
            if (parent[v] == -2) {
                parent[v] = u;
                q.push(v);
            }
        }
    }



    for (int i = 0; i < n; i++) {
        //vector<int> visited(n, 0);
        map<int, int> count_colors;
        dfs(tree, i, parent[i], colors, count_colors);
        cout << count_colors.size();
        if (i < n-1) cout << " ";
    }
    cout << endl;

}
