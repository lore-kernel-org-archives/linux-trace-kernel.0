Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7352C2980DC;
	Fri, 11 Apr 2025 07:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357096; cv=none; b=RQdPP+YOCKf0NGMKiPNxzEprnqgMjYOniS/qTKMYzj/WtoVl8yvzRAAfU0HyKTPd0I378FZYfvmgReCIselhm/sOY4gxYE+sp/Vli21cO4Ch/Z4TP9VD8uzQMQJDjd035IUY3VKdafU8q5mDQp4kHBjhds4kV2aWmurRx5qmYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357096; c=relaxed/simple;
	bh=D+9wO9dNN3EYV0lv+fWUQwBnCRPK8BfN8oSeYBiKgwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T+Y32EVvAhPjOcnKXIQ+x0M8YXqxe5GfqjyF9VELU8WBn2Z39BsQf2HKHaQQ8aNcspiZ68HveGwGLdqTRYwfH5C5FgBMW4rB8Xr+/loD6um1tfsk5UzO1kzFFIb5UHtWHbYt5V52sUj9j53QoOd8ClPHSg1mHjLqmdX8XP8TZso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f4DJbwmz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q7ZNzw7K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f4DJbwmz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7ZNzw7K"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=f4DJbwmzrkW7mPK9AHeAMNkaHKQb6i9D8wE+SjlI+6clttDzOXS+BH/xxNfaZnijDwvdOt
	o7eAVGZ+a1CE4f/4FkFqOxnwC9JVHPkMXqvimm41ko07kwtSwv6CcXwyYcRUMcuWrB4yO1
	WDpXcU36HnTCzuCfTd19Z/x6xdlaWhad04mswouMPSJHfhCHiPJBAOTNMdJvQdlgXiAIKC
	lgNEG17P4M9QKvyTvrBr2oMMyWGHeolQyB66jng4iaN2IzNfFpgjNA7k07Awn5B9rL9559
	klyZS1lhgO3nlRb0g9jCzNmW9t2xoCiDwbTYl1vzuq9M8geXllHaL7D+J0CMjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=q7ZNzw7KLTD8TrmZLui1q3zZXO8wwN74y0sMcI8jWDUU/BiH5Q1vArAYZTTz/JIp9gH6Ok
	sOiFNeZHbpm2KzDg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 17/22] arm64: mm: Add page fault trace points
Date: Fri, 11 Apr 2025 09:37:33 +0200
Message-Id: <952afa13306026813a5731703d6a86fb48f4ccf8.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
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

