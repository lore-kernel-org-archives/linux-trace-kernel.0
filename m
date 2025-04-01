Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99205207662;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743539550; cv=none; b=Leim1qXfHPIn9HqnOBobgs/BihTFbXKfyD6he59gX6TcaOrO1w3thePGtDF+fcUaqSZarE+bNRUfDavdNcOhkZLGnOsezitbq/75b2t/tBiN+X/yFcsPCHqNurSzvL/MgT3LfDwp39JYBLbiY8xti8ZwOJkMlILM+j2TuiESzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743539550; c=relaxed/simple;
	bh=WuikE8wOn9kp2dLyXBHxz62U7JuITFmA6597hRZHqUI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Kd8/dVHIEEk4szp7np2kmkUGsWFsP7T0KYozCzDU7cs2mOki/F+xgbE7Mo8VJHFOLc5nyTXMB5WUyPqZm3VpF+XsI7FzSDyPzHf+vT+hT3ZVeyk5ZQ1S4R4P2CgluNxsNzlUjdaX6mSETnbcztOvCJj3B+S18meWIp42DT+RhWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAEAC4CEE4;
	Tue,  1 Apr 2025 20:32:30 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tziId-00000006IdJ-2xXy;
	Tue, 01 Apr 2025 16:33:31 -0400
Message-ID: <20250401203331.559044804@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 01 Apr 2025 16:25:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: [PATCH v3 1/5] tracing: Enforce the persistent ring buffer to be page aligned
References: <20250401202549.409271454@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Enforce that the address and the size of the memory used by the persistent
ring buffer is page aligned. Also update the documentation to reflect this
requirement.

Link: https://lore.kernel.org/all/CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com/

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  2 ++
 Documentation/trace/debugging.rst               |  2 ++
 kernel/trace/trace.c                            | 12 ++++++++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec8..71861643ef14 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7241,6 +7241,8 @@
 			This is just one of many ways that can clear memory. Make sure your system
 			keeps the content of memory across reboots before relying on this option.
 
+			NB: Both the mapped address and size must be page aligned for the architecture.
+
 			See also Documentation/trace/debugging.rst
 
 
diff --git a/Documentation/trace/debugging.rst b/Documentation/trace/debugging.rst
index 54fb16239d70..d54bc500af80 100644
--- a/Documentation/trace/debugging.rst
+++ b/Documentation/trace/debugging.rst
@@ -136,6 +136,8 @@ kernel, so only the same kernel is guaranteed to work if the mapping is
 preserved. Switching to a different kernel version may find a different
 layout and mark the buffer as invalid.
 
+NB: Both the mapped address and size must be page aligned for the architecture.
+
 Using trace_printk() in the boot instance
 -----------------------------------------
 By default, the content of trace_printk() goes into the top level tracing
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 14c38fcd6f9e..1288e0aaadf8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10774,6 +10774,18 @@ __init static void enable_instances(void)
 		}
 
 		if (start) {
+			/* Start and size must be page aligned */
+			if (start & ~PAGE_MASK) {
+				pr_warn("Tracing: mapping start addr %lx is not page aligned\n",
+					(unsigned long)start);
+				continue;
+			}
+			if (size & ~PAGE_MASK) {
+				pr_warn("Tracing: mapping size %lx is not page aligned\n",
+					(unsigned long)size);
+				continue;
+			}
+
 			addr = map_pages(start, size);
 			if (addr) {
 				pr_info("Tracing: mapped boot instance %s at physical memory %pa of size 0x%lx\n",
-- 
2.47.2


