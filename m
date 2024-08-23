Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13FD171A7;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724377186; cv=none; b=nJ0xmHBTxUWgMK9wQyLVDK/kPpP1jmALs9wKl9TCbuPLoMVUgyB/A1fpwj7lKPDbDCu2zzBaN1VE9mc6Y9EX5iIanWDs5YG4hnGyAT+GuyRSiDXgMq+dqQNOfmTe9j5BgrihmY1YwnDvPDQcal50akcIKNc2Zni/YWS0MmNTS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724377186; c=relaxed/simple;
	bh=v7JSQko84R2XGVryVlMWWTln1DMXjC7h878O2Z+H3Cs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MovM3rDOxRefsIDTYrUaf6MGIJJAApSn4JWQqUxZallz5t+SsOEd30i5Nrk1qgA3FumyzCW+vvh8NrAGOnbk3aXSu8/czq6LTopmx4Z0APFIbB9XLz7GbcQrpLns5oyxKtm4yjcDDdjQ78ubfZ+Vn94oyuFOQncgqFkOwgkRELo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC5BC4AF0B;
	Fri, 23 Aug 2024 01:39:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1shJHn-00000003Zh7-0qQ7;
	Thu, 22 Aug 2024 21:40:19 -0400
Message-ID: <20240823014019.053229958@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 22 Aug 2024 21:39:03 -0400
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
Subject: [PATCH 1/5] tracing: Add "traceoff" flag to boot time tracing instances
References: <20240823013902.135036960@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add a "flags" delimiter (^) to the "trace_instance" kernel command line
parameter, and add the "traceoff" flag. The format is:

   trace_instance=<name>[^<flag1>[^<flag2>]][@<memory>][,<events>]

The code allows for more than one flag to be added, but currently only
"traceoff" is done so.

The motivation for this change came from debugging with the persistent
ring buffer and having trace_printk() writing to it. The trace_printk
calls are always enabled, and the boot after the crash was having the
unwanted trace_printks from the current boot inject into the ring buffer
with the trace_printks of the crash kernel, making the output very
confusing.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt         | 17 ++++++++++
 kernel/trace/trace.c                          | 31 ++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 388653448e72..3803f2b7f065 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6743,6 +6743,15 @@
 			the same thing would happen if it was left off). The irq_handler_entry
 			event, and all events under the "initcall" system.
 
+			Flags can be added to the instance to modify its behavior when it is
+			created. The flags are separated by '^'. Currently there's only one flag
+			defined, and that's "traceoff", to have the tracing instance tracing
+			disabled after it is created.
+
+				trace_instance=foo^traceoff,sched,irq
+
+			The flags must come before the defined events.
+
 			If memory has been reserved (see memmap for x86), the instance
 			can use that memory:
 
@@ -6765,6 +6774,14 @@
 			kernel versions where the validator will fail and reset the ring buffer
 			if the layout is not the same as the previous kernel.
 
+			If the ring buffer is used for persistent bootups and has events enabled,
+			it is recommend to disable tracing so that events from a previous boot do not
+			mix with events of the current boot (unless you are debugging a random crash
+			at boot up).
+
+				reserve_mem=12M:4096:trace trace_instance=boot_map^traceoff@trace,sched,irq
+
+
 	trace_options=[option-list]
 			[FTRACE] Enable or disable tracer options at boot.
 			The option-list is a comma delimited list of options
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9bcef199ae90..a79eefe84d6b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10468,10 +10468,36 @@ __init static void enable_instances(void)
 		phys_addr_t start = 0;
 		phys_addr_t size = 0;
 		unsigned long addr = 0;
+		bool traceoff = false;
+		char *flag_delim;
+		char *addr_delim;
 
 		tok = strsep(&curr_str, ",");
-		name = strsep(&tok, "@");
 
+		flag_delim = strchr(tok, '^');
+		addr_delim = strchr(tok, '@');
+
+		if (addr_delim)
+			*addr_delim++ = '\0';
+
+		if (flag_delim)
+			*flag_delim++ = '\0';
+
+		name = tok;
+
+		if (flag_delim) {
+			char *flag;
+
+			while ((flag = strsep(&flag_delim, "^"))) {
+				if (strcmp(flag, "traceoff") == 0)
+					traceoff = true;
+				else
+					pr_info("Tracing: Invalid instance flag '%s' for %s\n",
+						flag, name);
+			}
+		}
+
+		tok = addr_delim;
 		if (tok && isdigit(*tok)) {
 			start = memparse(tok, &tok);
 			if (!start) {
@@ -10519,6 +10545,9 @@ __init static void enable_instances(void)
 			continue;
 		}
 
+		if (traceoff)
+			tracer_tracing_off(tr);
+
 		/* Only allow non mapped buffers to be deleted */
 		if (!start)
 			trace_array_put(tr);
-- 
2.43.0


