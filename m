Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F413728137C;
	Tue,  6 May 2025 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746541374; cv=none; b=n7I5u/P77gMBmRpj+eFdpQ6TvyqWL8wuV99VFx0uRfRpo+kKPlHWAtCsXXVbwheezdujYDfOZzu3L3/A0MBIkKnBZWTzeZH22xMrhECVD2fgOE3kB3GXgflitD2mGnzw7MNQqO1KIfQun2SrrrQyiTpeKIixsCoAXPndDrVg/8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746541374; c=relaxed/simple;
	bh=XTWQPPP1CqAWGI/Fw2ZeFClLz5hjmv6Fdz70OB9eQdg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oV+DfMw2SnqIGPhrZltugCp5frm/tgsZDWk5a//TobtBz8nriFtv3L3EP2zpd+qLZU30SFEY4WnHXBsFiAXfXfWTCuJziFEzg9iu3w1I0CFWmOPelj7DkTbMVPRgqwAQ0XZjDkvTR07vu1qs+vk2QEr1GDPtFKJhICN4Jfd3k3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8831C4CEE4;
	Tue,  6 May 2025 14:22:52 +0000 (UTC)
Date: Tue, 6 May 2025 10:23:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v3] tracing: Only return an adjusted address if it matches
 the kernel address
Message-ID: <20250506102300.0ba2f9e0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The trace_adjust_address() will take a given address and examine the
persistent ring buffer to see if the address matches a module that is
listed there. If it does not, it will just adjust the value to the core
kernel delta. But if the address was for something that was not part of
the core kernel text or data it should not be adjusted.

Check the result of the adjustment and only return the adjustment if it
lands in the current kernel text or data. If not, return the original
address.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250325213919.790882670@goodmis.org

- Rebased on top of v6.15-rc5

- Check __is_kernel() first over data, as pointers to functions are more
  common via "%pS".

 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5b8db27fb6ef..01572ef79802 100644	
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6032,6 +6032,7 @@ unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 	struct trace_module_delta *module_delta;
 	struct trace_scratch *tscratch;
 	struct trace_mod_entry *entry;
+	unsigned long raddr;
 	int idx = 0, nr_entries;
 
 	/* If we don't have last boot delta, return the address */
@@ -6045,7 +6046,9 @@ unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 	module_delta = READ_ONCE(tr->module_delta);
 	if (!module_delta || !tscratch->nr_entries ||
 	    tscratch->entries[0].mod_addr > addr) {
-		return addr + tr->text_delta;
+		raddr = addr + tr->text_delta;
+		return __is_kernel(raddr) || is_kernel_core_data(raddr) ||
+			is_kernel_rodata(raddr) ? raddr : addr;
 	}
 
 	/* Note that entries must be sorted. */
-- 
2.47.2

