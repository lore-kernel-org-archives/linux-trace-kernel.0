Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502C71AB6DA;
	Mon, 14 Oct 2024 11:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903624; cv=none; b=QYGIgnM30DXedKEOiBsQ6by9ZS+cWIRh/DkwNJ7MUqCbNKOvFdRmNOAl/XsrN2qr+hBlDCSAykgHMJ93Eum8y8R7ziEzTxmLm6ImbmjYu3zLrvnKLn6NXPGUu/Ypl3QtcBStfFA3CAG5IxjgSBPIURpdFMhhQMShRr3QvVQMYwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903624; c=relaxed/simple;
	bh=ViWA2SK7ai4kd7Q4uLzkOMtdX8lq35uYLetmmGTNaas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDdN9biZnJV30HEiK/XuQlv3VU+o+HSi2c1QamlQBo+0a1/rC0Olft21a7xHEdpUdB63ZxGbH71YOql+7/yArZ00VvL3J0pQ8rS9g4JzpC5E2+nZKc1yVIF+ho0zzzOaHTk+S6MgSMWMxczdpmbQcYlHUzX++BfhVE781CDNB1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65FA91688;
	Mon, 14 Oct 2024 04:00:52 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09E9C3F51B;
	Mon, 14 Oct 2024 04:00:19 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Steven Rostedt <rostedt@goodmis.org>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Subject: [RFC PATCH v1 18/57] trace: Remove PAGE_SIZE compile-time constant assumption
Date: Mon, 14 Oct 2024 11:58:25 +0100
Message-ID: <20241014105912.3207374-18-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To prepare for supporting boot-time page size selection, refactor code
to remove assumptions about PAGE_SIZE being compile-time constant. Code
intended to be equivalent when compile-time page size is active.

Convert BUILD_BUG_ON() BUG_ON() since the argument depends on PAGE_SIZE
and its not trivial to test against a page size limit.

Redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is always
sized at 32K for 64-bit and 16K for 32-bit. It was previously defined in
terms of PAGE_SIZE (and worked out at the quoted sizes for a 4K page
size). But for 64K pages, the size expanded to 512K. Given the ftrace
stacks should be invariant to page size, this seemed like a waste. As a
side effect, it removes the PAGE_SIZE compile-time constant assumption
from this code.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 kernel/trace/fgraph.c | 2 +-
 kernel/trace/trace.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d7d4fb403f6f0..47aa5c8d8090e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -534,7 +534,7 @@ ftrace_push_return_trace(unsigned long ret, unsigned long func,
 	if (!current->ret_stack)
 		return -EBUSY;
 
-	BUILD_BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
+	BUG_ON(SHADOW_STACK_SIZE % sizeof(long));
 
 	/* Set val to "reserved" with the delta to the new fgraph frame */
 	val = (FGRAPH_TYPE_RESERVED << FGRAPH_TYPE_SHIFT) | FGRAPH_FRAME_OFFSET;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3b2c7dfadef1..0f2ec3d30579f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2887,7 +2887,7 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
 /* Allow 4 levels of nesting: normal, softirq, irq, NMI */
 #define FTRACE_KSTACK_NESTING	4
 
-#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
+#define FTRACE_KSTACK_ENTRIES	(SZ_4K / FTRACE_KSTACK_NESTING)
 
 struct ftrace_stack {
 	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
-- 
2.43.0

