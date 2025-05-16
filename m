Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2423099C;
	Fri, 16 May 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387150; cv=none; b=Gq0TCfZdNh6e4a+k2bi3k+Ym+8fl9fJ8JhqXLIK3C36jhIxlvKUNjVXkrA8NAFnyj6pKTrIZuPmTtJHNTagx/UkkAPr44F0N2Knbb+xgxBu7Ifoz0Sx7juTohPwgTUHkrJzDeprVxcmEf1LRQxiHtwIuM5FMq9WzStdXNbiOd7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387150; c=relaxed/simple;
	bh=oeqYFOKeWTs08idNhUY3+mP6RMqnO1Ic6IraknKxoUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MWg5gGGP0hl/lo9I+oN6nD+ZA9lGj1O7juitEait8Bz1fnZYdIko5gg04qppOIIGig2DYdJ3MqWjSvhnxIvrjICG6rOXmxGw6heNL7cVy/YkR14naqeq47CC1uWzruzBk8UIMz0TJNfXwUwdEOHlkakLz49c6JJC66S0j+OqvJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SbQWck49; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7QnbO/Hz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SbQWck49";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7QnbO/Hz"
Date: Fri, 16 May 2025 09:19:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747387146;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unsVJ9zVDG7LmN8MLzF3wE3jIqcV24kmsyWBmK/VY7Q=;
	b=SbQWck49hlwu4tW7l1xSwTi2PvnYSoGe/RbOz32ySwqjyv9wUmBblwySq12iZ3T+WJlN1k
	vVcgXQyAN08HrLQDoOJ1yN8RpWsNZWVZGOjuW4DM04BxP/tWEFPmWeyc9H/DWi/fW+QJir
	3x03CeAawM487mX5Frhk/1OeD6X2BW6PDlRNU8W4NQ/ZR2yQbMGyHMVog8X9aWMealeNrc
	+O5F7f67hcf56FCsIpOO00w6u94IbHm0AX0nw9HB4b8HaYmk7t6vmDj0HBO2BsRdJD9w19
	0GbzbqJHx9Kti1K41SwDHTSoL3v5qaVTmyIqd3FSMIyZzAr0gEJDAaSfbOmyDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747387146;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=unsVJ9zVDG7LmN8MLzF3wE3jIqcV24kmsyWBmK/VY7Q=;
	b=7QnbO/HzUHbvjnnndrXi2lStZMRBi3jY45SkNRUa/T0M5g+YTwz2ecRdZoEDgIXT4hO0UB
	J/K7PCKLtA3zsbCA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/debug] x86/tracing, x86/mm: Move page fault tracepoints to generic
Cc: Nam Cao <namcao@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Gabriele Monaco <gmonaco@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C89c2f284adf9b4c933f0e65811c50cef900a5a95=2E17470?=
 =?utf-8?q?46848=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C89c2f284adf9b4c933f0e65811c50cef900a5a95=2E174704?=
 =?utf-8?q?6848=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738714546.406.17660661674340828808.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/debug branch of tip:

Commit-ID:     06aa9378df017ea7482b1bfdcd750104c8b3c407
Gitweb:        https://git.kernel.org/tip/06aa9378df017ea7482b1bfdcd750104c8b3c407
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Mon, 12 May 2025 12:50:59 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 16 May 2025 10:13:59 +02:00

x86/tracing, x86/mm: Move page fault tracepoints to generic

Page fault tracepoints are interesting for other architectures as well.
Move them to be generic.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/89c2f284adf9b4c933f0e65811c50cef900a5a95.1747046848.git.namcao@linutronix.de
---
 arch/x86/include/asm/trace/exceptions.h | 48 +------------------------
 arch/x86/mm/Makefile                    |  2 +-
 arch/x86/mm/fault.c                     |  2 +-
 include/trace/events/exceptions.h       | 43 ++++++++++++++++++++++-
 4 files changed, 44 insertions(+), 51 deletions(-)
 delete mode 100644 arch/x86/include/asm/trace/exceptions.h
 create mode 100644 include/trace/events/exceptions.h

