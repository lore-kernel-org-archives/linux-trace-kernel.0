Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8FC6FD1C
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 11 Mar 2023 13:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjCKNwM (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 11 Mar 2023 08:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjCKNwL (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D2B121436
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678542678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NJ0Bmh3QpR71VfAXbH6zJND/zwnfiw4+lhOdGrMJTe8=;
        b=gFztCv1bNiiOso9XAoTXRCHaZ5s3Ny/11W1YuKmF9ge+ceYdzppMS8PjPO2e0EojIzu0cd
        79+aQhjJBaMLco3CkYUf+jdHKNbh/DO3p9HtXptc+YgqAThXV2/++WjH42V2lmiO1HcsXL
        9yMJA2Utxt3Gno2H7hO/eGzQNG5i57I=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-YYM3zPohOLOX3jg0MwGdeg-1; Sat, 11 Mar 2023 08:51:17 -0500
X-MC-Unique: YYM3zPohOLOX3jg0MwGdeg-1
Received: by mail-qk1-f199.google.com with SMTP id pc36-20020a05620a842400b00742c715894bso4560084qkn.21
        for <linux-trace-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ0Bmh3QpR71VfAXbH6zJND/zwnfiw4+lhOdGrMJTe8=;
        b=LribPoR5eh1LCpzCLVEq1L/oocvfJpW9Ow5JYpcnMwxnBX4/U0UJztfpvC1Mj8QleX
         bD6V0pIKeBFuhqT88L8fr6X/7COFVx5mPLr11JAb5aGpC5Q5wDalv4iRUHj1q2aqC/ji
         WVWXsG5TrPQIc2M51fb7ht7BA6wpUlJ4uGgCRJnR6G6P+J3klxq3LYLEFT6QOVZuOyQs
         Oh5b/fN6AFInY+yajUj+uNuQfAbDg9Z3MjhJUHGja1peKGyWaLqqdHW9DGu6oQDPgou4
         tXHXmHdDflqvhVfp8qhCCka3KOlZv/plwQwBcHS5DRcVf3KfvM5ItC29GywAuWyks52X
         mY4g==
X-Gm-Message-State: AO0yUKVU/7XgHER/YnyFAbgPfFttCcGdlRz9pK+Trq3XI/Xabhy00zqJ
        8GwzWZrWZCOgqceZiqB3EPyrivvQZOWnlDJUtJhxj3+UHX+SBvcXbzo4+vKfD0vPbDNi0YVypbK
        VsCAckqILrsFt2Ja9z0WzTA8vLRCSWCRh
X-Received: by 2002:ac8:5812:0:b0:3bf:d4dc:7058 with SMTP id g18-20020ac85812000000b003bfd4dc7058mr50196266qtg.11.1678542676978;
        Sat, 11 Mar 2023 05:51:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9lLnjrFgLGllezeYDec5YUFS01Mn9vN9iAmu8uD7oGadaM7RIjfAipVilkNFU7+sRp+uEwuA==
X-Received: by 2002:ac8:5812:0:b0:3bf:d4dc:7058 with SMTP id g18-20020ac85812000000b003bfd4dc7058mr50196250qtg.11.1678542676763;
        Sat, 11 Mar 2023 05:51:16 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p12-20020ac8740c000000b003afbf704c7csm1943823qtq.24.2023.03.11.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:51:16 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ftrace: set direct_ops storage-class-specifier to static
Date:   Sat, 11 Mar 2023 08:51:13 -0500
Message-Id: <20230311135113.711824-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

smatch reports this warning
kernel/trace/ftrace.c:2594:19: warning:
  symbol 'direct_ops' was not declared. Should it be static?

The variable direct_ops is only used in ftrace.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..05f76dc1f0c5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2591,7 +2591,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 	arch_ftrace_set_direct_caller(fregs, addr);
 }
 
-struct ftrace_ops direct_ops = {
+static struct ftrace_ops direct_ops = {
 	.func		= call_direct_funcs,
 	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
-- 
2.27.0

