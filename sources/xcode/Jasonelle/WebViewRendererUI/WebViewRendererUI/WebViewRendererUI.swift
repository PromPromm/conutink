import Foundation
import Jasonelle
import JasonelleSwift
import JavaScriptCore
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView

    let webView: WKWebView

    func makeUIView(context _: Context) -> WKWebView {
        return webView
    }

    func updateUIView(_: WKWebView, context _: Context) {}
}

class WebViewModel: ObservableObject {
    static let identifier: String = "com.jasonelle.webrendererui.webview.identifier"

    var webView: WKWebView
    let refreshControl: UIRefreshControl = .init()
    var delegate: WKWebViewDelegate = .init(identifier: WebViewModel.identifier)
    let webViewController: WKUserContentController = .init()

    @Published var app: Jasonelle.App? = nil
    @Published var loader: WebViewRendererUILoader? = nil
    @Published var isLoading: Bool = false

    init() {
        let configuration = WKWebViewConfiguration()

        // TODO: Add more config options
        // Like adding headers and other options

        // On iOS >= 14
        // The promise always would return a JS Promise.resolve(null).
        // On lesser iOS versions it is null.
        // The delegate must implement WKScriptMessageHandler protocol.
        // But that is the old way of doing things.
        // In the older versions of Jasonette. It was created an RPC
        // like structure that overcomes that limitation by separating
        // the call from the response in two different functions (in a map of functions waiting for response).
        // This is not needed on the newer versions since it always returns
        // a promise. But maybe the RPC implementation can be used in Android
        // if that platform does not includes a promise supported way of
        // waiting for the native code response.
        // uncomment and apply the protocol on the delegate if wanted. but why?.
        // self.webViewController.add(self.delegate, name: WebViewModel.identifier)

        // With this option it can be used as a Promise that returns something.
        // The delegate must implement WKScriptMessageHandlerWithReply protocol
        // Only supported in iOS >= 14.
        
        webViewController.addScriptMessageHandler(delegate, contentWorld: WKContentWorld.page, name: WebViewModel.identifier)

        configuration.websiteDataStore = .nonPersistent()
        configuration.userContentController = webViewController
        configuration.allowsInlineMediaPlayback = true

        webView = WKWebView(frame: .zero, configuration: configuration)
        
        webView.uiDelegate = delegate

        webView.publisher(for: \.isLoading).assign(to: &$isLoading)

        refreshControl.addTarget(self, action: #selector(pull), for: UIControl.Event.valueChanged)

        // Add RefreshControl to WebView
        webView.scrollView.addSubview(refreshControl)
        webView.scrollView.bounces = true

        setStyles()
    }

    func load(_ url: String) {
        var res = url
        var isResource = false

        // support loading local files with res:// prefix
        // example res://index.html
        if app!.utils.fs.isResource(res) {
            isResource = true
            res = app?.utils.fs.fileURL(forPath:
                app?.utils.fs.path(forResource: res) ?? "")
                .absoluteString ?? "about:blank"
        }

        guard let href = URL(string: res) else {
            return
        }

        if isResource {
            webView.loadFileURL(href, allowingReadAccessTo: app!.utils.fs.resourceDirectoryURL())
        } else {
            webView.load(URLRequest(url: href))
        }
    }

    // Refresh the WebView
    @objc func pull(sender _: UIRefreshControl) {
        webView.reload()
        refreshControl.endRefreshing()
        loader?.params.components().pull().hooks.onPull()
    }

    private func setStyles() {
        refreshControl.attributedTitle = NSAttributedString(string: PullStrings.defaultTitle(), attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.black,
        ])
        refreshControl.tintColor = UIColor.black
        refreshControl.setNeedsDisplay()
    }

    private func setStyles(with config: WebViewRendererUILoader) {
        // TODO: Add more style options

        if config.params.components().pull().params.hidden() || config.params.components().pull().options.hidden() {
            refreshControl.removeFromSuperview()
        }

        refreshControl.attributedTitle = config.params.components().pull().style.title()
        refreshControl.tintColor = config.params.components().pull().style.tint()
        refreshControl.setNeedsDisplay()
    }

    func setLoader(_ loader: WebViewRendererUILoader) {
        self.loader = loader
        // TODO: add config for the webview
        // Update the view following the styles in the loader
        setStyles(with: loader)
    }

    func setApp(_ app: Jasonelle.App) {
        self.app = app
        // TODO: Trigger Hooks
        app.notifications.post("com.jasonelle.notifications.webviewrendererui.ready", by: self, with: nil)

        app.logger.trace("App Ready")
        app.ext.extensions.appDidLoad()
        delegate = WKWebViewDelegate(app: app, andIdentifier: WebViewModel.identifier)
        webView.navigationDelegate = delegate
    }

    func onLoad() {
        app?.logger.trace("Triggering App Did Load Hook")
        loader?.hooks.onAppDidLoad()
        app?.ext.extensions.appDidLoad()
        webView = app?.ext.extensions.appDidLoad(with: webView) ?? webView
        
        app?.events.addListener(self, with: #selector(didReceiveHrefDeepLinkNotification(_:)), for: JLEventDidReceiveOpenURL.self)
    }
        
    @objc
    func didReceiveHrefDeepLinkNotification(_ notification: Notification) {
        
        app?.logger.trace("Received URL notification")
        
        // TODO: Maybe add specific event for each type of openURL
        let data = notification.userInfo?["data"] as? Dictionary<String, Any>
        if data?["type"] as! String == "href" {
            load(data!["value"] as! String)
        }
    }

    func onAppear() {
        app?.logger.trace("Triggering View Did Appear Hook")
        app?.ext.extensions.appDidAppear()
        loader?.hooks.onViewDidAppear()
    }

    func onDisappear() {
        app?.logger.trace("Triggering View Did Disappear Hook")
        app?.ext.extensions.appDidDisappear()
        loader?.hooks.onViewDidDisappear()
    }
}

public struct ContentView: View {
    @StateObject private var web = WebViewModel()

    var app = Jasonelle.App.instance
    var loader: WebViewRendererUILoader
    var renderer = JasonelleSwift.Renderer()

    var url: String

    public init() {
        // Since the config is user made
        // we have to wait for the js engine to be ready
        // before loading it
        // Thats why we need to pass it here instead of AppDelegate
        // self must be used after config setup
        // TODO: https://stackoverflow.com/questions/25792131/how-to-get-jscontext-from-wkwebview
        loader = WebViewRendererUILoader(app: app, context: JSContext())
        url = loader.params.url()

        renderer.view = self
        app.renderer = renderer

        app.logger.trace("WebViewRendererUI initialized")
    }

    public var body: some View {
        ZStack {
            WebView(webView: web.webView)
            if web.webView.isLoading {
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
        }.onAppear {
            // Only setup app once.
            // Since it will trigger every time the app will appear
            // For example being called after file input modal.
            // Is similar to an onViewDidLoad method.
            if web.app == nil {
                // Loader must be installed after the view is created
                web.setLoader(loader)
                // App must be set after the loader so it can trigger the hooks
                web.setApp(app)
                web.load(url)
                web.onLoad()
            }

            web.onAppear()
        }.onDisappear {
            web.onDisappear()
        }.onOpenURL { url in
            
            self.app.logger.trace("Did Receive Open URL: \(url.absoluteString)")
            
            let event : JLEventDidReceiveOpenURL = self.app.events.event(for: JLEventDidReceiveOpenURL.self) as! JLEventDidReceiveOpenURL
            
            event.trigger(with: url, andOptions: [:])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
