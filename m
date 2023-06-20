Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A063EB64DB
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 20 Jun 2023 16:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjFTQaX (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFTQaV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:30:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0C172E;
        Tue, 20 Jun 2023 09:30:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-25ecfb3947eso2876756a91.0;
        Tue, 20 Jun 2023 09:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687278618; x=1689870618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn+VvMrPWCKqoo4PubFGskWvnQBFZ4/nSXCXeyqhAzE=;
        b=cdBnE3Gn4CIi5QrJW5KtZE1S9YRHu5EaoSenrC4g41YYR++X0kMoowcj3rAWG0huly
         IMKvzIiw28kZHwMCh1Or5/qzu9uYYYrg4dSy4FUAIAQXg3RxExUmAeh1onhyURLxqUPS
         qm3HNmaT1k4EM4uKke0wLnzlvCLsla0WgNAvI0tKaHtngk8qF7QH6wL1sNKw7xlVAWwX
         IKKsApM9Jh9i2O0183KEq53ByQMwpc8Af+ZrnnWhg7eA6I0UBu87OjMeJBXTaI55t9SB
         HbF450HKZJM1Rqbl6Q+ll1ttnTQz3foWiTHZORLErEI/UqZAiwFxMA5WkVKcG40FNLu7
         32mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687278618; x=1689870618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn+VvMrPWCKqoo4PubFGskWvnQBFZ4/nSXCXeyqhAzE=;
        b=UHI68nxpscnom5coxPnJPo+Ze5gVo9dJlTOvsHydUz/aj4VYpQUR8/MKbtHVygcnU5
         OBuMJ9wblifqLTCbu+b3eEmjkejEcHbmOPRXxEKTKoioUZZ68IRwmyVhatIMBSIUNyHA
         Q2fAmdRgP2/UyiUNSjj/benurTLD33N1phYfmY6kQLaKr+eZFNRm/qqTmmMQx8PM6rXi
         bDLwNRfOvDoHVdcLM17WGsBr3MbfV+c/4AtgFUDiBqMXpZ1Kg3m4Ie4tCZ5WUTZemTeU
         vdtxTPTz96eAjaMsTLw/LDAX721u8TcPBYefcDnPZXhO+8Qt2sudLmRltQNQYTpeLrPG
         Gejw==
X-Gm-Message-State: AC+VfDzmoEhRS/lCeNoj3VeXii4F7XGYlXoxSD4rDvCdPSj/il0YzW7m
        YCzeHVtz1eUHieEsIc6pSMMluDgnrEi2S73domo=
X-Google-Smtp-Source: ACHHUZ5lAIN4/eKU4nFr/rTCd6cm2+EnugkJdsFnqa4TbXiEHSZCByJTVM9OEnj3XZ+gbGVz4OUjhA==
X-Received: by 2002:a17:90b:147:b0:25c:571:8670 with SMTP id em7-20020a17090b014700b0025c05718670mr12244348pjb.46.1687278618226;
        Tue, 20 Jun 2023 09:30:18 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b96:5400:4ff:fe7b:3b23])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090a3b4800b0025c1cfdb93esm1854286pjf.13.2023.06.20.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:30:17 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v4 bpf-next 01/11] bpf: Support ->fill_link_info for kprobe_multi
Date:   Tue, 20 Jun 2023 16:29:58 +0000
Message-Id: <20230620163008.3718-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230620163008.3718-1-laoar.shao@gmail.com>
References: <20230620163008.3718-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

With the addition of support for fill_link_info to the kprobe_multi link,
users will gain the ability to inspect it conveniently using the
`bpftool link show`. This enhancement provides valuable information to the
user, including the count of probed functions and their respective
addresses. It's important to note that if the kptr_restrict setting is not
permitted, the probed address will not be exposed, ensuring security.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/uapi/linux/bpf.h       |  5 +++++
 kernel/trace/bpf_trace.c       | 28 ++++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  5 +++++
 3 files changed, 38 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7b5e91..23691ea 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 2bc41e6..2123197b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2459,6 +2459,7 @@ struct bpf_kprobe_multi_link {
 	u32 cnt;
 	u32 mods_cnt;
 	struct module **mods;
+	u32 flags;
 };
 
 struct bpf_kprobe_multi_run_ctx {
@@ -2548,9 +2549,35 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
 	kfree(kmulti_link);
 }
 
+static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
+						struct bpf_link_info *info)
+{
+	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
+	struct bpf_kprobe_multi_link *kmulti_link;
+	u32 ucount = info->kprobe_multi.count;
+
+	if (!uaddrs ^ !ucount)
+		return -EINVAL;
+
+	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
+	info->kprobe_multi.count = kmulti_link->cnt;
+	info->kprobe_multi.flags = kmulti_link->flags;
+
+	if (!uaddrs)
+		return 0;
+	if (ucount < kmulti_link->cnt)
+		return -EINVAL;
+	if (!kallsyms_show_value(current_cred()))
+		return 0;
+	if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
+		return -EFAULT;
+	return 0;
+}
+
 static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
 	.release = bpf_kprobe_multi_link_release,
 	.dealloc = bpf_kprobe_multi_link_dealloc,
+	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
 };
 
 static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
@@ -2862,6 +2889,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	link->addrs = addrs;
 	link->cookies = cookies;
 	link->cnt = cnt;
+	link->flags = flags;
 
 	if (cookies) {
 		/*
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index a7b5e91..23691ea 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6438,6 +6438,11 @@ struct bpf_link_info {
 			__s32 priority;
 			__u32 flags;
 		} netfilter;
+		struct {
+			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
+			__u32 count;
+			__u32 flags;
+		} kprobe_multi;
 	};
 } __attribute__((aligned(8)));
 
-- 
1.8.3.1

