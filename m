Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785832E975A;
	Thu, 28 Aug 2025 07:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366479; cv=none; b=M7rXeYOkw2GIxe68MAYPnW4m78KMgVonkL7CDqsLHTWW95WEX5cxb2wjtTHSv132jwF29K/sde2P4fSbh7woOWkOydwGdzPMxnQjE5Cznm2+Xp5A3I50YXyt7jon+G0d+pp3I5pyJ0ErYqVxe426k+SeyMksrQr9OLKpAxXgxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366479; c=relaxed/simple;
	bh=GWYsCj2bqT7yEVuQqPqCBzjmTA08Q3+v4IQiO0uA9LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3Fq6XDpLmNgUn85gfvKRf/2wjYEgDLjSmGmRAer0yA72z+vIRflg6ejNpEOlLjsE5OgzdLlgbnZ2sKqmDRTI7REtrFUkChaR8Cij6qlDmo8fYj1xnm4g21CGUySJYnhWWa9Lsa19+KYqh+u3/DgIdB1Mnra5OAgPWhm5PDemZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNXQsxP+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNXQsxP+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7720f231174so595483b3a.1;
        Thu, 28 Aug 2025 00:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366478; x=1756971278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3AulfcHa1eTu5KICr74URcMQphKQ/vLHucAGhDPpIY=;
        b=UNXQsxP+EXVARALlAHiv0Ji4EyaheeafIKJ7D1z+Ao/C373LW0TKBOkcWqocyUucud
         fNwlO6neP0SBQyL87Cv/+16Mn7xf5W60SZtkGEBoHufXKv/1Isl2fDpUveVJ+TeL9KU7
         M7UkcH0i2IfX11eA/f+4m9lfmRKdiZbH9y0HpFaL6ZV24rxX0KQ8a+dZThsFpYUbt813
         06ZF2oHMSbG34qaxVpqfxCr/Yc68hL4l3i/mSy62lMo/30jm8quJDK0poKH5+f5mhKZV
         Jbjb6pkdnviTN7SvslVoVA8+ZhJOdGtpzovE1RBV1BaPhnF0MQqpu/F7XhLCC5obNQ22
         sCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366478; x=1756971278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3AulfcHa1eTu5KICr74URcMQphKQ/vLHucAGhDPpIY=;
        b=KUgMhOvTI8rF76/mgpqk4sWt2YOeJt5HwF6bVUOFSTSi8azmm8Aa9heoh4w2s4VpSY
         8XiZPq12FnbbIprW5zig6rX6DttoOf2dG8oN2qAPPQGM4vE07k0Vl7JCaXohjhFNU3oI
         bExyyHPigs9e9Q4wTLsb0TVEOVGNPANAOCVjVP8LG+BPyULwAr/R/RBKYgxOA9dcGlBW
         YghdgiTBMCXIPm3rIV17G9TBV7CRJaQMIiHpIfYDMtDVyOyN2I93avOamgP4RIYRWlHe
         HsRu+zK675dZKw/vHSRYGZNQ/JrJlFJ08W29KxXyfNMjWwnH+prPXrDfdU2XqGgIAL+J
         daGw==
X-Forwarded-Encrypted: i=1; AJvYcCVWlKXqX4fI43mRZpeZGKvxgv7ENQ2Y7qxZEOUUpL9usNx/lJilyTnVO9vwRsf5NFVAavaF5tkbJ59jxtsD7eSrZ1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL05sV/oIk8kM0DshPJjlgbOH78QQE6E6/QbIXBw6qekCQtrrj
	+H0NYT6+PDJAUyanVQwHctCcWfrvSaXO5wQ++rRDUrcC1/CWlV9Ep7ai4iKzoATG3rQ=
X-Gm-Gg: ASbGncsqcMbb2FLtVRboKNLwrVw/cbkha/U5Uw8e3exCsmRekkaAVrR7sDMw+JP9Yie
	yAgrZxPxOTJ5wPNESkhgOR6TNkMDkebYWF2Tl5qCcPRYa+PyLBdfrGG5K7kCzRU4DpLba5OYNP8
	0m3Qr7spASEli4igt51IoJspIu0dwy+6YA8BF/+PnYNJF4ZUygvtD850C3nF5hwXVlOfrS5nZN8
	bGwWGG2/y5waSwLNpLKtocH1kWsv1OrKHAhmt5KLewZxo1P7+XXHIX8T0wCtmlfvdLkkXdYCbo2
	Fv/gmrJQ21Q/1rKaMFM8YzBzjqHw8CyHAs2tP8mcgFZK/F2XQYVRM0Rr/w61cwtV2+prRUKGlTk
	Udvs3JrooMCFi93e4UpSt5moHW+BCKT1fUCB6NMxeUZQA2UFJ41Ty1F1EVbAi
