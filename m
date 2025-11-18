Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BD245008;
	Tue, 18 Nov 2025 07:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763452199; cv=none; b=ES9QJlvDE+9IvXhfL5+qwLZ7VHHWInI98i2Vn46VWZ2sxwpSSRL3WZnfJJeA1wsXoEAOk6T+vZy/Rh8ZoRv0WD2odBzvHgdoFv45dyUQnKdcM4JlCxB7FJ2s6+MYYHG7YE0i89cVkCVLfU4UoyMot+nowtN0jEhewWIjgVFY0xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763452199; c=relaxed/simple;
	bh=1OELAZhh7afwVceGwzfcjHqQq87gMBd1RV2OOhontBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BADWU6LZGdVNdvsClc34tdhoqzZZFL86KmJzfkStrV04b28wTR1K7+kwODvI1pDInv+X8VCksCWAiBwUR4mjolH86P240dArxa7qLHg3T6/XzoFqkSdLdIKYMDmazdGqsanPCqEX1/GF/BMzRcEiG891E7ECl1Agv5fxnQDT/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eip8WFSO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eip8WFSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030B7C2BCB1;
	Tue, 18 Nov 2025 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763452198;
	bh=1OELAZhh7afwVceGwzfcjHqQq87gMBd1RV2OOhontBY=;
	h=From:To:Cc:Subject:Date:From;
	b=eip8WFSOesd37alXAYCl4xugMr3V2UUz4WV9vBbh3ja3crzNMs1pvrE9XLl22QjGu
	 N1zHJFx9N23m6DuVGHRjy00UDFgCeblNaxQsegEKbG7WuAVkuir0R6Hfs0P93EUZOS
	 HUx/6mhCNjUP9YWMZkIJersyKexrp+eoTSC5RSwdx+NKoZ0Iaia/4CfNC/COagN8cB
	 ioqi1HOgBr5DjUA81iHjnyNCHLx8+itUpSPy/9OiFJW/cVhc7YO4m3lMGIiU6bRyt9
	 c2N+LIUDv8h8KYAWJRMBWcuA29CjZH9PabbpMHn9dP/L3nh3q6CoKr4dw34KXVTC06
	 QmxjA7wEm/6/g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Show the tracer options in boot-time created instance
Date: Tue, 18 Nov 2025 16:49:50 +0900
Message-ID:  <176345219055.1127138.4292126981726580037.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since tracer_init_tracefs_work_func() only updates the tracer options
for the global_trace, the instances created by the kernel cmdline
do not have those options.

Fix to update tracer options for those boot-time created instances
to show those options.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Fixes: f20a580627f43 ("ftrace: Allow instances to use function tracing")
---
 kernel/trace/trace.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8ae95800592d..2e87060e1d5a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10903,6 +10903,7 @@ static struct notifier_block trace_module_nb = {
 
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
+	struct trace_array *tr;
 
 	event_trace_init();
 
@@ -10937,7 +10938,8 @@ static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 
 	create_trace_instances(NULL);
 
-	update_tracer_options(&global_trace);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list)
+		update_tracer_options(tr);
 }
 
 static __init int tracer_init_tracefs(void)

