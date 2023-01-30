Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937EDC54EAA
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 30 Jan 2023 19:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjA3TiD (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 30 Jan 2023 14:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238199AbjA3TiB (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4340938EAD
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675107435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iRSQN5/L7bEE3ed7pm8jn+u620qpw2qg0aSU5e5+V5A=;
        b=CaeqmKAsO3l49gJt02y59HBcnN2mJBnF8gHba18deirO2tERZTpnrS7QTfPdHZjGhX52sz
        wJr7dwp9xEfDAcv6DO+EbHlVV+UzObIS/4PXXCGx96KthM77Mpe+ZgR01Rg7KkNdZFxgT9
        Su1iNUhmfmytYiDXCeaATY08lt2S/f4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-518-9pWAF2mMNae72KPtl0lCkw-1; Mon, 30 Jan 2023 14:37:14 -0500
X-MC-Unique: 9pWAF2mMNae72KPtl0lCkw-1
Received: by mail-qk1-f198.google.com with SMTP id de37-20020a05620a372500b00707391077b4so7681334qkb.17
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRSQN5/L7bEE3ed7pm8jn+u620qpw2qg0aSU5e5+V5A=;
        b=TBU4Ysnh4t4n5RXJ9jolStHtFqp4ndAv6XzEDLloxb00Oj6F7ruRyw8ZYG5bNB6IeD
         9gsqFXwLGIcmDOvm8Q9jfCc2xs7zfjPJF80ZmHdQAavV3meL1X+biaC75U2RIAS6HUWV
         RLlh8hfpq6web+HzHZtUWH2V17m7pF3mg2M4bONgCtL62I0wxEYq1M2t9ZS50PEIKt0M
         MykSj0MwQ5PMZlJLDguNQM899s48YWbhg1tbFsexhB2KewRon/fI6HhpAlX/PQSYSFHM
         MseF9hi1He0iHKh9/15LkFpYqV+yxajRhiH97i4cT48VfKpH3ZrAPF9dlesNHoEB4wbe
         Q6kQ==
X-Gm-Message-State: AO0yUKUh3f1cS1PYVulO0FL3kiKMGwgHd/n8G6VJTo/1sjX6qzl3iRaq
        t4wPRmLun/hz129YXHrHU0HhUCmouGpPQZHbIW++HO/M8XadaTJHtFwl8Zmm5bRCDyS9EWEeHK2
        q7pYwQlMvOv0DreO9l1h8/P20WOidl4QL
X-Received: by 2002:a05:622a:1008:b0:3b8:73c:15e6 with SMTP id d8-20020a05622a100800b003b8073c15e6mr37046135qte.18.1675107433503;
        Mon, 30 Jan 2023 11:37:13 -0800 (PST)
X-Google-Smtp-Source: AK7set9hTwciE89kW9G1USpz2AsDZXlnJeMZKGsvliD+KAOUZgbUQkV5hSbiU+q0+ZII6t+TWLarzA==
X-Received: by 2002:a05:622a:1008:b0:3b8:73c:15e6 with SMTP id d8-20020a05622a100800b003b8073c15e6mr37046108qte.18.1675107433234;
        Mon, 30 Jan 2023 11:37:13 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id p64-20020a374243000000b006ee8874f5fasm8499120qka.53.2023.01.30.11.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:37:12 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] samples: ftrace: make some global variables static
Date:   Mon, 30 Jan 2023 11:37:08 -0800
Message-Id: <20230130193708.1378108-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

smatch reports this representative issue
samples/ftrace/ftrace-ops.c:15:14: warning: symbol 'nr_function_calls' was not declared. Should it be static?

The nr_functions_calls and several other global variables are only
used in ftrace-ops.c, so they should be static.
Remove the instances of initializing static int to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 samples/ftrace/ftrace-ops.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/samples/ftrace/ftrace-ops.c b/samples/ftrace/ftrace-ops.c
index 24deb51c7261..5e891a995dd3 100644
--- a/samples/ftrace/ftrace-ops.c
+++ b/samples/ftrace/ftrace-ops.c
@@ -12,7 +12,7 @@
  * Arbitrary large value chosen to be sufficiently large to minimize noise but
  * sufficiently small to complete quickly.
  */
-unsigned int nr_function_calls = 100000;
+static unsigned int nr_function_calls = 100000;
 module_param(nr_function_calls, uint, 0);
 MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee");
 
@@ -21,7 +21,7 @@ MODULE_PARM_DESC(nr_function_calls, "How many times to call the relevant tracee"
  * be called directly or whether it's necessary to go via the list func, which
  * can be significantly more expensive.
  */
-unsigned int nr_ops_relevant = 1;
+static unsigned int nr_ops_relevant = 1;
 module_param(nr_ops_relevant, uint, 0);
 MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the relevant tracee");
 
@@ -30,7 +30,7 @@ MODULE_PARM_DESC(nr_ops_relevant, "How many ftrace_ops to associate with the rel
  * tracers enabled for distinct functions can force the use of the list func
  * and incur overhead for all call sites.
  */
-unsigned int nr_ops_irrelevant = 0;
+static unsigned int nr_ops_irrelevant;
 module_param(nr_ops_irrelevant, uint, 0);
 MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the irrelevant tracee");
 
@@ -38,15 +38,15 @@ MODULE_PARM_DESC(nr_ops_irrelevant, "How many ftrace_ops to associate with the i
  * On architectures with DYNAMIC_FTRACE_WITH_REGS, saving the full pt_regs can
  * be more expensive than only saving the minimal necessary regs.
  */
-bool save_regs = false;
+static bool save_regs;
 module_param(save_regs, bool, 0);
 MODULE_PARM_DESC(save_regs, "Register ops with FTRACE_OPS_FL_SAVE_REGS (save all registers in the trampoline)");
 
-bool assist_recursion = false;
+static bool assist_recursion;
 module_param(assist_recursion, bool, 0);
 MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RECURSION");
 
-bool assist_rcu = false;
+static bool assist_rcu;
 module_param(assist_rcu, bool, 0);
 MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
 
@@ -55,7 +55,7 @@ MODULE_PARM_DESC(assist_reursion, "Register ops with FTRACE_OPS_FL_RCU");
  * overhead. Sometimes a consistency check using a more expensive tracer is
  * desireable.
  */
-bool check_count = false;
+static bool check_count;
 module_param(check_count, bool, 0);
 MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number of times\n");
 
@@ -64,7 +64,7 @@ MODULE_PARM_DESC(check_count, "Check that tracers are called the expected number
  * runs, but sometimes it can be useful to leave them registered so that they
  * can be inspected through the tracefs 'enabled_functions' file.
  */
-bool persist = false;
+static bool persist;
 module_param(persist, bool, 0);
 MODULE_PARM_DESC(persist, "Successfully load module and leave ftrace ops registered after test completes\n");
 
@@ -114,8 +114,8 @@ static void ops_func_count(unsigned long ip, unsigned long parent_ip,
 	self->count++;
 }
 
-struct sample_ops *ops_relevant;
-struct sample_ops *ops_irrelevant;
+static struct sample_ops *ops_relevant;
+static struct sample_ops *ops_irrelevant;
 
 static struct sample_ops *ops_alloc_init(void *tracee, ftrace_func_t func,
 					 unsigned long flags, int nr)
@@ -163,8 +163,8 @@ static void ops_check(struct sample_ops *ops, int nr,
 	}
 }
 
-ftrace_func_t tracer_relevant = ops_func_nop;
-ftrace_func_t tracer_irrelevant = ops_func_nop;
+static ftrace_func_t tracer_relevant = ops_func_nop;
+static ftrace_func_t tracer_irrelevant = ops_func_nop;
 
 static int __init ftrace_ops_sample_init(void)
 {
-- 
2.26.3

