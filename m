Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F872253A1;
	Thu, 21 Aug 2025 15:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791036; cv=none; b=jW6OE4BUz0N+KaVn0Vbe3SYGD/H8G/xvz4NeRY0pABLwMb4QdVMQhecbvh0+T3Fk5VYlrUBTmUor6pHCYmxiBnoFHRz4ERxXOeGLncbmdB4d6k6UeDKRupcOw1ObGVWS6NnBMb3Ie4Hxcmf7nQ3eIUz9Mn3/l4xf5LCHyRacaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791036; c=relaxed/simple;
	bh=zkseqED+prKWKv8WhHs4A4hZi+XUkEv7BDHGRt5TJ7s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U5M+kaFDLdD4QBmLCR0NDVetGz48W3JnaNmgJtBzUfFNYxJtOe9O7odou20510l2QBScwok9yvoDzhDO2vyIn9i+xeFE44bg3YET0TShHP/wxjP/8Lp8h00R7wa2PSXt7TH7MYv5UYAabhqafMZsQZpa+O0lQRZnK60IsDJ/lsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 87D4513884E;
	Thu, 21 Aug 2025 15:43:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id C9CAB2000F;
	Thu, 21 Aug 2025 15:43:50 +0000 (UTC)
Date: Thu, 21 Aug 2025 11:43:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Elijah Wright <git@elijahs.space>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: move buffer in trace_seq to end of struct
Message-ID: <20250821114355.6ee546b0@gandalf.local.home>
In-Reply-To: <20250821053917.23301-1-git@elijahs.space>
References: <20250821053917.23301-1-git@elijahs.space>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C9CAB2000F
X-Stat-Signature: gcugpctkwzmdeup33w6qrqwu8wd8c3ng
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lb36+2aRzw445qXokpmmncYLfT8XTzYU=
X-HE-Tag: 1755791030-252035
X-HE-Meta: U2FsdGVkX1+Q2mGo1qDzaEsBPrG0VpVYOkzTvU97uxaWdfda+dgpcZOyxFqQWlB0bI3aaG+TpOuOUOtUn6j8bmXlwQMDZx2oCL06y4LCz/LIs9B+Hg5+T3Yoz/ZyseBZR/JXcdQ/THwN/v9e/mVB71tSZmONINHMeWXiV1Mf88h0EEbPozYjYKQXeZ71ayg5TuF3D3fHu5/IDc51z8rea90AEwEMnjG/Q46gi66k/M6QYFGm5imxTDuq4qBkjWjnJjwf3LVFXePIuwW2AViJAQrYEprzRFdo0P2LcTJUskP45m46Zc10kW5pxH0Jd6dS

On Wed, 20 Aug 2025 22:39:07 -0700
Elijah Wright <git@elijahs.space> wrote:

> TRACE_SEQ_BUFFER_SIZE is dependent on the architecture for its size. on 64-bit
> systems, it is 8148 bytes. forced 8-byte alignment in size_t and seq_buf means
> that trace_seq is 8200 bytes on 64-bit systems. moving the buffer to the end
> of the struct fixes the issue. there shouldn't be any side effects, i.e.
> pointer arithmetic on trace_seq

I don't remember why I had the buffer at the beginning. I think I did do
some crazy typecasting when I first developed this, as the buffer field
being first goes all the way back to the first commit (which doesn't
include prototypes before it).

I guess I'm fine with the change. Probably even makes the cache better, as
now the seq is now at the start of the buffer.

And that 'full' variable could actually be replaced as the seq does handle
those cases too. But it can't just be removed. I think the patch below
could be the answer to get rid of it.

Thanks,

-- Steve


diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index a93ed5ac3226..92364deb39a5 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -24,14 +24,12 @@ struct trace_seq {
 	char			buffer[TRACE_SEQ_BUFFER_SIZE];
 	struct seq_buf		seq;
 	size_t			readpos;
-	int			full;
 };
 
 static inline void
 trace_seq_init(struct trace_seq *s)
 {
 	seq_buf_init(&s->seq, s->buffer, TRACE_SEQ_BUFFER_SIZE);
-	s->full = 0;
 	s->readpos = 0;
 }
 
@@ -77,7 +75,7 @@ trace_seq_buffer_ptr(struct trace_seq *s)
  */
 static inline bool trace_seq_has_overflowed(struct trace_seq *s)
 {
-	return s->full || seq_buf_has_overflowed(&s->seq);
+	return seq_buf_has_overflowed(&s->seq);
 }
 
 /*
diff --git a/kernel/trace/trace_seq.c b/kernel/trace/trace_seq.c
index c158d65a8a88..bcb4cf1307f8 100644
--- a/kernel/trace/trace_seq.c
+++ b/kernel/trace/trace_seq.c
@@ -24,9 +24,6 @@
 #include <linux/seq_file.h>
 #include <linux/trace_seq.h>
 
-/* How much buffer is left on the trace_seq? */
-#define TRACE_SEQ_BUF_LEFT(s) seq_buf_buffer_left(&(s)->seq)
-
 /*
  * trace_seq should work with being initialized with 0s.
  */
@@ -64,6 +61,37 @@ int trace_print_seq(struct seq_file *m, struct trace_seq *s)
 	return ret;
 }
 
