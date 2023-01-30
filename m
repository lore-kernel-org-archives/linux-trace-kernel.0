Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB666C61D97
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 30 Jan 2023 18:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbjA3SUK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbjA3STw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:19:52 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAE338E81
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:47 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z2so4911344ilq.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Zzfg2bQz7c4Lu8nEbe0ztijhF1MDO6gwSQkkAUdaXs=;
        b=dmwVKpndVGSPOlMA/VgslRy1ADofot5yp07aOLyY9jXTSZcsSneVlwFSDFj0CE5724
         oI/cyicC+vcD2yb/HjemHEX5yLv5dEBWoEL3jle5pKfIh0+mwcKT9uIb12rZGMz4s4SU
         E3EM3F019eEjjTS1fosUInp5XbLpSSmqRMmi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Zzfg2bQz7c4Lu8nEbe0ztijhF1MDO6gwSQkkAUdaXs=;
        b=BrFyk/zQGbPso6nKhsoZLe8EHT7/5cAG9RoN0LqQ9B5eolbcsYrDR95b7/dKtM/ZP5
         8nohtUPBKqyGIBIqI1RIP/J4VJ3Vlejl6zCgWXgButzsUEg13byuGnWeDIOY8bYFV6eb
         RF97Zo2M2hHGZwWYTKk2x4G2M21rlU2lKEQhbwKe5HtwUB5/APycZ9jqaJk2LOxxGGFq
         JhUfCY07KPvlxTavDgTJjC2ocTBvS36/jtHMxw6/O6tdEfQEKbepfYXxGGb0VxyU654H
         3gFloNnDrca7RUL5D0Dt9pxrCXo+A9wJHl6bvqqRXpCcz9240uVX/1BfpUkPPFDNc1OM
         5DZA==
X-Gm-Message-State: AO0yUKV/JGgiDk+nmWgib7I2GEFegf/mWhfwOHlyeTLd7ycFXwtw4z7K
        nlnbydIziBOAcfp0NTf5WQgAIg==
X-Google-Smtp-Source: AK7set+ky9CHQsy21ct37ZLpWjENrtFy5wpnLexQn1n3RC31YGc9290nOHzz+0kP9SR0o/XTPU1x7Q==
X-Received: by 2002:a05:6e02:144c:b0:311:478:f273 with SMTP id p12-20020a056e02144c00b003110478f273mr1692297ilo.11.1675102787162;
        Mon, 30 Jan 2023 10:19:47 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:fc8a:dd2f:5914:df14])
        by smtp.gmail.com with ESMTPSA id o16-20020a056e02115000b002f139ba4135sm4189801ill.86.2023.01.30.10.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:19:46 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH 9/9] tools/kvm_stat: use canonical ftrace path
Date:   Mon, 30 Jan 2023 11:19:15 -0700
Message-Id: <20230130181915.1113313-10-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
In-Reply-To: <20230130181915.1113313-1-zwisler@google.com>
References: <20230130181915.1113313-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A comment in kvm_stat still refers to this older debugfs path, so let's
update it to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/kvm/kvm_stat/kvm_stat | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/kvm/kvm_stat/kvm_stat b/tools/kvm/kvm_stat/kvm_stat
index 6f28180ffeea..15bf00e79e3f 100755
--- a/tools/kvm/kvm_stat/kvm_stat
+++ b/tools/kvm/kvm_stat/kvm_stat
@@ -627,7 +627,7 @@ class TracepointProvider(Provider):
         name)'.
 
         All available events have directories under
-        /sys/kernel/debug/tracing/events/ which export information
+        /sys/kernel/tracing/events/ which export information
         about the specific event. Therefore, listing the dirs gives us
         a list of all available events.
 
-- 
2.39.1.456.gfc5497dd1b-goog

