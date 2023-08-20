import java.io.File;
import java.io.IOException;
import java.io.BufferedReader;
import java.io.FileReader;

class FileScanner {

  String match;

  public void scan(String path, String match) {
    this.match = match;
    File folder = new File(path);

    if (folder.isDirectory()) {
      traverseFiles(folder);
    }
  }

  private void traverseFiles(File f) {
    File[] files = f.listFiles();

    if (files == null) {
      return;
    }

    for (File file : files) {
      if (file.isFile()) {
        readFile(file);
      } else if (file.isDirectory()) {
        traverseFiles(file);
      }
    }
  }

  private void readFile(File file) {
    try {
      String fileName = file.getName();
      int dotIndex = fileName.lastIndexOf(".");

      if (dotIndex <= 0 || dotIndex > fileName.length() - 1) {
        return;
      }

      String fileExtension = fileName.substring(dotIndex + 1);

      if (!fileExtension.equals("cs")) {
        return;
      }

      FileReader fileReader = new FileReader(file);
      BufferedReader bufferedReader = new BufferedReader(fileReader);
      String line;

      while ((line = bufferedReader.readLine()) != null) {
        if (line.contains(this.match)) {
          println(file.getName(), file.getAbsolutePath());
        }
      }

      bufferedReader.close();
    }
    catch (IOException e) {
      e.printStackTrace();
    }
  }
}


void setup() {
  String path = "";
  FileScanner fc = new FileScanner();
  fc.scan(path, "class");

  exit();
}
