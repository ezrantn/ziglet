# Ziglet 

## Overview

Ziglet is a toy microkernel that I am developing, inspired by [Minix3](https://www.minix3.org/). My main goal with Ziglet is to learn about low-level programming, operating system concepts, and the Zig programming language. This project serves as a personal exploration into how microkernels operate, and I'm excited to dive deep into the intricacies of kernel development.

## Design Goals

The objectives I'm aiming for with Ziglet include:

1. Microkernel Architecture: Create a minimal kernel focused on essential tasks like scheduling, communication, and basic hardware interaction.
   
2. Learning: Use Ziglet as hands-on way to understand operating system principles and low-level programming.

3. Simplicity: Keep the codebase straightforward and easy to understand, perfect for learning and experimentation.

4. Modularity: Design services that can run in user space, allowing for separation between the core kernel functionality and other system services.

## Getting Started

Since Ziglet is still in the initial stages of development, here's how I plan to get started:

1. Set Up the Development Environment:

    - I'll need to install the latest version of the Zig compiler from [ziglang.com](https://ziglang.com).
    - I might use an emulator like [QEMU](https://www.qemu.org/) to run and test the kernel once I have some code.

2. Start Coding:

    - I will create the basic structure of the kernel, defining the main entry point and initial setup for the microkernel functionality.
    - Gradually, I'll implement core features like process management and inter-process communication (IPC).

3. Experiment and Iterate:

    - After setting up the initial features, I’ll continue to experiment by adding more complex modules and services like a simple file system or basic networking.

## License

This tool is open-source and available under the [MIT](https://github.com/ezrantn/ziglet/blob/main/LICENSE) License.

## Contributions

Contributions are welcome! Please feel free to submit a pull request.