#include "bits/stdc++.h"

using namespace std;

struct Contestant {
    int number;
    int solved = 0;
    int penalty = 0;
    vector<int> problem_time;
    vector<int> incorrect_count;
    
    Contestant(int num) : number(num) {
        problem_time.resize(10, 0);
        incorrect_count.resize(10, 0);
    }
};

bool comp(const Contestant* a, const Contestant* b) {
    if (a->solved != b->solved)
        return a->solved > b->solved;
    if (a->penalty != b->penalty)
        return a->penalty < b->penalty;
    return a->number < b->number;
}

int main() {
    int test_cases;
    string line;
    
    getline(cin, line);
    test_cases = stoi(line);
    getline(cin, line);
    
    for (int t = 0; t < test_cases; t++) {
        map<int, Contestant*> contestants;
        
        while (getline(cin, line) && !line.empty()) {
            stringstream ss(line);
            int id, problem, time;
            char result;
            ss >> id >> problem >> time >> result;
            
            if (contestants.find(id) == contestants.end()) {
                contestants[id] = new Contestant(id);
            }
            
            Contestant* c = contestants[id];
            
            if (c->problem_time[problem] > 0) {
                continue;
            }
            
            if (result == 'C') {
                c->problem_time[problem] = time;
                c->solved++;
                c->penalty += time + 20 * c->incorrect_count[problem];
            } else if (result == 'I') {
                c->incorrect_count[problem]++;
            }
        }
        
        vector<Contestant*> result;
        for (auto& pair : contestants) {
            result.push_back(pair.second);
        }
        
        sort(result.begin(), result.end(), comp);
        
        for (auto c : result) {
            cout << c->number << " " << c->solved << " " << c->penalty << endl;
        }
        
        for (auto c : result) {
            delete c;
        }
        
        if (t < test_cases - 1) {
            cout << endl;
        }
    }
    
    return 0;
}
