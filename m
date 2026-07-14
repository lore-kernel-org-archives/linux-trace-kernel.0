Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64936412BF1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053404; cv=none; b=lLXWvuC7sXACu77s97Z5o4ZYtrLxyqlDxMMI72pMTKCVRB2m88Sbh4LmGVCkZL4WKmITfXAr5IGYM1SwjeBJrrqQIj0vy6WX+qi3pSsIReGBHyeqn6Rl10Rw0+cZjsQiVfei0wXdwlXKiBC2Za3jYZ1RSJ91xVONIS7hUtkxpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053404; c=relaxed/simple;
	bh=iVQiaA1gzp4jOsMpivY/o63c2zQA1k2CD9ORqm0FVf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRthtMBt42WCF8KYv+3whj0g3ByFklQaiEoedVqDrCAWA3Hb2muJp2B20wce/VwCDx06Mgt/zO3a+iakMrR7iAXF4AC30K+NREKDerJ4/5CgCOp5mxBdfuI8yp4B1gc2vZkfYtMznaQBPAEK1IamWpb3G1o4OHo2CtkX+I07lVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jur5QtTv; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jur5QtTv"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92e50a650a0so240256285a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053401; x=1784658201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lu1r+dI7YhT/+Q6NrL3ZLzbfp3koK+yzDpN5AF+wuNI=;
        b=Jur5QtTvSrOL3J5B6UY4ZG+7iCg1zrBxM9REA587hphoH16xCNakYhvzt3pifzkFuN
         2u1UWTSRIsGAfFozHgYi4tTcEL5VPyS+FETaAZg2olAs/ZlMxtKxf6YkvNCeoND9TAMD
         VRJuJ9XEqED6w7BWVRk1qmwv1bd/YECeamFa/w8Y3JnQWp4vixTI6lYM+GX6ivzpCGz9
         qkTOHySpgE8kAIWBSNnTysy6BTWGP+wMc+mWhizqYOaABSJ9X4FI703wXD+9plm219ig
         AKM9Wi++sQr2MNhmxa/CSwAl+mwzoTzrv9QjwmHKVmy6zaTCVSBzVperO11F58T8Eb8b
         9jMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053401; x=1784658201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lu1r+dI7YhT/+Q6NrL3ZLzbfp3koK+yzDpN5AF+wuNI=;
        b=f6V8AfP88f+fseIssIGNjxYhXFKkuun/9I/Rmk9bjggq9o93SpcVV7izLQ203QW7Jk
         YyKkiEovFrVCZnafWNVqUeqhIsB8C1WnbJ3VTENy0o6F8vxfkVLuej58Z5JlweFi2UFf
         4gdVLBGbOafx95otEa8TFxGs2Aj1F+rYCTrLVkIcolw1pMjNQmgouLmCe9XH2KfJBAV7
         m7QhQEEwQoOuPqGoH3EAZOnSyLvM4wdwtb0Cyy+qfLzVb2WA16VzvxTiekzGsm2v9XrP
         IBHJlOxMPMP3zh1v01FHxcGiYpdXrsnzre65FX2b4mnXd19iYusYwmikmN1AVeRLoIWu
         0e4w==
X-Forwarded-Encrypted: i=1; AHgh+Rryng/YIBO53Tti2rL9yTZWWZjMvNtNXYvuNW3yzz8yurqEj0VX8WitYNtRMaFc2ZjV6G+KafG38yJNJh5eJv9wtpE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNbUWm027/foEWMoIBKgSi00sPEoyOA+Z/8tbAjrYYMk97D96u
	GnUaFzRa3b22yeTOUaipbGZkAmnskUul9DLlq9rB/mqAV+iIzfe+M+Bt
