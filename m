Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17495EB64DC
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 28 Jun 2023 11:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjF1Lx5 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 28 Jun 2023 07:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbjF1Lxr (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:53:47 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC082D7F;
        Wed, 28 Jun 2023 04:53:46 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2632336f75fso1133948a91.3;
        Wed, 28 Jun 2023 04:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953226; x=1690545226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDLsG7DN2b3FdB2SmfIhgetVS5BzyJrWZkdO/xsQBFg=;
        b=YwHSl6Ny/ZpzStt+BDG3zIF1J/7ExGXAD4CZQ85xLMCbK8L6P1uzrBVDVcmlZU1WUu
         qtFv++KOdYyAn3Agvy5iizPCqo1QAi0i91Nab08+DoJmcZ0Trr5pxxq1qqIsh3MtJF+L
         sbmBE/wVMk3CNrdwk2pdN7CHJWMDuAukD/OxeJoDqt+SZMB4wlUpHZTfi0MJ3eNFl9wZ
         mTM4phn4c85UOjlCWjjtrKcZTurNDdQRqgDXNSWDNed7N36e6EXlJXpqzz2VPc3w3v/f
         QVAyNX9jlTQgsPDXhzdUWngqRhClWWvQUKaTMS1vl6E84vixqfNKUuOBJBwAYQEhk0qy
         RB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953226; x=1690545226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDLsG7DN2b3FdB2SmfIhgetVS5BzyJrWZkdO/xsQBFg=;
        b=Cba4xpLYTn17J8G1hSaF/9mXkAlloXVIAFYTxcYmuQH2FmN6d9fRC6U4PP/ubNOACs
         lo/zCtC3NeANF/9OAjgcVbzA2dkxRO1q5+21IUtV5o9Gg2op7Ou4ZsQDwT8gPs8p6+MJ
         rsJSFDtmyADprp1PNTGssWfCRjXNygvUqJr6Bt0R42hSNNqB4eGuxK78IChgdeyqYMnw
         AuT+vpHcV23B98j6XUXb1pjagsJYfkYQtEjbd1U/Zs9sEMer69sIU1bvT3u8qpWccptl
         NUQycfjIWEsz9F7WQG3GjZUV9QAOgVAILitN3ZXrIXjxr175KVtuSx11KjeBn2Fg0f6c
         bFmA==
X-Gm-Message-State: AC+VfDwLsQNA6E1RAWRXfIEI44VQBIBvvVPxV9OytLrm8GnOOKLTYCnG
        gl910tNLzgnPCX68zzTgcBQ=
X-Google-Smtp-Source: ACHHUZ6zyJ2b0TwjRiE8dWQC11g2CVoZTrIwvvA0htm4lkmZnXt4befFWo11mro+S7H4iMm8qbZVPA==
X-Received: by 2002:a17:90a:346:b0:262:ad7b:235b with SMTP id 6-20020a17090a034600b00262ad7b235bmr13967792pjf.34.1687953226123;
        Wed, 28 Jun 2023 04:53:46 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id n91-20020a17090a5ae400b002471deb13fcsm8000504pji.6.2023.06.28.04.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:53:45 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, quentin@isovalent.com, rostedt@goodmis.org,
        mhiramat@kernel.org
Cc:     bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 bpf-next 07/11] bpf: Add a common helper bpf_copy_to_user()
Date:   Wed, 28 Jun 2023 11:53:25 +0000
Message-Id: <20230628115329.248450-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115329.248450-1-laoar.shao@gmail.com>
References: <20230628115329.248450-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Add a common helper bpf_copy_to_user(), which will be used at multiple
places.
No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/syscall.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index a2aef900519c..4aa6e5776a04 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3295,6 +3295,25 @@ static void bpf_raw_tp_link_show_fdinfo(const struct bpf_link *link,
 		   raw_tp_link->btp->tp->name);
 }
 
+static int bpf_copy_to_user(char __user *ubuf, const char *buf, u32 ulen,
+			    u32 len)
+{
+	if (ulen >= len + 1) {
+		if (copy_to_user(ubuf, buf, len + 1))
+			return -EFAULT;
+	} else {
+		char zero = '\0';
+
+		if (copy_to_user(ubuf, buf, ulen - 1))
+			return -EFAULT;
+		if (put_user(zero, ubuf + ulen - 1))
+			return -EFAULT;
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
 static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 					  struct bpf_link_info *info)
 {
@@ -3313,20 +3332,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 	if (!ubuf)
 		return 0;
 
-	if (ulen >= tp_len + 1) {
-		if (copy_to_user(ubuf, tp_name, tp_len + 1))
-			return -EFAULT;
-	} else {
-		char zero = '\0';
-
-		if (copy_to_user(ubuf, tp_name, ulen - 1))
-			return -EFAULT;
-		if (put_user(zero, ubuf + ulen - 1))
-			return -EFAULT;
-		return -ENOSPC;
-	}
-
-	return 0;
+	return bpf_copy_to_user(ubuf, tp_name, ulen, tp_len);
 }
 
 static const struct bpf_link_ops bpf_raw_tp_link_lops = {
-- 
2.39.3

