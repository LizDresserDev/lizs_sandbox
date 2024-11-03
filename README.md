# Liz's Sandbox

**Liz's Sandbox** is a collection of Flutter experiments and challenges designed to explore and showcase various coding techniques, algorithms, and animations. The project is organized into two main sections: **Challenges** and **Animations**.

---

## Contents

### Challenges

The **Challenges** directory contains small coding exercises inspired by challenges found online. Each challenge is intended to be completed within an hour or less, demonstrating quick solutions to simple problems.

- **Number to String**  
  This challenge takes a numeric input and converts it to its word representation. For example:

  - Input: `12345`
  - Output: `"twelve thousand, three hundred and forty five"`

- **Palindromic Substring**  
  This challenge finds the longest palindromic substring within a given string. For example:
  - Input: `"abcdeffedcbrqed"`
  - Output: `"bcdeffedcb"`

### Animations

The **Animations** directory contains examples of different animation techniques and experiments with Flutter's animation capabilities.

- **Real-Time Waveform**  
  This page features an animated, mock real-time waveform. It simulates waveform data, which is visualized in real time.

- **Unit Circle**  
  This page demonstrates angle calculations around a central point, visualized using Flutter’s canvas. It shows how to account for the canvas's axes to represent angles on the unit circle in the conventional orientation.

- **Rotating Cube**  
  Inspired by tutorials from [Vandad Nahavandipoor](https://youtu.be/vqrmXhT2HQg?feature=shared) and [王叔不秃](https://youtu.be/hDmWOsOU_Ko?feature=shared), this page features a 3D rotating cube with enhancements to avoid clipping issues.
  - **Problem**: The original implementations encountered clipping due to stacking.
  - **Solution**: This project builds on their work by implementing a back-culling method, showing two different approaches:
    1. **Canvas Drawing** - Drawing the cube directly on the canvas.
    2. **Transform Widget** - Using the `Transform` widget to manipulate individual cube faces.

---

## Getting Started

To run the project:

1. Clone the repository.
2. Ensure you have Flutter installed and set up on your development machine.
3. Run `flutter pub get` to install dependencies.
4. Use `flutter run` to launch the app on an emulator or connected device.

## References

- [Vandad Nahavandipoor's Rotating Cube Tutorial](https://youtu.be/vqrmXhT2HQg?feature=shared)
- [王叔不秃's Rotating Cube Tutorial](https://youtu.be/hDmWOsOU_Ko?feature=shared)
