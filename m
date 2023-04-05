Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B79C7619A
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Apr 2023 18:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjDESEK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjDESDy (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:03:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D2072A7
        for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:03:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso3346954wmq.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680717777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBVm5Zb8SvFMICocd9qO1ZxlhdAx1c4kialWJuW3JL8=;
        b=mYZ2ebBFhZzuxU4cNfsqpAqCqhwJKdWklj5QOg1NUs875jkf+Nq8raj8nf0ExLPfXx
         A+KwVuhrQts+hLJdZT7w7vB6vOUvrB5GOSiNb9/Ptd4Pe88bZsFbBbPfQSkUbBx9xmz9
         8EOqRXufDXqb0Qb8OWiM1dC3ab7+7DBIVEVYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBVm5Zb8SvFMICocd9qO1ZxlhdAx1c4kialWJuW3JL8=;
        b=G3TW8ndyA4Zofev03kDzdZs0Hiw7JJVwbwTe2gMyjgWKOB3ShwzEIIsCJg0XDsBmT7
         yf9RLNj/w+nWPgdws3YieYfuZJ1s7CeJEwEMRd9y/c30aKa9vQOtqQrQgaHAVaDlTS2J
         ymPl9Uev52IvWeG5O0949ZMFQUQvHTQHZx0dFXpED/KV9K4/Z0eYoFDEpB93BiLuN0Zj
         Y2CnVWYNCSjRU++FH9OoeqnQ2uFZCB2W+k2KTWYtQf9ftEZ78obA9/Xd/PsoIi9MRjar
         hglT2dFpfoI5J2jC+kOzGdcTTq4Upl6o0v17Im8ZZuv0JrekVq0HNekWp+SJ4Jr3JT9T
         Fdow==
X-Gm-Message-State: AAQBX9cNqnltZG8SjRS0gl4Qj5MTgdaQrASj5y1nyssDuQJL33L3ymYs
        NSeSVgBZ9+egVMu/iM3x9ghNbg==
X-Google-Smtp-Source: AKy350b+VOJrpQCtIjiBgZCLLaeGb2jZlDW7aZI8+QWO3odmUBexZoH9aajPLjpmANeBSzetMX5/fA==
X-Received: by 2002:a1c:f20d:0:b0:3ea:e582:48dd with SMTP id s13-20020a1cf20d000000b003eae58248ddmr5383281wmc.34.1680717777383;
        Wed, 05 Apr 2023 11:02:57 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:cf6a:9ae6:15f1:4213])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b003f0472ffc7csm2913233wmb.11.2023.04.05.11.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:02:57 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v6 2/5] arm64: ftrace: Simplify get_ftrace_plt
Date:   Wed,  5 Apr 2023 20:02:47 +0200
Message-Id: <20230405180250.2046566-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230405180250.2046566-1-revest@chromium.org>
References: <20230405180250.2046566-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Following recent refactorings, the get_ftrace_plt function only ever
gets called with addr = FTRACE_ADDR so its code can be simplified to
always return the ftrace trampoline plt.

Signed-off-by: Florent Revest <revest@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/ftrace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/ftrace.c b/arch/arm64/kernel/ftrace.c
index 758436727fba..432626c866a8 100644
--- a/arch/arm64/kernel/ftrace.c
+++ b/arch/arm64/kernel/ftrace.c
@@ -195,15 +195,15 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return ftrace_modify_code(pc, 0, new, false);
 }
 
-static struct plt_entry *get_ftrace_plt(struct module *mod, unsigned long addr)
+static struct plt_entry *get_ftrace_plt(struct module *mod)
 {
 #ifdef CONFIG_ARM64_MODULE_PLTS
 	struct plt_entry *plt = mod->arch.ftrace_trampolines;
 
-	if (addr == FTRACE_ADDR)
-		return &plt[FTRACE_PLT_IDX];
-#endif
+	return &plt[FTRACE_PLT_IDX];
+#else
 	return NULL;
+#endif
 }
 
 static bool reachable_by_bl(unsigned long addr, unsigned long pc)
@@ -270,7 +270,7 @@ static bool ftrace_find_callable_addr(struct dyn_ftrace *rec,
 	if (WARN_ON(!mod))
 		return false;
 
-	plt = get_ftrace_plt(mod, *addr);
+	plt = get_ftrace_plt(mod);
 	if (!plt) {
 		pr_err("ftrace: no module PLT for %ps\n", (void *)*addr);
 		return false;
-- 
2.40.0.577.gac1e443424-goog

