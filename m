Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF37CA553C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 13:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238587AbjINNLz (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238781AbjINNLm (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:11:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24D51FD8
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:11:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so2798485e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694697073; x=1695301873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RJomarRjaTtn3oATFqeS61pqk655aq9C7zKlWCyipu4=;
        b=QwlULImn/vm+b+kBqoqtJVxsCj+HpcKUTCrCTVlbAgwC3nyZfjIhiQhCu/IFkUMo2u
         ori8G1JIyt7SySCOeWp7qfX8wYGLMS6et236HC3gSG6HBGMfdGUCHUwv7EHqxPuX54A+
         QPd0TqPCDaWus2VIM9zLP6v1Ye7j5NSFCqisw54hi2ynDDBToETgiFZL3HaWU3tlQYF8
         pNOGXko5n69IrsGJuOYATy/qw2Kv2UxA3z7h04z2iDdUU27KIi1Plh/G6XaqQfWkhy1u
         ySZknfplgeZ3w+pHUrZkbN0WONjKa/tDpe82f6zE86kJSbQnu+lvHQSv2dZwX7M5rv6y
         8diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697073; x=1695301873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJomarRjaTtn3oATFqeS61pqk655aq9C7zKlWCyipu4=;
        b=kaK87C/rs75vV5+p5ZEuY9py2IU1SWE+ii7POxUoUuOdrjJEOmnEQxoAgL2F1zvIE8
         XOhFr71kQpSo3FhE6kRZEcwiz0un44s307LXIMfIwOrffuDHwhOsGt+LO3/fO3j6JSLS
         FU0Qck+Cp8L7pMoOFPYnxw6W0UZZaW9lIWPhFbWVWgfUNCcxkDXXfRGij+zDlmYiFSup
         F6p9NOklNlwqS2O41Z2VzLyR+/gHjze1dY9mfcKskpcIMxdB0n7mBT2EzAzbcxVj2Nkk
         tSF4fhCqdJQuj7spebsTtSIRwri7Zp3jwxlQ8vv0a8OyAHxpPXT5KdFQqYjOTlyX/M8x
         zHKQ==
X-Gm-Message-State: AOJu0YyPNZptdCL6Q0n4ngW3JbbiqTTDREJZDxCEL8VQd9wQ+CU+w2ni
        HDmm4I6yKBWpbDQaQDdEB7x2TUFZtPGzoZ2zzAa5KA==
X-Google-Smtp-Source: AGHT+IHtdHXK+gKFRE1SD8BCf0eWnyuZ16lDv+k6Xh9LB7lmWJfOWwJtzph6DKcNR09TpfcagYNMkA==
X-Received: by 2002:adf:fd4d:0:b0:317:3a23:4855 with SMTP id h13-20020adffd4d000000b003173a234855mr4676769wrs.2.1694697073094;
        Thu, 14 Sep 2023 06:11:13 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:999:a3a0:398c:d142:b5d1:4f7e])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d484b000000b00317ddccb0d1sm1747284wrs.24.2023.09.14.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 06:11:12 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [PATCH] tracing/user_events: align uaddr on unsigned long alignment
Date:   Thu, 14 Sep 2023 15:11:02 +0200
Message-Id: <20230914131102.179100-1-cleger@rivosinc.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
this will result in a misaligned access on 64 bits architectures since
set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
On architecture that do not support misaligned access, this will crash
the kernel. Align uaddr on unsigned long size to avoid such behavior.
This bug was found while running kselftests on RISC-V.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 kernel/trace/trace_events_user.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 6f046650e527..580c0fe4b23e 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -479,7 +479,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 				    bool fixup_fault, int *attempt)
 {
 	unsigned long uaddr = enabler->addr;
-	unsigned long *ptr;
+	unsigned long *ptr, bit_offset;
 	struct page *page;
 	void *kaddr;
 	int ret;
@@ -511,13 +511,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
 	}
 
 	kaddr = kmap_local_page(page);
+
+	bit_offset = uaddr & (sizeof(unsigned long) - 1);
+	if (bit_offset) {
+		bit_offset *= 8;
+		uaddr &= ~(sizeof(unsigned long) - 1);
+	}
 	ptr = kaddr + (uaddr & ~PAGE_MASK);
 
 	/* Update bit atomically, user tracers must be atomic as well */
 	if (enabler->event && enabler->event->status)
-		set_bit(ENABLE_BIT(enabler), ptr);
+		set_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
 	else
-		clear_bit(ENABLE_BIT(enabler), ptr);
+		clear_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
 
 	kunmap_local(kaddr);
 	unpin_user_pages_dirty_lock(&page, 1, true);
-- 
2.40.1

