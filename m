Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FDB47F761
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270381; cv=none; b=lsRsQOTRm0yQ9FpuyEHiaXqMywEQiYCD3dmKGYAJKuMOZcWZol9pJuROf0qFg7nsn2qgOJTSaXPkJKfvbGHzClYeNW60YH671qq2KaeM3XD9Ru3Wyl5BaG1vKWCB1UwNl6HPZlVxFWpGhdV+fpgogUw96X144RPXz5fyjmFQOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270381; c=relaxed/simple;
	bh=DbOu4itQQUQot2uL+glfUJyFG3dv01u2DN/NL0enzog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ha4XJBJZoLd7Gma4Sv6L+xhKIu86xm5OcTm/kF6ULfw8SUJAgbcKQMeyQQZRlIvXKijMz4AgMfD9bSgnw80p/QrpYf/Ma7zS7Va8vGJ681a8brVnG+/zENU3xNuKUlygVaYrXYNC/sJM8zMxwK1uubqD3YpXqLTAHF9g0XsD3i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qc9ywNg+; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc9ywNg+"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-853c401326eso2762202b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788270380; x=1788875180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmXxudQOrIc1hrZ9sSNT8017ofPSKdmo87vA8sHUzVM=;
        b=Qc9ywNg+nwE9nejo2iQpSMmwhtlAkBZWGinsBKQKQiCqzYXnS0K0ijCmwWSiCkx82I
         KUwv4EAWNJ/i4GuQrqh+BbSITuHvzKAWxYcA6t/txl+fGhpXcRk06xlWDmjY0F50NggO
         nJ4DZG6/nlleUFRaJJhEdMrocr3TS+J+1ud7MZQOqoJaV7+mbO5hiN9vAOq6nwcjAYfA
         yZaObpQBsM81IfWowBWndyotqSs68ruwkxWJpsum0UM4Y7LU4CZUG+atO8TSWv9K+Z8S
         R7owp+ptkhL9+NdCOlTSZL4zg0YWDOdtvpOLqqz0wUJUFdJUGdrS195I/cM3ZxmpcjGB
         9clA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788270380; x=1788875180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BmXxudQOrIc1hrZ9sSNT8017ofPSKdmo87vA8sHUzVM=;
        b=SumV9UaAzAQJZ4Nq2Zo/eeehGwqUuwrBzELqYN1ufbF0sYY1Q4M7BvMB42rsoVBh4n
         uXAO2ogxbxSBnpV0ctjAT7jICrTP7fFgyNuwguA7jZ1q9Wj+68N24cgPNjAzCWPEcr7Q
         SRUkP9tTLKYmckreEznMGuxI1SOk3PMSAYeGWx9tvaKnhcrZJ+sAcrcUwekHvY+J0HwM
         X1cTk2uTNEwKG3oTmLLYW4fv8tU43UmEaPBiOx6ugN0QzAa1DGAbeTitajbXjndX0cBU
         SVFoO8VVUJ8iwPkmGxgUk+Dnb1JBPa57Mc7zKOxUH4nN1rDtjRCIMwE7vZAGMj5OmzoT
         aJbw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+dpoJhrvOrquk1MX+Q5kYvVWGZwiUxL3gJJdg8PmpmhHrxMQiHANidhcpW5ZwkhC3kak+iZdEAOOztVRWQN7hORc=@vger.kernel.org
X-Gm-Message-State: AFuF++mSsnWPn0QiVBtaOiZUadDnJ/34C9DWpInm/F1tg+tZ0KeHi3yL
	Qz0wlqDzHJH3B+Co+K2UdSR51EWsuLWfUbVG8XxZP1s+fKLe31n86nnV
