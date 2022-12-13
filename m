Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5293AC4332F
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 13 Dec 2022 14:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiLMO4H (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 13 Dec 2022 09:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235944AbiLMO4G (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:56:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BEEFCC7;
        Tue, 13 Dec 2022 06:56:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2ADE7614C3;
        Tue, 13 Dec 2022 14:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E7DC433EF;
        Tue, 13 Dec 2022 14:56:03 +0000 (UTC)
Date:   Tue, 13 Dec 2022 09:56:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH] tracing: Have trigger filter parsing errors show up in 
 error_log
Message-ID: <20221213095602.083fa9fd@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It is annoying that the filter parsing of triggers do not show up in the
error_log. Trying to figure out what is incorrect in the input is
difficult when it fails for a typo.

Have the errors of filter parsing show up in error_log as well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 918730d74932..19ce9d22bfd7 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1067,7 +1067,14 @@ int set_trigger_filter(char *filter_str,
 
 	/* The filter is for the 'trigger' event, not the triggered event */
 	ret = create_event_filter(file->tr, file->event_call,
-				  filter_str, false, &filter);
+				  filter_str, true, &filter);
+
+	/* Only enabled set_str for error handling */
+	if (filter) {
+		kfree(filter->filter_string);
+		filter->filter_string = NULL;
+	}
+
 	/*
 	 * If create_event_filter() fails, filter still needs to be freed.
 	 * Which the calling code will do with data->filter.
-- 
2.35.1

