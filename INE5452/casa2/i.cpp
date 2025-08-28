#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

vector<vector<int>> graph;
vector<int> subtree_size;
int n;

void dfs(int u, int parent) {
    subtree_size[u] = 1;
    for (int v : graph[u]) {
        if (v == parent) continue;
        dfs(v, u);
        subtree_size[u] += subtree_size[v];
    }
}

int find_centroid(int u, int parent) {
    for (int v : graph[u]) {
        if (v == parent) continue;
        if (subtree_size[v] > n/2) {
            return find_centroid(v, u);
        }
    }
    return u;
}

int main() {
    cin >> n;
    graph.resize(n+1);
    subtree_size.resize(n+1);
    for (int i = 0; i < n-1; i++) {
        int a, b;
        cin >> a >> b;
        graph[a].push_back(b);
        graph[b].push_back(a);
    }
    dfs(1, 0);
    int centroid = find_centroid(1, 0);
    cout << centroid << endl;
    return 0;
}
