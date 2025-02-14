Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB62747F;
	Fri, 14 Feb 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739546889; cv=none; b=N4o/H2CZnHSf24bwYk7ydhOJdG/MPPoS9foIxpiy+q9TgaMZaoJCA7UaQbseVfhY9jdw1PLG7H2E+utgjV5M/DfjVdRlNuG7napiarnZIriqWvjL5aDKxMW2R5fzeglKwKgQhzY1uRjOs8DaosQ0280aK22M5KBHPbIJixtDXqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739546889; c=relaxed/simple;
	bh=rUBy4sFinlmT22XbeZj6w1L2v3nzFb8M6M4CUpGIY+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=oFRNOfp966E//cFHZI+/6l/Xjf92L4MP3NXrgpwD69vNYZ6F/pm2zg/tduYEmc3zSlhD8ygBjL/OQzIQU+z1Cz+dOs9lPCCV63MjKaEo1RqqhwZVyCd3wuV+fyrKrLfP6ye55XQHGy+744YbM7erQJhpWHUw5rAo4ipLNbb3aIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B88C4CED1;
	Fri, 14 Feb 2025 15:28:08 +0000 (UTC)
Date: Fri, 14 Feb 2025 10:28:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort <vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Validate the persistent meta data subbuf array
Message-ID: <20250214102820.7509ddea@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The meta data for a mapped ring buffer contains an array of indexes of all
the subbuffers. The first entry is the reader page, and the rest of the
entries lay out the order of the subbuffers in how the ring buffer link
list is to be created.

The validator currently makes sure that all the entries are within the
range of 0 and nr_subbufs. But it does not check if there are any
duplicates.

While working on the ring buffer, I corrupted this array, where I added
duplicates. The validator did not catch it and created the ring buffer
link list on top of it. Luckily, the corruption was only that the reader
page was also in the writer path and only presented corrupted data but did
not crash the kernel. But if there were duplicates in the writer side,
then it could corrupt the ring buffer link list and cause a crash.

Create a bitmask array with the size of the number of subbuffers. Then
clear it. When walking through the subbuf array checking to see if the
entries are within the range, test if its bit is already set in the
subbuf_mask. If it is, then there is duplicates and fail the validation.
If not, set the corresponding bit and continue.

Cc: stable@vger.kernel.org
Fixes: c76883f18e59b ("ring-buffer: Add test if range of boot buffer is valid")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

[ Note, I used this patch to fix the corrupted mapped ring buffer. ]

 kernel/trace/ring_buffer.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 07b421115692..0419d41a2060 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1672,7 +1672,8 @@ static void *rb_range_buffer(struct ring_buffer_per_cpu *cpu_buffer, int idx)
  * must be the same.
  */
 static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
-			  struct trace_buffer *buffer, int nr_pages)
+			  struct trace_buffer *buffer, int nr_pages,
+			  unsigned long *subbuf_mask)
 {
 	int subbuf_size = PAGE_SIZE;
 	struct buffer_data_page *subbuf;
@@ -1680,6 +1681,9 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 	unsigned long buffers_end;
 	int i;
 
+	if (!subbuf_mask)
+		return false;
+
 	/* Check the meta magic and meta struct size */
 	if (meta->magic != RING_BUFFER_META_MAGIC ||
 	    meta->struct_size != sizeof(*meta)) {
@@ -1712,6 +1716,8 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 
 	subbuf = rb_subbufs_from_meta(meta);
 
+	bitmap_clear(subbuf_mask, 0, meta->nr_subbufs);
+
 	/* Is the meta buffers and the subbufs themselves have correct data? */
 	for (i = 0; i < meta->nr_subbufs; i++) {
 		if (meta->buffers[i] < 0 ||
@@ -1725,6 +1731,12 @@ static bool rb_meta_valid(struct ring_buffer_meta *meta, int cpu,
 			return false;
 		}
 
+		if (test_bit(meta->buffers[i], subbuf_mask)) {
+			pr_info("Ring buffer boot meta [%d] array has duplicates\n", cpu);
+			return false;
+		}
+
+		set_bit(meta->buffers[i], subbuf_mask);
 		subbuf = (void *)subbuf + subbuf_size;
 	}
 
@@ -1889,17 +1901,22 @@ static void rb_meta_init_text_addr(struct ring_buffer_meta *meta)
 static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 {
 	struct ring_buffer_meta *meta;
+	unsigned long *subbuf_mask;
 	unsigned long delta;
 	void *subbuf;
 	int cpu;
 	int i;
 
+	/* Create a mask to test the subbuf array */
+	subbuf_mask = bitmap_alloc(nr_pages + 1, GFP_KERNEL);
+	/* If subbuf_mask fails to allocate, then rb_meta_valid() will return false */
+
 	for (cpu = 0; cpu < nr_cpu_ids; cpu++) {
 		void *next_meta;
 
 		meta = rb_range_meta(buffer, nr_pages, cpu);
 
-		if (rb_meta_valid(meta, cpu, buffer, nr_pages)) {
+		if (rb_meta_valid(meta, cpu, buffer, nr_pages, subbuf_mask)) {
 			/* Make the mappings match the current address */
 			subbuf = rb_subbufs_from_meta(meta);
 			delta = (unsigned long)subbuf - meta->first_buffer;
@@ -1943,6 +1960,7 @@ static void rb_range_meta_init(struct trace_buffer *buffer, int nr_pages)
 			subbuf += meta->subbuf_size;
 		}
 	}
+	bitmap_free(subbuf_mask);
 }
 
 static void *rbm_start(struct seq_file *m, loff_t *pos)
-- 
2.47.2

