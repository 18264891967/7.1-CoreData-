/*
 1:它自动的引入了CoreData框架
 
 2:它(数据模型):它继承不在是NSObject(基类,根类,父类),而是继承NSManagedObject 
 
 3:它的属性会自动生成
*/
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface Person : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * password;

@end
