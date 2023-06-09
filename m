Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2193EC7EE29
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  9 Jun 2023 04:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236435AbjFIE5N (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 9 Jun 2023 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjFIE5L (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40621993;
        Thu,  8 Jun 2023 21:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AE5E640C7;
        Fri,  9 Jun 2023 04:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F293C433D2;
        Fri,  9 Jun 2023 04:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686286629;
        bh=5xHKvL6ZfMuMe3jf7O1cpRApEDjxE+xErH+bXnkqE3A=;
        h=From:To:Cc:Subject:Date:From;
        b=HLEpQn6wzi23/XH+KH6KHupu49qFHaIe+lcRT3q9UxhXxm2hY9FuUeL0p6isB/wiQ
         MtWoESPEeGIGiGd84nUu0pDFK/Y0UPeYqBHjW4K/mjiBGblmxB74S2YpAyNmpqDqqO
         tvXywoXQmTYypWppbTmQ8HtydCi+h21z7Gzi9UxazRkafSh/5FyQuFxpWTPaqQqiuN
         PQy1sbdc8YTn4vTsVCa30JazXOKG0oTa3diClWxgPRmwVxCU+qj3TRayfUdSgpX/Wv
         i9nuA11+enVoGfS9GZoS9gMWu6hRwT9DeepZCFIAFz7U7ijG1K6j1aSlJ5f7gHAakC
         7mHeEJQf2bJmg==
From:   Naveen N Rao <naveen@kernel.org>
To:     <linux-trace-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] trace/kprobe: Display the actual notrace function when rejecting a probe
Date:   Fri,  9 Jun 2023 10:25:45 +0530
Message-Id: <20230609045545.418677-1-naveen@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Trying to probe update_sd_lb_stats() using perf results in the below
message in the kernel log:
	trace_kprobe: Could not probe notrace function _text

This is because 'perf probe' specifies the kprobe location as an offset
from '_text':
	$ sudo perf probe -D update_sd_lb_stats
	p:probe/update_sd_lb_stats _text+1830728

However, the error message is misleading and doesn't help convey the
actual notrace function that is being probed. Fix this by looking up the
actual function name that is being probed. With this fix, we now get the
below message in the kernel log:
	trace_kprobe: Could not probe notrace function update_sd_lb_stats.constprop.0

Signed-off-by: Naveen N Rao <naveen@kernel.org>
---
 kernel/trace/trace_kprobe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 74adb82331dd81..975daa66fcef59 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -449,9 +449,8 @@ static bool __within_notrace_func(unsigned long addr)
 	return !ftrace_location_range(addr, addr + size - 1);
 }
 
-static bool within_notrace_func(struct trace_kprobe *tk)
+static bool within_notrace_func(struct trace_kprobe *tk, unsigned long addr)
 {
-	unsigned long addr = trace_kprobe_address(tk);
 	char symname[KSYM_NAME_LEN], *p;
 
 	if (!__within_notrace_func(addr))
@@ -477,6 +476,8 @@ static bool within_notrace_func(struct trace_kprobe *tk)
 /* Internal register function - just handle k*probes and flags */
 static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
+	unsigned long addr = trace_kprobe_address(tk);
+	char symname[KSYM_NAME_LEN];
 	int i, ret;
 
 	ret = security_locked_down(LOCKDOWN_KPROBES);
@@ -486,9 +487,9 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_kprobe_is_registered(tk))
 		return -EINVAL;
 
-	if (within_notrace_func(tk)) {
+	if (within_notrace_func(tk, addr)) {
 		pr_warn("Could not probe notrace function %s\n",
-			trace_kprobe_symbol(tk));
+			lookup_symbol_name(addr, symname) ? trace_kprobe_symbol(tk) : symname);
 		return -EINVAL;
 	}
 

base-commit: e46ad59233cf16daf4f3b9dd080003f01ac940fe
-- 
2.40.1

