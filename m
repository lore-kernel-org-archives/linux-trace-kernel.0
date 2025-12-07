Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B302EE5F5
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Dec 2025 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765117675; cv=none; b=BzZf2UnBARFO3j72M96Y4s6/O9Jh05R4C3hKvAU83AfWl1DOt013FZvFyZIiPggqrWToPDWTI4GIU1p3FfIr4EnaOmPutYt6wbM7zlu6PtSsZea7kA9UxdxhqbDomT3YUty8kzQ5g5pVALazaNFfrrc3GoD8ZT9ZGfTLJhOFnD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765117675; c=relaxed/simple;
	bh=30o7EXsT+3UE9XemGnLUmRBLG1W6L02/uoH/F43nEZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LriYzPvcYsNCqos94Hq55dGSM+oMJUbMxZB6bTrtpa7UNiF18aqQzx0tfzrMjVt4p8/yDEMLxbS9I7yF9zwEONGiVhZJ+iWZ/0lFa8k8rqrlkieNTRqgyI8LvrGgddIGizYFiqRBCrdN5fUzexaI0DgI6Y9cgouL4VCuYx7m6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/f+c+Xu; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/f+c+Xu"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34381ec9197so3080990a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 07 Dec 2025 06:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765117671; x=1765722471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZnyUry+1w8xao5+MHyxhYILKDa1nn4nE9blPajp6gw=;
        b=f/f+c+XuZqgkMEXPAy1kmWFMbvXsQ4xErsuAjK5f43O/Eh6s72iB3qhtqE+p2i1lgK
         TY5Bd681ke2tB2GYFFQmKTHlxjumkGsS5qxj5irM98b128seCDdKKy4fvbIx4au6NGtU
         YozjzPykK209V1yW5H7WQKT6UJVZjGF1T08RuoGnavrTU1zGptT6GKGcWgt5ciOv6ehK
         +OjKssIuE9HUH6YgVIPfUyE4T/uUKgxXd44pO65EwvsgHZz4yPnuQy+GNF8ikctztMGE
         nxd5BvHwka0JzUijOQQUIEq050A4d9ZBoM7lN6aZoBzh7FDvcGigIJAFEoHIiXLKVzEC
         IB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765117671; x=1765722471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZnyUry+1w8xao5+MHyxhYILKDa1nn4nE9blPajp6gw=;
        b=oOw/ETrBmA2BYivF9lF4PjuEz+/4cmT6MQCyVuhsXH7J32VwuZKHYz0PzCa0IMmXDf
         CaQZqouw/jTs4ic6PBZWP6jtiwH6tIED02o3MAZJZZeMBgZ48co7b6twKABJjmbMO/qs
         H199yh4NS/OHEanG5gW6UZNhkYZeYzylw29Z4VGKLOjt5Vtrh02/XtrOV8lOXgRMIktM
         aRQtQofw8kbPqXhrzd2XgpnP5j0gV/4cniTf7pOIY9q+yr14+M7CJdNIYSkI1MxeDgEJ
         gGfwDu6jMyecVy/F3BDnrWG9n4dHO+TegIovpDXlOx6nP2eNNM44HVhzTih2ilduFFoA
         WefQ==
X-Gm-Message-State: AOJu0Yze5O0Z/sQOehMaO+g/6j5FrFjReQe4c27ASWqeNkfmLX7yIaS1
	QUTZB0m3Yx51ckDLRFMWWQvnvVAA96qXb9Li3l+sw30x+7lWzdWk7oLR
X-Gm-Gg: ASbGnctV7k8V5o9DtstWK5LsDkm9tOuUjwRHzbRkCmWuPFvk+NxtDnWqV6/U0Cj9lar
	2dOTgg2xHNG2q3N9VoGnD76aLM2F++SwrQD959azfTJFj+btoyFG1D/ljyugIe2YNLPyHcT7vG2
	NtynrMBPMGQ61sS331rnk+7ErmCbxikInqvmOP9C+HptQSqt7MdC0quUqbQQSW773YECjbiIxva
	RzkFVb3m79m9Myh6CXPCw05v4SsE+UhaLvOuItxOFAGRL1Ig+ZzrdJ25wD4YbBEhG4MXq/L/UXH
	WJAzbamzzOrgGsRwYoahMgBGr0OgYEn/ORikgkkZmbj6H5j3AiNcB+uPDIWlq612G6zFs/qR5bh
	ksK5cDhQ2GGo8/4slxTaQbHddYL0C+Rh0c336BfUsQ7HiLJk1/pb1z19wP6cubjdSq8/VjHwcRW
	2GoTBoQBg7umWJfoWFVTQfZJYzoj8=
