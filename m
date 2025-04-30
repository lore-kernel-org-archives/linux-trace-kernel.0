Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0225B1E1;
	Wed, 30 Apr 2025 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010974; cv=none; b=lIagR0wrjFq+AttjMUGJ/l8qwn6R6E6IwOeAIToxkYMxnlIVdJjdMLhOXrwpv3SG+TmKYXGHrWOiWjtFaVmZuyAZ0fVas6Sn7gt+sLS8PYfe7M/ihAIbHpeKxdLLKearllca+c0+3ItWGaWpjx1Eb43d6Z0KFcoETlodw2d+NDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010974; c=relaxed/simple;
	bh=eX5oXC+HBcw1mu0TCAHq5i0a+I/QmsXUI8/vYm8odp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ek6db/DwL469C6LEmN0KGN2ILRHlncJmKXzi7NJJrk0ohyprw7SrAAxLjJMXuhK4kHm/EW/In4MFMKhm7oCnVdFYdhc/RfJA2m6gBHCmzO0miKBIIgXbP8PfjfY9HZ+yGILiymkGmyHWtrWPeAIO/bOAheppF4zNK7vvrCt7jmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvcIbi3g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AqKQgEIB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvcIbi3g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AqKQgEIB"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=xvcIbi3gql4WCxASfzBmjJ8h3n6dXU2sFtFvOcO+M+k/I+JPJW1gvFK/rn1Cmk8n9kl2Wt
	2ZWMh8xopACKJ3YAElMcwQ1IcZMW9x22gcggMTnUgAHjLduHWKt0PwlLrZMxDUV0CYDZJH
	LdTC8ug9LyZW/jdSJmpeq++4QvAA1wyKT65ldWgkChmjgtZLUfpFWOIuy7hqh7mZQmafuF
	BpmaDIT5eQVAmQjHJ4tkEv7fEa3AhCjC4bfWa4eScOxVZzAf0Tbr7W+KY+xa7PvAQsUyn+
	WekYF9PYQ5zwnNqcMwyGRKgprLQsJpve9/7mRCa1VP5Fm4izUdnQkTuiQsXm9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=AqKQgEIB0ls3X4oMDyq8NxPF1DQCSvNBuWKpf3zKqBQJ5a8XurESv2UT1Jf+9H1aRKqeM1
	dh8Ai3j5s389BuCg==
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
Subject: [PATCH v6 18/22] riscv: mm: Add page fault trace points
Date: Wed, 30 Apr 2025 13:02:33 +0200
Message-Id: <dbcd52978bc997a59181b3d22601bf7c3c8210ed.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
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

