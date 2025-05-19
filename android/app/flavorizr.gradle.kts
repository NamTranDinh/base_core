import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("develop") {
            dimension = "flavor-type"
            applicationId = "com.example.base_core.dev"
            resValue(type = "string", name = "app_name", value = "[DEV] Base Core")
        }
        create("uat") {
            dimension = "flavor-type"
            applicationId = "com.example.base_core.uat"
            resValue(type = "string", name = "app_name", value = "[UAT] Base Core")
        }
        create("product") {
            dimension = "flavor-type"
            applicationId = "com.example.base_core"
            resValue(type = "string", name = "app_name", value = "Base Core")
        }
    }
}