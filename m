Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E1BC6379F
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  7 Feb 2023 18:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjBGSWr (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 7 Feb 2023 13:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjBGSWd (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:22:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4501DC653
        for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:22:03 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d14so14438950wrr.9
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ho1LTqGpuqCMKTH+Vb+qJkksCrHGryHHWBQdSRtpN18=;
        b=P4zcKCj6lVBE8Jvr1ZgHF49O5366Nvo9qiNzHONiZ9a6P75W5pxe80lVN0u29Mza1f
         +OBDh/WcVO0XIq1SrqsIjPdivB0GLwtKrB/cr9ojhMjU3TpH0qf/c7ORhkAc44QkBs6u
         WC/xsuhdMCe4prb6u8zCMcSjtYduiA/tnKe4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ho1LTqGpuqCMKTH+Vb+qJkksCrHGryHHWBQdSRtpN18=;
        b=SwsVaqu+OMOgRe1ZJK9jlLt8LB/w8VqQnA31CBBMycSzQGCNlYqtcp2EF5jQQQCXXJ
         YapBP0SxqFVrzT9MxhWRugkcZ9YGzvd3iz3AL8SuEjiGTAgf9tdGm7DQiwYfBq+12ngU
         jqsA0oS1a2P5lNm7btCC6hlinXxFFgpapTlGmI71tA6CUDLAe6/9wCHFJaEtBMN0pb18
         FQDmctqEBjzt+Yt4EgZYKOCMf3b+YB3SoxtAa2gjpj3twHanZXro59OEt2585QimldpE
         6/S2od0u8fPZSD9xTtlA/zPin0u7SAFwL7F+k0HEobmmr267F6bgpidtdiUa3SNV0oXS
         Q/Xw==
X-Gm-Message-State: AO0yUKVA5iQbRxtvyh5vYrxG2JOaIzmFOx6j7WOlF40gmeHnSxOgbmvM
        /Jmr0Jo5W3Z0RE0FTT+rH5E/dA==
X-Google-Smtp-Source: AK7set92GRWSRFD+JuTVMwT58IakG0EDR8mGYyNURslzZaz9MVR69Cwi5cso4J5qn+cGI7Jr3a0S7Q==
X-Received: by 2002:a5d:6a08:0:b0:2c3:dbe0:58e9 with SMTP id m8-20020a5d6a08000000b002c3dbe058e9mr3509035wru.47.1675794121697;
        Tue, 07 Feb 2023 10:22:01 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:5307:c0c0:ff97:80de])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003daf672a616sm15578369wmq.22.2023.02.07.10.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 10:22:01 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v2 01/10] ftrace: Replace uses of _ftrace_direct APIs with _ftrace_direct_multi
Date:   Tue,  7 Feb 2023 19:21:26 +0100
Message-Id: <20230207182135.2671106-2-revest@chromium.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
In-Reply-To: <20230207182135.2671106-1-revest@chromium.org>
References: <20230207182135.2671106-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The _multi API requires that users keep their own ops but can enforce
that an op is only associated to one direct call.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
 kernel/trace/trace_selftest.c         | 11 +++++++----
 samples/ftrace/ftrace-direct-modify.c | 12 ++++++++----
 samples/ftrace/ftrace-direct-too.c    | 12 +++++++-----
 samples/ftrace/ftrace-direct.c        | 12 +++++++-----
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index ff0536cea968..57221f69a33b 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -806,6 +806,9 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	int ret;
 	unsigned long count;
 	char *func_name __maybe_unused;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	struct ftrace_ops direct = {};
+#endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	if (ftrace_filter_param) {
@@ -870,8 +873,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 	 * Register direct function together with graph tracer
 	 * and make sure we get graph trace.
 	 */
-	ret = register_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				     (unsigned long) trace_direct_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long)DYN_FTRACE_TEST_NAME, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, (unsigned long)trace_direct_tramp);
 	if (ret)
 		goto out;
 
@@ -891,8 +894,8 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 
 	unregister_ftrace_graph(&fgraph_ops);
 
-	ret = unregister_ftrace_direct((unsigned long) DYN_FTRACE_TEST_NAME,
-				       (unsigned long) trace_direct_tramp);
+	ret = unregister_ftrace_direct_multi(&direct,
+					     (unsigned long) trace_direct_tramp);
 	if (ret)
 		goto out;
 
diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrace-direct-modify.c
index de5a0f67f320..ecd76f75cb80 100644
--- a/samples/ftrace/ftrace-direct-modify.c
+++ b/samples/ftrace/ftrace-direct-modify.c
@@ -96,6 +96,8 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static unsigned long my_tramp = (unsigned long)my_tramp1;
 static unsigned long tramps[2] = {
 	(unsigned long)my_tramp1,
@@ -114,7 +116,7 @@ static int simple_thread(void *arg)
 		if (ret)
 			continue;
 		t ^= 1;
-		ret = modify_ftrace_direct(my_ip, my_tramp, tramps[t]);
+		ret = modify_ftrace_direct_multi(&direct, tramps[t]);
 		if (!ret)
 			my_tramp = tramps[t];
 		WARN_ON_ONCE(ret);
@@ -129,7 +131,9 @@ static int __init ftrace_direct_init(void)
 {
 	int ret;
 
-	ret = register_ftrace_direct(my_ip, my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
+	ret = register_ftrace_direct_multi(&direct, my_tramp);
+
 	if (!ret)
 		simple_tsk = kthread_run(simple_thread, NULL, "event-sample-fn");
 	return ret;
@@ -138,12 +142,12 @@ static int __init ftrace_direct_init(void)
 static void __exit ftrace_direct_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct(my_ip, my_tramp);
+	unregister_ftrace_direct_multi(&direct, my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using modify_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index e13fb59a2b47..0e907092e2c0 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -70,21 +70,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)handle_mm_fault,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) handle_mm_fault, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)handle_mm_fault,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Another example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
diff --git a/samples/ftrace/ftrace-direct.c b/samples/ftrace/ftrace-direct.c
index 1f769d0db20f..e446c38f6b58 100644
--- a/samples/ftrace/ftrace-direct.c
+++ b/samples/ftrace/ftrace-direct.c
@@ -63,21 +63,23 @@ asm (
 
 #endif /* CONFIG_S390 */
 
+static struct ftrace_ops direct;
+
 static int __init ftrace_direct_init(void)
 {
-	return register_ftrace_direct((unsigned long)wake_up_process,
-				     (unsigned long)my_tramp);
+	ftrace_set_filter_ip(&direct, (unsigned long) wake_up_process, 0, 0);
+
+	return register_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
 }
 
 static void __exit ftrace_direct_exit(void)
 {
-	unregister_ftrace_direct((unsigned long)wake_up_process,
-				 (unsigned long)my_tramp);
+	unregister_ftrace_direct_multi(&direct, (unsigned long)my_tramp);
 }
 
 module_init(ftrace_direct_init);
 module_exit(ftrace_direct_exit);
 
 MODULE_AUTHOR("Steven Rostedt");
-MODULE_DESCRIPTION("Example use case of using register_ftrace_direct()");
+MODULE_DESCRIPTION("Example use case of using register_ftrace_direct_multi()");
 MODULE_LICENSE("GPL");
-- 
2.39.1.519.gcb327c4b5f-goog

