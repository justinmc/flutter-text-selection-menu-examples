import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'app_scaffold.dart';

// Minimal padding from tip of the selection toolbar arrow to horizontal edges of the
// screen. Eyeballed value.
const double _kArrowScreenPadding = 26.0;

class CustomCupertinoMenuPage extends StatefulWidget {
  const CustomCupertinoMenuPage({ Key key }) : super(key: key);

  static const String routeName = '/custom-cupertino-menu';

  @override _CustomCupertinoMenuPageState createState() => _CustomCupertinoMenuPageState();
}

class _CustomCupertinoMenuPageState extends State<CustomCupertinoMenuPage> {
  final TextEditingController controller = TextEditingController(
    text: 'Select me custom menu',
  );

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Custom Cupertino Menu Page',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CupertinoTextField(
            controller: controller,
            selectionControls: MyCupertinoTextSelectionControls(),
          ),
          SelectableText(
            'Select me custom menu',
            selectionControls: MyCupertinoTextSelectionControls(),
          ),
        ],
      ),
    );
  }
}

class MyCupertinoTextSelectionControls extends CupertinoTextSelectionControls {
  // Padding between the toolbar and the anchor.
  static const double _kToolbarContentDistanceBelow = 20.0;
  static const double _kToolbarContentDistance = 8.0;

  /// Builder for material-style copy/paste text selection toolbar.
  @override
  Widget buildToolbar(
    BuildContext context,
    Rect globalEditableRegion,
    double textLineHeight,
    Offset selectionMidpoint,
    List<TextSelectionPoint> endpoints,
    TextSelectionDelegate delegate,
    ClipboardStatusNotifier clipboardStatus,
  ) {
    assert(debugCheckHasMediaQuery(context));
    final MediaQueryData mediaQuery = MediaQuery.of(context);

    // The toolbar should appear below the TextField when there is not enough
    // space above the TextField to show it, assuming there's always enough
    // space at the bottom in this case.
    final double anchorX = (selectionMidpoint.dx + globalEditableRegion.left).clamp(
      _kArrowScreenPadding + mediaQuery.padding.left,
      mediaQuery.size.width - mediaQuery.padding.right - _kArrowScreenPadding,
    );

    // The y-coordinate has to be calculated instead of directly quoting
    // selectionMidpoint.dy, since the caller
    // (TextSelectionOverlay._buildToolbar) does not know whether the toolbar is
    // going to be facing up or down.
    final Offset anchorAbove = Offset(
      anchorX,
      endpoints.first.point.dy - textLineHeight + globalEditableRegion.top,
    );
    final Offset anchorBelow = Offset(
      anchorX,
      endpoints.last.point.dy + globalEditableRegion.top,
    );

    return MyTextSelectionToolbar(
      anchorAbove: anchorAbove,
      anchorBelow: anchorBelow,
      clipboardStatus: clipboardStatus,
      handleCopy: canCopy(delegate) && handleCopy != null ? () => handleCopy(delegate, clipboardStatus) : null,
      handleCustomButton: () {
        delegate.textEditingValue = delegate.textEditingValue.copyWith(
          selection: TextSelection.collapsed(
            offset: delegate.textEditingValue.selection.baseOffset,
          ),
        );
        delegate.hideToolbar();
      },
      handleCut: canCut(delegate) && handleCut != null ? () => handleCut(delegate) : null,
      handlePaste: canPaste(delegate) && handlePaste != null ? () => handlePaste(delegate) : null,
      handleSelectAll: canSelectAll(delegate) && handleSelectAll != null ? () => handleSelectAll(delegate) : null,
    );
  }
}

class MyTextSelectionToolbar extends StatefulWidget {
  const MyTextSelectionToolbar({
    Key key,
    this.anchorAbove,
    this.anchorBelow,
    this.clipboardStatus,
    this.handleCopy,
    this.handleCustomButton,
    this.handleCut,
    this.handlePaste,
    this.handleSelectAll,
  }) : super(key: key);

  final Offset anchorAbove;
  final Offset anchorBelow;
  final ClipboardStatusNotifier clipboardStatus;
  final VoidCallback handleCopy;
  final VoidCallback handleCustomButton;
  final VoidCallback handleCut;
  final VoidCallback handlePaste;
  final VoidCallback handleSelectAll;

  @override
  MyTextSelectionToolbarState createState() => MyTextSelectionToolbarState();
}

class MyTextSelectionToolbarState extends State<MyTextSelectionToolbar> {
  void _onChangedClipboardStatus() {
    setState(() {
      // Inform the widget that the value of clipboardStatus has changed.
    });
  }

  @override
  void initState() {
    super.initState();
    widget.clipboardStatus.addListener(_onChangedClipboardStatus);
    widget.clipboardStatus.update();
  }

  @override
  void didUpdateWidget(MyTextSelectionToolbar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clipboardStatus != oldWidget.clipboardStatus) {
      widget.clipboardStatus.addListener(_onChangedClipboardStatus);
      oldWidget.clipboardStatus.removeListener(_onChangedClipboardStatus);
    }
    widget.clipboardStatus.update();
  }

  @override
  void dispose() {
    super.dispose();
    if (!widget.clipboardStatus.disposed) {
      widget.clipboardStatus.removeListener(_onChangedClipboardStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Don't render the menu until the state of the clipboard is known.
    if (widget.handlePaste != null
        && widget.clipboardStatus.value == ClipboardStatus.unknown) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    final List<Widget> items = <Widget>[];
    final CupertinoLocalizations localizations = CupertinoLocalizations.of(context);
    assert(debugCheckHasMediaQuery(context));
    final Widget onePhysicalPixelVerticalDivider =
        SizedBox(width: 1.0 / MediaQuery.of(context).devicePixelRatio);

    void addToolbarButton(
      String text,
      VoidCallback onPressed,
    ) {
      if (items.isNotEmpty) {
        items.add(onePhysicalPixelVerticalDivider);
      }

      items.add(CupertinoTextSelectionToolbarButton(
        onPressed: onPressed,
        child: CupertinoTextSelectionToolbarButton.getText(text),
      ));
    }

    if (widget.handleCut != null) {
      addToolbarButton(localizations.cutButtonLabel, widget.handleCut);
    }
    if (widget.handleCopy != null) {
      addToolbarButton(localizations.copyButtonLabel, widget.handleCopy);
    }
    if (widget.handlePaste != null
        && widget.clipboardStatus.value == ClipboardStatus.pasteable) {
      addToolbarButton(localizations.pasteButtonLabel, widget.handlePaste);
    }
    if (widget.handleSelectAll != null) {
      addToolbarButton(localizations.selectAllButtonLabel, widget.handleSelectAll);
    }
    addToolbarButton('Custom button', widget.handleCustomButton);

    // If there is no option available, build an empty widget.
    if (items.isEmpty) {
      return const SizedBox(width: 0.0, height: 0.0);
    }

    return CupertinoTextSelectionToolbar(
      anchorAbove: widget.anchorAbove,
      anchorBelow: widget.anchorBelow,
      toolbarBuilder: (BuildContext context, Offset anchor, bool isAbove, Widget child) {
        return Container(
          color: Colors.pink,
          padding: EdgeInsets.all(22.0),
          child: child,
        );
      },
      children: items,
    );
  }
}

