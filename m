Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EF20126A;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422325; cv=none; b=pOhEN6Q0S6jQsPbSaD8gAlSpxpEvFB2GKLTzz6HKNOCLBodTUFY9xTB2eQqrUsFifBQg9SaUgj+qEBn78Bf9ZpepJL2UY8SXY7ngl/98XyNhZwS0pmVYFE+a3s9iN+iqUowoYkXiOGtzr1sO1Q/YwM1KkiSgqBmdY3mQdjbIGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422325; c=relaxed/simple;
	bh=piDcNEExtOgL6osgVebM5D1aBp6M5GPM60znCJNMmFc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=XhL4rqasZ1vk4HtHX4DI5SFmfo2HQjAoGMTx7L+F9jMg1Dz95TiqYWXBhgNRNYR3aJe5Mr6nmUQUCyZUVDaVlxHy9cEMMwxdCJ6kr77HktBd6na8+MYK8M8tMLYCM7a3g2LByVuLjYqmS9xvtsqB6OE0NpPipt0rIPZ6PiA81fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzSqhwXM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzSqhwXM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9B1C4CEF6;
	Tue,  5 Aug 2025 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754422324;
	bh=piDcNEExtOgL6osgVebM5D1aBp6M5GPM60znCJNMmFc=;
	h=Date:From:To:Cc:Subject:References:From;
	b=XzSqhwXMY+kSigTp9Gt3lkTNaB7BxxvITX7xHHn/vNwrips7ulktJbHStLsCQ0e4m
	 dgG6SPRIwb3DnxF90Vp0Chwe/gYFvOFkQkRDtPB2FjyihEtdBxgm/D0BWMIqkzDflb
	 V+YQXnuUg0e1kF3QwA9q5zxmFSWPfhbH7Xa9j7Rwoq6lZZKYYhORhMgAtzTO51J4bS
	 7buMmkMXYpteX662RIrxDqTt83wsod6fZ8VindJX9DXB5QUTXrP44JnuEWUiTkKvyM
	 BfGQShYYVsc3djQE+KstwHzzHQJVatG81IpbPIBHPVNatADALjJkwA4CyE5cRCYDH3
	 H+5tdpORIo0MA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ujNOl-0000000AtDD-0FgK;
	Tue, 05 Aug 2025 15:32:35 -0400
Message-ID: <20250805193234.915257520@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 05 Aug 2025 15:26:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 aahringo@redhat.com,
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH 2/7] tracing: Have syscall trace events show "0x" for values greater than
 10
References: <20250805192646.328291790@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently the syscall trace events show each value as hexadecimal, but
without adding "0x" it can be confusing:

   sys_write(fd: 4, buf: 0x55c4a1fa9270, count: 44)

Looks like the above write wrote 44 bytes, when in reality it wrote 68
bytes.

Add a "0x" for all values greater or equal to 10 to remove the ambiguity.
For values less than 10, leave off the "0x" as that just adds noise to the
output.

Also change the iterator to check if "i" is nonzero and print the ", "
delimiter at the start, then adding the logic to the trace_seq_printf() at
the end.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 3a0b65f89130..0f932b22f9ec 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -153,14 +153,20 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		if (trace_seq_has_overflowed(s))
 			goto end;
 
+		if (i)
+			trace_seq_puts(s, ", ");
+
 		/* parameter types */
 		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
 			trace_seq_printf(s, "%s ", entry->types[i]);
 
 		/* parameter values */
-		trace_seq_printf(s, "%s: %lx%s", entry->args[i],
-				 trace->args[i],
-				 i == entry->nb_args - 1 ? "" : ", ");
+		if (trace->args[i] < 10)
+			trace_seq_printf(s, "%s: %lu", entry->args[i],
+					 trace->args[i]);
+		else
+			trace_seq_printf(s, "%s: 0x%lx", entry->args[i],
+					 trace->args[i]);
 	}
 
 	trace_seq_putc(s, ')');
-- 
2.47.2


