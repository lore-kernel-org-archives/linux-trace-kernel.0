Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADC21514DA;
	Tue, 11 Jun 2024 19:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134132; cv=none; b=jYIz2AZs+D6Ex+XhYQKyu2n2uA1gpZvrDnnfTVcvZpqTKudfq5xqFuH6etsWHUWNccTkwzk8nKIOlCe7rZT1iuZnGxnMPmfAt8ZbFoM/m+ml9kviDs/YgSrghNLSMF+tqqY7NoEkfqQBJhDn+6LxrCqaMt42ac7dbECIaGYAXF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134132; c=relaxed/simple;
	bh=6Jl2ShtXKa6oe/J9WMbsmRq2sqkbA26nLPiNq2QCH+s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NYwKOMjqscdxbiGzwwg2lg9WR7q6dGuCxBV/Qc2UVbkudH9/yjqxXtzflClaSfWMeCyb7l3ojtfcOFm1fA4XF/h8CAyQIyg4jf+HdqU8PJLUKV40L8vWVqQfE4GdJ32Z8uWGAxK1+Lt5X1at4IU92L+845XCnH6BWwlw6IKcnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59ACAC4AF61;
	Tue, 11 Jun 2024 19:28:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sH7B6-00000001Ttw-3Q2q;
	Tue, 11 Jun 2024 15:29:08 -0400
Message-ID: <20240611192908.678828426@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 15:28:37 -0400
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
Subject: [PATCH v4 09/13] ring-buffer: Save text and data locations in mapped meta data
References: <20240611192828.691638177@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When a ring buffer is mapped to a specific address, save the address of a
text function and some data. This will be used to determine the delta
between the last boot and the current boot for pointers to functions as
well as to data.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 86f03c0ba4c0..ab6b8a0ee8e1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -45,6 +45,8 @@
 static void update_pages_handler(struct work_struct *work);
 
 struct ring_buffer_meta {
+	unsigned long	text_addr;
+	unsigned long	data_addr;
 	unsigned long	first_buffer;
 	unsigned long	head_buffer;
 	unsigned long	commit_buffer;
@@ -541,6 +543,9 @@ struct trace_buffer {
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
 
+	long				last_text_delta;
+	long				last_data_delta;
+
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
@@ -1819,10 +1824,15 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	}
 }
 
+/* Used to calculate data delta */
+static char rb_data_ptr[] = "";
+
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
 	unsigned long delta;
+	unsigned long this_text = (unsigned long)rb_range_meta_init;
+	unsigned long this_data = (unsigned long)rb_data_ptr;
 	void *subbuf;
 	int cpu;
 	int i;
@@ -1839,6 +1849,10 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
+			buffer->last_text_delta = this_text - meta->text_addr;
+			buffer->last_data_delta = this_data - meta->data_addr;
+			meta->text_addr = this_text;
+			meta->data_addr = this_data;
 			continue;
 		}
 
@@ -1855,6 +1869,8 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 		subbuf = rb_subbufs_from_meta(meta);
 
 		meta->first_buffer = (unsigned long)subbuf;
+		meta->text_addr = this_text;
+		meta->data_addr = this_data;
 
 		/*
 		 * The buffers[] array holds the order of the sub-buffers
-- 
2.43.0


