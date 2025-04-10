Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D684284B30;
	Thu, 10 Apr 2025 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744287748; cv=none; b=GvH59p/VWLBOGkurvhdknr77KQ6zdHv8y9LHmkVbGPt3TRH7eS+CIv12KNIzDiA4Oy1Nt0PWdLewFs4+xsJxkbRkY5fmR+0+j1Y9HHl6CVQdlXy4GvSmpXzUxB3VI8pNS/mByTeFNPuN8ITHVavh+I6JiexYYhFwdkE/G40kO0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744287748; c=relaxed/simple;
	bh=m3T4/LOg6mYcuQRnQtlKLSapjHOQqaJt4bIwTyZHRf0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PkXK/Pcw44OU3182Z4y+7uLb7luU/kb4Y634A08TmJHhyFW/jVgjJfZ80z0AtmJAz0MCuLgdBt94z1V/C10BYRu6xsUwj9DY/2dXOOsQKKIHegTL5VqsZvScCjUQ3enx8zT12KMZIF60h66tJ6pS5TZu1V03ce9Q8z2K0CPh1VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5e1a38c1aso896881a12.2;
        Thu, 10 Apr 2025 05:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744287744; x=1744892544;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X5UtJ2tlPuNevHqoiIq62Zf5tsaNGNxrKWyoL0OmWnY=;
        b=Ac331d+RUSBRwfzO2QsS+iiEnFUrrSA+F6cficdPoZlG+oiARKNgMHHszuFf/BYALQ
         Rx9au60XIrPsLs5X9MAnlZIl9aW7o3DsxbrHL601PvzRljkdN9O3lQ6aXiTqIDhusDqw
         JrblDKAxu24ie2tk5gULPd6bpvs2+3clm+Eyqr7mVLfs1jKEscZ41dHlQCQPS0rZckk8
         7mxmzpQw7y+uhawkUaKgxPGciAVjAohkfUHCqElcECq5K9ET3MIJ8leaYMBM7YZafzjs
         FzwjVueqUyuRtnG3ek5JP+ebHVYH6rHBoYCyXHknT7wuY8kYejkZc2HC1GkCpDiL3KuD
         fruQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGCEUwlxulxEjW8btb5dqvSxGLDKaxXU5A834U2PNwK70AxtSVT6K2KARQlKkoM9qSMoO23mlNnVOYaJRhJ3krCwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlUvtR6cPuXpObbiSCI5eWWTjH4MiH7KVW9G0Nov1BTpqhDlb8
	jcRWWPrd6Ys+cB9EIZjAunk9MtEzVwOrv0/PUk8RMyQTDpLvnXspyGmw2w==
X-Gm-Gg: ASbGncureOb75nALv5h697hD07SHYm+v8wodeHRYH0lhPs4w8gVEFKHQrBg00cYQf07
	zVdk/Uncrf8I9/j4XlT0PpMtze6SjuRasj/MsAIAgcuFSmUD06kghKolsYTMedJyfN3JolZ8Sau
	jGMQ8J9NlvLbGbzuoMwMtypF7CFScs5BTlcBJByAKUqaoJHtInpbDrfDoiWWeAAV3vO4Kxw2nK5
	VR4NTBrQ71rSugrtwBrR/ftNbSj2f/b0PUA5pzD60fzdG7ZGbVRWWA9ZMK7YTZtN+Arss0Vl7+V
	JdKrJwrgxS51Bv3F7hyKW/siJsaZ
X-Google-Smtp-Source: AGHT+IFnH+H/ypVsNPfD3gE4vTJKggvKhoU2bgrwMaI4jIVbqoop5MG7+2BV8LE04jhQKBDRfY6qzw==
X-Received: by 2002:a05:6402:390c:b0:5f0:a6bd:78d3 with SMTP id 4fb4d7f45d1cf-5f32932db0amr2206716a12.34.1744287743936;
        Thu, 10 Apr 2025 05:22:23 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fec02372sm2019462a12.8.2025.04.10.05.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:22:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 10 Apr 2025 05:22:21 -0700
Subject: [PATCH] tracing: fprobe: Fix RCU warning message in list traversal
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fprobe-v1-1-068ef5f41436@debian.org>
X-B4-Tracking: v=1; b=H4sIAPy392cC/x3MTQqAIBAG0KsM3zpBrSi9SrToZ6zZpChEIN096
 B3gVRTOwgWeKjLfUiRe8GQawnYu18FKdniC1bbXndEqpBxXVntgZwY3Bt1uaAgpc5Dnj6b5fT9
 FudLnWAAAAA==
