#include <bits/stdc++.h>

using namespace std;

struct Person {
    int arrive;
    int direction;
};

int main() {
    int n;
    cin >> n;

    vector<Person> people(n, {0, 0});
    for (int i=0; i<n; i++) {
        cin >> people[i].arrive >> people[i].direction;
    }
    sort(people.begin(), people.end(), [](const auto& a, const auto& b) {
        return a.arrive < b.arrive;
    });

    int end_time = 0;
    int direction;
    while (!people.empty()) {
        Person first = people[0];
        people.erase(people.begin());

        if (first.arrive <= end_time)
            end_time += 10;
        else
            end_time = first.arrive+10;

        direction = first.direction;
        if (people.empty()) break;

        for (int i=0; i<people.size(); i++) {
            Person p = people[i];

            if (p.arrive < end_time) {
                if (p.direction != direction) {
                    p.arrive = end_time;
                } else {
                    if (p.arrive+10 > end_time) {
                        end_time = p.arrive+10;
                    }
                    people.erase(people.begin()+i);
                    i--;
                }
            }
        }
    }

    cout << end_time << endl;
    return 0;
}
