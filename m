Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CE5A79B;
	Mon, 21 Oct 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520323; cv=none; b=QWoI6ToPMIn0SOxvEx3+T0+z6bT76ZY63CL3tr1h8eW9Ig1u31+yrJzk+3McjaBTSCxC/UyUQUj1iJT/o2zEnvwb7MpOF0+PyngQiTZzXfm04H7A25YTOL+xWuNpq5PVLGPAMPMJRNLicgg9ZXJk6yROatf+3ARc7ELn0XNWQB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520323; c=relaxed/simple;
	bh=4PqKFbnXtjrVOKH1RCuooGjPrj3vKC1/J74OQn0EL5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksLZ42bnIiU40TnWkFP++6QCZw1+QIdcAEctXZSyHSG43OIh+VnM5xQ1NpFBKbL9fN7kv3N9NFJ0JtmOeckFzrHb0Y1UkJ6u6wd9DblDDuGaJsAtSrxgaOSyOvY96HzYm9j4wXZmQjVYW8CF1BiabnY/rtpe44FnT9ZS/OHIhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A2BDDA7;
	Mon, 21 Oct 2024 07:19:10 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D4CC3F73B;
	Mon, 21 Oct 2024 07:18:39 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Make percpu stack trace buffer invariant to PAGE_SIZE
Date: Mon, 21 Oct 2024 15:18:31 +0100
Message-ID: <20241021141832.3668264-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously the size of "struct ftrace_stacks" depended upon PAGE_SIZE.
For the common 4K page size, on a 64-bit system, sizeof(struct
ftrace_stacks) was 32K. But for a 64K page size, sizeof(struct
ftrace_stacks) was 512K.

But ftrace stack usage requirements should be invariant to page size. So
let's redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is
always sized at 32K for 64-bit and 16K for 32-bit.

As a side effect, it removes the PAGE_SIZE compile-time constant
assumption from this code, which is required to reach the goal of
boot-time page size selection.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1c69ca1f1088..d4654943b580 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2914,7 +2914,7 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 /* Allow 4 levels of nesting: normal, softirq, irq, NMI */
 #define FTRACE_KSTACK_NESTING	4

-#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
+#define FTRACE_KSTACK_ENTRIES	(SZ_4K / FTRACE_KSTACK_NESTING)

 struct ftrace_stack {
 	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
--
2.43.0

