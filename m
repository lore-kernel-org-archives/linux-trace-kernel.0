Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D48EC74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 14:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjCUOEj (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCUOEi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78B220A1A
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j24so4906419wrd.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WwprlyMlMMHhcPdyuhJ0L2KuDUXGr9VK74fm/Vyg9g=;
        b=nLWVXyspYz9peVqzG15vQujgApPLo7W8YAlDMmwXgMiAA8jyvGC+C9kFU5nQxGTPhi
         zJaGZ+jIs25bcgi3FxZOM/mn7T0TS5RAADcWbBNMT8QkFTxWOR1tGMn9V9jRt+S4/O8J
         vhouX/tHYrYoPpKhnDRpdau1olcLao3K7xi84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WwprlyMlMMHhcPdyuhJ0L2KuDUXGr9VK74fm/Vyg9g=;
        b=xM3B6xgibNtAEFw/eMAqXc08iI69mpFAG7Z0OTPb3PXtfbeqXCAt55+sZJjBTq6/Ci
         Y6Cyqokn/OBcdyuxaqAFNCkDTTFXQv/rVABzrCojGZUMJh5KCI4vSewRmz5HgzmWcmEx
         f+fbWrUKeAKRlWF/z8RSt79OW113lUMdLzM7pyDrgAAxfQxtEDyWApkXSBHYHWqScdEt
         PKKqcAvGvVhpSBNzHAyVmXmeBZdb1BF5CNkRmVpVnqjJnUN3N0jhbyXZWW/vTXt5iNVp
         f2GP4YfY2JXXLG/8F8xAFNad+XwMWXYJ0B5cynJYw0AoTyIbgXwR1YU6xmdV/QDm0E9g
         tljA==
X-Gm-Message-State: AO0yUKXlEyJ86Z0WRRnmQTt+X7YTJhkG89breGMlJ9zPTgTyg8hS66Zg
        oNvzUISIuWk2HJgznyHKTOUwqvezdmcQT20kCkc=
X-Google-Smtp-Source: AK7set8j3AWvvYQCOCHio+wE0JelTFbsmhmRg5txzyLp9SsTVqwHubY4XxVeXRxmdO+Rz1x3oFnzoQ==
X-Received: by 2002:a05:6000:105:b0:2d9:eb77:90d2 with SMTP id o5-20020a056000010500b002d9eb7790d2mr182791wrx.70.1679407476066;
        Tue, 21 Mar 2023 07:04:36 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:35 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 1/7] ftrace: Let unregister_ftrace_direct_multi() call ftrace_free_filter()
Date:   Tue, 21 Mar 2023 15:04:18 +0100
Message-Id: <20230321140424.345218-2-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
References: <20230321140424.345218-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

A common pattern when using the ftrace_direct_multi API is to unregister
the ops and also immediately free its filter. We've noticed it's very
easy for users to miss calling ftrace_free_filter().

This adds a "free_filters" argument to unregister_ftrace_direct_multi()
to both remind the user they should free filters and also to make their
life easier.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/ftrace.h                      | 6 ++++--
 kernel/bpf/trampoline.c                     | 2 +-
 kernel/trace/ftrace.c                       | 6 +++++-
 samples/ftrace/ftrace-direct-multi-modify.c | 3 +--
 samples/ftrace/ftrace-direct-multi.c        | 3 +--
 5 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 366c730beaa3..5b68ee874bc1 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -407,7 +407,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 				unsigned long new_addr);
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
+				   bool free_filters);
 int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int modify_ftrace_direct_multi_nolock(struct ftrace_ops *ops, unsigned long addr);
 
@@ -446,7 +447,8 @@ static inline int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned
 {
 	return -ENODEV;
 }
-static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
+						 bool free_filters)
 {
 	return -ENODEV;
 }
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index d0ed7d6f5eec..88bc23f1e10a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -198,7 +198,7 @@ static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
 	int ret;
 
 	if (tr->func.ftrace_managed)
-		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr);
+		ret = unregister_ftrace_direct_multi(tr->fops, (long)old_addr, false);
 	else
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, old_addr, NULL);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..fa379cf91fdb 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5804,7 +5804,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct_multi);
  *  0 on success
  *  -EINVAL - The @ops object was not properly registered.
  */
-int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr,
+				   bool free_filters)
 {
 	struct ftrace_hash *hash = ops->func_hash->filter_hash;
 	int err;
@@ -5822,6 +5823,9 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	/* cleanup for possible another register call */
 	ops->func = NULL;
 	ops->trampoline = 0;
+
+	if (free_filters)
+		ftrace_free_filter(ops);
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace/ftrace-direct-multi-modify.c
index b58c594efb51..196b43971cb5 100644
--- a/samples/ftrace/ftrace-direct-multi-modify.c
+++ b/samples/ftrace/ftrace-direct-multi-modify.c
@@ -151,8 +151,7 @@ static int __init ftrace_direct_multi_init(void)
 static void __exit ftrace_direct_multi_exit(void)
 {
 	kthread_stop(simple_tsk);
-	unregister_ftrace_direct_multi(&direct, my_tramp);
-	ftrace_free_filter(&direct);
+	unregister_ftrace_direct_multi(&direct, my_tramp, true);
 }
 
 module_init(ftrace_direct_multi_init);
diff --git a/samples/ftrace/ftrace-direct-multi.c b/samples/ftrace/ftrace-direct-multi.c
index c27cf130c319..ea0e88ee5e43 100644
--- a/samples/ftrace/ftrace-direct-multi.c
+++ b/samples/ftrace/ftrace-direct-multi.c
@@ -78,8 +78,7 @@ static int __init ftrace_direct_multi_init(void)
 
 static void __exit ftrace_direct_multi_exit(void)
 {
-	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp);
-	ftrace_free_filter(&direct);
+	unregister_ftrace_direct_multi(&direct, (unsigned long) my_tramp, true);
 }
 
 module_init(ftrace_direct_multi_init);
-- 
2.40.0.rc2.332.ga46443480c-goog

