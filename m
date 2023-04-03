Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3909EC77B6D
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  3 Apr 2023 11:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjDCLVe (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 3 Apr 2023 07:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjDCLVb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 07:21:31 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD910A81
        for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Apr 2023 04:21:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t4so23719404wra.7
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Apr 2023 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680520884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccD+WMcpnfxpdEJ20qi2WQ3yxV21AzFl62yMric/kQs=;
        b=AhCYV+eMAiRqkEFIZZCxRh4GXN58tf1TxfTeDHp19jbjkX2YxBnH2QpPjJ0HIdm9JO
         iyvZrNh2wwTauil0fQm6Z9HWXCNltVm/t/kIS+JflHqXsrPYZ1wpHxw1Fxlecvla2dcW
         puXX87gZylWHxocfXtFSOPP+SFLvn3aPHhy3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680520884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccD+WMcpnfxpdEJ20qi2WQ3yxV21AzFl62yMric/kQs=;
        b=zSvy1ij5X2znQFC3ZjiVIHs/t26RAzADQFR9+bwiXjzoWq8bQ25qmrQDEjWno9pGmo
         M5a73BuuS2xlvHvrthMzyv53fA0b34Ja91hSD9Uh++jjaf6Ig8Zrr4OMznvjKN/MH3+0
         UkuEesL5kx2nYITWp0rKjmXC8X06vafxi8/aieRIkRXnixeQ/ZamWCOkRWOHDlHFmni0
         lJORR7zaEhpSXXaief3zMYFBlyHEaUosuroPvmS+rMDW9o2/VEByQ5IIAkw3fstMKJP2
         bnaBg7iVl058YM3NUJ7Z4XS2VOThXV8yQzxnQzZaHxP0WYO0Z11KqXdThQn4czVwt4RT
         0BKQ==
X-Gm-Message-State: AAQBX9cIVfegZJqFyiw62aH8k0IMVeDEdN/mipNeqZ2UaxkzQX8ng/AU
        p2yZUO/XURifK4oHEzzs4+403Q==
X-Google-Smtp-Source: AKy350Zgv+BnOKwyxEwke4yedmRdckQgXNSpQ+JtjC4hDbJ8wkdJo2VCOh4gPSxeHI+ho5KDR3RkZg==
X-Received: by 2002:a5d:6602:0:b0:2ce:a098:c6b8 with SMTP id n2-20020a5d6602000000b002cea098c6b8mr25905426wru.55.1680520884478;
        Mon, 03 Apr 2023 04:21:24 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:b5a2:4ffd:8524:ac1])
        by smtp.gmail.com with ESMTPSA id u13-20020adfeb4d000000b002daeb108304sm9510031wrn.33.2023.04.03.04.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 04:21:24 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v4 2/4] arm64: ftrace: Simplify get_ftrace_plt
Date:   Mon,  3 Apr 2023 13:20:57 +0200
Message-Id: <20230403112059.2749695-3-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.423.gd6c402a77b-goog
In-Reply-To: <20230403112059.2749695-1-revest@chromium.org>
References: <20230403112059.2749695-1-revest@chromium.org>
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
2.40.0.423.gd6c402a77b-goog

