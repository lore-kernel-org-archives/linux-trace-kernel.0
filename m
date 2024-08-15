Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2866314884B;
	Thu, 15 Aug 2024 12:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723724877; cv=none; b=MPbqwLdVlnQ+lUIFzXILxFqpv6rDFCVqIrCisC4pgI/gxRnJQyMKwGPDoG/eyPopR6W9bCJplayq50d18lw9GWTSToVrF9HzQraNze+iOlYGma+Swd15YpTLjwdgJtEAHqfCEcqnw1yqpfZdIHnywnv0qUQ3T9qdNg+//0QppZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723724877; c=relaxed/simple;
	bh=ReQuDQIToWZBlBw02ZmqJVlAuG9/z85X0gnMftUVdvk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=s58LRumTZmufhu01yiYoM7y4/3k3uMZpj/c7MPcTlJ8eeQOKEgVYeNps+iWhkVfrQRrkNCzLrGHqAOsdwy8GVKjf68nggXNLJ08T9qNLTgr39Wnpjwe5rMp8QmsjPQg2CzhVL3HdlAyx4btb0Kk6GxtILbg67ylTqJhxpZhXuPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E1DC32786;
	Thu, 15 Aug 2024 12:27:55 +0000 (UTC)
Date: Thu, 15 Aug 2024 08:28:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Ross Zwisler <zwisler@google.com>, Vincent
 Donnefort <vdonnefort@google.com>
Subject: [PATCH v2] tracing: Allow boot instances to use reserve_mem boot
 memory
Message-ID: <20240815082811.669f7d8c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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
Changes since v1: https://lore.kernel.org/20240813171257.319724335@goodmis.org

- Fixed pr_info() to handle change of start and size going from unsigned long
  to phys_addr_t, as that can not use the "%lx" format.

 .../admin-guide/kernel-parameters.txt         | 13 +++++++++++
 kernel/trace/trace.c                          | 23 ++++++++++++-------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 35b592823338..388653448e72 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6752,6 +6752,19 @@
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
index 8e5a4ca9fd70..9bcef199ae90 100644
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
@@ -10492,10 +10490,19 @@ __init static void enable_instances(void)
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
-				pr_info("Tracing: mapped boot instance %s at physical memory 0x%lx of size 0x%lx\n",
-					name, start, size);
+				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
+					name, &start, (unsigned long)size);
 			} else {
 				pr_warn("Tracing: Failed to map boot instance %s\n", name);
 				continue;
-- 
2.43.0

