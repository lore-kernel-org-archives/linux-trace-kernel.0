Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD322267B15;
	Wed, 23 Apr 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391049; cv=none; b=CeRDAdhnchORpI+lg/YP2PB1asL5TAjpOeQuhd2sMBzkWFqjcKjKhcWlsp14Nx2RksBnqy/ceI3r+rpMTKf/INjzVxadIVip7K3oYK4JnuOXOESrzDy+8E3Eodu0hnhdLtOwB2nG/lLoFJxkOMH+gTCmGdLsxHh0BZOihSNGB3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391049; c=relaxed/simple;
	bh=eX5oXC+HBcw1mu0TCAHq5i0a+I/QmsXUI8/vYm8odp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ib9HoV0rd9ftMXod+JGDMgXitb991fZifGOjUjc4QCyMbsIMvUOudIZ/UekJrvdRMiN4e0dpqibsFjpzEs1swR8A+QOMumtvoB5k5yfABzfIdvaRHDoHLVY5YD+JEPyGNR5DBZjbS6OFUgx+WFgIc15k5yCw+JLsleADB/tJHjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fWFGa6B/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=66lJ4fMn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fWFGa6B/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="66lJ4fMn"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=fWFGa6B/J/hJ7ThfApnt5/XFzcFknjNvDhRv47jaGvXCeNSsS/ZCsw9slPqCZ42soxwCug
	/iO6yCxJCuOXOFAk8RYdGBmp6BIcMCU3Qd8CYtoKzv6lH8YsRx7Y60+AZp7uE5uiEzeKDt
	dmZFU1ndg3pt9CLkE6qSiNcdJL5cfkxJmEguLhf0pNakL1kBUS8gHDBj62wgjGWGz/AouB
	zHYE0pvK7/5wFvW41WlO38wNRu/zzbhlcbnBQ0qBBZFYsGh9t9+G2FhWQnjXHX6+i+GMuM
	Ax3fOiQgSOBy1TMV/z8qVkwnHYTRaXY39Cf7HM8gi/LF6jiu6JyBGB2Pp3DI3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRN84yAGCbJ9jXd7YMFr0fN4dU5tvyZpKeky5D5bT9k=;
	b=66lJ4fMnVjS/5kJQh27nJyjJvPogmJXIyulDJU/ikxccrZ5i+hECSCawRsxVbnIzGb7IAj
	Hl4LG8qObw1Qe0DA==
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
Subject: [PATCH v4 18/22] riscv: mm: Add page fault trace points
Date: Wed, 23 Apr 2025 08:50:13 +0200
Message-Id: <fb13b6e50372370a9c84771503f19be897881d29.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
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

