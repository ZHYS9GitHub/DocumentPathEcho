//
//  ViewController.m
//  DocumentPathEcho
//
//  Created by 老师 on 15/9/14.
//  Copyright (c) 2015年 echo. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//获取根目录
- (IBAction)homeButtonClick:(id)sender {
    NSString *homePath = NSHomeDirectory();
    NSLog(@"path == %@",homePath);
}
//获取document 目录
- (IBAction)Document:(id)sender {
    //拼接路径
    NSString *homePath = NSHomeDirectory();
    NSString *documentPath = [NSString stringWithFormat:@"%@%@",homePath,@"/Documents"];
    NSLog(@"doc == %@",documentPath);
    
    //用系统方法获取
    NSString *documentsPath2 = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"doc2 == %@",documentsPath2);
    //轻量级存储，用户名密码等
    [[NSUserDefaults standardUserDefaults] setObject:@"123" forKey:@"userKey"];
   NSLog(@"user == %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userKey"]);
}
//获取资源库目录
- (IBAction)LibraryButtonClick:(id)sender {
    //用系统方法获取
    NSString *libPath2 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"Library == %@",libPath2);
}
//获取缓存路径
- (IBAction)cachesButtonClick:(id)sender {
    //用系统方法获取
    NSString *cachesPath2 = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"caches == %@",cachesPath2);
}
//获取临时路径
- (IBAction)tmpButtonClick:(id)sender {
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath == %@",tmpPath);
}
//在指定路径写入字符串的文件
- (IBAction)stringButtonCLICK:(id)sender {
    //获取写入的路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件的路径地址，后缀可以不写
    NSString *filePath = [path stringByAppendingPathComponent:@"saveStr.txt"];
    NSString *str = @"这是写入的文件";
    //写入文件  atomically,yes标示使用缓存文件，NO不使用缓存文件直接写入
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];//写入方法
    NSLog(@"path22 == %@",path);
    //获取指定路径文件的内容
    NSString *cotentStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"content == %@",cotentStr);
}
//写入数组
- (IBAction)arrayButtonClick:(id)sender {
    NSArray *array = @[@"数组",@"数组2",@"数组3"];
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件的路径地址，后缀可以不写
    NSString *filePath = [path stringByAppendingPathComponent:@"array.plist"];
    [array writeToFile:filePath atomically:YES];
    NSLog(@"patht == %@",filePath);
    //读取指定路径的plist文件
    NSArray *arry2 = [NSArray arrayWithContentsOfFile:filePath];
    NSLog(@"arrr == %@",arry2);
}
//写入词典
- (IBAction)dicButtonClick:(id)sender {
    NSDictionary *dic = @{@"key":@"数组",@"key2":@"数组2",@"key3":@"数组3"};
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //拼接文件的路径地址，后缀可以不写
    NSString *filePath = [path stringByAppendingPathComponent:@"dic.plist"];
    [dic writeToFile:filePath atomically:YES];
    
    NSLog(@"patht == %@",filePath);
    //读取指定路径的plist文件
    NSDictionary *dic2 = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSLog(@"dic == %@",dic2);
}
//写入二进制
- (IBAction)dataButtonClick:(id)sender {
    NSString *path = NSTemporaryDirectory();
    //拼接文件的路径地址，后缀可以不写
    NSString *filePath = [path stringByAppendingPathComponent:@"img.jpg"];
    UIImage *img = [UIImage imageNamed:@"iconPhoto.jpg"];
    NSData *imgData = UIImageJPEGRepresentation(img, 1);
    //使用UIImageJPEGRepresentation 转化为nSData，最后一个参数压缩图片的大小
    [imgData writeToFile:filePath atomically:YES];
}
//执行归档操作
- (IBAction)CodeButtonClick:(id)sender {
    Person *person = [[Person alloc] init];
    person.name = @"Jack";
    person.sex = @"男";
    //初始化data对象，用来存person对象
    NSMutableData *data = [NSMutableData data];
    //初始化归档工具类
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //设置peron 归档
    [archiver encodeObject:person forKey:@"person"];
    [archiver finishEncoding];//结束归档操作
    
    NSString *path = NSTemporaryDirectory();
    //拼接文件的路径地址，后缀可以不写
    NSString *filePath = [path stringByAppendingPathComponent:@"person"];
    //写入
    [data writeToFile:filePath atomically:YES];
    
    NSLog(@"person == %@",filePath);
}

//解档
- (IBAction)UnCodeButtonClick:(id)sender {
    
    NSString *path = NSTemporaryDirectory();
    //拼接文件的路径地址，后缀可以不写
    NSString *filePath = [path stringByAppendingPathComponent:@"person"];
    //获取到文件的data数据流
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //解档工具类
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解档到这个person 对象
    Person *person = [unArchiver decodeObjectForKey:@"person"];
    [unArchiver finishDecoding];//结束归档操作
    NSLog(@"name == %@",person.name);
}

@end
