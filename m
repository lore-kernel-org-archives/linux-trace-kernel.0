Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488C8C74A5B
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 21 Mar 2023 14:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjCUOEw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 21 Mar 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjCUOEo (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:04:44 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E6211F7
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id m35so9635998wms.4
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679407481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2fmFB1FVRjrhf8zh2dvknFsm562JmIp8xz3gFT+UVA=;
        b=VYFq9Y/i+3bznsGRQQidOXTXEdh59n3ImD7f48RqiRuS6jw4VQFeV9Fbwg6JlfWcTe
         QO1ejrsHbmk76zOqsucN8SS14PjoqSzyYKmonbBdC64TObAwdijzLJGlGJXBpsoYghSA
         uXhrwcxvkOVJayviK6NuPHnfY6AB+TBs5H5Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679407481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m2fmFB1FVRjrhf8zh2dvknFsm562JmIp8xz3gFT+UVA=;
        b=uu+NAm8KRGm5YQcOUG7CKDB4ShfXV8SBvenWWwJD/UgTvgAZs7oJQsisn3QBAlXqPa
         kpgZM+PSZiVOUxXoPlXiIe92Vx5TycyfLyTVaFB2rbKC/q/CiSC6NORAhEhDEZ7iJsEs
         R0aKsaCvwt3eCIIxxqnL8Iu1/OOuAGcGlOasu6IAKqGBtDwt4BW1SI8AxkU57tZn074u
         f2B6FM3CR7ySWOz36XOxLYK5uPxKV1+GIt2wtZgIDJ1iHlRhWQiK2Rkd/7TxrliWUAd7
         hjwg861SAIWRzzT+RRS47uvDtJqKTn6iG0HpQ7x9Z38dQM/vkMMe58JXwiWndETQW3sX
         BTMA==
X-Gm-Message-State: AO0yUKWWG23FrpIS/q8cG5nGFwNVX+ytPE6QO28ZKP4jFRYvBrP0hZ+D
        nsETMRVA/k9Bx7+hkk+AnGBiDA==
X-Google-Smtp-Source: AK7set9kAZZfIfQYRbzvwWo0ac+ttDsnVfvSDTzDInqjOlaZ/piVfDg6oJq+fKaxQ0vK3lbK9hMqgQ==
X-Received: by 2002:a05:600c:2148:b0:3ed:b6ad:54d with SMTP id v8-20020a05600c214800b003edb6ad054dmr2523905wml.18.1679407481466;
        Tue, 21 Mar 2023 07:04:41 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:4b8c:8b16:90d:8d9a])
        by smtp.gmail.com with ESMTPSA id f12-20020a1cc90c000000b003e20cf0408esm13620896wmb.40.2023.03.21.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:04:41 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH v2 5/7] ftrace: Store direct called addresses in their ops
Date:   Tue, 21 Mar 2023 15:04:22 +0100
Message-Id: <20230321140424.345218-6-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230321140424.345218-1-revest@chromium.org>
References: <20230321140424.345218-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

All direct calls are now registered using the register_ftrace_direct API
so each ops can jump to only one direct-called trampoline.

By storing the direct called trampoline address directly in the ops we
can save one hashmap lookup in the direct call ops and implement arm64
direct calls on top of call ops.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 include/linux/ftrace.h | 3 +++
 kernel/trace/ftrace.c  | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index abee60865fc7..6a532dd6789e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -321,6 +321,9 @@ struct ftrace_ops {
 	unsigned long			trampoline_size;
 	struct list_head		list;
 	ftrace_ops_func_t		ops_func;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
+	unsigned long			direct_call;
+#endif
 #endif
 };
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 33530198d1ca..bf1f857bfe76 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	unsigned long addr;
+	unsigned long addr = READ_ONCE(ops->direct_call);
 
-	addr = ftrace_find_rec_direct(ip);
 	if (!addr)
 		return;
 
@@ -5380,6 +5379,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	ops->func = call_direct_funcs;
 	ops->flags = MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
+	ops->direct_call = addr;
 
 	err = register_ftrace_function_nolock(ops);
 
@@ -5454,6 +5454,7 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	/* Enable the tmp_ops to have the same functions as the direct ops */
 	ftrace_ops_init(&tmp_ops);
 	tmp_ops.func_hash = ops->func_hash;
+	tmp_ops.direct_call = addr;
 
 	err = register_ftrace_function_nolock(&tmp_ops);
 	if (err)
@@ -5475,6 +5476,8 @@ __modify_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 			entry->direct = addr;
 		}
 	}
+	/* Prevent store tearing if a trampoline concurrently accesses the value */
+	WRITE_ONCE(ops->direct_call, addr);
 
 	mutex_unlock(&ftrace_lock);
 
-- 
2.40.0.rc2.332.ga46443480c-goog

