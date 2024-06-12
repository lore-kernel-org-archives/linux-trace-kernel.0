Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9691312D76E;
	Wed, 12 Jun 2024 23:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718234407; cv=none; b=Modzz7PxtRdU3Cjig/Rofzi2oynw+4T+SPpd73NiZDf98+4fBo7O3b1RN8bke3v1sTyHeM1GM/y4xJjIvnU/YvXh1/kezAScUztGPZ3HtMK+oQ4vDuYsPwyDBTzqfjolpicFnqhRLN+Jx9ZBMzM6j7/pqXY5oemBj6/mttU5s5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718234407; c=relaxed/simple;
	bh=+k1Ovci6p6/I4LM80e9A+R9QOVvPuVbEFeW9HWxETJY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=d2K7fyyWpczC8+2SxNBhJTMxPBGMLNXOIBXNP/0vWjtKTzvM+oUvIpu/lkmOOkR4TrqXeYJhKPKh0yXaRgXRRbVkqwkxYZ/3NvwouFQU2JFigXcXOtvD7ATA563fovqeYySfC26C0j6VFLzQjjzPQuVkdGBbaS95DTQ69ePBB3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A71EC4AF5F;
	Wed, 12 Jun 2024 23:20:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHXGU-00000001deQ-2fi3;
	Wed, 12 Jun 2024 19:20:26 -0400
Message-ID: <20240612232026.496176678@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 12 Jun 2024 19:19:43 -0400
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
Subject: [PATCH v6 09/13] ring-buffer: Save text and data locations in mapped meta data
References: <20240612231934.608252486@goodmis.org>
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
index 804dfbdeef84..8c287430411d 100644
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
@@ -542,6 +544,9 @@ struct trace_buffer {
 	unsigned long			range_addr_start;
 	unsigned long			range_addr_end;
 
+	long				last_text_delta;
+	long				last_data_delta;
+
 	unsigned int			subbuf_size;
 	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
@@ -1821,10 +1826,15 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
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
@@ -1841,6 +1851,10 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			meta->first_buffer += delta;
 			meta->head_buffer += delta;
 			meta->commit_buffer += delta;
+			buffer->last_text_delta = this_text - meta->text_addr;
+			buffer->last_data_delta = this_data - meta->data_addr;
+			meta->text_addr = this_text;
+			meta->data_addr = this_data;
 			continue;
 		}
 
@@ -1857,6 +1871,8 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 		subbuf = rb_subbufs_from_meta(meta);
 
 		meta->first_buffer = (unsigned long)subbuf;
+		meta->text_addr = this_text;
+		meta->data_addr = this_data;
 
 		/*
 		 * The buffers[] array holds the order of the sub-buffers
-- 
2.43.0


