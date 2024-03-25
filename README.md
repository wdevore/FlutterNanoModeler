# FlutterNanoModeler
A very simple demo of using Flutter's CustomPaint widget.

# Initial build:
```sh
flutter create --platform linux --template app modeler
```

# Design
- Select an object from a list. Selecting automatically adds it to the scene based on the current insert 3D cursor
- Arcball
- Objects
  - Cube
  - Plane
  - Pyramid
  - sphere
  - Line
- Object selection
- Move selected object (G)
- Only flat shading

# Tasks
- ☑ Refactor app to include custom painter
- ☑ Animator controller
- ☒ Vertices type data
- ☒ Transform pipeline
  - ☒ model view
  - ☒ perspective projection
- ☒ Integrate River_pod
- ☒ Port GLM to Dart
  - https://github.com/g-truc/glm
  - https://learnopengl.com/Introduction
  - https://learnopengl.com/Getting-started/Camera



// - ☑
// - ☒


# Notes
- https://www.youtube.com/watch?v=pD38Yyz7N2E excellent video from Filip Hracek
- https://www.youtube.com/watch?v=DmId-KOgPkg Filip with Craig: Faking 3D
- https://www.youtube.com/watch?v=OpcPZdfJbq8 custom fragment shader howto
  - https://thebookofshaders.com/
  - https://www.youtube.com/watch?v=HQT8ABlgsq0 very advanced UI
- https://ksimek.github.io/2013/06/03/calibrated_cameras_in_opengl/ perspective projection matrix for Frustum.

## Custom paint
- https://getstream.io/blog/definitive-flutter-painting-guide/
- https://api.flutter.dev/flutter/dart-ui/Vertices-class.html
- https://api.flutter.dev/flutter/dart-ui/Canvas-class.html
- https://pub.dev/documentation/vector_math/latest/vector_math/vector_math-library.html