X-Gm-Gg: AR+sD11cqAVAQVrseODJQ9iZg6JUA/BxzlaV4f2upR7aQVQdKLmWVa+4tG7h+lO0Vk2
	BD20gMKPxTEfJBjU2oxRvNJRe6D1rUoU74uV4LwMbFJ/n3AuyTFgPZ7TeJe6hHaRkAJclx8F/4D
	y1VCQtIwMF6D12u6Vbo57SV/I9V5B5kH5NKv5XFon9BDbx/tOGD6K4FYOa0sFbsUuHZiK1NxtGw
	XgJeM7z9ptCGqcmQ6GGFxXazSJTZ+s5pWe9r/ndvnTeS6jLKdqrcsUHMRRYHfsJzUP+Xt1BOVHO
	Au06FTbRWGnOpZKBLoUlS3UB6xcdLfVge3q0DCsqgttPvyYobeJkjubtgjWGBOY2G81d19L2eCs
	joWgP54Z5zG25xrvS/9oXY7Ccvsbrc+gFnqwpQQ2aJh4/91Et4A5yzI0qKZbKslypORee/4gByf
	BsTxfrva/rs/a4HJQyw/FAYYlG6wGft9J2qWa8tJoAusvINH545UvRDI97SXNjnm0cW0zeqoSDY
	eFR
X-Received: by 2002:a05:6a00:a01:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-85b59593e6dmr11671845b3a.1.1788270379544;
        Tue, 01 Sep 2026 06:46:19 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be8f52cb4sm1132502b3a.39.2026.09.01.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 06:46:19 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v5 2/3] fgraph: Enhance funcgraph-retval with BTF-based type-aware output
Date: Tue,  1 Sep 2026 21:46:03 +0800
Message-Id: <20260901134604.4052265-3-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260901134604.4052265-1-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The current funcgraph-retval implementation suffers from two accuracy
issues:

1. Void-returning functions still print a return value, creating
   misleading noise in the trace output.

2. For functions returning narrower types (e.g., char, short), the
   displayed value can be incorrect because high bits of the register
   may contain undefined data.

This patch addresses both problems by leveraging BTF to obtain the exact
return type of each traced kernel function. The key changes are:

1. Void function filtering: Functions with void return type no longer
   display any return value in the trace output, eliminating unnecessary
   clutter.

2. Type-aware value formatting: The return value is now properly truncated
   to match the actual width of the return type before being displayed.
   Additionally, the value is formatted according to its type for better
   human readability.

Here is an output comparison:

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |   touch_atime() {
 1)               |     atime_needs_update() {
 1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
 1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
 1)               |       current_time() {
 1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
 1)   0.352 us    |       } /* current_time ret=0x69380753 */
 1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
 1)   0.937 us    |   } /* touch_atime ret=0x0 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 2)               |   touch_atime() {
 2)               |     atime_needs_update() {
 2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
 2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
 2)               |       current_time() {
 2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
 2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_btf.c             | 68 ++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h             | 16 +++++++
 kernel/trace/trace_functions_graph.c | 50 ++++++++++++++------
 3 files changed, 121 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index 00172f301f25..38825f566235 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -2,6 +2,7 @@
 #include <linux/btf.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/kallsyms.h>
 
 #include "trace_btf.h"
 
@@ -120,3 +121,70 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	return member;
 }
 
+#ifdef CONFIG_DEBUG_INFO_BTF
+void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
+			int *fmt)
+{
+	const struct btf_type *t;
+	char name[KSYM_NAME_LEN];
+	struct btf *btf;
+	u32 v, msb;
+	int kind;
+
+	if (lookup_symbol_name(func, name))
+		return;
+
+	t = btf_find_func_proto(name, &btf);
+	if (IS_ERR_OR_NULL(t))
+		return;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+	kind = t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN;
+	switch (kind) {
+	case BTF_KIND_UNKN:
+		*print_retval = false;
+		break;
+	case BTF_KIND_STRUCT:
+	case BTF_KIND_UNION:
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		if (kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION)
+			*fmt = RETVAL_FMT_HEX;
+		else
+			*fmt = RETVAL_FMT_DEC;
+
+		if (t->size > sizeof(unsigned long)) {
+			*fmt |= RETVAL_FMT_TRUNC;
+		} else {
+			msb = BITS_PER_BYTE * t->size - 1;
+			*retval &= GENMASK(msb, 0);
+		}
+		break;
+	case BTF_KIND_INT:
+		v = *(u32 *)(t + 1);
+		if (BTF_INT_ENCODING(v) == BTF_INT_BOOL) {
+			*fmt = RETVAL_FMT_BOOL;
+			msb = 0;
+		} else {
+			if (BTF_INT_ENCODING(v) == BTF_INT_SIGNED)
+				*fmt = RETVAL_FMT_DEC;
+			else
+				*fmt = RETVAL_FMT_HEX;
+
+			if (t->size > sizeof(unsigned long)) {
+				*fmt |= RETVAL_FMT_TRUNC;
+				msb = BITS_PER_LONG - 1;
+			} else {
+				msb = BTF_INT_BITS(v) - 1;
+			}
+		}
+		*retval &= GENMASK(msb, 0);
+		break;
+	default:
+		*fmt = RETVAL_FMT_HEX;
+		break;
+	}
+
+	btf_put(btf);
+}
+#endif
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bc44bc261e6..3675d99c22eb 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/btf.h>
 
+enum {
+	RETVAL_FMT_HEX   = BIT(0),
+	RETVAL_FMT_DEC   = BIT(1),
+	RETVAL_FMT_BOOL  = BIT(2),
+	RETVAL_FMT_TRUNC = BIT(3),
+};
+
 const struct btf_type *btf_find_func_proto(const char *func_name,
 					   struct btf **btf_p);
 const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
@@ -9,3 +16,12 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
 						u32 *anon_offset);
+#ifdef CONFIG_DEBUG_INFO_BTF
+void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
+		     int *fmt);
+#else
+static inline void btf_trim_retval(unsigned long func, unsigned long *retval,
+				   bool *print_retval, int *fmt)
+{
+}
+#endif
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index ff7cb1a76b95..89a64982df2c 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -15,6 +15,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_btf.h"
 
 /* When set, irq functions might be ignored */
 static int ftrace_graph_skip_irqs;
