Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D9AC7EE32
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  2 Mar 2023 02:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCBCIP (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 1 Mar 2023 21:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCBCIO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:08:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9951ACC5;
        Wed,  1 Mar 2023 18:08:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 987C961544;
        Thu,  2 Mar 2023 02:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02179C433D2;
        Thu,  2 Mar 2023 02:08:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1pXYMc-003Wbh-1i;
        Wed, 01 Mar 2023 21:08:10 -0500
Message-ID: <20230302010051.044209550@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Mar 2023 20:00:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Fix adding some modifiers to histogram values
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org


Mark Rutland reported to me on IRC that he accidentally added the
".buckets=8" modifier to hitcount. This should not be allowed, but it
did not error. Worse yet, when reading the hist file, it would crash
as there was a NULL pointer dereference due to the values not having
fields assigned to them.

The first fix is to make sure that histogram values do not get assigned
modifiers that they can't use.

The the second patch is to not crash if a NULL pointer is passed to
hist_field_name() (which is what happens if you allow some of these
modifiers to be used by values).

Steven Rostedt (Google) (2):
      tracing: Do not let histogram values have some modifiers
      tracing: Check field value in hist_field_name()

----
 kernel/trace/trace_events_hist.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)
