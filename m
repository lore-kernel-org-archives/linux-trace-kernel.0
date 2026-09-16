Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFDD4FDE40
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565559; cv=none; b=T//0qfKytgWBkzpMuPBzesNyHbifGPb9ASk6U0TrPR+lJ+t31/2dP6YkBex5OteVCK/ppYox+YGkFQBBZceyt7LHw6m8Wg8FmwuSJnVYQMRIHC+SWZQkIif+KvhJnlUJRMJHjy9kaX+P4Ryg0fYsrCJjvoiAoQCl5UuVfEcJ3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565559; c=relaxed/simple;
	bh=6UxjLPsS8HHSsfySyBekkbdAS89qWegB5Z/pfhVXzaY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=urrZgSW3FTu8tA8QiJ8WRGBeQPRoXR3yCAly3Pj5eRuIfAVFYND6Qbp0J2xtJk8Fd9ZbnhovzNQQj+TV6niXbHA5R0v7q68J+Z/Mo9A8VqVStSMLo9T8d6+Gmyf5xBXnT3WoaQRdVAovilKbosEv/+mPuZxkHvb4J6gV3P09vw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbMgV5lu; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbMgV5lu"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so933690a12.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Sep 2026 06:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565553; x=1790170353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yg2C5mt4scE/xmOQfp5Li2GDZmfVPDiocqzH0MD1Seo=;
        b=dbMgV5luhiNHlM+mccynRdhqGOBUTAyfkPQpN72FkSUB7Xi11ZWlXN3imd8NymJYZB
         /dVDmyp2Coztl/CBBVDJWbmYlKcU3LDMOlHE4u6vQmBzTu++QK2m3LvJkynHBqzFAYZF
         JtVmVui4/7LatkS7kHvjEfbz3oDytMIa7tME/lBM35A8zXhqAu4tQc99i1KJiyODC+gV
         k2q8OrPsGNxNv4xL4dAgjnGaareJzSI7vLWJBwDsmrD2OGmLFnbD0tZ6E8l4axAkDZXx
         KKc5Fa/QWr3ZbT3IAl30hVakytAo1b/ALyE6OI8GEWixFZ0d2wwrfnDegYAm4jhl3PTr
         9xoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565553; x=1790170353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Yg2C5mt4scE/xmOQfp5Li2GDZmfVPDiocqzH0MD1Seo=;
        b=lJcUp16pZwScUV3Nt89Lv/tPJ+YXKGiQ+YPpvJabYlyW7YdMwY4LRvBE0TJAHNieYg
         zgUh0/LWqHWUSwunI1ewODMLxU5ekI5kVTq7oW/vfd9kxLQF3KUzxIJw6Jk0jtExybkP
         xRP/o7icJXlt0Z7pI2RuROF53V5cAEfZ4RG2Z/GxnoQfn0/uN+jnNjEjMHHVDbdBgr6P
         BirFeU0MnbrfcnTiT9ct3Go/3En27aBZI/Y7et6zzcpZa7tT71kGxAnoVf7hk/RKD6yf
         9r1hp3D3DkDJbmzozwJLZvCgyY9M6Jq342MWsSEY0JmQwKZOyFu4tkswExkEbIKKlFt1
         HhUg==
X-Forwarded-Encrypted: i=1; AKwUvBzl3fNUs8FLVvx8WRU6N5bB6pc2e89adPDqRTcjFwRkM7q0SAvuoBK5MkFMgfAs4sFDe3ws0KBlk9qd4XO4OBVenZM=@vger.kernel.org
X-Gm-Message-State: AFuF++l7MWvUeKLPXfMDCT5Gm88TGA9UXPJa6Q2ROmzx0LsgvafIDM18
	ILhEXgOJRQ0GUAShISoDL1mMdE9qqoJAJemmg9g7ERKeGsxLlQ0hhh6h
