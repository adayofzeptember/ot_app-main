import 'package:flutter/material.dart';

class RouteFade {
  static Route noSlide(page) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 350,
      ),
    );
  }

  static Route slideTop(page) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, -1.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  static Route slideBottom(page) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 1.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  static Route slideLeft(page) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }

  static Route slideRight(page) {
    return PageRouteBuilder(
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return page;
      },
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1.0, 0.0),
            end: const Offset(0.0, 0.0),
          ).animate(animation),
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(
                begin: 0,
                end: 1,
              ).animate(animation),
              child: child,
            ),
          ),
        );
      },
      transitionDuration: const Duration(
        milliseconds: 300,
      ),
    );
  }
}