X-Gm-Gg: AfdE7clqKabUt1Pe4Uo0MTg8Mg8U1GSWCmBGYWImS0seegOjP0N2RKlgN7c9Iq8QdC8
	KA5czcLaOK810plBVaA8JzpHTLIgb6XW+XaxNbml4Vvru8vCW3rC/Dt7bBZtPy/trGx4ZKQWqNu
	5SvG0taPu2UroZffKQOoUAey98Cue+PlQ19oJoErSBbdyD/wdWUkVtha1l3kLB0Tl/tjXmwreDe
	r7D2hBUXSdAScKmGescGnIQPpkwEZOmqDur2H8J6a2sGGt5Qw9OKlfNs7ND833YuAREEOZtaKk5
	29tXoEY3Sh6zy/0Ie2Pj4cW9b6mjJxLkpZol0eN9cNjh/Er+CboLeFShTlPDgFymb6Jb3NNZH+b
	MD/s8kHtrqnXCLy+154MyIXg5hiBEP4fJgU41domARcPiM+8HrVHHNYRtdpLT8ogv3idkhzaKDh
	P/rIMECKAi4RIC1XxYP3lP36HRQN2CXy5yc9FocsktoC0HCdAWVK4=
X-Received: by 2002:a05:620a:408c:b0:92e:9cb3:3f71 with SMTP id af79cd13be357-93086a5a11emr367980985a.36.1784053400994;
        Tue, 14 Jul 2026 11:23:20 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d33689sm1501801285a.36.2026.07.14.11.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:23:20 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 02/13] x86/hw_breakpoint: Unify breakpoint install/uninstall
Date: Wed, 15 Jul 2026 02:22:32 +0800
Message-ID: <20260714182243.10687-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Consolidate breakpoint management to reduce code duplication.
The diffstat was misleading, so the stripped code size is compared instead.
After refactoring, it is reduced from 11976 bytes to 11448 bytes on my
x86_64 system built with clang.

This also makes it easier to introduce arch_reinstall_hw_breakpoint().

In addition, including linux/types.h to fix a missing build dependency.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/include/asm/hw_breakpoint.h |   6 ++
 arch/x86/kernel/hw_breakpoint.c      | 141 +++++++++++++++------------
 2 files changed, 84 insertions(+), 63 deletions(-)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..aa6adac6c3a2 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -5,6 +5,7 @@
 #include <uapi/asm/hw_breakpoint.h>
 
 #define	__ARCH_HW_BREAKPOINT_H
+#include <linux/types.h>
 
 /*
  * The name should probably be something dealt in
@@ -18,6 +19,11 @@ struct arch_hw_breakpoint {
 	u8		type;
 };
 
+enum bp_slot_action {
+	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_UNINSTALL,
+};
+
 #include <linux/kdebug.h>
 #include <linux/percpu.h>
 #include <linux/list.h>
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index f846c15f21ca..877509539300 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -49,7 +49,6 @@ static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
  */
 static DEFINE_PER_CPU(struct perf_event *, bp_per_reg[HBP_NUM]);
 
-
 static inline unsigned long
 __encode_dr7(int drnum, unsigned int len, unsigned int type)
 {
@@ -86,96 +85,112 @@ int decode_dr7(unsigned long dr7, int bpnum, unsigned *len, unsigned *type)
 }
 
 /*
- * Install a perf counter breakpoint.
- *
- * We seek a free debug address register and use it for this
- * breakpoint. Eventually we enable it in the debug control register.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * We seek a slot and change it or keep it based on the action.
+ * Returns slot number on success, negative error on failure.
+ * Must be called with IRQs disabled.
  */
