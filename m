Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901E417BB9;
	Wed, 12 Jun 2024 02:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158626; cv=none; b=SDvjZTBtf50xin1Km7wBof04WNxyD9cPRuobkSL/pwi7FajVfK+txrRTxaSZERDb9aW/bElCnTSIsZMTHvkRyC9Qylf16A3Lyjucgn4ufBXZots6w33qLGET9jEAUQbsIGh2v1MGLjzu1IjcDdK5nhCme+ccHGnDiMzYotsh0zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158626; c=relaxed/simple;
	bh=37r8lDjHzicuRAJsYN1lC8DJ6beNJb/4WZW/eHu4mrg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=QM1gqb8sDmiM1cZYmXUhOSLdLr87tPFoqNAtSXrGL4tK7O2xmfA+wexZawcWj/f+Tpfd/zTOkg2BMsgIuzk6/9QlrjYTY6W3006yj1M+hIdwKKouk1S78ksE21lFPZVyGDH7Koi9dTZgNf9k5MRwFQRxYK8+27/FtP5phDh6VdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7751DC4AF65;
	Wed, 12 Jun 2024 02:17:06 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHDYB-00000001XNC-2oNb;
	Tue, 11 Jun 2024 22:17:23 -0400
Message-ID: <20240612021723.532929570@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 22:16:51 -0400
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
Subject: [PATCH v5 09/13] ring-buffer: Save text and data locations in mapped meta data
References: <20240612021642.941740855@goodmis.org>
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
index 2118c478e42b..195e47ef730d 100644
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


