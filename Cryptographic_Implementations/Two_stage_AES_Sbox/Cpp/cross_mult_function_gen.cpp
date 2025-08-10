#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <string>
#include <cmath>

using namespace std;
//************************************************************

vector<vector<string>> File_reader_2D(const string &filename)
{
	vector<vector<string>> result;
	ifstream file(filename);

	if (!file.is_open())
	{
		throw runtime_error("Unable to open file -> " + filename);
	}

	string line;
	while (getline(file, line))
	{
		if (line.empty())
		{
			continue;
		}

		vector<string> row;
		stringstream ss(line);
		string word;

		while (ss >> word)
		{
			row.push_back(word);
		}

		if (!row.empty())
		{
			result.push_back(row);
		}
	}

	return result;
}

// ------------------

bool is_Substring(string &S1, string &S2)
{
	if (S2.empty())
		return true;
	return S1.find(S2) != string::npos;
}

void Write2File(vector<string> &vec, const string &filename, string idx, string num)
{
	ofstream outfile(filename, ios::app);
	if (!outfile.is_open())
	{
		throw runtime_error("Unable to open file: " + filename);
	}
	string str = "assign f" + idx + "_" + num + " = ";
	outfile << endl;
	outfile << str;
	for (auto i = 0; i < vec.size(); ++i)
	{
		if (i == vec.size() - 1)
			outfile << vec[i] << " ; ";
		else
			outfile << vec[i] << " ^ ";
	}
}

//***************************************************
int main()
{
	int num_of_vars = 4;
	size_t d = 1;

	size_t sz = pow(2, num_of_vars) - 1;
	vector<string> P_prime(sz);
	vector<string> Q_prime(sz);

	P_prime = {"a", "b", "c", "d", "ab", "ac", "ad", "bc", "bd", "cd",
			   "abc", "abd", "acd", "bcd", "abcd"};
	Q_prime = {"e", "f", "g", "h", "ef", "eg", "eh", "fg", "fh", "gh",
			   "efg", "efh", "egh", "fgh", "efgh"};

	// P_prime = {"a", "b", "ab"};  // testing for 4-var
	// Q_prime = {"c", "d", "cd"};

	auto ANF_terms = File_reader_2D("F.txt");

	for (auto n = 0; n < 8; ++n)
	{
		string S;
		string J1, J2;
		vector<vector<string>> fn(4);
		for (auto idx = 0; idx < ANF_terms[n].size(); ++idx)
		{
			S = ANF_terms[n][idx];
			J1 = "\0";
			J2 = "\0";
			//
			for (auto n = sz - 1; n >= 0; --n)
			{
				auto p_tmp = P_prime[n];
				auto p_check = is_Substring(S, p_tmp);
				if (p_check)
				{
					J1 = p_tmp;
					break;
				}
			}
			//
			for (auto n = sz - 1; n >= 0; --n)
			{
				auto q_tmp = Q_prime[n];
				auto q_check = is_Substring(S, q_tmp);
				if (q_check)
				{
					J2 = q_tmp;
					break;
				}
			}

			vector<string> p(2);
			vector<string> q(2);
			if (J1 != "" && J2 != "")
			{
				p[0] = J1 + "_0";
				p[1] = J1 + "_1";

				q[0] = J2 + "_0";
				q[1] = J2 + "_1";

				int cnt = 0;
				for (auto i = 0; i <= d; ++i)
				{
					for (auto j = 0; j <= d; ++j)
					{
						string cross = p[i] + " & " + q[j];
						fn[cnt].push_back(cross);
						++cnt;
					}
				}
			}

			else if (J1 == "")
			{
				q[0] = J2 + "_0";
				q[1] = J2 + "_1";

				fn[0].push_back(q[0]);
				fn[3].push_back(q[1]);
			}

			else if (J2 == "")
			{
				p[0] = J1 + "_0";
				p[1] = J1 + "_1";

				fn[0].push_back(p[0]);
				fn[3].push_back(p[1]);
			}
		}
		vector<string> num = {"00", "01", "10", "11"};
		for (auto x = 0; x < 4; ++x)
		{
			Write2File(fn[x], "fn_ii.txt", to_string(n), num[x]);
		}
	}
	return 0;
}
