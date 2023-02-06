#The Window Location Object

The location object is a property of the window object and contains information about the current URL. It is accessible with window.location or just location

The method reload() of location will cause reload of the current document.
```
location.reload();
```
The Method assign() of location will load a new document
```
location.assign("https://www.w3schools.com");
```
The method replace() of location will load a new document and remove the current URL from the document history. With replace() it is not possible to use "back" to navigate back to the original document.
