Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51025C001B3
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 23 Jun 2023 14:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFWOQ1 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 23 Jun 2023 10:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbjFWOQZ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:16:25 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41622133;
        Fri, 23 Jun 2023 07:16:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-6685421cdb3so1314679b3a.1;
        Fri, 23 Jun 2023 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687529782; x=1690121782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzAEwWz2g31UMs4g4MUixj1iNbtJ/dM5TZGhqlQXR9c=;
        b=Du4qFBhVRDavQkjSfw1UhiKH87F0Og4EJXGDRJA8147dzuQf81Hrb1r0iSbe3Zcqob
         DUpB5PGz+8H5VIelumpfCsw1s+76Kh1xcvuJLz7HdhKGOuvBkm3Tb5XFwUPjaY3TsYOz
         cNDD0ugNByKP6tU1VyGXddf2TShai1657KLml4Qwk1nHJQWgVG438k4bypP7NmZKSEP+
         u9hXgIGa0dvpKtXZYC2z62p7YIExGRi56bU2aHwulqlQnsmkoCs6GYgwTqF1IDGjrI0e
         wBEap7C6AX/XGu/EbUoMgbzKy1eqMe4oRt50FVtT5y081LQGHdWJSKYmjLigvjyh6JSw
         qdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687529782; x=1690121782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzAEwWz2g31UMs4g4MUixj1iNbtJ/dM5TZGhqlQXR9c=;
        b=doqAwBR1olxlHi//nHooGKZkLXF5lWYKRurM8KC2/2KinlVfdJQ01eyWAEYh+deWm/
         CD9c7QnWn55xxmP1YdVbnmaftm00Bcas32UNfLlyICRgIAWRDKMvdkTy/f778hCAvi2m
         r2xPXvTfqbRcCMkWBpX4x6DCV43pHfvY2JXfSasQSjDBlyS+20U9p7fbPujkDZ5U2KkM
         T8s+8n9K9BgP42+0V2eFN2/suommcarh+usUkZOaubnWWB9yMLggyGXfAW5WA9FhQtTI
         j2o/D58MG1UkPn26fxYug1/Ms0rtmFKHQLTnJtKChWaalL7RLkDz/YThehEW1TXHCBhN
         TLgA==
X-Gm-Message-State: AC+VfDzRGMnYMaK9NrTEug6Z2qgTktQLMzOn57b7womhQu91l64Pa+3W
        94JyHAU4SYiwofGtDGUbWSs=
X-Google-Smtp-Source: ACHHUZ55e8bjY7iXV2b6JkCIfWVjUPItrlMUjZIkfG+VE9WwjS2G3DTM5c5W7wEON9WwLU9b05P1cQ==
X-Received: by 2002:a17:902:f68c:b0:1b6:c193:96e0 with SMTP id l12-20020a170902f68c00b001b6c19396e0mr3702156plg.1.1687529782117;
        Fri, 23 Jun 2023 07:16:22 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:1058:5400:4ff:fe7c:972])
        by smtp.gmail.com with ESMTPSA id p14-20020a63e64e000000b005533c53f550sm6505942pgj.45.2023.06.23.07.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:16:21 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v5 bpf-next 04/11] bpf: Protect probed address based on kptr_restrict setting
Date:   Fri, 23 Jun 2023 14:15:39 +0000
Message-Id: <20230623141546.3751-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230623141546.3751-1-laoar.shao@gmail.com>
References: <20230623141546.3751-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

The probed address can be accessed by userspace through querying the task
file descriptor (fd). However, it is crucial to adhere to the kptr_restrict
setting and refrain from exposing the address if it is not permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19..e4554db 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		*probe_addr = (unsigned long)tk->rp.kp.addr;
+		if (kallsyms_show_value(current_cred()))
+			*probe_addr = (unsigned long)tk->rp.kp.addr;
+		else
+			*probe_addr = 0;
 	}
 	return 0;
 }
-- 
1.8.3.1

