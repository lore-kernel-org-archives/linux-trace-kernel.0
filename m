Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E2BA31;
	Wed, 12 Jun 2024 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718158625; cv=none; b=iRylk801XsdBH9naxt/E7aODseyC/e/EXqG+qMtmWf9rXfxWXdtKE2ccfjOf24kxisGCVvU2RYBpoCkyK1aF0oo+jSeP7K18KBBvaI/teCtxwwmlxMjTiW2g20kcYOtclZ9Q3fdKiUxIpJwD+wBQiXhXz8CuX3JRgvPqzZHkAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718158625; c=relaxed/simple;
	bh=BlgxlSswpRp4zqn1ekEJQm27vUkwbaQkvQ0gF+mbzUo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LorYQGwzGhsehyPQPvlywLUjEVDrR2lQgiFqIjD3FJX7sU6iBVevAe4pZeP0X+cPibyDS8yXmTDZYbkW2SzWxLU/bku0uJxMx/LjuWiKAlLkAq8eAs4IJUpus2eHmOPAC8BtvSopVA9C5Ti/YPmDn8c+RQ7Z48Aahm6WWoGWZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5155AC32789;
	Wed, 12 Jun 2024 02:17:05 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sHDYA-00000001XJG-1bwt;
	Tue, 11 Jun 2024 22:17:22 -0400
Message-ID: <20240612021722.239841009@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 11 Jun 2024 22:16:43 -0400
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
Subject: [PATCH v5 01/13] ring-buffer: Allow mapped field to be set without mapping
References: <20240612021642.941740855@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

In preparation for having the ring buffer mapped to a dedicated location,
which will have the same restrictions as user space memory mapped buffers,
allow it to use the "mapped" field of the ring_buffer_per_cpu structure
without having the user space meta page mapping.

When this starts using the mapped field, it will need to handle adding a
user space mapping (and removing it) from a ring buffer that is using a
dedicated memory range.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..aa8eb878e0d4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -491,6 +491,7 @@ struct ring_buffer_per_cpu {
 	unsigned long			pages_removed;
 
 	unsigned int			mapped;
+	unsigned int			user_mapped;	/* first user space mapping */
 	struct mutex			mapping_lock;
 	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
@@ -5224,6 +5225,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 
+	if (!meta)
+		return;
+
 	meta->reader.read = cpu_buffer->reader_page->read;
 	meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
@@ -6167,7 +6171,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
 		mutex_unlock(&cpu_buffer->mapping_lock);
 		return ERR_PTR(-ENODEV);
 	}
@@ -6194,7 +6198,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 	if (inc && cpu_buffer->mapped == UINT_MAX)
 		return -EBUSY;
 
-	if (WARN_ON(!inc && cpu_buffer->mapped == 0))
+	if (WARN_ON(!inc && cpu_buffer->mapped < cpu_buffer->user_mapped))
 		return -EINVAL;
 
 	mutex_lock(&cpu_buffer->buffer->mutex);
@@ -6328,7 +6332,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (cpu_buffer->mapped) {
+	if (cpu_buffer->user_mapped) {
 		err = __rb_map_vma(cpu_buffer, vma);
 		if (!err)
 			err = __rb_inc_dec_mapped(cpu_buffer, true);
@@ -6359,12 +6363,15 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	 */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	err = __rb_map_vma(cpu_buffer, vma);
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-		cpu_buffer->mapped = 1;
+		/* This is the first time it is mapped externally */
+		cpu_buffer->mapped++;
+		cpu_buffer->user_mapped = cpu_buffer->mapped;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
 		kfree(cpu_buffer->subbuf_ids);
@@ -6392,10 +6399,10 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->user_mapped) {
 		err = -ENODEV;
 		goto out;
-	} else if (cpu_buffer->mapped > 1) {
+	} else if (cpu_buffer->mapped > cpu_buffer->user_mapped) {
 		__rb_inc_dec_mapped(cpu_buffer, false);
 		goto out;
 	}
@@ -6403,7 +6410,10 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	mutex_lock(&buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	cpu_buffer->mapped = 0;
+	/* This is the last user space mapping */
+	if (!WARN_ON_ONCE(cpu_buffer->mapped != cpu_buffer->user_mapped))
+		cpu_buffer->mapped--;
+	cpu_buffer->user_mapped = 0;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-- 
2.43.0


