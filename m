Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA958119;
	Fri, 17 May 2024 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953231; cv=none; b=c2omvD34by8YvZUZhWDGOigUzMIAr1ll92DIjtcWlpF3XxjMrNBNMdL9QEzjrs1nSZ8gXHgFXYSKaZuA3b90daYZYwgL0gDjBL6VqbMtTEL1OX/KXV+zWo7uxbyABk6mfw+UBmIFWPux9mXR6pWFQch9l0eHl0DqcQ7l3JyBQBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953231; c=relaxed/simple;
	bh=wW1xeCQUaIL1k7wdoM5lDS80AEp5iYokHaGcbM0sEDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbymVh4r/4b3lvkg1juRzLKFOCEGa9c4+Z26NDzm6bYxSwQWrI+U9MhrHs5WOArNKzJEI3GhX6OHL7wrXZ82JQInirxcWjqGmU5tqsRfHtF4Jz/NSNbizC0DqCkDMOCZsg/d/Rn7TFuUoVn+ekT70x64wt9BuXUuIMwqC2L+RU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6B48A374EB;
	Fri, 17 May 2024 13:40:28 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51F8713A69;
	Fri, 17 May 2024 13:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4K3bE0xeR2Z/BQAAD6G6ig
	(envelope-from <petr.pavlu@suse.com>); Fri, 17 May 2024 13:40:28 +0000
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/2] ring-buffer: Correct stale comments related to non-consuming readers
Date: Fri, 17 May 2024 15:40:07 +0200
Message-Id: <20240517134008.24529-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240517134008.24529-1-petr.pavlu@suse.com>
References: <20240517134008.24529-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6B48A374EB

Adjust the following code documentation:

* Kernel-doc comments for ring_buffer_read_prepare() and
  ring_buffer_read_finish() mention that recording to the ring buffer is
  disabled when the read is active. Remove mention of this restriction
  because it was already lifted in commit 1039221cc278 ("ring-buffer: Do
  not disable recording when there is an iterator").

* Function ring_buffer_read_finish() performs a self-check of the
  ring-buffer by locking cpu_buffer->reader_lock and then calling
  rb_check_pages(). The preceding comment explains that the lock is
  needed because rb_check_pages() clears the HEAD flag required by
  readers which might be running in parallel. Remove this explanation
  because commit 8843e06f67b1 ("ring-buffer: Handle race between
  rb_move_tail and rb_check_pages") simplified the function so it no
  longer resets the mentioned flag. Nonetheless, the lock is still
  needed because a reader swapping a page into the ring buffer can make
  the underlying doubly-linked list temporarily inconsistent.

This is a non-functional change.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/ring_buffer.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6511dc3a00da..0ae569eae55a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5036,13 +5036,9 @@ EXPORT_SYMBOL_GPL(ring_buffer_consume);
  * @flags: gfp flags to use for memory allocation
  *
  * This performs the initial preparations necessary to iterate
- * through the buffer.  Memory is allocated, buffer recording
+ * through the buffer.  Memory is allocated, buffer resizing
  * is disabled, and the iterator pointer is returned to the caller.
  *
- * Disabling buffer recording prevents the reading from being
- * corrupted. This is not a consuming read, so a producer is not
- * expected.
- *
  * After a sequence of ring_buffer_read_prepare calls, the user is
  * expected to make at least one call to ring_buffer_read_prepare_sync.
  * Afterwards, ring_buffer_read_start is invoked to get things going
@@ -5129,8 +5125,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_read_start);
  * ring_buffer_read_finish - finish reading the iterator of the buffer
  * @iter: The iterator retrieved by ring_buffer_start
  *
- * This re-enables the recording to the buffer, and frees the
- * iterator.
+ * This re-enables resizing of the buffer, and frees the iterator.
  */
 void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
@@ -5138,12 +5133,7 @@ ring_buffer_read_finish(struct ring_buffer_iter *iter)
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
 	unsigned long flags;
 
-	/*
-	 * Ring buffer is disabled from recording, here's a good place
-	 * to check the integrity of the ring buffer.
-	 * Must prevent readers from trying to read, as the check
-	 * clears the HEAD page and readers require it.
-	 */
+	/* Use this opportunity to check the integrity of the ring buffer. */
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_check_pages(cpu_buffer);
 	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
-- 
2.35.3

