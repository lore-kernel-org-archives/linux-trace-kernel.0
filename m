Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C87C7618D
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Apr 2023 15:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjDFPLJ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Apr 2023 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbjDFPLH (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC25189;
        Thu,  6 Apr 2023 08:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F12A64634;
        Thu,  6 Apr 2023 15:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B5FC433EF;
        Thu,  6 Apr 2023 15:10:34 +0000 (UTC)
Date:   Thu, 6 Apr 2023 11:10:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        kernel test robot <lkp@intel.com>,
        Tze-nan Wu <Tze-nan.Wu@mediatek.com>
Subject: [PATCH] tracing/synthetic: Make lastcmd_mutex static
Message-ID: <20230406111033.6e26de93@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The lastcmd_mutex is only used in trace_events_synth.c and should be
static.

Link: https://lore.kernel.org/linux-trace-kernel/202304062033.cRStgOuP-lkp@intel.com/

Fixes: 4ccf11c4e8a8e ("tracing/synthetic: Fix races on freeing last_cmd")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index f0ff730125bf..d6a70aff2410 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -44,7 +44,7 @@ enum { ERRORS };
 
 static const char *err_text[] = { ERRORS };
 
-DEFINE_MUTEX(lastcmd_mutex);
+static DEFINE_MUTEX(lastcmd_mutex);
 static char *last_cmd;
 
 static int errpos(const char *str)
-- 
2.39.2

