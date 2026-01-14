Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831D2D5946
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 12:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394307; cv=none; b=HFJdtHCZ35anotZwuLk482XRapBoLU0StTbTcVD1qqtb0zEJGeRG7UKTE2PO4jlD55ge+MCXIByq/q6xvPlqbki97KabU6gfvQ9lCg3jB+1CuSqlloSvW6c/18Puq02dkT1gs79pb8nq6zVEAP1S8o8ZwxiniTItYlUwes53yB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394307; c=relaxed/simple;
	bh=St5hY/xdPV64+Z36nIFqhnh9NvmhRzlS6P1W8UdKUx8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LadbB1c2hI4mjc3H0Tzx/l98KBMoH4DOi5xeoUFHEDxLgtOYt5XdK20GCGDR2pFj6WABVdXMN5eBeQwdZrXxgDKQ1mKGDiOVtHic7Hww91mqIZDc2Ae5Et4T6vZiqsekNxJJomcXRH3syplzz3GB0ewwIOx8Q3mwIPlGrJg1Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L64hv2u3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L64hv2u3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768394303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5hLPIxf1skim8eXLrM4/NJDBybR6ErvrcqNCgp+dZ1A=;
	b=L64hv2u3iCc1CtRRUHXhat74qgfRVu8XZIkKkSYrLnCBq2LLG8BRMVC5hxa8GGlZpgPE89
	XhuZVf9MrKB2R6vVsxictFsbLwWpABdZ9575mizxGq2KFfvJhgdnL0mVd9s6p8J+vcTwwy
	x5IbEirJcHCLp4BQTShz7cXbL3P2oAY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-Ssdj70xxN6ejXOowHq1d6g-1; Wed,
 14 Jan 2026 07:38:19 -0500
X-MC-Unique: Ssdj70xxN6ejXOowHq1d6g-1
X-Mimecast-MFC-AGG-ID: Ssdj70xxN6ejXOowHq1d6g_1768394298
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38FEB195608F;
	Wed, 14 Jan 2026 12:38:18 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.147])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 475D419560A2;
	Wed, 14 Jan 2026 12:38:14 +0000 (UTC)
From: Tomas Glozar <tglozar@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Crystal Wood <crwood@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Luis Goncalves <lgoncalv@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
	Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH] tracing/osnoise: Fix OSN_WORKLOAD-related crash
Date: Wed, 14 Jan 2026 13:35:47 +0100
Message-ID: <20260114123547.583859-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A kernel panic was observed in the timerlat tracer with the following
reproducer:

   #!/bin/bash
   while true; do
      rtla timerlat hist -u -d 5s & PID=$!
      sleep 2
      echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options
      rtla timerlat hist -k -d 1s
   done

The kernel first displays several WARN traces with the following pattern:

   WARNING: CPU: 1 PID: 1822 at kernel/trace/trace_osnoise.c:1959 stop_kthread+0xb7/0xc0
   ...
   CPU: 1 UID: 0 PID: 1822 Comm: bash
   ..
   Call Trace:
     ...
     ? stop_kthread+0xb7/0xc0
     stop_per_cpu_kthreads+0xf/0x40
     osnoise_options_write+0xda/0x1b0
     vfs_write+0xf5/0x450
     ...
     ksys_write+0x6d/0xf0
     do_syscall_64+0x7d/0x160
     ...
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Then, it displays a similar pattern, but in start_per_cpu_kthreads():

   WARNING: CPU: 1 PID: 2120 at kernel/trace/trace_osnoise.c:2068 start_per_cpu_kthreads+0xfe/0x110
   ...
   CPU: 1 UID: 0 PID: 2120 Comm: rtla
   ...
   Call Trace:
     ...
     ? start_per_cpu_kthreads+0xfe/0x110
     ...
     osnoise_workload_start+0xb1/0x2d0
     timerlat_tracer_start+0x50/0x70
     rb_simple_write+0x13a/0x160
     vfs_write+0xf5/0x450
     ...
     ksys_write+0x6d/0xf0
     do_syscall_64+0x7d/0x160
     ...
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

and finally a null pointer reference BUG:

   BUG: kernel NULL pointer dereference, address: 0000000000000030
   ...
   CPU: 1 UID: 0 PID: 2155 Comm: timerlatu/1
   ...
   Call Trace:
     ...
     ? timerlat_fd_read+0xf2/0x370
     ? timerlat_fd_read+0xee/0x370
     vfs_read+0xe8/0x370
     ksys_read+0x6d/0xf0
     do_syscall_64+0x7d/0x160
     ...
     entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix the bug by disallowing OSNOISE_WORKLOAD to be set if timerlat is
running with NO_OSNOISE_WORKLOAD and a user workload is attached to at
least one CPU.

To implement this, a new function osnoise_validate_option() is added.
The function validates any osnoise option change, and return an error
value if the change is not valid. EBUSY is used for this particular
case.

Fixes: 30838fcd8107 ("tracing/osnoise: Add OSNOISE_WORKLOAD option")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 kernel/trace/trace_osnoise.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 827104d00bc0..6a6d4f8bc19f 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2186,6 +2186,31 @@ static const struct seq_operations osnoise_options_seq_ops = {
 	.stop		= s_options_stop
 };
 
+/**
+ * osnoise_validate_option - Check if set option is valid
+ * @option: The index of the option
+ * @enabled: The requested state of the option
+ *
+ * Verify if the requested osnoise option is valid with regards to the current
+ * state of the tracer.
+ *
+ * If valid, return 0, if not, return error number.
+ */
+static int osnoise_validate_option(int option, int enabled)
+{
+	int cpu;
+
+	if (option == OSN_WORKLOAD && enabled &&
+	    !test_bit(OSN_WORKLOAD, &osnoise_options)) {
+		/* Trying to enable kernel threads while user workload is running? */
+		for_each_online_cpu(cpu)
+			if (per_cpu(per_cpu_osnoise_var, cpu).pid)
+				return -EBUSY;
+	}
+
+	return 0;
+}
+
 static int osnoise_options_open(struct inode *inode, struct file *file)
 {
 	return seq_open(file, &osnoise_options_seq_ops);
@@ -2229,6 +2254,10 @@ static ssize_t osnoise_options_write(struct file *filp, const char __user *ubuf,
 	if (option < 0)
 		return -EINVAL;
 
+	retval = osnoise_validate_option(option, enable);
+	if (retval != 0)
+		return retval;
+
 	/*
 	 * trace_types_lock is taken to avoid concurrency on start/stop.
 	 */
-- 
2.52.0

