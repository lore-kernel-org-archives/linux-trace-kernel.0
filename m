Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CAEC77B73
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 25 May 2023 05:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjEYFkl (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 25 May 2023 01:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEYFkl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 25 May 2023 01:40:41 -0400
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F9BA1;
        Wed, 24 May 2023 22:40:39 -0700 (PDT)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1353972b3a.0;
        Wed, 24 May 2023 22:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684993239; x=1687585239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUK+1sZwH5x1POWo13nOYhiz5YcV3CrJGvFKdHODSKo=;
        b=P5aPmgayiHAnMuvWbYhQE0mpZpyB81ISHO6aQPuDxUeQWKGsmzcHF9zzHTaGz9Ba6l
         OmZQ4Tb3LSxaFKFFNrfQPR/gBddy3EPcPLk14iBLtbpLa00Iejm1iU851FGMbEeuFf+2
         nU63CN2WgLbu1IVgB8k2lkkWv2CvD7ueWSJrbuSIuEcfOrqT4dkmonxFej32AlRF40u5
         l5JnwUtv1qAzhKSnvFfrtUn3rO9YXg9ySz3JwmrXUZ4HRS3/6SVyDMkMvy6uQIyMvmXG
         Xx2mwYR7fmEOb1TsEsue4JVqwS26wAmoAIS4wP2VSI8jvQNCI6tcf7gmgBDEZQy0U58O
         a9Sg==
X-Gm-Message-State: AC+VfDxc1pG8Yluish1XQ4QpvUuWxNHi60PNzKpsO8HafHwi4P2cI4xI
        yO6cwqen2T+xjxqqh9jcDg==
X-Google-Smtp-Source: ACHHUZ6uyACOdfWrTJazLeuZey8MxnQsdqH4Yg8rdw+RboEE9NQkTu0PW+BYUJ0O+3A7zpcRIryqhA==
X-Received: by 2002:aa7:88d0:0:b0:63b:854e:8459 with SMTP id k16-20020aa788d0000000b0063b854e8459mr6626319pff.31.1684993238570;
        Wed, 24 May 2023 22:40:38 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id l11-20020a62be0b000000b0064dbf805ff7sm364200pff.72.2023.05.24.22.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 22:40:38 -0700 (PDT)
From:   sunliming <sunliming@kylinos.cn>
To:     mhiramat@kernel.org, rostedt@goodmis.org, beaub@linux.microsoft.com
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelulanainsley@gmail.com, sunliming <sunliming@kylinos.cn>
Subject: [PATCH] tracing/user_events: Fix the order of the fields in the trace output
Date:   Thu, 25 May 2023 13:40:32 +0800
Message-Id: <20230525054032.29392-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Commit 4bec284cc0b9 ("tracing/user_events: Use print_format_fields() for
trace output") use print_event_fields() as safe and gives user readable
output. However, due to the insertion of the struct ftrace_event_field
structure into the field linked list from the header, the trace output
oder of fields of user events is reversed. Fix the problem by insertint
to the tail of field linked list.

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 kernel/trace/trace_events_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index aacd22c1e9f8..e9e2ec3c7613 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -972,7 +972,7 @@ static int user_event_add_field(struct user_event *user, const char *type,
 	if (filter_type == FILTER_OTHER)
 		field->filter_type = filter_assign_type(type);
 
-	list_add(&field->link, &user->fields);
+	list_add_tail(&field->link, &user->fields);
 
 	/*
 	 * Min size from user writes that are required, this does not include
-- 
2.25.1

