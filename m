Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C877513212A;
	Tue,  4 Mar 2025 01:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741051494; cv=none; b=j+hOF4crmBWB0X5L+E1SQHao1hKAM+6fvWMy/B0rXt+8dw/lx6gBLNhyHl55PLUQ651Tcge78ow1HBHhhPhXjRXuCFF+HQo/rUip/3lqOT+oC7VZMB45jyvGvvCkezNB5awAbmEADsSrhZkpR1cTasC2EovYW0jDfRAlztOm5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741051494; c=relaxed/simple;
	bh=uwP4DOo17w5bMID/vK/+QW5Yb0LcCl7y2kyQrYSQMBk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TxP35qbdWnzivR8wuhIp2dNkKB23eCou1/CkG8rPqRVWhDBeg7akD73h7cvDXYer7w4xQGqp7yNY5NGAesLZuF+kwTxswcOFFHY/uxXzUWbbMzO4UznpNUiFQHXPc+qV9fJW8SqBj6YBsrI7re40uoluFNu7fPQgDv4ana3xv/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9E1C4CEED;
	Tue,  4 Mar 2025 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpH2a-0000000CC6r-2RUI;
	Mon, 03 Mar 2025 20:25:48 -0500
Message-ID: <20250304012548.433669427@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 03 Mar 2025 20:25:21 -0500
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
Subject: [PATCH v3 5/8] module: Add module_for_each_mod() function
References: <20250304012516.282694507@goodmis.org>
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
Changes since v2: https://lore.kernel.org/20250215034404.902259250@goodmis.org

- Use RCU guard instead of disabling preemption

 include/linux/module.h |  6 ++++++
 kernel/module/main.c   | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 30e5b19bafa9..9a71dd2cb11f 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -782,6 +782,8 @@ static inline void *module_writable_address(struct module *mod, void *loc)
 	return __module_writable_address(mod, loc);
 }
 
+void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
@@ -894,6 +896,10 @@ static inline void *module_writable_address(struct module *mod, void *loc)
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
index 1fb9ad289a6f..927a2e0ffd5f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3809,6 +3809,19 @@ bool is_module_text_address(unsigned long addr)
 	return ret;
 }
 
+void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
+{
+	struct module *mod;
+
+	guard(rcu)();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (func(mod, data))
+			break;
+	}
+}
+
 /**
  * __module_text_address() - get the module whose code contains an address.
  * @addr: the address.
-- 
2.47.2


