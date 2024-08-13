Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B921A0727;
	Tue, 13 Aug 2024 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723569165; cv=none; b=HB49IVlyt/oVi1vqvfV0f9BLND8H5kZntFUs/9ZUjDUhUHfmmepQzja4phx5FfhOCo829Io8wd5PMcMjdL7nqrB1gmnp84YBuBSREne2YREyBpDeM3Htx/EuffHKpwGo/nCOrXjIgFczkfLPrjfVf0os6PlA4kSSLtrTe8geh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723569165; c=relaxed/simple;
	bh=meK3xd7C59qfbWbc3FCAvyTYa7D8wgcX/jSj4QGCQ9Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=t+sD4BqJVuo06gXkfe5nZlgw+J18WR9kXlIOq5kPdCc0oB9rryK30CNoV8PskUfOGd1VNeJK9lEqQUcjPHx9tn7/t+TeedyMS1uM+mIqwqXsmzunALkSTNyfQDbEGoM/le1w+rHm4/KF1DWb7MWrREBshY7dqBjfPQObQos8Lvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BAD6C4AF0B;
	Tue, 13 Aug 2024 17:12:45 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1sdv4r-00000001TPZ-1vDo;
	Tue, 13 Aug 2024 13:12:57 -0400
Message-ID: <20240813171257.319724335@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 13 Aug 2024 13:11:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Ross Zwisler <zwisler@google.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH 1/2] tracing: Allow boot instances to use reserve_mem boot memory
References: <20240813171104.950972475@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Allow boot instances to use memory reserved by the reserve_mem boot
option.

  reserve_mem=12M:4096:trace  trace_instance=boot_mapped@trace

The above will allocate 12 megs with 4096 alignment and label it "trace".
The second parameter will create a "boot_mapped" instance and use the
memory reserved and labeled as "trace" as the memory for the ring buffer.

That will create an instance called "boot_mapped":

  /sys/kernel/tracing/instances/boot_mapped

Note, because the ring buffer is using a defined memory ranged, it will
act just like a memory mapped ring buffer. It will not have a snapshot
buffer, as it can't swap out the buffer. The snapshot files as well as any
tracers that uses a snapshot will not be present in the boot_mapped
instance.

Also note that reserve_mem is not reliable in acquiring the same physical
memory at each soft reboot. It is possible that KALSR could map the kernel
at the previous boot memory location forcing the reserve_mem to return a
different memory location. In this case, the previous ring buffer will be
lost.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 13 +++++++++++++
 kernel/trace/trace.c                          | 19 +++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c688bc6e9153..f91a68bc8e77 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6754,6 +6754,19 @@
 			memory at 0x284500000 that is 12Megs. The per CPU buffers of that
 			instance will be split up accordingly.
 
+			Alternatively, the memory can be reserved by the reserve_mem option:
+
+				reserve_mem=12M:4096:trace trace_instance=boot_map@trace
+
+			This will reserve 12 megabytes at boot up with a 4096 byte alignment
+			and place the ring buffer in this memory. Note that due to KASLR, the
+			memory may not be the same location each time, which will not preserve
+			the buffer content.
+
+			Also note that the layout of the ring buffer data may change between
+			kernel versions where the validator will fail and reset the ring buffer
+			if the layout is not the same as the previous kernel.
+
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
 			The option-list is a comma delimited list of options
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8e5a4ca9fd70..c93a8dc69c69 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10465,22 +10465,20 @@ __init static void enable_instances(void)
 	str = boot_instance_info;
 
 	while ((curr_str = strsep(&str, "\t"))) {
-		unsigned long start = 0;
-		unsigned long size = 0;
+		phys_addr_t start = 0;
+		phys_addr_t size = 0;
 		unsigned long addr = 0;
 
 		tok = strsep(&curr_str, ",");
 		name = strsep(&tok, "@");
-		if (tok) {
+
+		if (tok && isdigit(*tok)) {
 			start = memparse(tok, &tok);
 			if (!start) {
 				pr_warn("Tracing: Invalid boot instance address for %s\n",
 					name);
 				continue;
 			}
-		}
-
-		if (start) {
 			if (*tok != ':') {
 				pr_warn("Tracing: No size specified for instance %s\n", name);
 				continue;
@@ -10492,6 +10490,15 @@ __init static void enable_instances(void)
 					name);
 				continue;
 			}
+		} else if (tok) {
+			if (!reserve_mem_find_by_name(tok, &start, &size)) {
+				start = 0;
+				pr_warn("Failed to map boot instance %s to %s\n", name, tok);
+				continue;
+			}
+		}
+
+		if (start) {
 			addr = map_pages(start, size);
 			if (addr) {
 				pr_info("Tracing: mapped boot instance %s at physical memory 0x%lx of size 0x%lx\n",
-- 
2.43.0