diff --git a/arch/x86/include/asm/trace/exceptions.h b/arch/x86/include/asm/trace/exceptions.h
deleted file mode 100644
index 34bc821..0000000
--- a/arch/x86/include/asm/trace/exceptions.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM exceptions
-
-#if !defined(_TRACE_PAGE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_PAGE_FAULT_H
-
-#include <linux/tracepoint.h>
-
-DECLARE_EVENT_CLASS(x86_exceptions,
-
-	TP_PROTO(unsigned long address, struct pt_regs *regs,
-		 unsigned long error_code),
-
-	TP_ARGS(address, regs, error_code),
-
-	TP_STRUCT__entry(
-		__field(		unsigned long, address	)
-		__field(		unsigned long, ip	)
-		__field(		unsigned long, error_code )
-	),
-
-	TP_fast_assign(
-		__entry->address = address;
-		__entry->ip = regs->ip;
-		__entry->error_code = error_code;
-	),
-
-	TP_printk("address=%ps ip=%ps error_code=0x%lx",
-		  (void *)__entry->address, (void *)__entry->ip,
-		  __entry->error_code) );
-
-DEFINE_EVENT(x86_exceptions, page_fault_user,
-	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
-	TP_ARGS(address, regs, error_code));
-
-DEFINE_EVENT(x86_exceptions, page_fault_kernel,
-	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
-	TP_ARGS(address, regs, error_code));
-
-#undef TRACE_INCLUDE_PATH
-#undef TRACE_INCLUDE_FILE
-#define TRACE_INCLUDE_PATH .
-#define TRACE_INCLUDE_FILE exceptions
-#endif /*  _TRACE_PAGE_FAULT_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 32035d5..629a8bf 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -34,8 +34,6 @@ obj-y				+= pat/
 CFLAGS_physaddr.o		:= -fno-stack-protector
 CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
 
-CFLAGS_fault.o := -I $(src)/../include/asm/trace
-
 obj-$(CONFIG_X86_32)		+= pgtable_32.o iomap_32.o
 
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 7e3e51f..ad4cb15 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -38,7 +38,7 @@
 #include <asm/sev.h>			/* snp_dump_hva_rmpentry()	*/
 
 #define CREATE_TRACE_POINTS
-#include <asm/trace/exceptions.h>
+#include <trace/events/exceptions.h>
 
 /*
  * Returns 0 if mmiotrace is disabled, or if the fault is not
diff --git a/include/trace/events/exceptions.h b/include/trace/events/exceptions.h
new file mode 100644
index 0000000..a631f8d
--- /dev/null
+++ b/include/trace/events/exceptions.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM exceptions
+
+#if !defined(_TRACE_PAGE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PAGE_FAULT_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(exceptions,
+
+	TP_PROTO(unsigned long address, struct pt_regs *regs,
+		 unsigned long error_code),
+
+	TP_ARGS(address, regs, error_code),
+
+	TP_STRUCT__entry(
+		__field(		unsigned long, address	)
+		__field(		unsigned long, ip	)
+		__field(		unsigned long, error_code )
+	),
+
+	TP_fast_assign(
+		__entry->address = address;
+		__entry->ip = instruction_pointer(regs);
+		__entry->error_code = error_code;
+	),
+
+	TP_printk("address=%ps ip=%ps error_code=0x%lx",
+		  (void *)__entry->address, (void *)__entry->ip,
+		  __entry->error_code) );
+
+DEFINE_EVENT(exceptions, page_fault_user,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
+	TP_ARGS(address, regs, error_code));
+DEFINE_EVENT(exceptions, page_fault_kernel,
+	TP_PROTO(unsigned long address,	struct pt_regs *regs, unsigned long error_code),
+	TP_ARGS(address, regs, error_code));
+
+#endif /*  _TRACE_PAGE_FAULT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
