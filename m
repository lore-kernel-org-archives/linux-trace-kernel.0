Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDDCC38142
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 31 Jan 2023 14:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjAaOwm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjAaOwl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:52:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF0215CAE;
        Tue, 31 Jan 2023 06:52:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 59E3D61546;
        Tue, 31 Jan 2023 14:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C850C433EF;
        Tue, 31 Jan 2023 14:52:39 +0000 (UTC)
Date:   Tue, 31 Jan 2023 09:52:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] tracing: Fix trace_event_raw_event_synth() if else
 statement
Message-ID: <20230131095237.63e3ca8d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The test to check if the field is a stack is to be done if it is not a
string. But the code had:

    } if (event->fields[i]->is_stack) {

and not

   } else if (event->fields[i]->is_stack) {

which would cause it to always be tested. Worse yet, this also included an
"else" statement that was only to be called if the field was not a string
and a stack, but this code allows it to be called if it was a string (and
not a stack).

Also fixed some whitespace issues.

Link: https://lore.kernel.org/all/202301302110.mEtNwkBD-lkp@intel.com/

Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index adb630633f31..306c89e0ce55 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -564,8 +564,8 @@ static notrace void trace_event_raw_event_synth(void *__data,
 					   event->fields[i]->is_dynamic,
 					   data_size, &n_u64);
 			data_size += len; /* only dynamic string increments */
-		} if (event->fields[i]->is_stack) {
-		        long *stack = (long *)(long)var_ref_vals[val_idx];
+		} else if (event->fields[i]->is_stack) {
+			long *stack = (long *)(long)var_ref_vals[val_idx];
 
 			len = trace_stack(entry, event, stack,
 					   data_size, &n_u64);
-- 
2.39.0

