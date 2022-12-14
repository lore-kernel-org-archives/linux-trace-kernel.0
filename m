Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10CFC4332F
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 14 Dec 2022 03:12:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiLNDMg (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 13 Dec 2022 22:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLNDMf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 22:12:35 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC852705;
        Tue, 13 Dec 2022 19:12:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E9479CE17E2;
        Wed, 14 Dec 2022 03:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77004C433EF;
        Wed, 14 Dec 2022 03:12:29 +0000 (UTC)
Date:   Tue, 13 Dec 2022 22:12:27 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] tracing: Fix cpumask() example typo
Message-ID: <20221213221227.56560374@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The sample code for using cpumask used the wrong field for the
__get_cpumask() helper. It used "cpus" which is the bitmask (but would
still give a proper example) instead of the "cpum" that was there to be
used.

Although it produces the same output, fix it, because it's an example and
is confusing in how to properly use the cpumask() macro.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 samples/trace_events/trace-events-sample.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index fb4548a44153..1c6b843b8c4e 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -359,7 +359,7 @@ TRACE_EVENT(foo_bar,
 		  __print_array(__get_dynamic_array(list),
 				__get_dynamic_array_len(list) / sizeof(int),
 				sizeof(int)),
-		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpus),
+		  __get_str(str), __get_bitmask(cpus), __get_cpumask(cpum),
 		  __get_str(vstr))
 );
 
-- 
2.35.1

