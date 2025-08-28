#include <iostream>
#include <set>
using namespace std;

int main() {
    int n;
    while (cin >> n && n != 0) {
        multiset<int> urn;
        int total_cost = 0;

        for (int day = 0; day < n; day++) {
            int k;
            cin >> k;

            for (int i = 0; i < k; i++) {
                int bill;
                cin >> bill;
                urn.insert(bill);
            }

            auto min_it = urn.begin();
            auto max_it = urn.end();
            max_it--;

            total_cost += (*max_it - *min_it);
            urn.erase(min_it);
            urn.erase(max_it);
        }
        cout << total_cost << endl;
    }
    return 0;
}
