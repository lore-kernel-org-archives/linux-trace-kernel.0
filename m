Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCCEB64D8
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 20 Jun 2023 16:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFTQaf (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjFTQaa (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:30 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5105100;
        Tue, 20 Jun 2023 09:30:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-25eb777c7f2so2038801a91.0;
        Tue, 20 Jun 2023 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278628; x=1689870628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyYbQyqyiVM9g5n2rww2bISilT8aqkXPzSI5XyPezvE=;
        b=FHORSIsxyB2e5F+WDg4EC5eqGqMDHRX/lCSrq734fmaj03OnYfncUtDHC0+rEc5itg
         T0ySRkaw5Z6boAkXmu1+A8kzn3lc9rAUaPB8ln8mY2IqeSJKZXVyE8/YLePNFmC6c7au
         a6aZDquzWQywL1ZaE/GpEuJhMXVAgs/R/GB+Tpi5Pg6PfvuecTkhpyz4gouA92XDuDL8
         3N/483dKBvHzWmj38JY3r9Hv82CCGYgHdsdrH8WBhtPtTO14SzpyNKmTGSVgFHVL0Y9E
         JdDSaJ6Nb/LfbAVrO1+/EJkLSMlG0b/cQGjVhEXHYj8O1xgygwG83jk7GZmjSypwBl+2
         EHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278628; x=1689870628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyYbQyqyiVM9g5n2rww2bISilT8aqkXPzSI5XyPezvE=;
        b=Gmj/VkGFQtS+V21aDkLN6qIw+kCbGa2YJwS3wOFnHEP5B3ZXoqdTAxpMaGUY1BKAfN
         PJi20lngkW3gPRnJRbLZk/48RU318Fb6/2LBudqxZsMnbNI9LQe+TcIDo7UgvrUaX92j
         jxbYp+SRIAXmcods6mS/Ne6ApIPsl7HsrufzjIlu09zivO2S1D9IVjviW4k4bQQjC0mF
         cZ4N5Q7+t+WE2jELY2q1GsPh7W5bmsP+O/SQsT6dRloTXoC3+LpKGbzbhlfrHaSwvYr1
         PyLK6U4SUEE9as1V/WkoLhFaHygALqqyWb/5rzQSaXSHy+Ymluqrl2jHNBHqf7eXaVTs
         RLdg==
X-Gm-Message-State: AC+VfDz0Nm0nonorIpZicPwhXMgBGY0Y4+M6RfXwOxSHqVh9Ao4GFt7t
        m2ZRYcl9q/BTfZmz7W4rJEw=
X-Google-Smtp-Source: ACHHUZ63HvyaITyK3ygZ01lUuHv4DyBK9nJfxvO97p1KOgIQ+IOjTIqANDMK4m87BHtFz2aIwpHyUQ==
X-Received: by 2002:a17:90a:fe8d:b0:255:b1d9:a206 with SMTP id co13-20020a17090afe8d00b00255b1d9a206mr6897606pjb.22.1687278628061;
        Tue, 20 Jun 2023 09:30:28 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:27 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 06/11] bpf: Expose symbol's respective address
Date:   Tue, 20 Jun 2023 16:30:03 +0000
Message-Id: <20230620163008.3718-7-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Since different symbols can share the same name, it is insufficient to only
expose the symbol name. It is essential to also expose the symbol address
so that users can accurately identify which one is being probed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index e4554db..17e1729 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1547,15 +1547,15 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	if (tk->symbol) {
 		*symbol = tk->symbol;
 		*probe_offset = tk->rp.kp.offset;
-		*probe_addr = 0;
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		if (kallsyms_show_value(current_cred()))
-			*probe_addr = (unsigned long)tk->rp.kp.addr;
-		else
-			*probe_addr = 0;
 	}
+
+	if (kallsyms_show_value(current_cred()))
+		*probe_addr = (unsigned long)tk->rp.kp.addr;
+	else
+		*probe_addr = 0;
 	return 0;
 }
 #endif	/* CONFIG_PERF_EVENTS */
-- 
1.8.3.1