X-Gm-Gg: AYBFou3N725IQVkTUddRfEpQushT3rD3tpYgeH82gpsOdbEAGuZRXgMtpi9dtpsvhOQ
	U4LP0TWeJUNPjbIQvhOWq/Gir8jehEB7hKeEGlovlBnHvt9GYhhqZtNEAs3rWBWHdwovEHxIQmF
	Ih7TCwhmkzjhRbGFBy24D75oCZ5UDvoPUerh1kj2sewhv7Bvf8QDpT58AJuYEJobBUPIOGLFlLf
	fybyWGNndP1zIizPK0dWdtyF1WUMj1hXb/4BNwMBF52XidQZqTrgDpO+JP5U+wrIWfrQ7G0bg++
	r7yknRGGXVLC4sTv8rJfStnCdfeR8BefRr9TvB5pCitlFYqpuuvR/FSlLhJLE20wdrXRlqNVsRD
	4e1Pmxaf9L/6h8SeXZfAExZ9NgzJP4G3Hn9bWSBfrOIzOI+iUW0tCM2SJibXYfJIhg7CDPl7SN1
	ay68S338NsNosJb3Dnn3dl+pMVZ2NPCLQo6R/Yk2fTwszYYo34aVAGZ6nCyivvEqeGadfab8IIF
	tpUEUPqE+0fmyIVWoffumPmrg==
X-Received: by 2002:a05:6a21:7107:b0:3c3:b57b:6285 with SMTP id adf61e73a8af0-3dd5f735116mr6731242637.13.1789565552667;
        Wed, 16 Sep 2026 06:32:32 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50ab960edsm1651702a12.20.2026.09.16.06.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:32:32 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v6 3/4] fgraph: Enhance funcgraph-retval with BTF-based type-aware output
Date: Wed, 16 Sep 2026 21:32:17 +0800
Message-Id: <20260916133218.1282590-4-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916133218.1282590-1-dolinux.peng@gmail.com>
References: <20260916133218.1282590-1-dolinux.peng@gmail.com>
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
 kernel/trace/trace_btf.c             | 83 ++++++++++++++++++++++++++++
 kernel/trace/trace_btf.h             | 18 ++++++
 kernel/trace/trace_functions_graph.c | 56 ++++++++++++++-----
 3 files changed, 144 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_btf.c b/kernel/trace/trace_btf.c
index ae562192b619..bcf65fec7bb1 100644
--- a/kernel/trace/trace_btf.c
+++ b/kernel/trace/trace_btf.c
@@ -2,6 +2,7 @@
 #include <linux/btf.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/kallsyms.h>
 
 #include "trace_btf.h"
 
@@ -123,3 +124,85 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 	return member;
 }
 
+void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
+			int *fmt, bool hex)
+{
+	const struct btf_type *t;
+	char name[KSYM_NAME_LEN];
+	struct btf *btf;
+	u32 v, msb;
+	bool signed_type;
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
+		if (kind == BTF_KIND_STRUCT || kind == BTF_KIND_UNION) {
+			*fmt = RETVAL_FMT_HEX;
+			signed_type = false;
+		} else {
+			*fmt = RETVAL_FMT_DEC;
+			signed_type = btf_type_kflag(t);
+			if (!signed_type)
+				*fmt |= RETVAL_FMT_UNSIGNED;
+		}
+
+		if (t->size > sizeof(unsigned long)) {
+			*fmt |= RETVAL_FMT_TRUNC;
+			msb = BITS_PER_LONG - 1;
+		} else {
+			msb = min_t(u32, BITS_PER_BYTE * t->size - 1,
+				    BITS_PER_LONG - 1);
+			*retval &= GENMASK(msb, 0);
+		}
+		if (signed_type && t->size && !hex)
+			*retval = sign_extend64(*retval, msb);
+		break;
+	case BTF_KIND_INT:
+		v = *(u32 *)(t + 1);
+		signed_type = false;
+		if (BTF_INT_ENCODING(v) == BTF_INT_BOOL) {
+			*fmt = RETVAL_FMT_BOOL;
+			msb = 0;
+		} else {
+			signed_type = BTF_INT_ENCODING(v) & BTF_INT_SIGNED;
+			if (signed_type)
+				*fmt = RETVAL_FMT_DEC;
+			else
+				*fmt = RETVAL_FMT_HEX;
+
+			if (t->size > sizeof(unsigned long)) {
+				*fmt |= RETVAL_FMT_TRUNC;
+				msb = BITS_PER_LONG - 1;
+			} else {
+				msb = min_t(u32, BTF_INT_BITS(v) - 1,
+					    BITS_PER_LONG - 1);
+			}
+		}
+		*retval &= GENMASK(msb, 0);
+		if (signed_type && !hex)
+			*retval = sign_extend64(*retval, msb);
+		break;
+	default:
+		*fmt = RETVAL_FMT_HEX;
+		break;
+	}
+
+	if (*print_retval)
+		*fmt |= RETVAL_FMT_BTF;
+	btf_put(btf);
+}
diff --git a/kernel/trace/trace_btf.h b/kernel/trace/trace_btf.h
index 4bc44bc261e6..0286c89e1cf9 100644
--- a/kernel/trace/trace_btf.h
+++ b/kernel/trace/trace_btf.h
@@ -1,6 +1,15 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/btf.h>
 
