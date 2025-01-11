Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463CA43166;
	Sat, 11 Jan 2025 06:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736577133; cv=none; b=YuuZHPawu+mvBkb6o/LK2zdq+yE4Ejk85D/nRrFvC9BfoIw256fcG5GlqEeHHZQ1qo7ps8HyqLmUsnGfHEUywdJbn8/qYi9mmNYV8F333D2hvMyscOuGfVpYT4Q0Vtp5FCeJPlg9PrbKF/8KAo2jJfi/AjtxVt6p62+/ivli74k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736577133; c=relaxed/simple;
	bh=WlW5wzVMtiCxmCyYY4AQnRLrTwEq6CUwkUmbhIO6pQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l70kkw/ZEO7csGItMPlfqAsp2m45W4bD+50VYtWdK9nD6hutYe7kPF/zAZZY/WGTOGvPQKv0oFcrTcfjMTMeU+Lsr8vtsnxPGADbsmQbSPOGlaoKjtIw0CVIwt63xzC0qyOd97WuW1zPKlAYSkwxffTIgbeAfmyWAu89GadRzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=htHeZbAO; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="htHeZbAO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=JiAWufxqkVzPBh0xWUrDhwqwo+seeZMaBCVPXILNB6Q=; b=htHeZbAOG9CXeDrATfs+VjXtNe
	LC/w2Ev/Z2tppzH6b2mrRamyIOkWJEx4igtqzhuk0yjbu0YD1jGuzMNQ9A5pL4IWcN6nEVpahhiax
	gIX6q6CYE16XnSLM0Z4VhKeZD4HYZvEn82uyi/91OPV2G05iaxTQ763IW94hXhLss+tYfWb8CQK0A
	c/fLHV3NKp0sdq70BJ7p9iM7FbTsr2M9hCB0payiFWNZPurK25vfKvZfzxjK05qKqR9uma3iUhcP9
	Qe3JJbaJx9AZGAgmwGz7J4tT2yhHa4Dkbm38l4xkF3j3spkQ5PgreaISrFz0g7WuykxhyAuutAE18
	ZqTO/hSA==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tWV2Y-00000000HmV-48wO;
	Sat, 11 Jan 2025 06:32:11 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix trace.h kernel-doc func/struct/enum members
Date: Fri, 10 Jan 2025 22:32:10 -0800
Message-ID: <20250111063210.910922-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc for function or struct members.
Use the correct enum names for enum members to prevent kernel-doc
warnings.

trace.h:302: warning: Function parameter or struct member 'cond_data' not described in 'cond_snapshot'
trace.h:618: warning: Excess struct member 'print_headers' description in 'tracer'

trace.h:1978: warning: Enum value 'EVENT_CMD_FL_POST_TRIGGER' not described in enum 'event_command_flags'
trace.h:1978: warning: Enum value 'EVENT_CMD_FL_NEEDS_REC' not described in enum 'event_command_flags'
trace.h:1978: warning: Excess enum value 'NEEDS_REC' description in 'event_command_flags'
trace.h:1978: warning: Excess enum value 'POST_TRIGGER' description in 'event_command_flags'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/trace.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- linux-next-20250108.orig/kernel/trace/trace.h
+++ linux-next-20250108/kernel/trace/trace.h
@@ -285,6 +285,8 @@ typedef bool (*cond_update_fn_t)(struct
  * associated with the trace instance by
  * tracing_cond_snapshot_disable().
  *
+ * @cond_data: the conditional snapshot's associated data
+ *
  * The method below is required.
  *
  * @update: When a conditional snapshot is invoked, the update()
@@ -568,7 +570,7 @@ struct trace_option_dentry {
  * @read: override the default read callback on trace_pipe
  * @splice_read: override the default splice_read callback on trace_pipe
  * @selftest: selftest to run on boot (see trace_selftest.c)
- * @print_headers: override the first lines that describe your columns
+ * @print_header: override the first lines that describe your columns
  * @print_line: callback that prints a trace
  * @set_flag: signals one of your private flags changed (trace_options file)
  * @flags: your private flags
@@ -1947,7 +1949,7 @@ struct event_command {
 /**
  * enum event_command_flags - flags for struct event_command
  *
- * @POST_TRIGGER: A flag that says whether or not this command needs
+ * @EVENT_CMD_FL_POST_TRIGGER: Indicates whether or not this command needs
  *	to have its action delayed until after the current event has
  *	been closed.  Some triggers need to avoid being invoked while
  *	an event is currently in the process of being logged, since
@@ -1966,7 +1968,7 @@ struct event_command {
  *	itself logs to the trace buffer, this flag should be set,
  *	otherwise it can be left unspecified.
  *
- * @NEEDS_REC: A flag that says whether or not this command needs
+ * @EVENT_CMD_FL_NEEDS_REC: Indicates whether or not this command needs
  *	access to the trace record in order to perform its function,
  *	regardless of whether or not it has a filter associated with
  *	it (filters make a trigger require access to the trace record
