Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1705FEB64D8
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 20 Jun 2023 16:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjFTQad (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjFTQa1 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:27 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39361737;
        Tue, 20 Jun 2023 09:30:26 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-39ecf031271so2020305b6e.1;
        Tue, 20 Jun 2023 09:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278626; x=1689870626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv+tPT5eAlvNoQ80V3EmyTwHswl30O9kG2EfoBAZWRg=;
        b=RV+EXQdU/oXDko6hZobrCco4399gIgixyQa4wQbLrtpu/iqbbdDfZh1n58Obp9EjPy
         1hmDiI8YaP7XbGurd4mIMZvLUOl/cL/S61Uive6F9Br7KNJLnnKOY0v5W4u11FhKwRe3
         2v4t+v66FwgC5ChwUC5C7VyMwOAC6o6ZkDwQoGWsw80PdS3n03uaniK+JvY8HWFpIy6b
         9ueyAJhoY3Nlr+TXtDBLrhL+3KNay0V0CbvfyFz6lhRO4dmLGYHGc+bidQ0+3zTTn8Vl
         kFBRSFt/2URNyl60Fvzqw+7DGfJSqg7D0rTdfMTAIU8VbEkxWPEOM3hrGamQVfu4EQBZ
         tQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278626; x=1689870626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv+tPT5eAlvNoQ80V3EmyTwHswl30O9kG2EfoBAZWRg=;
        b=jlY5zq0JjF7A9ajPTC3I0NkgEyjd59F2DCgoHpQ7Bs9po6qkFru9lDBfcSV58iTods
         BN4mUa0VDDqBekUfmYre6W++C/lWQPskAd6a9TRqWUNDl+MNwKgQa6zTiw9bodrZ0UGW
         hr8AbsMjjjrgSV1UnUQ9feToG+Wd+JvC2musKQonc98lNLQIIqW/O1TEHTtgYo9XmbJN
         Ys0sZrHQDNPqZJA760ZGzdg7d61dVNGQv86QReEFYJBQxOQp9iblxSVtYmIRLLiNZ0As
         LI2tKx0A1i1R6beswpiGO0F/V08MjQnrEr5Y8At601Xgp/U3h2O/fhL+E4t6ZnUug87m
         +t0g==
X-Gm-Message-State: AC+VfDyEXC6IECCFn4VoUK/YAghFUI17lI5uYiRNQmiVZSrw5sAbb8GR
        ZRknFtL0DOVuPP0Us9rr4DQ=
X-Google-Smtp-Source: ACHHUZ4ZVWukC2718oZGTXeSBiYqDs+ZdjHVdhztfSqIZZ/6d1v9m2SCov33eQHLJLWLESJA1y/g6g==
X-Received: by 2002:a05:6808:614:b0:3a0:3623:11f with SMTP id y20-20020a056808061400b003a03623011fmr3400802oih.21.1687278626052;
        Tue, 20 Jun 2023 09:30:26 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:25 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
Date:   Tue, 20 Jun 2023 16:30:02 +0000
Message-Id: <20230620163008.3718-6-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

To avoid returning uninitialized or random values when querying the file
descriptor (fd) and accessing probe_addr, it is necessary to clear the
variable prior to its use.

Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 kernel/trace/bpf_trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2123197b..45ee111 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2372,10 +2372,12 @@ int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
-		if (flags & TRACE_EVENT_FL_UPROBE)
+		if (flags & TRACE_EVENT_FL_UPROBE) {
 			err = bpf_get_uprobe_info(event, fd_type, buf,
 						  probe_offset,
 						  event->attr.type == PERF_TYPE_TRACEPOINT);
+			*probe_addr = 0x0;
+		}
 #endif
 	}
 
-- 
1.8.3.1