X-Google-Smtp-Source: AGHT+IEQPKTDJOGVO2EbTeY/cLoR+hJ9sc+9WFZR9p9/1pqb0apVThZUN4kWnczmM0yNi/O2dtI1UA==
X-Received: by 2002:a05:6a20:748d:b0:243:b144:ad9d with SMTP id adf61e73a8af0-243b144b0b5mr1218934637.6.1756366477661;
        Thu, 28 Aug 2025 00:34:37 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:37 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 08/17] mm/ksw: implement stack canary and local var resolution logic
Date: Thu, 28 Aug 2025 15:32:41 +0800
Message-ID: <20250828073311.1116593-9-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement logic to resolve stack watch target for kstackwatch:
 - Locate the stack canary within the current frame
 - Resolve local variable offsets relative to the stack pointer
 - Validate addresses against current task's stack bounds

This logic prepares watch addr and len for use in kprobe/fprobe handlers,
enabling dynamic stack monitoring.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/stack.c | 102 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 3 deletions(-)

diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
index 3b72177315cc..1d9814a58fde 100644
--- a/mm/kstackwatch/stack.c
+++ b/mm/kstackwatch/stack.c
@@ -1,22 +1,118 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/fprobe.h>
+#include <linux/interrupt.h>
 #include <linux/kprobes.h>
+#include <linux/percpu.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/stackprotector.h>
 
 #include "kstackwatch.h"
 
 struct ksw_config *probe_config;
 
+/* Find canary address in current stack frame */
+static unsigned long ksw_stack_find_canary(struct pt_regs *regs)
+{
+	unsigned long *stack_ptr, *stack_end;
+	unsigned long expected_canary;
+	unsigned int i;
+
+	if (!regs || !regs->sp)
+		return 0;
+
+	stack_ptr = (unsigned long *)regs->sp;
+	stack_end =
+		(unsigned long *)current->stack + THREAD_SIZE / sizeof(long);
+	expected_canary = current->stack_canary;
+
+	for (i = 0; i < MAX_FRAME_SEARCH && &stack_ptr[i] < stack_end; i++) {
+		if (stack_ptr[i] == expected_canary) {
+			pr_info("KSW: canary found i:%d 0x%px\n", i,
+				&stack_ptr[i]);
+			return (unsigned long)&stack_ptr[i];
+		}
+	}
+
+	return 0;
+}
+
+/* Resolve stack offset to actual address */
+static unsigned long ksw_stack_resolve_offset(struct pt_regs *regs,
+					      s64 local_var_offset)
+{
+	unsigned long stack_base;
+	unsigned long target_addr;
+
+	if (!regs)
+		return 0;
+
+	/* Use stack pointer as base for offset calculation */
+	stack_base = regs->sp;
+	target_addr = stack_base + local_var_offset;
+
+	pr_debug("KSW: stack resolve offset target: 0x%lx\n", target_addr);
+
+	return target_addr;
+}
+
+/* Validate that address is within current stack bounds */
+static int ksw_stack_validate_addr(unsigned long addr, size_t size)
+{
+	unsigned long stack_start, stack_end;
+
+	if (!addr || !size)
+		return -EINVAL;
+
+	stack_start = (unsigned long)current->stack;
+	stack_end = stack_start + THREAD_SIZE;
+
+	if (addr < stack_start || (addr + size) > stack_end) {
+		pr_warn("KSW: address 0x%lx (size %zu) outside stack bounds [0x%lx-0x%lx]\n",
+			addr, size, stack_start, stack_end);
+		return -ERANGE;
+	}
+
+	return 0;
+}
+
 /* prepare watch_addr and watch_len for watch */
 static int ksw_stack_prepare_watch(struct pt_regs *regs,
 				   struct ksw_config *config, u64 *watch_addr,
 				   u64 *watch_len)
 {
-	/* TODO: implement logic */
-	*watch_addr = 0;
-	*watch_len = 0;
+	u64 addr;
+	u64 len;
+
+	/* Resolve addresses for all active watches */
+	switch (config->type) {
+	case WATCH_CANARY:
+		addr = ksw_stack_find_canary(regs);
+		len = 8;
+		break;
+
+	case WATCH_LOCAL_VAR:
+		addr = ksw_stack_resolve_offset(regs, config->local_var_offset);
+		if (!addr) {
+			pr_err("KSW: invalid stack var offset %u\n",
+			       config->local_var_offset);
+			return -EINVAL;
+		}
+		if (ksw_stack_validate_addr(addr, config->local_var_len)) {
+			pr_err("KSW: invalid stack var len %u\n",
+			       config->local_var_len);
+		}
+		len = config->local_var_len;
+		break;
+
+	default:
+		pr_warn("KSW: Unknown watch type %d\n", config->type);
+		return -EINVAL;
+	}
+
+	*watch_addr = addr;
+	*watch_len = len;
 	return 0;
 }
 
-- 
2.43.0

