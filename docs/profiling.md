# PHP-Profiling with tideways_xhprof

``Profiling only works in php >= 7.0``

Profiling is active by default. The recording can be triggered in two different ways:
- Setting the Env Variable `PROFILING_ENABLED`
- Setting the Cookie `XDEBUG_PROFILE`
  - to set the Cookie you can use the [Xdebug helper] Chrome Extension. 
  
That should flood your xhgui with requests.

hint: if `PHP_DEBUGGER` is set to `xdebug` or xdebug was enabled through xdebug-enable, then the xh-profiler won't profile anything 

## Screenshots

**Xdebug helper**

![profiling button][profiling]

**xhgui**

![xhgui gui][xhgui]

[Xdebug helper]: https://chrome.google.com/webstore/detail/xdebug-helper/eadndfjplgieldjbigjakmdgkmoaaaoc.
[profiling]: ./images/xdebug-helper-profile.png
[xhgui]: ./images/xhgui.png
