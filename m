Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F3D2D193B;
	Tue, 29 Apr 2025 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928102; cv=none; b=WfvM7IjVFwDRgbgM54c80FS1HYUMCNbjw/vcq9TfBh8t/EBlcTaTue4BI/z7AE3z/Nc1aW97ZrF79lyuljuk47Ufb7CNNYpYMZ+Nw+fKSUXD5SM2qGCGiPWJJNgYPwpS4LWNJXIlfARyeovAIzAFt0YRbZXpZfbH0JNEDHLMLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928102; c=relaxed/simple;
	bh=eX5oXC+HBcw1mu0TCAHq5i0a+I/QmsXUI8/vYm8odp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kypJOYfUPQ3rAjVSxJtzzHy4cT7FMzDkRj2CH7meoGG6y2mXL+KdDKHxGYpgk8uF9wntxXkeEpw3b5zu8iB1RIfWidiIS6idt4JipMewuoxkL3wZyJfm/gnVcL83Hof8X0IKo1IBUQfSXwfHLFYkOxMn9ZYUgDQXSHxJEKS8gCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zs50VbMd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kUuJdrB1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zs50VbMd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kUuJdrB1"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=zs50VbMd5RPwPLLoES8n9vP5JDBeTma5SNNlVGcRoV8H+HTZB9R7c3aP96Cx9Mdk16UBvw
	RNBgsv4/UFu6erZ5g3/N5FznYjJ+j9VDtBaL/2Xp3d4bHLZxM4p5RPk1QBLHFQRNAUPded
	ZAvHlTtx0pMZtriVVtm/hXnjV/XbgvGa/dwybOQ9sxFsuIWG5Mkute9JbKpeXdOWtq1bEz
	xIowuDFUr1928UvbunJnQ7VloI3F2d413tNzi2CVfU47z/FICZOHp0BMSN5ut9KsCz1lRY
	JgFrPAIRedLPGsyCQwVlTHg4L6cfFlfj6ENHb+ybgKbD/F9vdItQo1jkpIVMLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=kUuJdrB1DQ5Z21gxVBukh/xivxxLllH4B3gcRA6T9DaPj9+cx0CMQe51sKURkyfvet4IL7
	IsRe9NUtI2CELhCA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 18/23] riscv: mm: Add page fault trace points
Date: Tue, 29 Apr 2025 14:01:03 +0200
Message-Id: <dbcd52978bc997a59181b3d22601bf7c3c8210ed.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add page fault trace points, which are useful to implement RV monitor that
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Acked-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 0194324a0c50..04ed6f8acae4 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -20,6 +20,9 @@
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 #include "../kernel/head.h"
=20
 static void show_pte(unsigned long addr)
@@ -291,6 +294,11 @@ void handle_page_fault(struct pt_regs *regs)
 	if (kprobe_page_fault(regs, cause))
 		return;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, cause);
+	else
+		trace_page_fault_kernel(addr, regs, cause);
+
 	/*
 	 * Fault-in kernel-space virtual memory on-demand.
 	 * The 'reference' page table is init_mm.pgd.
--=20
2.39.5

