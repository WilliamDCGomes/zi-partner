#import <Foundation/Foundation.h>

#if __has_attribute(swift_private)
#define AC_SWIFT_PRIVATE __attribute__((swift_private))
#else
#define AC_SWIFT_PRIVATE
#endif

/// The "LaunchImage" asset catalog image resource.
static NSString * const ACImageNameLaunchImage AC_SWIFT_PRIVATE = @"LaunchImage";

/// The "devLaunchImage" asset catalog image resource.
static NSString * const ACImageNameDevLaunchImage AC_SWIFT_PRIVATE = @"devLaunchImage";

/// The "hmlgLaunchImage" asset catalog image resource.
static NSString * const ACImageNameHmlgLaunchImage AC_SWIFT_PRIVATE = @"hmlgLaunchImage";

/// The "prodLaunchImage" asset catalog image resource.
static NSString * const ACImageNameProdLaunchImage AC_SWIFT_PRIVATE = @"prodLaunchImage";

#undef AC_SWIFT_PRIVATE