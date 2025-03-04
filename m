Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9C81F8697;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130122; cv=none; b=ngciAZlNCn6BtCwxon1pY5aMDUxFVmVUUkgindJIttfbUAVlMjC3GzMcW+h/3NhD9AZkn5WiW/rUS+c+lgaAEK9z2qVgC0Kb8opOJBHMzk+QOtbZeCTu5QZmZxGb9nQ73dUMSK27dO6pvodRTmFVbAOsxOmvne0sTN/chVg14iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130122; c=relaxed/simple;
	bh=wC/IeTaVY4YGXDLvAUqyWXaYfQfr59gdDdHoBxGilKY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XYuBQaXuc/tVOwRRYomfU2Q+vN8tyNDEMX8I3MfQdbkxIoojuzBo2HkXeBu1rpAIGMWKXKNgEbPagfPvx0bal+c064UFrSo8pYyWSOkWVpiuIKKH2ygcm3DT9G0hSM9g8dsRz+L7iBm5u/rIwnfU5iC07gGl6kT0cxcagKCGEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1AEC4CEEC;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpbUo-0000000CSaQ-2R1E;
	Tue, 04 Mar 2025 18:16:18 -0500
Message-ID: <20250304231618.438023367@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 18:15:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/4] tracing: Only return an adjusted address if it matches the kernel
 address
References: <20250304231545.708806702@goodmis.org>
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
 kernel/trace/trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c37dd3b6acb3..2ad2686f39f3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6005,6 +6005,7 @@ static DEFINE_MUTEX(scratch_mutex);
 unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 {
 	struct trace_scratch *tscratch;
+	unsigned long raddr;
 	int i;
 
 	/* If we don't have last boot delta, return the address */
@@ -6020,7 +6021,9 @@ unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr)
 		return addr + tr->module_delta[i - 1];
 	}
 
-	return addr + tr->text_delta;
+	raddr = addr + tr->text_delta;
+	return is_kernel_core_data(raddr) || is_kernel_rodata(raddr) ||
+		__is_kernel(raddr) ? raddr : addr;
 }
 
 static int save_mod(struct module *mod, void *data)
-- 
2.47.2


