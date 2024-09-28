enum Environment { dev, prod }

class Config {
  static Environment environment = Environment.prod;

  static String get baseUrl {
    switch (environment) {
      case Environment.prod:
        return "http://atozerserver.3bbddns.com:21758/api";
      case Environment.dev:
        return "http://10.0.2.2:8000/api";
    }
  }

  static String get baseImageUrl {
    switch (environment) {
      case Environment.prod:
        return "http://atozerserver.3bbddns.com:21758";
      case Environment.dev:
        return "http://10.0.2.2:8000";
    }
  }
}
