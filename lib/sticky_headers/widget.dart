// Copyright 2018 Simon Lightfoot. All rights reserved.
// Use of this source code is governed by a the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import './render.dart';

/// Builder called during layout to allow the header's content to be animated or styled based
/// on the amount of stickyness the header has.
///
/// [context] for your build operation.
///
/// [stuckAmount] will have the value of:
/// ```
///   0.0 <= value <= 1.0: about to be stuck
///          0.0 == value: at top
///  -1.0 >= value >= 0.0: past stuck
/// ```
///
typedef Widget StickyHeaderWidgetBuilder(
    BuildContext context, double stuckAmount);

/// Stick Header Widget
class StickyHeader extends MultiChildRenderObjectWidget {
  /// Constructs a  [StickyHeader] widget.
  StickyHeader({
    Key key,
    @required this.header,
    @required this.content,
    this.overlapHeaders: false,
    this.callback,
  }) : super(
          key: key,
          children: [content, header],
        );

  /// Header to be shown at the top of the parent [Scrollable] content.
  final Widget header;

  /// Content to be shown below the header.
  final Widget content;

  /// If true, the header will overlap the Content.
  final bool overlapHeaders;

  /// Optional callback with stickyness value. If you think you need this, then you might want to
  /// consider using [StickyHeaderBuilder] instead.
  final RenderStickyHeaderCallback callback;

  @override
  RenderStickyHeader createRenderObject(BuildContext context) {
    var scrollable = Scrollable.of(context);
    return RenderStickyHeader(
      scrollable: scrollable,
      callback: this.callback,
      overlapHeaders: this.overlapHeaders,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderStickyHeader renderObject) {
    renderObject
      ..scrollable = Scrollable.of(context)
      ..callback = this.callback
      ..overlapHeaders = this.overlapHeaders;
  }
}
