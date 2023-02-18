Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B37C636CC
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 18 Feb 2023 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBRP72 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 18 Feb 2023 10:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBRP71 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 10:59:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A4217CDB;
        Sat, 18 Feb 2023 07:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C60E860B99;
        Sat, 18 Feb 2023 15:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85878C433D2;
        Sat, 18 Feb 2023 15:59:23 +0000 (UTC)
Date:   Sat, 18 Feb 2023 10:59:21 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, ionut_n2001@yahoo.com
Subject: [PATCH] tracing: Check for NULL field_name in
 __synth_event_add_val()
Message-ID: <20230218105921.12ddb86f@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

It is possible that the field_name passed into __synth_event_add_val() can
be NULL with the trace_state set to add_name (possibly set from a previous
call), in which case it needs to be checked.

Cc: stable@vger.kernel.org
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=217053
Fixes: 8dcc53ad956d2 ("tracing: Add synth_event_trace() and related functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Tom, can you review this. Is there a legitimate case where you can have a
previous call set "add_name" but the next call not require it? This patch
assumes that it can't.

 kernel/trace/trace_events_synth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 70bddb25d9c0..fa28c1da06d2 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1982,6 +1982,10 @@ static int __synth_event_add_val(const char *field_name, u64 val,
 
 	event = trace_state->event;
 	if (trace_state->add_name) {
+		if (!field_name) {
+			ret = -EINVAL;
+			goto out;
+		}
 		for (i = 0; i < event->n_fields; i++) {
 			field = event->fields[i];
 			if (strcmp(field->name, field_name) == 0)
-- 
2.39.1

