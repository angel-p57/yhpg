#include <iostream>
#include <string>
#include <vector>
#include <sstream>
#include <cstdint>
#include <algorithm>

int solve(int m,int n,int b,int x) {
  std::vector<int> buf;
  buf.resize(n-m+1);
  for ( int i=0; i<=n-m; i++ ) {
    buf[i]=m+i;
  }
  std::vector<int64_t> wm;
  for ( int64_t tmp=1; tmp<static_cast<int64_t>(n)*b; tmp*=b ) {
    wm.push_back(tmp);
  }
  std::sort(
    buf.begin(),
    buf.end(),
    [&wm](int a,int b) {
      auto da=std::distance(wm.rbegin(),std::find_if(wm.rbegin(),wm.rend(),[a](int64_t x){ return a>=x; }));
      auto db=std::distance(wm.rbegin(),std::find_if(wm.rbegin(),wm.rend(),[b](int64_t x){ return b>=x; }));
      return da<db ? a<wm[db-da]*b : wm[da-db]*a<=b;
    }
  );
  return buf[x-1];
}

void test(int id, const char *input, const char *expected) {
  std::istringstream iss(input);
  int m,n,b,x;
  char dummy;
  iss>>m>>dummy>>n>>dummy>>b>>dummy>>x;
  auto actual=std::to_string(solve(m,n,b,x));
  if ( actual==expected ) {
    std::cout<<id<<": ok"<<std::endl;
  }
  else {
    std::cout<<id<<": ng ( "<<actual<<" against "<<expected<<" for "<<input<<" )"<<std::endl;
  }
}

int main() {
  test( 0, "2,15,3,8", "14" );
  test( 1, "6,8,8,1", "8" );
  test( 2, "6,6,5,1", "6" );
  test( 3, "4,11,5,2", "6" );
  test( 4, "9,17,8,2", "10" );
  test( 5, "73,82,18,5", "77" );
  test( 6, "70,149,2,48", "95" );
  test( 7, "82,119,15,26", "107" );
  test( 8, "40,127,26,47", "86" );
  test( 9, "851,950,31,89", "939" );
  test( 10, "660,807,34,143", "802" );
  test( 11, "962,1227,34,186", "1075" );
  test( 12, "544,1258,25,245", "869" );
  test( 13, "1208,7380,2,803", "4630" );
  test( 14, "2,100000000,10,1", "10" );
  test( 15, "1642,6626,3,4354", "2029" );
  test( 16, "8623,15873,2,4188", "12810" );
  test( 17, "7013,16409,17,3919", "10931" );
  test( 18, "7222,13243,19,3623", "10844" );
  test( 19, "4421,87412,5,62080", "60697" );
  test( 20, "51812,61593,22,2957", "54768" );
  test( 21, "44260,67742,17,15128", "59387" );
  test( 22, "90929,696974,36,84356", "175284" );
  test( 23, "1,100000000,2,50000000", "92108858" );
  test( 24, "101262,924931,7,341846", "358105" );
  test( 25, "211114,675661,33,312769", "523882" );
  test( 26, "1,100000000,36,50000000", "11855060" );
  test( 27, "1,100000000,10,100000000", "99999999" );
  test( 28, "826566,1444644,36,186226", "1012791" );
  test( 29, "6687091,6985458,4,251580", "6938670" );
  test( 30, "4219082,6179401,12,538113", "4757194" );
  test( 31, "7781931,8634872,23,217457", "7999387" );
  test( 32, "818218,64845924,12,57752258", "30039084" );
  test( 33, "4987258,11760092,32,6741567", "11728824" );
  test( 34, "7075964,28431054,22,11548591", "18624554" );
  test( 35, "26065964,66252692,18,29196596", "63208819" );
  test( 36, "66097362,104618756,16,32740764", "98838125" );
}
