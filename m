Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C0EC6FD1F
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 16 Mar 2023 17:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjCPRi6 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 16 Mar 2023 13:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCPRiq (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 13:38:46 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDED61309
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id az3-20020a05600c600300b003ed2920d585so3680458wmb.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Mar 2023 10:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678988322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RknWTQPZwhibubaws4VpF1wT1qJmtFEhJqVyQzYCbBk=;
        b=f56BSsM5F/ldRHe5qOjUptpr+nccSsE5eRA+3mK+BgPce9DTV5LPUavBnVLW47eUr/
         6awV/JtevYfZanAmjonsIB5yDkuEWU+8Bh4+0wwFygu9rthmr6XVcRYgNPxpRsObPeen
         eXqYveVWhsHFhzLC7FwxE+eSuYdf1kpXMZ9V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678988322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RknWTQPZwhibubaws4VpF1wT1qJmtFEhJqVyQzYCbBk=;
        b=Ck9yYN2kLoq0v41FGL7HY0gTK6IjOxalJ7q7JJIO/dYL5CdsoQugcJNYrxUHQES5/j
         U2txqC9sDiOT++rFfXT8CViYhAHk5myyjE4v4R/gkD30tH98YUaMmCBk3xOYqx//eLKO
         mlkiB4/NMfPqKlKP96F4zHolOgWEfF2PcDnSZUi0F+9B2syOqqxoiSXsqOqIi+hNmREr
         2f1hxaejQokTCeywN20ezOU/Cj84Xbw7+9OBthcx3oKtF56xKJJoXzJQB3yY+up0Iwi/
         k62xAh9LdeapvWO5RpRB3lHbxE1rZb3nlGnEyxCJrtONH8ASukCGdoypt9WKAqPIGocO
         4J8g==
X-Gm-Message-State: AO0yUKUYRwOsA479rOBx5OIx8khC4SKjtFk8Uq4nfOrBveu7V2wSpQ1m
        5hJJCMSjvb8kqEjK04kNFShpZg==
X-Google-Smtp-Source: AK7set8fQLltLcsZzQ9slScet8GE/Dwu5L9dJC6i/Vr8BgFYq3Cv/RXIIf+pHRdklUlxKFsDAwyCLg==
X-Received: by 2002:a05:600c:314c:b0:3ed:3d89:1b4b with SMTP id h12-20020a05600c314c00b003ed3d891b4bmr4819498wmo.8.1678988322663;
        Thu, 16 Mar 2023 10:38:42 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:24ff:9ff7:736e:20a6])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b003daf7721bb3sm5596436wmi.12.2023.03.16.10.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 10:38:42 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        ast@kernel.org, daniel@iogearbox.net, kpsingh@kernel.org,
        revest@chromium.org, jolsa@kernel.org
Subject: [PATCH 6/7] ftrace: Make DIRECT_CALLS work WITH_ARGS and !WITH_REGS
Date:   Thu, 16 Mar 2023 18:38:10 +0100
Message-Id: <20230316173811.1223508-7-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
In-Reply-To: <20230316173811.1223508-1-revest@chromium.org>
References: <20230316173811.1223508-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Direct called trampolines can be called in two ways:
- either from the ftrace callsite. In this case, they do not access any
  struct ftrace_regs nor pt_regs
- Or, if a ftrace ops is also attached, from the end of a ftrace
  trampoline. In this case, the call_direct_funcs ops is in charge of
  setting the direct call trampoline's address in a struct ftrace_regs

Since:

commit 9705bc709604 ("ftrace: pass fregs to arch_ftrace_set_direct_caller()")

The later case no longer requires a full pt_regs. It only needs a struct
ftrace_regs so DIRECT_CALLS can work with both WITH_ARGS or WITH_REGS.
With architectures like arm64 already abandoning WITH_REGS in favor of
WITH_ARGS, it's important to have DIRECT_CALLS work WITH_ARGS only.

Signed-off-by: Florent Revest <revest@chromium.org>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 include/linux/ftrace.h | 6 ++++++
 kernel/trace/Kconfig   | 2 +-
 kernel/trace/ftrace.c  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6a532dd6789e..31f1e1df2af3 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -241,6 +241,12 @@ enum {
 	FTRACE_OPS_FL_DIRECT			= BIT(17),
 };
 
+#ifndef CONFIG_DYNAMIC_FTRACE_WITH_ARGS
+#define FTRACE_OPS_FL_SAVE_ARGS                        FTRACE_OPS_FL_SAVE_REGS
+#else
+#define FTRACE_OPS_FL_SAVE_ARGS                        0
+#endif
+
 /*
  * FTRACE_OPS_CMD_* commands allow the ftrace core logic to request changes
  * to a ftrace_ops. Note, the requests may fail.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a856d4a34c67..5b1e7fa41ca8 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -257,7 +257,7 @@ config DYNAMIC_FTRACE_WITH_REGS
 
 config DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	def_bool y
-	depends on DYNAMIC_FTRACE_WITH_REGS
+	depends on DYNAMIC_FTRACE_WITH_REGS || DYNAMIC_FTRACE_WITH_ARGS
 	depends on HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 
 config DYNAMIC_FTRACE_WITH_CALL_OPS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 66c91fa4b6ab..7a0c7eddf25b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5287,7 +5287,7 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
-#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
-- 
2.40.0.rc2.332.ga46443480c-goog

