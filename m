Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA4621A453;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795823; cv=none; b=gRyoKLfDd1jntTIcy+6GjUl8mvjJ3qO8MiDRcOzXIR5w2b5CsuNXiHoMaZ0m+roMjNLP1fugvS4BONGFboEUP349O+1TMMxJRxIrO9QiGw4hxUdJKIm9otKbMfbH73OJadpl8qEw9PdRrjfKnshXDlbL8clYKFFOyEpQoT+/9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795823; c=relaxed/simple;
	bh=NGlDmyhKE+eXxsSImJtT/RQQNDcwlx1ewF9KadcrQKs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Yk/qTK2dXr/n+19AuEjEjSPpcef5NQBbRDqd1Iyq40CdbCHI3ue/GjHCo0lNjpgigwh2x50sftSx1cjr0AzG+3t+IVbOTQHnne7FDTR2LTvE0acCIQMcgOTrVMvl6Wu8IcchBLzK7QAVAulvTATUmemkCTIFaHMVA09C+x/n1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6924FC4CED1;
	Wed,  5 Feb 2025 22:50:23 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tfoEZ-00000007gVb-3pBn;
	Wed, 05 Feb 2025 17:51:03 -0500
Message-ID: <20250205225103.760856859@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Feb 2025 17:50:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org
Subject: [PATCH 5/8] module: Add module_for_each_mod() function
References: <20250205225031.799739376@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The tracing system needs a way to save all the currently loaded modules
and their addresses into persistent memory so that it can evaluate the
addresses on a reboot from a crash. When the persistent memory trace
starts, it will load the module addresses and names into the persistent
memory. To do so, it will call the module_for_each_mod() function and pass
it a function and data structure to get called on each loaded module. Then
it can record the memory.

This only implements that function.

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/module.h |  6 ++++++
 kernel/module/main.c   | 14 ++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 23792d5d7b74..9e1f42f03511 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -779,6 +779,8 @@ static inline void *module_writable_address(struct module *mod, void *loc)
 	return __module_writable_address(mod, loc);
 }
 
+void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -891,6 +893,10 @@ static inline void *module_writable_address(struct module *mod, void *loc)
 {
 	return loc;
 }
+
+static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
+{
+}
 #endif /* CONFIG_MODULES */
 
 #ifdef CONFIG_SYSFS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1fb9ad289a6f..ea1fe313fb89 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3809,6 +3809,20 @@ bool is_module_text_address(unsigned long addr)
 	return ret;
 }
 
+void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
+{
+	struct module *mod;
+
+	preempt_disable();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (func(mod, data))
+			break;
+	}
+	preempt_enable();
+}
+
 /**
  * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
-- 
2.45.2


