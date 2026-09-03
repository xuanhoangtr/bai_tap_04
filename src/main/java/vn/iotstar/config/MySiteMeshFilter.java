package vn.iotstar.config;

import org.sitemesh.builder.SiteMeshFilterBuilder;
import org.sitemesh.config.ConfigurableSiteMeshFilter;

public class MySiteMeshFilter extends ConfigurableSiteMeshFilter {

    @Override
    protected void applyCustomConfiguration(SiteMeshFilterBuilder builder) {
        builder.setDispatchMode(org.sitemesh.webapp.DispatchMode.INCLUDE)
               .setMimeTypes("text/html", "application/xhtml+xml")
               .addDecoratorPath("/profile*", "user.jsp")
               .addDecoratorPath("/user/*", "user.jsp")
               
               // Cac duong dan khong ap dung Decorator (Auth, API, Static Resources)
               .addExcludedPath("/login*")
               .addExcludedPath("/register*")
               .addExcludedPath("/verify-otp*")
               .addExcludedPath("/forgot-password*")
               .addExcludedPath("/reset-password*")
               .addExcludedPath("/logout*")
               .addExcludedPath("/image*")
               .addExcludedPath("/home*")
               .addExcludedPath("/product*")
               .addExcludedPath("/admin/*")
               .addExcludedPath("/decorators/*")
               .addExcludedPath("/static/*")
               .addExcludedPath("/assets/*");
    }
}
