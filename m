Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E476C7619A
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Apr 2023 18:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjDESEL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjDESEB (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:04:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720CD72AE
        for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:03:14 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so18934117wmq.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680717779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nCRr5H3+UuYPyZozTZ61KEaaCsnzGj0McQyaAuLox6Y=;
        b=VRGLF6jYpqlAUjlImbNGc9MAbL+CwYzIVyjcpCvSfXD6sQX9PKy+4myAOoc4WbAbkW
         D+KltU67z9hJ+/GOxp6DrjoYihchae67PJR3xjST8iAKcNjCodZ15EgPWNvXbCCblr5b
         zYr2eOXongK1hoZvSmIoEoGWnCFuVT/ZDbl1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nCRr5H3+UuYPyZozTZ61KEaaCsnzGj0McQyaAuLox6Y=;
        b=yANq9cUVLEa+fyVOqQAqSdZblz6fduswGo+uzT7TezjImv5+rPb3wfiHSm5xN3JHGt
         sUgNVwu2Vtl1rBekmIzrhFzWxVXVeSpuaNNJi+mQBMBbYYwlG56wpzhdYaZ+Z6IkMmRh
         lUHmA4HISEYFsGRWwE0ZoEaKC8EF+zAC572SchukVBJG0oKUb95XGqYKr2ZW/HMhWSye
         Q40cLT5mlNeRRQQIJBRlR2pW/cj9ZAIJ/t8CCXVJP7DQCMthsEP6M5AJqMIbVyjv2+/1
         vtCIoqIl4v/wFhzLhsH0OqK+/5rdFnY/gLnkhxRWeEqmavMIw530j6rSeI09ZmWehmOk
         0a8Q==
X-Gm-Message-State: AAQBX9cKQrsvVhLYhT2lPO2pFfh93aRtVPHUsFJ6frXqo+3gJLpnFYvh
        RMPyypPEY623cRkvQAOekQwN7zq9E1RP34K40w0=
X-Google-Smtp-Source: AKy350bceighfDjd/DZgGBjsH+Kb8HCWWBPSbtjJxKcBSXp/7bD2cQK/+06fC/OP05iTqgJ5Bh0azg==
X-Received: by 2002:a7b:cc98:0:b0:3ed:8079:27d7 with SMTP id p24-20020a7bcc98000000b003ed807927d7mr5232746wma.40.1680717778801;
        Wed, 05 Apr 2023 11:02:58 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:cf6a:9ae6:15f1:4213])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b003f0472ffc7csm2913233wmb.11.2023.04.05.11.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:02:58 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v6 3/5] samples: ftrace: Save required argument registers in sample trampolines
Date:   Wed,  5 Apr 2023 20:02:48 +0200
Message-Id: <20230405180250.2046566-4-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
In-Reply-To: <20230405180250.2046566-1-revest@chromium.org>
References: <20230405180250.2046566-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The ftrace-direct-too sample traces the handle_mm_fault function whose
signature changed since the introduction of the sample. Since:
commit bce617edecad ("mm: do page fault accounting in handle_mm_fault")
handle_mm_fault now has 4 arguments. Therefore, the sample trampoline
should save 4 argument registers.

s390 saves all argument registers already so it does not need a change
but x86_64 needs an extra push and pop.

This also evolves the signature of the tracing function to make it
mirror the signature of the traced function.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 samples/ftrace/ftrace-direct-too.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/samples/ftrace/ftrace-direct-too.c b/samples/ftrace/ftrace-direct-too.c
index f28e7b99840f..71ed4ee8cb4a 100644
--- a/samples/ftrace/ftrace-direct-too.c
+++ b/samples/ftrace/ftrace-direct-too.c
@@ -5,14 +5,14 @@
 #include <linux/ftrace.h>
 #include <asm/asm-offsets.h>
 
-extern void my_direct_func(struct vm_area_struct *vma,
-			   unsigned long address, unsigned int flags);
+extern void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+			   unsigned int flags, struct pt_regs *regs);
 
-void my_direct_func(struct vm_area_struct *vma,
-			unsigned long address, unsigned int flags)
+void my_direct_func(struct vm_area_struct *vma, unsigned long address,
+		    unsigned int flags, struct pt_regs *regs)
 {
-	trace_printk("handle mm fault vma=%p address=%lx flags=%x\n",
-		     vma, address, flags);
+	trace_printk("handle mm fault vma=%p address=%lx flags=%x regs=%p\n",
+		     vma, address, flags, regs);
 }
 
 extern void my_tramp(void *);
@@ -34,7 +34,9 @@ asm (
 "	pushq %rdi\n"
 "	pushq %rsi\n"
 "	pushq %rdx\n"
+"	pushq %rcx\n"
 "	call my_direct_func\n"
+"	popq %rcx\n"
 "	popq %rdx\n"
 "	popq %rsi\n"
 "	popq %rdi\n"
-- 
2.40.0.577.gac1e443424-goog

