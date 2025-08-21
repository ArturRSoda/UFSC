#include <bits/stdc++.h>
using namespace std;

int cardValue(const string &card) {
    char c = card[0];
    if (c >= '2' && c <= '9') return c - '0';
    return 10;
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int T;
    cin >> T;
    for (int cs = 1; cs <= T; cs++) {
        vector<string> deck(52);
        for (int i = 0; i < 52; i++) cin >> deck[i];

        vector<string> hand(deck.end() - 25, deck.end());
        deck.erase(deck.end() - 25, deck.end());

        int Y = 0;

        for (int i = 0; i < 3; i++) {
            string topCard = deck.back(); deck.pop_back();
            int X = cardValue(topCard);
            Y += X;

            int removeCnt = 10 - X;
            while (removeCnt-- && !deck.empty()) {
                deck.pop_back();
            }
        }

        for (auto &c : hand) deck.push_back(c);

        string ans = deck[Y - 1];

        cout << "Case " << cs << ": " << ans << "\n";
    }

    return 0;
}

