Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846831624F5;
	Sat, 15 Feb 2025 03:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739591031; cv=none; b=ngyG8kH0F1UFVdtruqKmcw5RQejnIGOpKGvURvUh2UvAywXVpwOo6QOSnQeJsvwxVCXqxQmzdCF++j20p3YMLfhyyRv9ELfUrOoMngvnS5Y2lyDVmZcCiSp7/H6s3onjJuPhQTxlB6LBv0ifabZi5BuOnYJwsfd13x0ETmgqaTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739591031; c=relaxed/simple;
	bh=uJnQyG8i5lyHH/RkjjPSKWtqaqlnhy1DWyeFiqlXDKo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CS2yzl78yybG55E51o9x3SQ0QJrJkRM+oR2MOf593BSGiebiBGxmmGDCD6YIrstNKGc692B39Nv0Sn3pmmkCmHDDEXvHgNXOcz5sw6sKsf1BQp9dbDGWOHXzA3O3sjrqm6pNPo24NdUDc+Jk8g8s8QK5XKlvYaIdP6tmqHlYC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E72AC4CEE6;
	Sat, 15 Feb 2025 03:43:51 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tj965-00000002gwJ-0Dzx;
	Fri, 14 Feb 2025 22:44:05 -0500
Message-ID: <20250215034404.902259250@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 14 Feb 2025 22:43:06 -0500
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
Subject: [PATCH v2 5/8] module: Add module_for_each_mod() function
References: <20250215034301.624019422@goodmis.org>
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
2.47.2