@@ -877,7 +878,7 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	unsigned long retval = 0;
 	bool print_retaddr = false;
 	bool print_retval = false;
-	bool hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
+	int retval_fmt = 0;
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	retval = graph_ret->retval;
@@ -888,17 +889,35 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 	print_retaddr = !!(opt_flags & TRACE_GRAPH_PRINT_RETADDR);
 #endif
 
-	if (print_retval && retval && !hex_format) {
-		/* Check if the return value matches the negative format */
-		if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
-			(((u64)retval) >> 32) == 0) {
-			err_code = sign_extend64(retval, 31);
-		} else {
-			err_code = retval;
+	if (print_retval) {
+		int fmt = RETVAL_FMT_HEX;
+
+		btf_trim_retval((unsigned long)func, &retval, &print_retval, &fmt);
+		if (print_retval) {
+			if (opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX)
+				retval_fmt = RETVAL_FMT_HEX;
+
+			if (retval && retval_fmt != RETVAL_FMT_HEX) {
+				/* Check if the return value matches the negative format */
+				if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
+					(((u64)retval) >> 32) == 0) {
+					err_code = sign_extend64(retval, 31);
+				} else {
+					err_code = retval;
+				}
+
+				if (!IS_ERR_VALUE(err_code))
+					err_code = 0;
+			}
+
+			if (retval_fmt == RETVAL_FMT_HEX) {
+				retval_fmt |= (fmt & RETVAL_FMT_TRUNC);
+			} else {
+				if (err_code && fmt & RETVAL_FMT_HEX)
+					fmt = (fmt & ~RETVAL_FMT_HEX) | RETVAL_FMT_DEC;
+				retval_fmt = fmt;
+			}
 		}
-
-		if (!IS_ERR_VALUE(err_code))
-			err_code = 0;
 	}
 
 	if (entry) {
@@ -925,10 +944,15 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 				    trace_flags, false);
 
 	if (print_retval) {
-		if (hex_format || (err_code == 0))
+		if (retval_fmt & RETVAL_FMT_HEX)
 			trace_seq_printf(s, " ret=0x%lx", retval);
+		else if (retval_fmt & RETVAL_FMT_BOOL)
+			trace_seq_printf(s, " ret=%s", retval ? "true" : "false");
 		else
-			trace_seq_printf(s, " ret=%ld", err_code);
+			trace_seq_printf(s, " ret=%ld", err_code ?: retval);
+
+		if (retval_fmt & RETVAL_FMT_TRUNC)
+			trace_seq_printf(s, "(trunc)");
 	}
 
 	if (!entry || print_retval || print_retaddr)
-- 
2.34.1

