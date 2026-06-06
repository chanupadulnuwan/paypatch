allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val configureAndroidNamespace = { proj: Project ->
        if (proj.hasProperty("android")) {
            val android = proj.extensions.findByName("android")
            if (android != null) {
                try {
                    val getNamespace = android.javaClass.getMethod("getNamespace")
                    val setNamespace = android.javaClass.getMethod("setNamespace", String::class.java)
                    if (getNamespace.invoke(android) == null) {
                        setNamespace.invoke(android, "com.example.${proj.name.replace("-", "_").replace(" ", "_")}")
                    }
                } catch (e: Exception) {
                    // Ignore
                }
            }

            try {
                val manifestFile = proj.file("src/main/AndroidManifest.xml")
                if (manifestFile.exists()) {
                    var content = manifestFile.readText()
                    if (content.contains("package=\"")) {
                        content = content.replace(Regex("package=\"[^\"]*\""), "")
                        manifestFile.writeText(content)
                    }
                }
            } catch (e: Exception) {
                // Ignore manifest modification errors
            }
        }
    }

    if (project.state.executed) {
        configureAndroidNamespace(project)
    } else {
        project.afterEvaluate {
            configureAndroidNamespace(project)
        }
    }
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