-int arch_install_hw_breakpoint(struct perf_event *bp)
+static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long *dr7;
-	int i;
-
-	lockdep_assert_irqs_disabled();
+	struct perf_event *old_bp;
+	struct perf_event *new_bp;
+	int slot;
+
+	switch (action) {
+	case BP_SLOT_ACTION_INSTALL:
+		old_bp = NULL;
+		new_bp = bp;
+		break;
+	case BP_SLOT_ACTION_UNINSTALL:
+		old_bp = bp;
+		new_bp = NULL;
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+	for (slot = 0; slot < HBP_NUM; slot++) {
+		struct perf_event **curr = this_cpu_ptr(&bp_per_reg[slot]);
 
-		if (!*slot) {
-			*slot = bp;
-			break;
+		if (*curr == old_bp) {
+			*curr = new_bp;
+			return slot;
 		}
 	}
 
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return -EBUSY;
+	if (old_bp) {
+		WARN_ONCE(1, "Can't find matching breakpoint slot");
+		return -EINVAL;
+	}
+
+	WARN_ONCE(1, "No free breakpoint slots");
+	return -EBUSY;
+}
+
+static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
+{
+	unsigned long dr7;
 
-	set_debugreg(info->address, i);
-	__this_cpu_write(cpu_debugreg[i], info->address);
+	set_debugreg(info->address, slot);
+	__this_cpu_write(cpu_debugreg[slot], info->address);
 
-	dr7 = this_cpu_ptr(&cpu_dr7);
-	*dr7 |= encode_dr7(i, info->len, info->type);
+	dr7 = this_cpu_read(cpu_dr7);
+	if (enable)
+		dr7 |= encode_dr7(slot, info->len, info->type);
+	else
+		dr7 &= ~__encode_dr7(slot, info->len, info->type);
 
 	/*
-	 * Ensure we first write cpu_dr7 before we set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 * Enabling:
+	 *   Ensure we first write cpu_dr7 before we set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
 	 */
+	if (enable)
+		this_cpu_write(cpu_dr7, dr7);
+
 	barrier();
 
-	set_debugreg(*dr7, 7);
+	set_debugreg(dr7, 7);
+
 	if (info->mask)
-		amd_set_dr_addr_mask(info->mask, i);
+		amd_set_dr_addr_mask(enable ? info->mask : 0, slot);
 
-	return 0;
+	/*
+	 * Disabling:
+	 *   Ensure the write to cpu_dr7 is after we've set the DR7 register.
+	 *   This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	if (!enable)
+		this_cpu_write(cpu_dr7, dr7);
 }
 
 /*
- * Uninstall the breakpoint contained in the given counter.
- *
- * First we search the debug address register it uses and then we disable
- * it.
- *
- * Atomic: we hold the counter->ctx->lock and we only handle variables
- * and registers local to this cpu.
+ * find suitable breakpoint slot and set it up based on the action
  */
-void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+static int arch_manage_bp(struct perf_event *bp, enum bp_slot_action action)
 {
-	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
-	unsigned long dr7;
-	int i;
+	struct arch_hw_breakpoint *info;
+	int slot;
 
 	lockdep_assert_irqs_disabled();
 
-	for (i = 0; i < HBP_NUM; i++) {
-		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
-
-		if (*slot == bp) {
-			*slot = NULL;
-			break;
-		}
-	}
-
-	if (WARN_ONCE(i == HBP_NUM, "Can't find any breakpoint slot"))
-		return;
+	slot = manage_bp_slot(bp, action);
+	if (slot < 0)
+		return slot;
 
-	dr7 = this_cpu_read(cpu_dr7);
-	dr7 &= ~__encode_dr7(i, info->len, info->type);
+	info = counter_arch_bp(bp);
+	setup_hwbp(info, slot, action != BP_SLOT_ACTION_UNINSTALL);
 
-	set_debugreg(dr7, 7);
-	if (info->mask)
-		amd_set_dr_addr_mask(0, i);
+	return 0;
+}
 
-	/*
-	 * Ensure the write to cpu_dr7 is after we've set the DR7 register.
-	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
-	 */
-	barrier();
+int arch_install_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
+}
 
-	this_cpu_write(cpu_dr7, dr7);
+void arch_uninstall_hw_breakpoint(struct perf_event *bp)
+{
+	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
 }
 
 static int arch_bp_generic_len(int x86_len)
-- 
2.53.0