+/* If buffer has overflowed, nul terminate the old end */
+static inline void reset_buf_cond(struct trace_seq *s, unsigned int end)
+{
+	if (likely(!seq_buf_has_overflowed(&s->seq)))
+		return;
+
+	/* If we can't write it all, don't bother writing anything */
+	if (end >= s->seq.size)
+		end = s->seq.size - 1;
+	s->buffer[end] = '\0';
+}
+
+static inline bool len_overflows_buf(struct trace_seq *s, unsigned int len)
+{
+	unsigned int end;
+
+	if (len < seq_buf_buffer_left(&(s)->seq))
+		return false;
+
+	/* Buffer is full, end it */
+	end = seq_buf_used(&s->seq);
+	if (end >= s->seq.size)
+		end = s->seq.size - 1;
+	s->buffer[end] = '\0';
+
+	/* Make the buffer overflowed */
+	seq_buf_set_overflow(&s->seq);
+
+	return true;
+}
+
 /**
  * trace_seq_printf - sequence printing of trace information
  * @s: trace sequence descriptor
@@ -80,20 +108,13 @@ void trace_seq_printf(struct trace_seq *s, const char *fmt, ...)
 	unsigned int save_len = s->seq.len;
 	va_list ap;
 
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
 	va_start(ap, fmt);
 	seq_buf_vprintf(&s->seq, fmt, ap);
 	va_end(ap);
 
-	/* If we can't write it all, don't bother writing anything */
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
-		s->full = 1;
-	}
+	reset_buf_cond(s, save_len);
 }
 EXPORT_SYMBOL_GPL(trace_seq_printf);
 
@@ -110,17 +131,11 @@ void trace_seq_bitmask(struct trace_seq *s, const unsigned long *maskp,
 {
 	unsigned int save_len = s->seq.len;
 
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
 	seq_buf_printf(&s->seq, "%*pb", nmaskbits, maskp);
 
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
-		s->full = 1;
-	}
+	reset_buf_cond(s, save_len);
 }
 EXPORT_SYMBOL_GPL(trace_seq_bitmask);
 
@@ -140,18 +155,11 @@ void trace_seq_vprintf(struct trace_seq *s, const char *fmt, va_list args)
 {
 	unsigned int save_len = s->seq.len;
 
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
 	seq_buf_vprintf(&s->seq, fmt, args);
 
-	/* If we can't write it all, don't bother writing anything */
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
-		s->full = 1;
-	}
+	reset_buf_cond(s, save_len);
 }
 EXPORT_SYMBOL_GPL(trace_seq_vprintf);
 
@@ -174,19 +182,11 @@ void trace_seq_bprintf(struct trace_seq *s, const char *fmt, const u32 *binary)
 {
 	unsigned int save_len = s->seq.len;
 
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
 	seq_buf_bprintf(&s->seq, fmt, binary);
 
-	/* If we can't write it all, don't bother writing anything */
-	if (unlikely(seq_buf_has_overflowed(&s->seq))) {
-		s->seq.len = save_len;
-		s->full = 1;
-		return;
-	}
+	reset_buf_cond(s, save_len);
 }
 EXPORT_SYMBOL_GPL(trace_seq_bprintf);
 
@@ -204,15 +204,10 @@ void trace_seq_puts(struct trace_seq *s, const char *str)
 {
 	unsigned int len = strlen(str);
 
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
-	if (len > TRACE_SEQ_BUF_LEFT(s)) {
-		s->full = 1;
+	if (len_overflows_buf(s, len))
 		return;
-	}
 
 	seq_buf_putmem(&s->seq, str, len);
 }
@@ -230,15 +225,10 @@ EXPORT_SYMBOL_GPL(trace_seq_puts);
  */
 void trace_seq_putc(struct trace_seq *s, unsigned char c)
 {
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
-	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
-		s->full = 1;
+	if (len_overflows_buf(s, len))
 		return;
-	}
 
 	seq_buf_putc(&s->seq, c);
 }
@@ -256,15 +246,10 @@ EXPORT_SYMBOL_GPL(trace_seq_putc);
  */
 void trace_seq_putmem(struct trace_seq *s, const void *mem, unsigned int len)
 {
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
-	if (len > TRACE_SEQ_BUF_LEFT(s)) {
-		s->full = 1;
+	if (len_overflows_buf(s, len))
 		return;
-	}
 
 	seq_buf_putmem(&s->seq, mem, len);
 }
@@ -285,16 +270,11 @@ void trace_seq_putmem_hex(struct trace_seq *s, const void *mem,
 {
 	unsigned int save_len = s->seq.len;
 
-	if (s->full)
-		return;
-
 	__trace_seq_init(s);
 
 	/* Each byte is represented by two chars */
-	if (len * 2 > TRACE_SEQ_BUF_LEFT(s)) {
-		s->full = 1;
+	if (len_overflows_buf(s, len * 2))
 		return;
-	}
 
 	/* The added spaces can still cause an overflow */
 	seq_buf_putmem_hex(&s->seq, mem, len);
@@ -328,10 +308,8 @@ int trace_seq_path(struct trace_seq *s, const struct path *path)
 
 	__trace_seq_init(s);
 
-	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
-		s->full = 1;
-		return 0;
-	}
+	if (len_overflows_buf(s, 1))
+		return;
 
 	seq_buf_path(&s->seq, path, "\n");
 
@@ -387,10 +365,8 @@ int trace_seq_hex_dump(struct trace_seq *s, const char *prefix_str,
 
 	__trace_seq_init(s);
 
-	if (TRACE_SEQ_BUF_LEFT(s) < 1) {
-		s->full = 1;
-		return 0;
-	}
+	if (len_overflows_buf(s, 1))
+		return;
 
 	seq_buf_hex_dump(&(s->seq), prefix_str,
 		   prefix_type, rowsize, groupsize,
