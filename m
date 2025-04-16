Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EAE230BD8;
	Wed, 16 Apr 2025 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786327; cv=none; b=GkthGZTfI75VxcmdeXmDxQs5s5teq9Ed82yNXu6GhrEzlMsV6cMfulv6e/sHgVuu3vsGG4C/XttHoUe8lUouhpa5hQ5rrIJxh1Y1HVpaA8vMd2uA87LqwmiJhKA8j7DJbtLfh2RgvTc+oFX8sSL2PkDTxmEzsADBvrhCtg038wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786327; c=relaxed/simple;
	bh=D+9wO9dNN3EYV0lv+fWUQwBnCRPK8BfN8oSeYBiKgwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFFaU+fdIhI537RW03+8zLERUnxLhWBw8eb4YkwahvlWpFukSZmrHVqes+u9HEPKeZXDsALLnw42EALdoIdfTxsUrmGur1NSdOq0BPhFNM2KOU6dZr9XRUoFT2p1eFbX+0k11f5904G0WzNJWHig61wbB7tcXJYSSEDo+MCN1wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eHR72bZy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l2HtqqLt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eHR72bZy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l2HtqqLt"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=eHR72bZylIbq0WrE3VY+Wdf6rzeiV/LZFizmP6c9mZARRIFmxLhaB2Q7REttLm1znj4hah
	gS7EQp6PXvCQuRy3OIVpf0F8tDU9ZF+ZJeS+eHkHbpTYztVD5j8caj5nwpK4cpYDyGgaqX
	WpzLOx7pzoKUxRGK6Vv94dx3skWRGEyo0eiWY+lQI9k0WhpUSVJnIxjSXRweN48l+kguf5
	pQp9mgHSv3GxOawcGDE7saE4o4zN2nImnTZZrUsp7/oepZ5ZTgsuSZ6/dBoLUI1o3YRm9p
	J7svVS9TFBVUXDhNTcVrakMUX4GviKqPUv/pQWXjEz+DdVHZgEcHra/kFdD+yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=l2HtqqLtED4EAiAkJZ3w0SQSzLbWv/ImpVLWY3NnLCaPVvVKYzrqaeIm7GVGYXpyTba00U
	H2HT0UhL5WJfYZCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 17/22] arm64: mm: Add page fault trace points
Date: Wed, 16 Apr 2025 08:51:23 +0200
Message-Id: <77c5fa64e512cc72d10a027dfae49263def3520d.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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