X-Google-Smtp-Source: AGHT+IH9mYL+8pQfNgZ4r8ZFqW+QSWz3AKdRwbEmCblz9taenxcf6eaYppGqEuojMUEJzBiNafSuyw==
X-Received: by 2002:a17:90b:5546:b0:343:eb40:8e01 with SMTP id 98e67ed59e1d1-349a26223e5mr3565025a91.27.1765117670867;
        Sun, 07 Dec 2025 06:27:50 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bf686c32deesm9514792a12.13.2025.12.07.06.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 06:27:49 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v1 1/2] fgraph: use BTF to trim and filter return values
Date: Sun,  7 Dec 2025 22:27:41 +0800
Message-Id: <20251207142742.229924-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251207142742.229924-1-dolinux.peng@gmail.com>
References: <20251207142742.229924-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

The current funcgraph-retval implementation has two limitations:

1. It prints a return value even when the traced function returns void.
2. When the return type is narrower than a register, the printed value may
   be incorrect because high bits can contain undefined data.

Both issues are addressed by using BTF to obtain the precise return type
of each traced function:

- Return values are now printed only for functions whose return type is
  not void.
- The value is truncated to the actual width of the return type, ensuring
  correct representation.

These changes make the funcgraph-retval output more accurate and remove
noise from void functions.

Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
---
 kernel/trace/trace_functions_graph.c | 64 +++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 17c75cf2348e..9e63665c81e2 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -15,6 +15,7 @@
 
 #include "trace.h"
 #include "trace_output.h"
+#include "trace_btf.h"
 
 /* When set, irq functions might be ignored */
 static int ftrace_graph_skip_irqs;
@@ -865,6 +866,46 @@ static void print_graph_retaddr(struct trace_seq *s, struct fgraph_retaddr_ent_e
 
 #if defined(CONFIG_FUNCTION_GRAPH_RETVAL) || defined(CONFIG_FUNCTION_GRAPH_RETADDR)
 
+static void trim_retval(unsigned long func, unsigned long *retval, bool *print_retval)
+{
+	const struct btf_type *t;
+	char name[KSYM_NAME_LEN];
+	struct btf *btf;
+	u32 v, msb;
+
+	if (!IS_ENABLED(CONFIG_DEBUG_INFO_BTF))
+		return;
+
+	if (lookup_symbol_name(func, name))
+		return;
+
+	t = btf_find_func_proto(name, &btf);
+	if (IS_ERR_OR_NULL(t))
+		return;
+
+	t = btf_type_skip_modifiers(btf, t->type, NULL);
+	switch (t ? BTF_INFO_KIND(t->info) : BTF_KIND_UNKN) {
+	case BTF_KIND_UNKN:
+		*print_retval = false;
+		break;
+	case BTF_KIND_ENUM:
+	case BTF_KIND_ENUM64:
+		msb = BITS_PER_BYTE * t->size - 1;
+		*retval &= GENMASK(msb, 0);
+		break;
+	case BTF_KIND_INT:
+		v = *(u32 *)(t + 1);
+		if (BTF_INT_ENCODING(v) == BTF_INT_BOOL)
+			msb = 0;
+		else
+			msb = BTF_INT_BITS(v) - 1;
+		*retval &= GENMASK(msb, 0);
+		break;
+	default:
+		break;
+	}
+}
+
 static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entry *entry,
 				struct ftrace_graph_ret *graph_ret, void *func,
 				u32 opt_flags, u32 trace_flags, int args_size)
@@ -884,17 +925,20 @@ static void print_graph_retval(struct trace_seq *s, struct ftrace_graph_ent_entr
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
+		trim_retval((unsigned long)func, &retval, &print_retval);
+		if (print_retval && retval && !hex_format) {
+			/* Check if the return value matches the negative format */
+			if (IS_ENABLED(CONFIG_64BIT) && (retval & BIT(31)) &&
+				(((u64)retval) >> 32) == 0) {
+				err_code = sign_extend64(retval, 31);
+			} else {
+				err_code = retval;
+			}
+
+			if (!IS_ERR_VALUE(err_code))
+				err_code = 0;
 		}
-
-		if (!IS_ERR_VALUE(err_code))
-			err_code = 0;
 	}
 
 	if (entry) {
-- 
2.34.1

