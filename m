Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADF125B1E2;
	Wed, 30 Apr 2025 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010976; cv=none; b=cH+o88VkqZxwOOgo/XoqtBMcxnGgSFfW0TfEPzrG/pRqWdcmpTv32IyWYEqy4JMWpi0dyvxgYIwEHbnndm3lXXEa+UaLmLITo/hQp0SPb6UOTQz0DdRBBQxcpJn713/I7IbThzHU4Sqn6zUR9lTvg4zfCQOp8pDpaMZps4vIoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010976; c=relaxed/simple;
	bh=D+9wO9dNN3EYV0lv+fWUQwBnCRPK8BfN8oSeYBiKgwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZC62uP1u6hnePOu1JfM4947cTX/rCqLjn9QYpR4mdhg7d7/1FjHqr88hVbZNrFRUSnkj4Eoy29PanriJz4mfAW4oTW7GAI1eBFOXTtrxnACKNT5SscJzZqs0deMfpGWJz4oaCWPlB3FhHJaaeg6bWi5rdn7e7XxH2s1Q7Htvrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANqaAKL7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IeZfvP+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANqaAKL7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IeZfvP+C"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=ANqaAKL7xzONGZzgwjEwKQxoafpPmwihdB8CSIyrcsP3KcbC2ExMY75BPTBVLQA0zfcbtJ
	ZTiDewcAEoUvv1Yi5rGET1A08/yP0IylIY58Q7v4zO0CdbwR8Wg4g2lPFuMn/IFjg52I+n
	WuIPJbpr08vZDoCPjq7/lVW4gyWEdTBxhslRAXuH4Xx7Zf/9XggO+h+Bfym6jIcTO6AZVN
	gW5790lSI8OsBQbB21zuPu7XwS030pQ2/2eTARn5KageaYc34vam4Z83lc2RIKTO5yJJre
	bfBdHUptrBZGk/Kq/xPRPhEqYS0f7+4qpH/G1ik3xuhNBDgSI7xz92lQBHE/6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+UQEszhhyx5orvv0upRMEVuQLmNZT576sheEcGpELI=;
	b=IeZfvP+C48+pRqTuFVYBkD4Ru8kfnfuLYOIeUVtA/GOD6yeEakAMarP+fHf/JwHyULRVZa
	b46u99+7ymuIsIAw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 17/22] arm64: mm: Add page fault trace points
Date: Wed, 30 Apr 2025 13:02:32 +0200
Message-Id: <554038c996662282df8a9d0482ef06f8d44fccc5.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
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

