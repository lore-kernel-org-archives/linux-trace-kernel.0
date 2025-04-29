Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0052D1F61;
	Tue, 29 Apr 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928102; cv=none; b=ikGDBfdoOb0mjVLoDTPFPPMpyUiQCY9kQ1bIq3WdYRNdZVnlMDymK5angiLRWF0CHTwstdaMTGCDoiCznh3cu73ryigPNi3GIw0JLbwHG0gsG3zYrgbtLoQB8S2o/TavnS3zfu3vozWBMoihruW5+7Z3lN9Z/HNpvQ6yA//LsYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928102; c=relaxed/simple;
	bh=D+9wO9dNN3EYV0lv+fWUQwBnCRPK8BfN8oSeYBiKgwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D24lCuXAACxcfFAqHhpGFX7qUFKdWoJvNw8WDZR5IjVtvSWmsz88DuIPDvPiZudYCQMjJs2rkPtToZUw2BqjJHSu05VBOecMAo08VX84UxW8ewzBlwybCZOQ1rIALaEiGRiYKcFVsu9ivmdQxOqRV22olFgu8SBTL9uSlZtKX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QHhQ6j3X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pc1ZqgS7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QHhQ6j3X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pc1ZqgS7"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=QHhQ6j3XQ35uW8lM33Iri+d2d7ashP9AZfInkXLmBkcmolpxLsgshSSRdu0sjmu4D2n1bA
	DsLANVQw3M6JA3uTBLT5VuTJMgBvuJTB+rI5u8oPBNxqejbuRSNSuTIl58R3FYosL0Za1Z
	XSS/CB3sxRcLNdxjTjn1wkLI0Hlt5w1i+mga8fdj3oCt+mux9e8mOU6jfdfltz0van4cOc
	oUaEtxiwEdB/Ss5cLOapl+wCXGyg6ImemEsA13KGsmGWR/z/nLEj7D0+9UdSZjvKl7okJK
	ncZmTw7kziulvaIkgiHpScerBaVZtWkFKW5BrIXFnT2kQxscWdfNX+rhSnorzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=Pc1ZqgS7RXqWFqgNkCZldc3Fl/mcM1w++M4/HQGbduyBb4aLMt8nkfS5VPJ+/UBolG7beC
	gXeTGFsWu+D32oDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 17/23] arm64: mm: Add page fault trace points
Date: Tue, 29 Apr 2025 14:01:02 +0200
Message-Id: <554038c996662282df8a9d0482ef06f8d44fccc5.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add page fault trace points, which are useful to implement RV monitor which
watches page faults.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ef63651099a9..e3f096b0dffd 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -44,6 +44,9 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long far, unsigned long esr,
 		      struct pt_regs *regs);
@@ -559,6 +562,11 @@ static int __kprobes do_page_fault(unsigned long far, =
unsigned long esr,
 	if (kprobe_page_fault(regs, esr))
 		return 0;
=20
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, esr);
+	else
+		trace_page_fault_kernel(addr, regs, esr);
+
 	/*
 	 * If we're in an interrupt or have no user context, we must not take
 	 * the fault.
--=20
2.39.5

