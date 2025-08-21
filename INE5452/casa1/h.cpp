#include <bits/stdc++.h>

using namespace std;

struct Date {
    int year, month, day;
};

vector<string> monthNames = {
    "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
};

int monthDays[] = {31,28,31,30,31,30,31,31,30,31,30,31};

bool isLeap(int y) {
    if (y % 400 == 0) return true;
    if (y % 100 == 0) return false;
    return (y % 4 == 0);
}

int getMonthIndex(string s) {
    for (int i = 0; i < 12; i++) {
        if (monthNames[i] == s) return i;
    }
    return -1;
}

void addOneDay(Date &d) {
    int daysInMonth = monthDays[d.month];
    if (d.month == 1 && isLeap(d.year)) daysInMonth = 29;
    d.day++;
    if (d.day > daysInMonth) {
        d.day = 1;
        d.month++;
        if (d.month == 12) {
            d.month = 0;
            d.year++;
        }
    }
}

int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    int T;
    cin >> T;
    for (int cs = 1; cs <= T; cs++) {
        string dateStr;
        int K;
        cin >> dateStr;
        cin >> K;

        stringstream ss(dateStr);
        string yearStr, monthStr, dayStr;
        getline(ss, yearStr, '-');
        getline(ss, monthStr, '-');
        getline(ss, dayStr, '-');

        Date d;
        d.year = stoi(yearStr);
        d.month = getMonthIndex(monthStr);
        d.day = stoi(dayStr);

        for (int i = 0; i < K; i++) {
            addOneDay(d);
        }

        cout << "Case " << cs << ": " 
             << d.year << "-" << monthNames[d.month] << "-";

        cout << setw(2) << setfill('0') << d.day << "\n";
    }
    return 0;
}


