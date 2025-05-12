Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E665269CF5;
	Mon, 12 May 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047085; cv=none; b=DfBdct60VvCu7g5x+IyEXn1XNuEtcIH1CRxo6lbVVdpq0A9PQfv8J+PK3kD6rg33MlcoWBZGYylKofL+JVsWAwR36r3E0CpRJYB6DqtsVXrnzmvhseIsjHrMw/RBJWNFK5aignhKcObxfwRY/Q9PEtVJkTMTv4WkuBzcppU2Ydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047085; c=relaxed/simple;
	bh=eX5oXC+HBcw1mu0TCAHq5i0a+I/QmsXUI8/vYm8odp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SlbeiQmAAlc9zeOQKzrez9/5FK0GuYIL4volRmKeGTbugV3mBu20X7hH+zsdA+nPbIjHSnaBeYe5DJ0+4bVJbQ6a+0OLr6czX8ll0duzrJm2QvZv8bT2aYcvqWUVJfZ7rCnYCNvq/7SLJWCsd4GyHZdCzEuOSQdN6kJ+L1mDoBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lWYw5dVh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2VNd9cv1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lWYw5dVh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2VNd9cv1"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=lWYw5dVhwTY/Rd5JEMbr5TV80WlTf7uiCI1hmWfWb6VHt0BMQxPm0xDxKyYMQO/tcWML2E
	ZlFadGGKu4qhpr9n7gjPtSWWTvW10fNtRlAprVHeU8RMof3X529SqleywKGmQa+y10fJJq
	OFfgFIbC2iV1ec0jeChFGto1iypbsCEYDn8mjrohsIJWgdx4xKOjwIn2U/VTlxgDAa/W7R
	1/kyTVUjRaL7Lqv8vW+yyKDR4pL1/QE5ME3+RlY6QM8C/Af6gVjr6pNeqXw5tbWPbmxtei
	kFQNhFUzLPvou6yx8UH019/PVeQREaUaEwA+pClx/LQddd5Us7vSdH805VugtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=2VNd9cv18ED4C4ucSqx8UH02IAblhdWPUHKm29lA7oUAoYSuWBvMLpJy51I2qm3Qnn7zPF
	JL3pNk13bugyInBw==
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
Subject: [PATCH v8 18/22] riscv: mm: Add page fault trace points
Date: Mon, 12 May 2025 12:51:01 +0200
Message-Id: <178fb6ea9110bb9f2476f20f2b5ccfade4eb4974.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
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

