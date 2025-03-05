Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8681A704B;
	Wed,  5 Mar 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193169; cv=none; b=IWDA3PavswO7y/OHv4IqJKkLj/F9BWs9I3tDD5xMTS30GTF3J9TumAlmiNwSdg/DN8F/mHrRwnSiw6FTFDGJd3xKa2J03aB5FCXLDuaiW+9bXAeJe5Z2N22cm75E9nYiVjC2CYqjQzYNVs225oL926encBjzHi5lkYYv/A2wjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193169; c=relaxed/simple;
	bh=wumHBIhM/7KLa1CC5s6IUc+P8YjIgavNBqomY6LvzZE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Yn53JeFcTmFzv0gYFsjl+mQVvA8+ktrtyE0PB6jfZSqw36o+Cq+5n+k1B8/NNaTsnJV5q75O5S1jIELDGvRdBJh7EesTxUUkomp4dHPp3GGrQIhz9uqSEyHOZob+bz1G8nMLWIOoJH1X+5lDc++kJu/aboTlBUJq/2vb18QSdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D6FC4CEE9;
	Wed,  5 Mar 2025 16:46:09 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tprsn-0000000D0wx-0SJz;
	Wed, 05 Mar 2025 11:46:09 -0500
Message-ID: <20250305164608.962615966@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 05 Mar 2025 11:45:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org,
 Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v4 5/8] module: Add module_for_each_mod() function
References: <20250305164539.379008535@goodmis.org>
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
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org
Acked-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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


