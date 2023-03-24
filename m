Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0535DC6FD20
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 24 Mar 2023 17:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbjCXRPs (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjCXRPi (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:15:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165E9975F
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:15:08 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so1458938wmq.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679678100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTb8hl3+k2g5BleJPKEi21fxSb3Jo8zSKEOFv/5dzqM=;
        b=Sjs+e2MuGXM4+tmPbmahZDPk5vhmIGwM1TCJdHBvC/vfRdvIUj07fTTL5Wt/uaDaYu
         DfMJybSOkAeHgMxMvbMeNbajKEAsfOhtRrFJy8nQ9QMcHE2MtYMXpY5UHdm42LdjIudN
         vk7fz6LH3vojtLooWHY9sKvQRlThThT8omqho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTb8hl3+k2g5BleJPKEi21fxSb3Jo8zSKEOFv/5dzqM=;
        b=wR4xZMeSvFIBsOUipR0vbxpLgHV91OprZK3r/gzV8YnV9kT3QCfQOVCaNrOsEUHFNj
         xM8bvCwO5wgmlEisJ+iD6brkc1hIqABw72IolYc9VtkQDk8yNFecUlZeto/JTf+4lcNH
         MIc5QB02iZRXgL6vrAHXd1L5qekUzHLQXJ8m0kMCxuVjZ0sryWlYBIkDpM8UeSIjkn/Z
         GXG6nczDz4/Nx5DxjYSHlxhkOf2T99yJcf2JpM7U7c/jAUkphj5DzgRx7dXMiCKY86O1
         W+fIf1Z89eF5aWnI+VhmV8Z/UKHH3DLRXufjjObJIvSmV7ws/neOcsYW3qzrcGi2N8RK
         y/uw==
X-Gm-Message-State: AO0yUKXzE1koAAJp5Dp7Djju/9R+O9ktVdZlDOM9G5XHEaecoUejYS6J
        Q6SSLLhvrnj2EsFI6LaGJQ7r2Q==
X-Google-Smtp-Source: AK7set/IU3/IZnULMqGdchh7xP/nUBYFvkCopwb13gAO4K8vJUP4QfRzDq1ks8LMggPOywxWb/EIhQ==
X-Received: by 2002:a05:600c:c6:b0:3ef:df3:1693 with SMTP id u6-20020a05600c00c600b003ef0df31693mr2530391wmm.32.1679678100550;
        Fri, 24 Mar 2023 10:15:00 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:ffb1:35ba:1031:ba71])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c231a00b003dc522dd25esm5385107wmo.30.2023.03.24.10.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:15:00 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 2/4] arm64: ftrace: Simplify get_ftrace_plt
Date:   Fri, 24 Mar 2023 18:14:49 +0100
Message-Id: <20230324171451.2752302-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230324171451.2752302-1-revest@chromium.org>
References: <20230324171451.2752302-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Following recent refactorings, the get_ftrace_plt function only ever
gets called with addr = FTRACE_ADDR so its code can be simplified to
always return the ftrace trampoline plt.

Signed-off-by: Florent Revest <revest@chromium.org>
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
2.40.0.348.gf938b09366-goog

