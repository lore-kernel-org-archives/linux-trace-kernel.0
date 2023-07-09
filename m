Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FCAEB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Sun,  9 Jul 2023 02:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjGIC4s (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 8 Jul 2023 22:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGIC4s (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 22:56:48 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DE9E45;
        Sat,  8 Jul 2023 19:56:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e97fcc60so2137307b3a.3;
        Sat, 08 Jul 2023 19:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871407; x=1691463407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBs3mktan1YmmX0M9dfKX3Pl7uyEaN9wbTRd5MR/QSA=;
        b=H+aVD1SdcgDIArYmzolhZ6vdAy22W5+nZPqDQhwFxqx/ZnHWVKOm3iYk6AlK3mPdf/
         AfNdb2Dy/SZ/AnbPDx7nab14DByiz7PZoU8IxXz3hbfOumNN7Qj3AARACWMFPUcqokRY
         +ElytCV9KqhzCxXKLc6aZAvC5HBjaQ9kXnHzK80bOqXR9uXf3jK4zslgmZpgNJohX0jg
         3yU7xE1gQChLnJSlLS4Do4I3y0LNzGc2i9Fe6d+w5j4NA6XS8TGuLir/ktuP5oi9KI2O
         dmfVT52VflAgl0VdNzn2L/XSF7HnqUGYsq01YaveqpAjQ2uJsX/Xyi3iHguj/6a+8wZn
         srDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871407; x=1691463407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WBs3mktan1YmmX0M9dfKX3Pl7uyEaN9wbTRd5MR/QSA=;
        b=HOhmRoevA3wYg/qKCyD2amaQx8RHxaSQE1iXjC7aIfcOZJae/fUXuMma1n6wggv1Ey
         BK0AWbS66He4umld8YLNsC+X28XnQGuwRbzfgtH4c8xbcpszcl8kzASLGjimJ2mFEDvv
         nzhyF6NPTii97ynqkDX8LzGJJM1WH0oK311Ycc8BpWGmq7cCmJD7tTsBgYzXMWN9Jt/4
         3dgnah4qpYS87UGFO6nhUEhPF7HNIUymE+sRlKic1yeSRKERjBgKhjScF5sUyL7SnNXP
         S2S2sdwI1+NnA/FBeWfRNzsmyaiLnpe0GEULfFUkdcOb3oUSqtJf/l2s0Xoe2Kc5Fx34
         XwVw==
X-Gm-Message-State: ABy/qLbtRDVProNOeGYWeVkBfA3p43M9qoAlcIU5WajnJMuW00uF0qLE
        /yKQoYfQrsfQi1flGLm2fu0=
X-Google-Smtp-Source: APBJJlH0ViHiGDmT63SOTDc5gDjYRwd3bfCDyAoOi0spQrAIfg9b81xIZVVZfzMtIvlK6+/+cDH8Hg==
X-Received: by 2002:a05:6a00:1389:b0:682:4edf:b9b4 with SMTP id t9-20020a056a00138900b006824edfb9b4mr8442419pfg.23.1688871406892;
        Sat, 08 Jul 2023 19:56:46 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b00682ad247e5fsm5043421pfn.179.2023.07.08.19.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:56:46 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v7 bpf-next 02/10] bpftool: Dump the kernel symbol's module name
Date:   Sun,  9 Jul 2023 02:56:22 +0000
Message-Id: <20230709025630.3735-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025630.3735-1-laoar.shao@gmail.com>
References: <20230709025630.3735-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

If the kernel symbol is in a module, we will dump the module name as
well. The square brackets around the module name are trimmed.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/xlated_dumper.c | 6 +++++-
 tools/bpf/bpftool/xlated_dumper.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/xlated_dumper.c b/tools/bpf/bpftool/xlated_dumper.c
index da608e10c843..567f56dfd9f1 100644
--- a/tools/bpf/bpftool/xlated_dumper.c
+++ b/tools/bpf/bpftool/xlated_dumper.c
@@ -46,7 +46,11 @@ void kernel_syms_load(struct dump_data *dd)
 		}
 		dd->sym_mapping = tmp;
 		sym = &dd->sym_mapping[dd->sym_count];
-		if (sscanf(buff, "%p %*c %s", &address, sym->name) != 2)
+
+		/* module is optional */
+		sym->module[0] = '\0';
+		/* trim the square brackets around the module name */
+		if (sscanf(buff, "%p %*c %s [%[^]]s", &address, sym->name, sym->module) < 2)
 			continue;
 		sym->address = (unsigned long)address;
 		if (!strcmp(sym->name, "__bpf_call_base")) {
diff --git a/tools/bpf/bpftool/xlated_dumper.h b/tools/bpf/bpftool/xlated_dumper.h
index 9a946377b0e6..db3ba0671501 100644
--- a/tools/bpf/bpftool/xlated_dumper.h
+++ b/tools/bpf/bpftool/xlated_dumper.h
@@ -5,12 +5,14 @@
 #define __BPF_TOOL_XLATED_DUMPER_H
 
 #define SYM_MAX_NAME	256
+#define MODULE_MAX_NAME	64
 
 struct bpf_prog_linfo;
 
 struct kernel_sym {
 	unsigned long address;
 	char name[SYM_MAX_NAME];
+	char module[MODULE_MAX_NAME];
 };
 
 struct dump_data {
-- 
2.30.1 (Apple Git-130)

