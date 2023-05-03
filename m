Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0ECC77B75
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  3 May 2023 14:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjECOCH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 3 May 2023 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjECOCG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BA85FC9
        for <linux-trace-kernel@vger.kernel.org>; Wed,  3 May 2023 07:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683122478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Il2Tq+zS33ksY9INyL3IhsljNXln+sovSvsBut32DE=;
        b=TfryoDBdJ5bxcvSPpSpLhgGHqmfzSYP/SZH/9SfFlkxIGkAynH+jJEHpwCLVMISdaN1Rna
        j9DOlZHRVKgsoNHXWGtsyLvvU+lK3v1sw+Bxpx00ztSONSi2R6vKP+W4IncOdvYUjIjBOq
        Iph049Sep+n7gAdMJLq5wBs2LFLWrG0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-gcDtzzbgPaapbcopztTvKg-1; Wed, 03 May 2023 10:01:17 -0400
X-MC-Unique: gcDtzzbgPaapbcopztTvKg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-953429dac27so468676066b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 May 2023 07:01:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683122476; x=1685714476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Il2Tq+zS33ksY9INyL3IhsljNXln+sovSvsBut32DE=;
        b=CO6zb2oO+00hdnThtQRDGXLCYFNjNpJbLNU+Ias7UPNegDDYVR0Fw+U2qZNFUTalkc
         J8pv1+ITc9NiE5jpmxRCORl1xRQIv4TLk6a2OdkJuZQ9oTKR1SQYnzxRmos4+7fcnfj4
         ScG7PA5ke9VszymwZxqwjXvY3OR8zCIaEBRUHbnUrjhsVzbnh9aQ3f8Q4nRXSBdiRBmF
         UOejmz39MteNoCCOjjynRWE3RxihG59o95KKynztdQCoI38XNcHXFzHqXtzJ95NPuJ5E
         2IJtH9MRclNcBkuu4hYxlKWd/fFxRttMSQPlB9HTTjh3LldVQJgtIFOS20L2jsge41Et
         brhw==
X-Gm-Message-State: AC+VfDysjRiUPJe4zGExsnn5d/Eu2K2F96RGTlujaaxiYeImfbn/EEFd
        ku14bz9BQ7BQX6HTSj7YwehvvRpQDPz0HLC7JDYn5wtlvkB2cTyFPcqkMcLiPHXgyaLKtAm1N3+
        Zy44AFMFXhUTAAhHh7sXq9WxyNL06AS+g
X-Received: by 2002:a17:907:daa:b0:94f:3eec:f6b5 with SMTP id go42-20020a1709070daa00b0094f3eecf6b5mr3366049ejc.57.1683122476183;
        Wed, 03 May 2023 07:01:16 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VGaXLvHuYIGWrNA1RjvkxhdE9GKsPgniiA5ySFOrm4GhYLdn+pfujLnUmJ0M1BEq8eVZZ4Q==
X-Received: by 2002:a17:907:daa:b0:94f:3eec:f6b5 with SMTP id go42-20020a1709070daa00b0094f3eecf6b5mr3366020ejc.57.1683122475887;
        Wed, 03 May 2023 07:01:15 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id re4-20020a170906d8c400b0094a82a236cbsm17196221ejb.129.2023.05.03.07.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 07:01:15 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix permissions for the buffer_percent file
Date:   Wed,  3 May 2023 16:01:14 +0200
Message-Id: <20230503140114.3280002-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This file defines both read and write operations, yet it is being
created as read-only. This means that it can't be written to without the
CAP_DAC_OVERRIDE capability. Fix the permissions to allow root to write
to it without the need to override DAC perms.

Fixes: 03329f993978 ("tracing: Add tracefs file buffer_percentage")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 45551c7b4c365..e278f4202a7ed 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9655,7 +9655,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 
 	tr->buffer_percent = 50;
 
-	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
+	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
 	create_trace_options_dir(tr);
-- 
2.40.1

