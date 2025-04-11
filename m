Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075029899E;
	Fri, 11 Apr 2025 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357097; cv=none; b=R8J+rBUOIJ/ea/VKqcZiyg2aMF4ptnE49c7LVkfHzLQPJkVYW6z16cMNoYKdnOYXG4PwMOEszOsZJN4SYucts2ZSE2uCXNKLollVFe7EdQLAEwm07dJkb9QkLWxWg0wzquu/DQlf/MXZOCRheQjVvoDa1AW25TZOtbWr3Fv9t7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357097; c=relaxed/simple;
	bh=eX5oXC+HBcw1mu0TCAHq5i0a+I/QmsXUI8/vYm8odp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1DgpvaUn/KHjkUnOrkudHWIRdQj66S4Ilo1zYrbn+1zYwxp7v0fVJ52J3iv+lwVEFtNLMlyJ75T/NKnFsbejJjaoxyCPeiExb/9pcxquE0pflD8oq+nhHj+mJ2krjQ9jVjC42my4eiSalapG/h5DGPbr3dMEGgDTVzBAXHuEQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/2Rsani; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0Iqet4p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/2Rsani";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0Iqet4p"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=c/2Rsani1hT35Cqnzj8xOZOp+r/nolml77r99gNnEpLZ0SyKe0/nOuUh7dFunwFACqN/ED
	SloBqJ64a5fRS2aiA+Rl5fbGECwBjjSw9N4trekQ1bbwPbRk3KYbjXBSSCjIhyb6H4oKa2
	jcT4nNMzygupToztoRUF71xNVlYaXGq8cvgmaygrZtEKF+A71es7jmif1JLA9cPyRgkwBL
	vgjwwYnR6eKsYyzrhvxZu49h8KAIF53k9lSoQTIPrIBuhU//KFu0dwfDDk3IsM4JMpAFfJ
	dvHRURq8Anp4Dc/TPoc5EUs/fQkY0zomUhHRUII1hELILDcXyaBEX9Xp21Ewpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=E0Iqet4pSAXE+UC0ayzROuYKmudwTofI3E/a0x2/uNMHJmtL6NNolfKDJE0W+Aq5yjHulF
	TSxBUWrAjdfRCcDg==
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
Subject: [PATCH v2 18/22] riscv: mm: Add page fault trace points
Date: Fri, 11 Apr 2025 09:37:34 +0200
Message-Id: <8fcf3f2a72c9491b206b34d133801634c8286fd8.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
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

