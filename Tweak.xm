#import <Foundation/Foundation.h>
#import <mach-o/dyld.h>
#import <string.h>

static BOOL LMContains(const char *haystack, const char *needle) {
    return haystack && needle && strstr(haystack, needle) != NULL;
}

static void LMReportLoadedAdSDKs(void) {
    @autoreleasepool {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSString *bundleID = mainBundle.bundleIdentifier ?: @"(unknown)";
        NSLog(@"[LitmatchAdControl] Loaded in bundle: %@", bundleID);

        if (![bundleID isEqualToString:@"com.litatom.Litmatch"]) {
            NSLog(@"[LitmatchAdControl] Unexpected bundle; diagnostic scan skipped.");
            return;
        }

        const char *needles[] = {
            "AppLovin", "Pangle", "BUAd", "Vungle", "Moloco",
            "InMobi", "Fyber", "GoogleMobileAds", "AdsGlobal", NULL
        };

        uint32_t count = _dyld_image_count();
        NSMutableSet<NSString *> *reported = [NSMutableSet set];
        for (uint32_t i = 0; i < count; i++) {
            const char *name = _dyld_get_image_name(i);
            if (!name) continue;
            for (NSUInteger j = 0; needles[j] != NULL; j++) {
                if (LMContains(name, needles[j])) {
                    NSString *image = [NSString stringWithUTF8String:name];
                    if (image && ![reported containsObject:image]) {
                        [reported addObject:image];
                        NSLog(@"[LitmatchAdControl] Loaded SDK image: %@", image);
                    }
                }
            }
        }
        NSLog(@"[LitmatchAdControl] Scan complete. Found %lu matching image(s).", (unsigned long)reported.count);
    }
}

%ctor {
    @autoreleasepool {
        LMReportLoadedAdSDKs();
    }
}
