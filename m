Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8AAC6FD1F
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  9 Mar 2023 15:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCIPH7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:07:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjCIPHk (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:07:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7E913DD2
        for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678374280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ViHH+dQMmI/KiT9ScZND3L6rVhY7uFbPCwSs6bh4wg4=;
        b=CepbBO4LiDzmR4ntZRc0RmKCSaOv21GRI73Ie8hWsfHCPpdOBwe8IFIs//zUhtBczWwK1V
        AcKIWp2nrZIlcn5QvhyKXCCUi5mGenP/eF5u5v8DBPqTdQe9sfnLCu8LUJ4N+01+lywVjr
        A+6Q7st5q2d8BxmcSVj2S9SbxJ2XLqk=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-auwTTUPjM92mDactTno-Rg-1; Thu, 09 Mar 2023 10:04:37 -0500
X-MC-Unique: auwTTUPjM92mDactTno-Rg-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-538116920c3so22154837b3.15
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:04:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViHH+dQMmI/KiT9ScZND3L6rVhY7uFbPCwSs6bh4wg4=;
        b=Kr7ZMoVIeTNVbJ8elh5+YVHopsXm6u7QNN2ePynAU3zKue4CFlo9XRIEXR3kat+pn3
         qe2suuCsS+1gUqy+P4BJHXJ+hF0BJ1V6AWtNNaCv3lrIEYyUJbweHFf+ST1PJ5Lk8MYX
         704ZvtO4v4uF275NkN3n5UoILIvLoinznHdmeFXkV6F3NQWECgKonhAjq9tBjhUvZ/Ex
         LOV6n3a/NrYPqqW63N2HJhZuDb9k9YJMe8lHtCSLGYSrIWJ1pSpzDQ7TvkOBIY4BF1S0
         ae/J58y+G9Z4n+doZr2/6bi52+DkB4qaan6/1xxFCcTOxuq+2AHeaWrUhqSxnMn15ca7
         PsWA==
X-Gm-Message-State: AO0yUKUl8mdkvxw10X6dLns6PU7QzZMET6YKaMpeTRKgUM5xVY3qgcQp
        NOPiIAi3BoH/gArGcPqKxbMGLXJwSw1qplmJlj4RUq39Q1Das74ILs8vhKHR4+fwYADdlKXBjqa
        4TzXrVbdanAsimOyYfyd+MOs1Cm/8vCnl
X-Received: by 2002:a05:7500:98b:b0:fb:265f:2db3 with SMTP id ee11-20020a057500098b00b000fb265f2db3mr594948gab.17.1678374277034;
        Thu, 09 Mar 2023 07:04:37 -0800 (PST)
X-Google-Smtp-Source: AK7set+pQojk8UkLH4FHuXMwqDYGdqTrN3D/xgZ/ik4mWw9maGzt3nu7qGUn/6mViSPnPrezV31wrA==
X-Received: by 2002:a05:7500:98b:b0:fb:265f:2db3 with SMTP id ee11-20020a057500098b00b000fb265f2db3mr594919gab.17.1678374276542;
        Thu, 09 Mar 2023 07:04:36 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e10-20020a05620a014a00b0071a02d712b0sm13722404qkn.99.2023.03.09.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:04:36 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rostedt@goodmis.org, bristot@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tracing/osnoise: set several trace_osnoise.c variables storage-class-specifier to static
Date:   Thu,  9 Mar 2023 10:04:14 -0500
Message-Id: <20230309150414.4036764-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

smatch reports several similar warnings
kernel/trace/trace_osnoise.c:220:1: warning:
  symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:243:1: warning:
  symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:335:14: warning:
  symbol 'interface_lock' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:2242:5: warning:
  symbol 'timerlat_min_period' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:2243:5: warning:
  symbol 'timerlat_max_period' was not declared. Should it be static?

These variables are only used in trace_osnoise.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f68ca1e6460f..cf395d2e8775 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -217,7 +217,7 @@ struct osnoise_variables {
 /*
  * Per-cpu runtime information.
  */
-DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
 
 /*
  * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
@@ -240,7 +240,7 @@ struct timerlat_variables {
 	u64			count;
 };
 
-DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
@@ -332,7 +332,7 @@ struct timerlat_sample {
 /*
  * Protect the interface.
  */
-struct mutex interface_lock;
+static struct mutex interface_lock;
 
 /*
  * Tracer data.
@@ -2239,8 +2239,8 @@ static struct trace_min_max_param osnoise_print_stack = {
 /*
  * osnoise/timerlat_period: min 100 us, max 1 s
  */
-u64 timerlat_min_period = 100;
-u64 timerlat_max_period = 1000000;
+static u64 timerlat_min_period = 100;
+static u64 timerlat_max_period = 1000000;
 static struct trace_min_max_param timerlat_period = {
 	.lock	= &interface_lock,
 	.val	= &osnoise_data.timerlat_period,
-- 
2.27.0

