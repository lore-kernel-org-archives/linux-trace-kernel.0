Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413DAEB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Sun,  2 Jul 2023 14:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGBOrv (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sun, 2 Jul 2023 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjGBOru (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:47:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50945E5E;
        Sun,  2 Jul 2023 07:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0E2260C2C;
        Sun,  2 Jul 2023 14:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577A6C433CB;
        Sun,  2 Jul 2023 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688309258;
        bh=YM6t77hkrmL0BQ4fCrPPMAXrOgv5IQjPa1agd03fP70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZAJv7+bSjNkfj3L2nXyNjhcy/BxEBu9FTQlSatczbFtOg2/U4+IOT0Q5G+jZ7Gwp0
         8br1UiPmexAvFkKepIeq+BHXRm34QM7uAcbDZLAXQzMPIUxXpVd3yz+FEDUP2D31uT
         ifZRTotfXmdnv/oG8/vN3yht+H+v8cu+KY1afvHB7GjtCfZ1oLraoNvrmuNwACqveh
         NcLqFAIQV7UWGD45KskndizDCZ007dQ+0Of/TvnX21oWBw95EimjBbDyghdPqgSy70
         bEut4WLCgQG/xWwDWxv0xE0eipXo0txH/jUnc/A7T1rDZSR8BBPmaGUkpulMWAn0h8
         1EqLwGQhISZjQ==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 3/3] tracing/probes: Fix return value when "(fault)" is injected
Date:   Sun,  2 Jul 2023 23:47:35 +0900
Message-ID:  <168830925534.2278819.7237772177111801959.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
In-Reply-To:  <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
References:  <168830922841.2278819.9165254236027770818.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When the "(fault)" is injected, the return value of fetch_store_string*()
should be the length of the "(fault)", but an error code is returned.
Fix it to return the correct length and update the data_loc according the
updated length.
This needs to update a ftracetest test case, which expects trace output
to appear as '(fault)' instead of '"(fault)"'.

Fixes: 2e9906f84fc7 ("tracing: Add "(fault)" name injection to kernel probes")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_kernel.h                  |   17 +++++++----------
 .../ftrace/test.d/kprobe/kprobe_args_user.tc       |    2 +-
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_probe_kernel.h b/kernel/trace/trace_probe_kernel.h
index c4e1d4c03a85..63d90fe4eb87 100644
--- a/kernel/trace/trace_probe_kernel.h
+++ b/kernel/trace/trace_probe_kernel.h
@@ -48,14 +48,15 @@ fetch_store_strlen(unsigned long addr)
 	return (ret < 0) ? strlen(FAULT_STRING) + 1 : len;
 }
 
-static nokprobe_inline void set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
+static nokprobe_inline int set_data_loc(int ret, void *dest, void *__dest, void *base, int len)
 {
-	if (ret >= 0) {
-		*(u32 *)dest = make_data_loc(ret, __dest - base);
-	} else {
+	if (ret < 0) {
 		strscpy(__dest, FAULT_STRING, len);
 		ret = strlen(__dest) + 1;
 	}
+
+	*(u32 *)dest = make_data_loc(ret, __dest - base);
+	return ret;
 }
 
 /*
@@ -76,9 +77,7 @@ fetch_store_string_user(unsigned long addr, void *dest, void *base)
 	__dest = get_loc_data(dest, base);
 
 	ret = strncpy_from_user_nofault(__dest, uaddr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
-
-	return ret;
+	return set_data_loc(ret, dest, __dest, base, maxlen);
 }
 
 /*
@@ -107,9 +106,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	 * probing.
 	 */
 	ret = strncpy_from_kernel_nofault(__dest, (void *)addr, maxlen);
-	set_data_loc(ret, dest, __dest, base, maxlen);
-
-	return ret;
+	return set_data_loc(ret, dest, __dest, base, maxlen);
 }
 
 static nokprobe_inline int
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
index d25d01a19778..8dcc0b29bd36 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_user.tc
@@ -29,6 +29,6 @@ echo 1 > events/kprobes/myevent/enable
 ln -s foo $TMPDIR/bar
 echo 0 > events/kprobes/myevent/enable
 
-grep myevent trace | grep -q 'path=(fault) path2=(fault)'
+grep myevent trace | grep -q 'path="*(fault)"* path2="*(fault)"*'
 
 exit 0

