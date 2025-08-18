#include <bits/stdc++.h>

using namespace std;

int main() {

    string line;
    while (getline(cin, line)) {
        if (line == "0:00") break;

        int pos = line.find(":");
        int hour = stoi(line.substr(0, pos));
        int min = stoi(line.substr(pos+1, line.size()));

        float hour_degrees = (360/12) * hour;
        float min_degrees = (360/60) * min;
        if (hour_degrees == 360) hour_degrees = 0;
        hour_degrees += (30.0/60.0)*min;

        float higher = hour_degrees;
        float lower = min_degrees;
        if (lower > higher) swap(higher, lower);

        float dif = higher - lower;
        if (dif > 180) dif = 360 - dif;

        printf("%.3f\n", dif);

    }
}
