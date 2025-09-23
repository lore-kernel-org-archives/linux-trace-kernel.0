Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE31A9F90;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758632754; cv=none; b=EhOtKdaBKjqN7NpZqzpbV5uovhNaIVRADfPtydyU60VwWGprmYVXRp9iYf+l1kEwlltz/A2eQG7sxLtDkW9pWlBnNmqawTVIHuFlnBe46bXWiiBExDUhyV98z7d62x844+qLfoCV0bJ9p0STwKuSyjQpL4AzR3uGVKJTAg826LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758632754; c=relaxed/simple;
	bh=Flt5aJNz1gfLnak7pHQFz0fCiVR4gaqzsAxMb+syYyg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OmMSJZ4kxfxw4bbQODQ2KfhceCAhvX3RrZv7zd/f5KROlWiswh/grQ21VMvuuJPF423ZXatELFfd57qyA4WsYeknxv/UgsEwbZJ9DXlRlOgi57SftD7ehOeooCHqNl7FpWMK8OHrhCUhiuW1/T2kVvkYIgoqR4cPqU6DUuUR00Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtNzpZ++; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtNzpZ++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB99C19421;
	Tue, 23 Sep 2025 13:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758632754;
	bh=Flt5aJNz1gfLnak7pHQFz0fCiVR4gaqzsAxMb+syYyg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=HtNzpZ++JQ4yNTdsyG4pEdKYTqdsL60q1NGaGQFAUD6FMvkYEkZ5GaivBSQnKbx1G
	 frcS0zklJldMYBosprmqNeQLoGkXGds2I4DLu9BAGCES4Tzz8ZxU+gDBC+YTApoJ1M
	 kTfw6wE3TrkKn7xYbS2Py+5DfWCRhWHzopiUvpKAAO6JZRF+QFxjksucxbXzZcu4pE
	 ZHmwMADMzhNX77weilt+Nvcaxj40n5PYmmExw0J3+r10sgSjCprPO+SUq6VUqnORQV
	 1bzvwdeh22I0wHAlOnernQ9tq+F4gkhX8YKyoKqhmU+DhuMkZI5DqbKEwnVZR4vO+H
	 7W4Rr5WDsspzQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v12jh-0000000Copf-3q6T;
	Tue, 23 Sep 2025 09:07:13 -0400
Message-ID: <20250923130713.764558957@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 23 Sep 2025 09:04:59 -0400
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
 Douglas Raillard <douglas.raillard@arm.com>
Subject: [PATCH v2 2/8] tracing: Have syscall trace events show "0x" for values greater than
 10
References: <20250923130457.901085554@kernel.org>
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
2.50.1