+enum {
+	RETVAL_FMT_HEX   = BIT(0),
+	RETVAL_FMT_DEC   = BIT(1),
+	RETVAL_FMT_BOOL  = BIT(2),
+	RETVAL_FMT_TRUNC = BIT(3),
+	RETVAL_FMT_BTF   = BIT(4),
+	RETVAL_FMT_UNSIGNED = BIT(5),
+};
+
 const struct btf_type *btf_find_func_proto(const char *func_name,
 					   struct btf **btf_p);
 const struct btf_param *btf_get_func_param(const struct btf_type *func_proto,
@@ -9,3 +18,12 @@ const struct btf_member *btf_find_struct_member(struct btf *btf,
 						const struct btf_type *type,
 						const char *member_name,
 						u32 *anon_offset);
+#ifdef CONFIG_DEBUG_INFO_BTF
+void btf_trim_retval(unsigned long func, unsigned long *retval, bool *print_retval,
+		     int *fmt, bool hex);
+#else
+static inline void btf_trim_retval(unsigned long func, unsigned long *retval,
+				   bool *print_retval, int *fmt, bool hex)
+{
+}
+#endif
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index ff7cb1a76b95..8645a33f0388 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -15,6 +15,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_btf.h"
 
 /* When set, irq functions might be ignored */
 static int ftrace_graph_skip_irqs;
@@ -875,9 +876,10 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 {
 	unsigned long err_code = 0;
 	unsigned long retval = 0;
+	bool hex_format;
 	bool print_retaddr = false;
 	bool print_retval = false;
-	bool hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
+	int retval_fmt = 0;
 
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	retval = graph_ret->retval;
@@ -888,17 +890,38 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
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
+		hex_format = !!(opt_flags & TRACE_GRAPH_PRINT_RETVAL_HEX);
+		btf_trim_retval((unsigned long)func, &retval, &print_retval, &fmt,
+				hex_format);
+		if (print_retval) {
+			if (hex_format)
+				retval_fmt = RETVAL_FMT_HEX;
+
+			if (retval && retval_fmt != RETVAL_FMT_HEX &&
+			    !(fmt & RETVAL_FMT_BTF)) {
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
@@ -925,10 +948,17 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
 				    trace_flags, false);
 
 	if (print_retval) {
-		if (hex_format || (err_code == 0))
+		if (retval_fmt & RETVAL_FMT_HEX)
 			trace_seq_printf(s, " ret=0x%lx", retval);
+		else if (retval_fmt & RETVAL_FMT_BOOL)
+			trace_seq_printf(s, " ret=%s", retval ? "true" : "false");
+		else if (retval_fmt & RETVAL_FMT_UNSIGNED)
+			trace_seq_printf(s, " ret=%lu", retval);
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

