Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEF219E4;
	Wed, 12 Jun 2024 02:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158627; cv=none; b=YbZQScllsJnyDP3pYCxHypF2hyPPlFhzv7UCVU6dskzgDCKoslPUmTtjxpruJV4uQX61+c7YKBV1u01gbwv5u/u+SnPkCwZaHFZzNN8104wXT2jNp0p3nzE0E5XyiuV3oAAw780QQoiKItcbZweQ9XkmSn17+pChBesGnM4w5v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158627; c=relaxed/simple;
	bh=IE1IK2OKn7/pafSQ0ncO+HLzuopsT1q+/33iYZS7wTg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Ime2h42TBND9sVvPhV9xLMcHJaxEymszzKeiLvKOgcs0fwGE0ebCSuVI9x/MqM9XmkwK4meDMgWhGcTqgGhEYVbDVyYUzdqGFBM83Waim0a2J0G5x9atK1BGDrMHioRDHw8y3pR3bQif6gfTWXMKrbx+XE3knUGwlva6xAyY/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E06C4AF50;
	Wed, 12 Jun 2024 02:17:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHDYC-00000001XOh-0gKW;
	Tue, 11 Jun 2024 22:17:24 -0400
Message-ID: <20240612021724.022660136@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 22:16:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
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
 Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 12/13] tracing: Update function tracing output for previous boot buffer
References: <20240612021642.941740855@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

For a persistent ring buffer that is saved across boots, if function
tracing was performed in the previous boot, it only saves the address of
the functions and uses "%pS" to print their names. But the current boot,
those functions may be in different locations. The persistent meta-data
saves the text delta between the two boots and can be used to find the
address of the saved function of where it is located in the current boot.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..b9d2c64c0648 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -990,8 +990,11 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, int flags)
+			   unsigned long parent_ip, long delta, int flags)
 {
+	ip += delta;
+	parent_ip += delta;
+
 	seq_print_ip_sym(s, ip, flags);
 
 	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
@@ -1009,7 +1012,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1674,7 +1677,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.43.0


