Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678234C622;
	Thu,  6 Jun 2024 21:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708891; cv=none; b=RU+K9jxoks66U9xpFi5L9zgqzZl1P43Sk09R4kOVoCeJoBM5PbB+dvmSSGmkonH52EKY7BA98qc2FmjnyhdnjDIi8B4ddWqEWf8tjAruiaoi8jhw14jGHQiH1JOUXgmoUcOWsNXuGSgp7gs44LpZpkUv+oSwBsPLSfWBRj1FpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708891; c=relaxed/simple;
	bh=0lLeJ9L6obuUbihPoov7/e8fbffmXhCAKt5nfOzmqgM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=O7PdobTqYRp14iLc8kMNYh2irDlyJL3ONRdNf6KOkeQ24BqwgrqMweFFnGwh8MSRRlpdVCDIgxA+IspJxX4uDzY4Go+UnDbUbLEHbvKXjStKVHyGHdBsx83hhp2p8X5rZ7qHVdOmp0Z4hK1kUgAd3Pky8TZ++yxXpXjHlpSuY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F7AC3277B;
	Thu,  6 Jun 2024 21:21:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1sFKYC-00000000qHm-1Tg3;
	Thu, 06 Jun 2024 17:21:36 -0400
Message-ID: <20240606212136.207093084@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 06 Jun 2024 17:17:36 -0400
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
Subject: [PATCH v3 01/13] ring-buffer: Allow mapped field to be set without mapping
References: <20240606211735.684785459@goodmis.org>
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
 kernel/trace/ring_buffer.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..78beaccf9c8c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5224,6 +5224,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 
+	if (!meta)
+		return;
+
 	meta->reader.read = cpu_buffer->reader_page->read;
 	meta->reader.id = cpu_buffer->reader_page->id;
 	meta->reader.lost_events = cpu_buffer->lost_events;
@@ -6167,7 +6170,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
 
 	mutex_lock(&cpu_buffer->mapping_lock);
 
-	if (!cpu_buffer->mapped) {
+	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
 		mutex_unlock(&cpu_buffer->mapping_lock);
 		return ERR_PTR(-ENODEV);
 	}
@@ -6359,12 +6362,13 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	 */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
+
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	err = __rb_map_vma(cpu_buffer, vma);
 	if (!err) {
 		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
-		cpu_buffer->mapped = 1;
+		cpu_buffer->mapped++;
 		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	} else {
 		kfree(cpu_buffer->subbuf_ids);
@@ -6403,7 +6407,8 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	mutex_lock(&buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-	cpu_buffer->mapped = 0;
+	WARN_ON_ONCE(!cpu_buffer->mapped);
+	cpu_buffer->mapped--;
 
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-- 
2.43.0


