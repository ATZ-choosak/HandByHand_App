enum Environment { dev, prod }

class Config {
  static Environment environment = Environment.prod;

  static String get baseUrl {
    switch (environment) {
      case Environment.prod:
        return "http://atozerserver.3bbddns.com:21758/api";
      case Environment.dev:
        return "http://192.168.1.7:8000/api";
    }
  }

  static String get socketUrl {
    switch (environment) {
      case Environment.prod:
        return "http://atozerserver.3bbddns.com:21758";
      case Environment.dev:
        return "http://192.168.1.7:8000";
    }
  }

  static String get baseImageUrl {
    switch (environment) {
      case Environment.prod:
        return "http://atozerserver.3bbddns.com:21758";
      case Environment.dev:
        return "http://192.168.1.7:8000";
    }
  }
}
