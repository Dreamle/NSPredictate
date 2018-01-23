//
//  ViewController.m
//  NSPredictate
//
//  Created by 李梦 on 16/12/9.
//  Copyright © 2016年 RedStar. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"

@interface ViewController ()

@property (nonatomic, strong) Test * test;
@end

@implementation ViewController

//http://www.cppblog.com/kesalin/archive/2012/11/17/kvo.html
// https://segmentfault.com/a/1190000004238379#articleHeader0
//https://segmentfault.com/a/1190000000623005

- (void)viewDidLoad {
    [super viewDidLoad];

    NSPredicate *namesBeginningWithLetterPredicate = [NSPredicate predicateWithFormat:@"(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)"];


    NSLog(@"Names: %@", [namesBeginningWithLetterPredicate predicateWithSubstitutionVariables:@{@"letter": @"AM"}]);

    NSPredicate *predicateTemplate = [NSPredicate predicateWithFormat:@"name == $NAME"];

    NSDictionary *varDict = [NSDictionary dictionaryWithObjectsAndKeys:@"Herbie", @"NAME", nil];

    NSPredicate *predicate = [predicateTemplate predicateWithSubstitutionVariables:varDict];

    NSLog(@"predicate:==========%@", predicate);

    //    [self KVOTest];
    //    [self test1];
    //    [self predicate];

}


- (void)sliceTheURLStringToDic {
    NSString *a = @"123456";
    NSArray *arr = [a componentsSeparatedByString:@"7"];
    NSLog(@"-----%@",arr);


    NSMutableDictionary *dic2 = [NSMutableDictionary dictionary];
    dic2[@"1"] = @"2";
    NSLog(@"%@",dic2);

    NSDictionary *dic = [self dictionaryWithUrlString:@"http://mkl.uat1.rs.com/QR_code?channel=81044"];
    NSLog(@"+++++ %@",dic);
}

- (void)chuliArr:(NSMutableArray *)muarr {
    [muarr addObject:@"5"];
    NSLog(@"____ %@",muarr);
}

-(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}


#pragma mark --- KVO中数组的用法
- (void)KVOTest {

    Test *test1 = [[Test alloc]init];
    test1.name = @"absr";
    test1.code = @1;
    test1.arr = [@[@"1",@"2"] mutableCopy];

    self.test = test1;

    NSLog(@"--- %@---%@",test1,self.test);
    NSLog(@"12212121");

    [test1 addObserver:self forKeyPath:@"arr" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];

    [test1 addObserver:test1 forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];


    [[test1 mutableArrayValueForKey:@"arr"] addObject:@"4"];

    NSLog(@"--- %@---%@",test1,self.test);

    test1.name = @"lee";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@", keyPath);
    NSLog(@"%@", object);
    NSLog(@"%@", change);
}



#pragma mark --- 谓词学习

- (void)test1 {

    NSDictionary *dic1 = @{@"code":@1,@"name":@"lee"};

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"self.code == 1"];
    BOOL match = [pre evaluateWithObject:dic1];
    NSLog(@"match pre is %zd",match);

    NSString *string=@"assdbfe";
    NSString *targetString=@"^a.+e$";
    NSPredicate *pres = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", targetString];
    BOOL match1 = [pres evaluateWithObject:string];
    NSLog(@"match pre is %zd",match1);

    Test *test1 = [[Test alloc]init];
    test1.name = @"absr";
    test1.code = @1;

    Test *test2 = [[Test alloc]init];
    test2.name = @"asb";
    test2.code = @2;

    Test *test3 = [[Test alloc]init];
    test3.name = @"raskj";
    test3.code = @3;

    NSArray *array = @[test1, test2, test3];

    NSPredicate *pre3 = [NSPredicate predicateWithFormat:@"%K == %@", @"code", @2];
    NSLog(@"%@", [array filteredArrayUsingPredicate:pre3]);

}


- (void)predicate  {

    NSArray *array = @[@"ada",@"bear",@"calling",@"silly"];

    NSPredicate *pre = [NSPredicate predicateWithFormat:@"self.length > 3"];
    NSArray *arr1 = [array filteredArrayUsingPredicate:pre];
    NSLog(@"arr1 is %@",arr1);

    NSArray *array2 = @[@"2", @"3", @"4", @"5"];
    NSPredicate *pre2 = [NSPredicate predicateWithFormat:@"self == '3'"];
    NSLog(@"arr2 is %@", [array2 filteredArrayUsingPredicate:pre2]);


    Test *test1 = [[Test alloc]init];
    test1.name = @"西湖";
    test1.code = @1;

    Test *test2 = [[Test alloc]init];
    test2.name = @"西溪湿地";
    test2.code = @3;

    Test *test3 = [[Test alloc]init];
    test3.name = @"灵隐寺";
    test3.code = @3;

    array2 = @[test1, test2, test3];

    NSPredicate *pre3 = [NSPredicate predicateWithFormat:@"self.name contains %@", @"西"];
    NSArray *arr2 = [array2 filteredArrayUsingPredicate:pre3];
    NSLog(@"contain pre is %@",arr2);

    pre3 = [NSPredicate predicateWithFormat:@"name == '灵隐寺'"];
    pre3 = [NSPredicate predicateWithFormat:@"name like '西*'"];
    arr2 = [array2 filteredArrayUsingPredicate:pre3];
    NSLog(@"like pre is %@",arr2);

    pre3 = [NSPredicate predicateWithFormat:@"name in %@ ",@[@"西溪湿地",@"大神",@"大幅度"]];
    arr2 = [array2 filteredArrayUsingPredicate:pre3];
    NSLog(@"in pre is %@",arr2);


    pre3 = [NSPredicate predicateWithFormat:@"code between {1,3}"];
    arr2 = [array2 filteredArrayUsingPredicate:pre3];
    NSLog(@"between pre is %@",arr2);

    NSArray *arrayFilter = @[@"abc1", @"abc2"];
    NSArray *arrayContent = @[@"a1", @"abc1", @"abc4", @"abc2"];
    NSPredicate *thePredicate = [NSPredicate predicateWithFormat:@"NOT (self in %@)", arrayFilter];
    NSLog(@"%@",[arrayContent filteredArrayUsingPredicate:thePredicate]);


    NSPredicate *pre4 = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        Test *test = (Test *)evaluatedObject;
        if (test.name.length > 2) {
            return YES;
        } else{
            return NO;
        }
    }];

    arr2 = [array2 filteredArrayUsingPredicate:pre4];
    NSLog(@"block pre is %@",arr2);


    NSPredicate *pre5 = [NSPredicate predicateWithFormat:@"code == '3'"];
    NSPredicate *pre6 = [NSPredicate predicateWithFormat:@"name == %@",@"灵隐寺"];

    NSPredicate *com1 = [NSCompoundPredicate andPredicateWithSubpredicates:@[pre5,pre6]];
    NSLog(@"com1 pre is %@",[array2 filteredArrayUsingPredicate:com1]);

    NSPredicate *com2 = [NSCompoundPredicate orPredicateWithSubpredicates:@[pre5,pre6]];

    NSLog(@"com2 pre is %@",[array2 filteredArrayUsingPredicate:com2]);

    NSPredicate *com3 = [NSCompoundPredicate notPredicateWithSubpredicate:pre5];
    NSLog(@"com3 pre is %@",[array2 filteredArrayUsingPredicate:com3]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

