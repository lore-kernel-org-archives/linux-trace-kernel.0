Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCD1C694;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377187; cv=none; b=spJmb2/JVycWGgluhqmyv7nJWEVZbj9YCFS4MdIEVDziZOBZdfhB5tYcS+KubTZ2CSt/iJQKvLlOw1sqHp1E5+kLCFCOYrYBsKuifmUBG5y0OK9YxdySrn/ESK1AcXWCP0TjC42CLdqMKGIuJQTISyWP24hNHFgpdlEoqNnWn2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377187; c=relaxed/simple;
	bh=R883UB1lQPveP+GSFXVrQFNV+2afojxMSJTjv9FnDKc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H2iy/4wrn45iBCySg4b1KWivwppt3KBxa53vEjSuLb83M2Ydd/DJv0ckGrtBBd6dO4MCJKgVDn5+mVZPqPvFgU0mXRF6zI5fOC8jUIn0ZQssLp3romAv3l0gi2bfSPKbIz1hOAh1/5qPq+2mbjNzOQzO7Hz1XAtjLfH7UsMm2Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C001EC4AF50;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1shJHn-00000003ZiZ-2rLe;
	Thu, 22 Aug 2024 21:40:19 -0400
Message-ID: <20240823014019.545459018@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 22 Aug 2024 21:39:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>,
 Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Tony Luck <tony.luck@intel.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>,
 Kees Cook <keescook@chromium.org>,
 Alexander Aring <aahringo@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Jonathan Corbet" <corbet@lwn.net>
Subject: [PATCH 4/5] tracing: Add option to set an instance to be the trace_printk
 destination
References: <20240823013902.135036960@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a option "trace_printk_dest" that will make the tracing instance the
location that trace_printk() will go to. This is useful if the
trace_printk or one of the top level tracers is too noisy and there's a
need to separate the two. Then an instance can be created, the
trace_printk can be set to go there instead, where it will not be lost in
the noise of the top level tracer.

Note, only one instance can be the destination of trace_printk at a time.
If an instance sets this flag, the instance that had it set will have it
cleared. There is always one instance that has this set. By default, that
is the top instance. This flag cannot be cleared from the top instance.
Doing so will result in an -EINVAL. The only way this flag can be cleared
from the top instance is by another instance setting it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst | 12 ++++++++++
 kernel/trace/trace.c           | 40 +++++++++++++++++++++++++++++-----
 kernel/trace/trace.h           |  1 +
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 5aba74872ba7..4073ca48af4a 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1186,6 +1186,18 @@ Here are the available options:
   trace_printk
 	Can disable trace_printk() from writing into the buffer.
 
+  trace_printk_dest
+	Set to have trace_printk() and similar internal tracing functions
+	write into this instance. Note, only one trace instance can have
+	this set. By setting this flag, it clears the trace_printk_dest flag
+	of the instance that had it set previously. By default, the top
+	level trace has this set, and will get it set again if another
+	instance has it set then clears it.
+
+	This flag cannot be cleared by the top level instance, as it is the
+	default instance. The only way the top level instance has this flag
+	cleared, is by it being set in another instance.
+
   annotate
 	It is sometimes confusing when the CPU buffers are full
 	and one CPU buffer had a lot of events recently, thus
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 35b37c9aa26c..658b40b483a3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -482,7 +482,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 	 TRACE_ITER_ANNOTATE | TRACE_ITER_CONTEXT_INFO |		\
 	 TRACE_ITER_RECORD_CMD | TRACE_ITER_OVERWRITE |			\
 	 TRACE_ITER_IRQ_INFO | TRACE_ITER_MARKERS |			\
-	 TRACE_ITER_HASH_PTR)
+	 TRACE_ITER_HASH_PTR | TRACE_ITER_TRACE_PRINTK)
 
 /* trace_options that are only supported by global_trace */
 #define TOP_LEVEL_TRACE_FLAGS (TRACE_ITER_PRINTK |			\
@@ -490,7 +490,7 @@ EXPORT_SYMBOL_GPL(unregister_ftrace_export);
 
 /* trace_flags that are default zero for instances */
 #define ZEROED_TRACE_FLAGS \
-	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK)
+	(TRACE_ITER_EVENT_FORK | TRACE_ITER_FUNC_FORK | TRACE_ITER_TRACE_PRINTK)
 
 /*
  * The global_trace is the descriptor that holds the top-level tracing
@@ -513,6 +513,16 @@ static __always_inline bool printk_binsafe(struct trace_array *tr)
 	return !(tr->flags & TRACE_ARRAY_FL_BOOT);
 }
 
+static void update_printk_trace(struct trace_array *tr)
+{
+	if (printk_trace == tr)
+		return;
+
+	printk_trace->trace_flags &= ~TRACE_ITER_TRACE_PRINTK;
+	printk_trace = tr;
+	tr->trace_flags |= TRACE_ITER_TRACE_PRINTK;
+}
+
 void trace_set_ring_buffer_expanded(struct trace_array *tr)
 {
 	if (!tr)
@@ -5300,7 +5310,8 @@ int trace_keep_overwrite(struct tracer *tracer, u32 mask, int set)
 int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 {
 	if ((mask == TRACE_ITER_RECORD_TGID) ||
-	    (mask == TRACE_ITER_RECORD_CMD))
+	    (mask == TRACE_ITER_RECORD_CMD) ||
+	    (mask == TRACE_ITER_TRACE_PRINTK))
 		lockdep_assert_held(&event_mutex);
 
 	/* do nothing if flag is already set */
@@ -5312,6 +5323,25 @@ int set_tracer_flag(struct trace_array *tr, unsigned int mask, int enabled)
 		if (tr->current_trace->flag_changed(tr, mask, !!enabled))
 			return -EINVAL;
 
+	if (mask == TRACE_ITER_TRACE_PRINTK) {
+		if (enabled) {
+			update_printk_trace(tr);
+		} else {
+			/*
+			 * The global_trace cannot clear this.
+			 * It's flag only gets cleared if another instance sets it.
+			 */
+			if (printk_trace == &global_trace)
+				return -EINVAL;
+			/*
+			 * An instance must always have it set.
+			 * by default, that's the global_trace instane.
+			 */
+			if (printk_trace == tr)
+				update_printk_trace(&global_trace);
+		}
+	}
+
 	if (enabled)
 		tr->trace_flags |= mask;
 	else
@@ -9687,7 +9717,7 @@ static int __remove_instance(struct trace_array *tr)
 	}
 
 	if (printk_trace == tr)
-		printk_trace = &global_trace;
+		update_printk_trace(&global_trace);
 
 	tracing_set_nop(tr);
 	clear_ftrace_function_probes(tr);
@@ -10578,7 +10608,7 @@ __init static void enable_instances(void)
 			tracer_tracing_off(tr);
 
 		if (traceprintk)
-			printk_trace = tr;
+			update_printk_trace(tr);
 
 		/*
 		 * If start is set, then this is a mapped buffer, and
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 07b2d2af9b33..c866991b9c78 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1321,6 +1321,7 @@ extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		C(IRQ_INFO,		"irq-info"),		\
 		C(MARKERS,		"markers"),		\
 		C(EVENT_FORK,		"event-fork"),		\
+		C(TRACE_PRINTK,		"trace_printk_dest"),	\
 		C(PAUSE_ON_TRACE,	"pause-on-trace"),	\
 		C(HASH_PTR,		"hash-ptr"),	/* Print hashed pointer */ \
 		FUNCTION_FLAGS					\
-- 
2.43.0