X-Change-ID: 20250410-fprobe-dfe91798f03c
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=1905; i=leitao@debian.org;
 h=from:subject:message-id; bh=m3T4/LOg6mYcuQRnQtlKLSapjHOQqaJt4bIwTyZHRf0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBn97f+oMcon9v5l4QT+NPNxcyQjtiToAHIw2kTM
 M6GeKHuxm+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ/e3/gAKCRA1o5Of/Hh3
 bZpYD/4916gqkWKh1P+bnr3Xk5pA8UV3fnEhW/W3D7KlfRjFSmxOp+SbzCqU/bnw+vI5hqxGzKX
 2ieSGnqlQu0DugGr4r4hbc1DLer9Vgw3jFuj3muWfXc0hy1sD9XRuiqkbgcAL57vyu7x8GZqmL6
 yyewFXXYtwGOoAiNl3zn3PhF6wHryotW3sO/mF3j6z7eYUE52Q48X/O/vOejDyEcgeGOVRhS/D6
 iQ7TYOHCMMeay4Iq05zmFmqz8SreDC2vJvg7EZxpuOS7wfJTBdcahxgj9wYSHcq624BFqzhVvPk
 JSsl/vycP7iAy+P9wygmW1wjyrnhRmxm6pdRkl+nTpLzzidilYQyrvULjTAFWKFM4BKQFc3T2qt
 CR+Gosza5iHEgy7rmR2UGqbGeU+8BhLm0Ts68XFWt3+U/WVVmBLHYdQOkvKOTvlUcBVukRPrK7T
 GL8fwYDp6Y/HxUmFLHbuZVRmk/gALSa8WZYDA7ztZGisTTDc1K5NCEZrNbj7ILMr2KhH6D74Vy2
 LUnhxlfjMOF+IePxImgn4iwm3Gdtw0PmqFywDGd1JUZkxeLUNrDvfenzcoMXngH/UhC0hyvT6gN
 ZRSkPRytBJ9LJkYyLPB3X/gCoTJMRaNo/jwlmbYzqbQI3kFQrWMxYMjvXzyBKHbewpEJMVPOSuO
 gRBD3mfApREf+GQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

When CONFIG_PROVE_RCU_LIST is enabled, fprobe triggers the following
warning:

    WARNING: suspicious RCU usage
    kernel/trace/fprobe.c:457 RCU-list traversed in non-reader section!!

    other info that might help us debug this:
	#1: ffffffff863c4e08 (fprobe_mutex){+.+.}-{4:4}, at: fprobe_module_callback+0x7b/0x8c0

    Call Trace:
	fprobe_module_callback
	notifier_call_chain
	blocking_notifier_call_chain

This warning occurs because fprobe_remove_node_in_module() traverses an
RCU list using RCU primitives without holding an RCU read lock. However,
the function is only called from fprobe_module_callback(), which holds
the fprobe_mutex lock that provides sufficient protection for safely
traversing the list.

Fix the warning by specifying the locking design to the
CONFIG_PROVE_RCU_LIST mechanism. Add the lockdep_is_held() argument to
hlist_for_each_entry_rcu() to inform the RCU checker that fprobe_mutex
provides the required protection.

Fixes: a3dc2983ca7b90 ("tracing: fprobe: Cleanup fprobe hash when module unloading")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/trace/fprobe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 95c6e3473a76b..ba7ff14f5339b 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -454,7 +454,8 @@ static void fprobe_remove_node_in_module(struct module *mod, struct hlist_head *
 	struct fprobe_hlist_node *node;
 	int ret = 0;
 
-	hlist_for_each_entry_rcu(node, head, hlist) {
+	hlist_for_each_entry_rcu(node, head, hlist,
+				 lockdep_is_held(&fprobe_mutex)) {
 		if (!within_module(node->addr, mod))
 			continue;
 		if (delete_fprobe_node(node))

---
base-commit: 3b07108ada81a8ebcebf1fe61367b4e436c895bd
change-id: 20250410-fprobe-dfe91798f03c

Best regards,
-- 
Breno Leitao <leitao@debian.org>

