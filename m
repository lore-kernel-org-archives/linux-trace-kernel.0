Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F1258EC2;
	Thu, 18 Dec 2025 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093765; cv=none; b=Ke+I1kii9fJbeyxh0iYejx2MLW4l3mGMeNePlc82aS/7+yaj/M6Z3kK1IxH4zUZcM17Na3lF4/XmOaOnWPAu9SNYYp7sx1BiEiDpDbkmlQHiQSQJyoGyJKDU2Q6gYcACI2IKhrW6CocV826Xr3WzTCGgZVgv3aPXNGNYq/OmHn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093765; c=relaxed/simple;
	bh=rMGx0jEG4fmUaN/rMahbQYaSkzwPJHW4sd/dq+A1lpg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=g18W65ZOCsDttbwCgoGZmP4LATv2hHCf477ozGQziWtkIqlyvIP8bA29t7kjUy+LkBvOnQUX3cswpmj//rOd/MMpCJ3in8+nu9wjXMKhBkp3rJ8cbCLASZYttAPuqAPVE3ZvlEjufNPvhUdIKRFB1H7VrFRAKWheF7ZF3n2Qo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CA728160239;
	Thu, 18 Dec 2025 21:36:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 07D021B;
	Thu, 18 Dec 2025 21:35:59 +0000 (UTC)
Date: Thu, 18 Dec 2025 16:37:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Yury Norov <yury.norov@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>
Subject: [PATCH] tracing: Remove size parameter in __trace_puts()
Message-ID: <20251218163739.5605f9ea@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: feydioow5qjrgnggmrntkrh387raxb7m
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 07D021B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/i35hstc4hPmAaAR78S7Z3bhBdzTgHzU8=
X-HE-Tag: 1766093759-564182
X-HE-Meta: U2FsdGVkX19z05WVDCQ17yF8WgK5DX1B4SWtq8Nh6Ryo4PlV7paTu+qJXQahKzNO5TAo1KranP463Vnl3E6ezCjfxX6X4gookRq1QsmpMgII5RksY4j3xkJMB8mkP0ts7twIlWpIAGmK/aQUwF/sUGTZyZFsHkb0BeZ+3OBevI5S/5CYDs1Nt6V0H2jSmjRedE/MrJkmUB1f6/bktgZ2IUpI0oN8hfP49dtaFrnZEzfExsIXioY/ZVKye66ovxNXZ/D9VX5N0L1pfWASnMUFCAQU1hqtUDJMafIDJXWTsdqZ3/Yr75bVaTynQnKDNonhWBpxJ7jZXvtjTOHdO8RmCsQkZ8TDxcAjXIZPpVsnrWzM1dULdZOHSxCggg5oKUDTDFP14QC7dPDqxgvKv0hUjQ==

From: Steven Rostedt <rostedt@goodmis.org>

The __trace_puts() function takes a string pointer and the size of the
string itself. All users currently simply pass in the strlen() of the
string it is also passing in. There's no reason to pass in the size.
Instead have the __trace_puts() function do the strlen() within the
function itself.

This fixes a header recursion issue where using strlen() in the macro
calling __trace_puts() requires adding #include <linux/string.h> in order
to use strlen(). Removing the use of strlen() from the header fixes the
recursion issue.

Link: https://lore.kernel.org/all/aUN8Hm377C5A0ILX@yury/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/kernel.h | 4 ++--
 kernel/trace/trace.c   | 7 +++----
 kernel/trace/trace.h   | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b46924fdff5..d5a939b8c391 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -331,10 +331,10 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
 	if (__builtin_constant_p(str))					\
 		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
 	else								\
-		__trace_puts(_THIS_IP_, str, strlen(str));		\
+		__trace_puts(_THIS_IP_, str);				\
 })
 extern int __trace_bputs(unsigned long ip, const char *str);
-extern int __trace_puts(unsigned long ip, const char *str, int size);
+extern int __trace_puts(unsigned long ip, const char *str);
 
 extern void trace_dump_stack(int skip);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e575956ef9b5..686741edb803 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1178,11 +1178,10 @@ EXPORT_SYMBOL_GPL(__trace_array_puts);
  * __trace_puts - write a constant string into the trace buffer.
  * @ip:	   The address of the caller
  * @str:   The constant string to write
- * @size:  The size of the string.
  */
-int __trace_puts(unsigned long ip, const char *str, int size)
+int __trace_puts(unsigned long ip, const char *str)
 {
-	return __trace_array_puts(printk_trace, ip, str, size);
+	return __trace_array_puts(printk_trace, ip, str, strlen(str));
 }
 EXPORT_SYMBOL_GPL(__trace_puts);
 
@@ -1201,7 +1200,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	int size = sizeof(struct bputs_entry);
 
 	if (!printk_binsafe(tr))
-		return __trace_puts(ip, str, strlen(str));
+		return __trace_puts(ip, str);
 
 	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..de4e6713b84e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2116,7 +2116,7 @@ extern void tracing_log_err(struct trace_array *tr,
  * about performance). The internal_trace_puts() is for such
  * a purpose.
  */
-#define internal_trace_puts(str) __trace_puts(_THIS_IP_, str, strlen(str))
+#define internal_trace_puts(str) __trace_puts(_THIS_IP_, str)
 
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(call, struct_name, id, tstruct, print)	\
-- 
2.51.0

