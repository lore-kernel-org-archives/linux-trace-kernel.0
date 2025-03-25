Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359B7266B51;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938715; cv=none; b=JYis09+BGZts2K/8XRxbs9f6OVeu+oiv1HnDw5aOEJdgkucXmKZQ+A2yMYRt/eW9YlM8lwQFIrcvUfSavQXLa1ejABXejeUxfNHogmhUdBBLRN1iKA3BWW4URzNC62aQ2/yWK/cksiNy+cQg5kcX3IWAO5O6bgfQt13ItxJl0ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938715; c=relaxed/simple;
	bh=zduBI9phQ5jreSKmekDgvVSgzegkxRf2r7wk3Nb9d/M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=asSjdcLZDQYgxKhQ3W2mSpIlcIHqJjPgd+NmGbvxK6diJgQjHk4oxuJjw9U84sPH/V0VIkdmxOpwSqAtJgCAyNT25pjXZ/JeYSr7u/JtoPwZRAF7U4dIFiK5la5t+zVGc7yO3xBiCDaNoC0HBn7krlkzrrMYO0hJsAgZB2CQuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C645AC4CEF1;
	Tue, 25 Mar 2025 21:38:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txBzT-00000002Vfa-3vXa;
	Tue, 25 Mar 2025 17:39:19 -0400
Message-ID: <20250325213919.790882670@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 17:38:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/4] tracing: Only return an adjusted address if it matches the kernel
 address
References: <20250325213845.844200633@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

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
 kernel/trace/trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7ca8a0dbd4fa..85128ef96246 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6023,6 +6023,7 @@ unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 	struct trace_module_delta *module_delta;
 	struct trace_scratch *tscratch;
 	struct trace_mod_entry *entry;
+	unsigned long raddr;
 	int idx = 0, nr_entries;
 
 	/* If we don't have last boot delta, return the address */
@@ -6034,8 +6035,11 @@ unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 	tscratch = tr->scratch;
 	/* if there is no tscrach, module_delta must be NULL. */
 	module_delta = READ_ONCE(tr->module_delta);
-	if (!module_delta || tscratch->entries[0].mod_addr > addr)
-		return addr + tr->text_delta;
+	if (!module_delta || tscratch->entries[0].mod_addr > addr) {
+		raddr = addr + tr->text_delta;
+		return is_kernel_core_data(raddr) || is_kernel_rodata(raddr) ||
+			__is_kernel(raddr) ? raddr : addr;
+	}
 
 	/* Note that entries must be sorted. */
 	nr_entries = tscratch->nr_entries;
-- 
2.47.2


