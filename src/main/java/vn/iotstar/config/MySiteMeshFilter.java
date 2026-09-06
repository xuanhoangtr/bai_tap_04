package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        // Su dung DispatchMode.INCLUDE de tuong thich hoan hao voi Tomcat 11 / Jakarta EE 10
        builder.setDispatchMode(org.sitemesh.webapp.DispatchMode.INCLUDE)
               .setMimeTypes("text/html", "application/xhtml+xml")
               
               // 1. Decorator Admin cho toan bo khu vuc quan tri
               .addDecoratorPath("/admin/*", "admin.jsp")
               
               // 2. Decorator Web cho nguoi dung (Profile, Home, San pham)
               .addDecoratorPath("/profile*", "user.jsp")
               .addDecoratorPath("/user/*", "user.jsp")
               .addDecoratorPath("/home*", "web.jsp")
               .addDecoratorPath("/product*", "web.jsp")
               .addDecoratorPath("/products*", "web.jsp")
               
               // 3. Cac duong dan khong ap dung Decorator (Auth, Static Resources, Images)
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/verify-otp*")
               .addExcludedPath("/forgot-password*")
               .addExcludedPath("/reset-password*")
               .addExcludedPath("/logout*")
               .addExcludedPath("/image*")
               .addExcludedPath("/decorators/*")
               .addExcludedPath("/static/*")
               .addExcludedPath("/assets/*");
    }
}
