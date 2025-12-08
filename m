Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA773148D7
	for <linux-trace-kernel@vger.kernel.org>; Mon,  8 Dec 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199968; cv=none; b=MIIGV3Tiay2D0Z6ghlxxAU8hr5NfdohPVAMhAL4EO/eyDay0YEdUYOph2petMC/AIIff3Da7QuszgACuwwR49J3KEZX5R63HDJMelb4xGFSydqWSt9HVX2nXwVAcdhtlPyGZjF9kjlDLgaRsIO3fPdUe7fkvy5aGWhOfTKBpC7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199968; c=relaxed/simple;
	bh=30o7EXsT+3UE9XemGnLUmRBLG1W6L02/uoH/F43nEZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BWotCkaGP/FndHaqp4mXeFGkZYgDFpQkEAElsY/IRy15elXWLKOyA5M/j4mHMd6IuENCC9waDvAtwVV7viZtCZEeUOkeAJuW70+6R0SizFiWPGbDb5AAPHWyTHTwuReciIymXOidNzBth2eomq6RSHPIVAxvv7d/RxzrUPvc9Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4wS5yNZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4wS5yNZ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29555b384acso45369825ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 Dec 2025 05:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765199966; x=1765804766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZnyUry+1w8xao5+MHyxhYILKDa1nn4nE9blPajp6gw=;
        b=G4wS5yNZjiOURtICLLVcSskh/lLVrSopH7L0y09BhaUHXCbopeaO7y19/ARIb54mOy
         5pjOVnlAw0Ls5TPxpbi1EMUwhVDewjED8SXjo/gmwDRc1kWsznKlLyDtD2/1VPwhoCo9
         Vm5uKtYY1ebm6kW9n9A/i+MdHV6HfFEla2UOlX7hGCYOLOPj6mfnQ7MKqtgPBr6Lgq1S
         5x52l63sypJnqESxjS2HeNdiIdzt/mHqiKOrNe0+bcd4e/wfv6C6EYfnpJJwMx4TQiO4
         SHKzPQnP7CRksNl5av+31SPKbgRX15V/exz1KWp6N0m5ZoREG8UsdpT2ISN/Bpbt4e4b
         vvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765199966; x=1765804766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lZnyUry+1w8xao5+MHyxhYILKDa1nn4nE9blPajp6gw=;
        b=aEskpp2aa0vGLl96/xZ890vDe9sVtSox7At1acDn9J69TTvwCcxse60AWZlzmZL3Cn
         kn3JHtgiEi9Iwld0UpnsWQubFIOZVOZoHe/AbXsajP9AODQ/ndRdP/zoKFCuavQg8wrA
         oJPZVwpbtEc85rlTtKHyz6bG0MwigV1qtnfQAVqOC0QW3kUzJ+fIcdWcqcCU4IxVlD7c
         0on6rufGecDNEzdwIJA24kOYpo3kwKG7gbuqtSP3SqsLbIdmhYID9E0rKgvtS/DJmk60
         7swSfOh00NKAMnjnOejyRwWcJPvMAZsNiGBun8zAlE9Mp4ziOzTUrs627vAaTY6CJQvz
         ZFHw==
X-Gm-Message-State: AOJu0YzmN7c4uUWR+e+DI+dRkN8efQDKNFAHMziB105GufOyM2hrQbLP
	Ar3JatNxadgyq6MXLZ3x+JMuZEu/P650SGaqmDREqJ0n8sD2jUcMk1xRUZKIkLFD
X-Gm-Gg: ASbGncsYTI5yhV2KTiOc5smBSrvvJXGsFpPyNp1smEKgcWgs8OWz+GueYp1NU4f+W1v
	XrPJ7qyOt6sOIdHIq5V9GADbNgqrNr8TqhheFqezia/yRxnqFmq5lxOPQreYYSOMkuvch1tXTBp
	lcFSPeoiBJMYZ353mmvB91150k6pm99SJkjAMZdw2u/ccnMAL2Dk/IFH5z5zpkXuOR7UHf2N6EK
	MCBT7wkNGbK4+EoQWHNP0EqN6hapAukf4zcddejwad0uXwTriH17y3mNCmqcw51++yVZV6GyWda
	Elc6Eeic6IP1+X4qdyasFobKTAeIBRqIdJjF4CpFVwuCT0dAHoAxEJnF778TQ9pIoLNZmqLDbBf
	q5CE1XGEI3qcKEMGndzs4aimE5IpgbE12tydI/k7EtBmVycXpQ80I7vQSpRupKr6/4AifZz26/l
	3oqkPF3miSOxd5GK6T6us7AC/quOE=
X-Google-Smtp-Source: AGHT+IFWXGjhBj6hkqmebRecDz2AWq0HxXcKoCZvpg7M+b+Y6TIyVk5TEkPd/s/kMEV1LLpgSWp5lw==
X-Received: by 2002:a17:903:2f84:b0:295:57cc:cfb5 with SMTP id d9443c01a7336-29df880d030mr64767545ad.37.1765199965715;
        Mon, 08 Dec 2025 05:19:25 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29daeaaba21sm126848595ad.70.2025.12.08.05.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 05:19:24 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Subject: [PATCH v2 1/2] fgraph: Use BTF to trim and filter return values
Date: Mon,  8 Dec 2025 21:19:16 +0800
Message-Id: <20251208131917.2444620-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251208131917.2444620-1-dolinux.peng@gmail.com>
References: <20251208131917.2444620-1-dolinux.peng@gmail.com>
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

