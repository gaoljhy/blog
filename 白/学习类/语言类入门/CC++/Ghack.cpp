#include<iostream>
#include<cstdlib>
#include<ctime>
#include<unistd.h>
#define random(x) (rand()%x)


using namespace std;

int main(){
    char ch[] = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n',
    'o','p','q','r','s','t','u','v','w','x','y','z',' ','\n'};

    srand((unsigned int)(time(0)));
    while(true){
        cout<< ch[random(28)];
        usleep(1000);
    }

    return 0 ;
}
