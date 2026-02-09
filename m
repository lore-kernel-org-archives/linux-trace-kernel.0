Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE8B2DCC04
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Feb 2026 07:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621613; cv=none; b=DqTVVNinDmtzjgOIy6rcILBhttbMKRbriIBmgSGNmcHcfVahFIedGNhFFJFZa02ljwNIp0fMIwtQOiMfYxHwo4j50JMQP6NCGs2nc+iRBQrFCZt3SxKjHmTJzIGCb/RC6yI0FHQQy8aaCwQgXSj4vzuWWbV21iwBQ6Aic1HaFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621613; c=relaxed/simple;
	bh=MEAVASPVwF9tM/GX53hf7h/WsTf+5Q0TBYiXRJ2gCyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V3tvhC8cnezFird20NZHXT2jegbE88e2AhrtXGpKcyunoBwGZvqw/UjCNTFFVOV2ZqR4eQp0ddkqh007m9IEs3jcWgjcWOxMtJvLX9NFgUqpHnuVJ3wPh9TwuY3TJ3LDt662QXKUKDY7XNuzxdyDRtnRIiUkPBoeZ/V7zVU0CVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUMbR7z8; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUMbR7z8"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf91bbcd9so2385935ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 08 Feb 2026 23:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770621612; x=1771226412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UeVAwVWwwDK3JOVVjER3ZN9u1U/i6j13w87F+ZL3MDA=;
        b=dUMbR7z8uvzbGG3qYQ7sp11tatPBH3lUZeix9mAkyKQZW1iBkY79i5YYoATWHgIDeK
         1bpjJK+779lnQet/5Y+jwR28kW8ENOjEXsubHE7vjjMNcSrJLRqszdSLp0KxvAqAR182
         nbsJh3uydBawUbpqNr6Glj02feLysLHqaYciNpSJ53zoXcsU1/6IeTgmvCBtYZTpIs4e
         HnABnJ/pR4nlgp0tkXqqXpo22LPSaYTDgluPr7qTltJ+IbRsVw2UOu32djkRuPstvsyx
         8hK3yo9K9FX8bil+m6bk2ZtwwcVJj6deHLxinvuqo7hhpzbyi5o1bWfjCy7qR0gQGJ7C
         wDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770621612; x=1771226412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeVAwVWwwDK3JOVVjER3ZN9u1U/i6j13w87F+ZL3MDA=;
        b=lGfnmIHsIkSnxqF+gZ1ZZqYXtKhXLDEekhR6/HABrC2UhzWajmFm3G3sQXOYbhUzbW
         NlzSHPEgSktjr0GEsFyxc4mHVc82LFh/bvzrZT4MsnWkNJ0U6pAoeys3fmXwcmsw+m/Q
         1Dzzl5cJoiDjZyE3C5caJH7OwJhJNqsgjtzYaCZr7IttR3Yt6VQ0WgK+dL8fQ6OF/g0e
         QL3tTMblJIFpXnkIO516wB66Rn+XFVMB10EAyx0ToDEAUVo0ADmU4ctFEv8rkxC0YZ3k
         5YkRxUfk+x/uDZzr/Mo60WHS6uQwaM8gj3Du1sCHOyv0BdXXdqXwCA3ftvC6DQL55B1U
         69lw==
X-Forwarded-Encrypted: i=1; AJvYcCXu0YMeLRzyyA7d8pqjcSOwkTMlF4zcDio8LxDLLvgNyGgTqOP0xv453OGSRVJE6cBp8zrugQhQnSWHYAGX7+yAIQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwos9rpzO8dKh65GFWudMH72FYJ/5BR5ZMX81pQQFTgvezMYrJ
	cpDfW8skwDUwlo28YzMM1WqL/NROkNwaBNKpeyKgxysRgT95IFSDsn8i
X-Gm-Gg: AZuq6aLBe0h+DmTcI93jDRIWHq4GUcioNRKxr7D/x8bH78aGaPmXRi9tZtSi7wOVPMw
	yUjdcOxxER/5ZJo/sxSOYnAL7UJ/FdoJ3qalZ1+9dR28t9KsueRezYujQ6/vphKmhlLhDOvtJf8
	QdqQ9s8hm7I3yvWEkHLdRa1mBBBHTWHMpTfXMH3N/9eTumfvaDaMSFDonjPbE/7H4dPNXObqByp
	m852ONFTAF1PBiuVZOoChSCRP8/JvwdcJ2x3t6GN0O8ps1PLw6vg09XUviHCP+U+eGkZdVzWRbM
	F3dPr6BF+tMf2g1Cm9wCnQax2UC9wGG9M4X/HWzNBffAIB9DbBLIMB/AqKqvPmnMYz/+wO1a7yp
	vFK3WdIi/RQ6yG4KAOLTyJft0VIZUZr/RXTxtbP+aw1sAnk0lpFlwy7qp4pxfOZIO3hq74jNIJx
	UdjGoaM6nfZhGW/71ZXSnCtbNsfXB7yxwrt+/31A==
X-Received: by 2002:a17:902:f546:b0:2a5:99ec:16d7 with SMTP id d9443c01a7336-2a951608914mr105628835ad.7.1770621612446;
        Sun, 08 Feb 2026 23:20:12 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9bd1sm108448785ad.66.2026.02.08.23.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 23:20:11 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>
Subject: [PATCH] tracing: Pretty-print enum parameters in function arguments
Date: Mon,  9 Feb 2026 15:19:49 +0800
Message-Id: <20260209071949.4040193-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

Currently, print_function_args() prints enum parameter values
in decimal format, reducing trace log readability.

Use BTF information to resolve enum parameters and print their
symbolic names (where available). This improves readability by
showing meaningful identifiers instead of raw numbers.

Before:
  mod_memcg_lruvec_state(lruvec=0xffff..., idx=5, val=320)

After:
  mod_memcg_lruvec_state(lruvec=0xffff..., idx=5 [NR_SLAB_RECLAIMABLE_B], val=320)

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
v2:
 - Iterate btf_enum members directly with a for loop,
   replacing the for_each_enum macro helper.
---
 kernel/trace/trace_output.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index cc2d3306bb60..548e3cd06b04 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -695,12 +695,13 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 {
 	const struct btf_param *param;
 	const struct btf_type *t;
+	const struct btf_enum *enums;
 	const char *param_name;
 	char name[KSYM_NAME_LEN];
 	unsigned long arg;
 	struct btf *btf;
 	s32 tid, nr = 0;
-	int a, p, x;
+	int a, p, x, i;
 	u16 encode;
 
 	trace_seq_printf(s, "(");
@@ -754,6 +755,15 @@ void print_function_args(struct trace_seq *s, unsigned long *args,
 			break;
 		case BTF_KIND_ENUM:
 			trace_seq_printf(s, "%ld", arg);
+			enums = btf_enum(t);
+			for (i = 0; i < btf_vlen(t); i++) {
+				if (arg == enums[i].val) {
+					trace_seq_printf(s, " [%s]",
+							 btf_name_by_offset(btf,
+							 enums[i].name_off));
+					break;
+				}
+			}
 			break;
 		default:
 			/* This does not handle complex arguments */
-- 
2.34.1

