Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794212580;
	b=mJsexS+SE2yihEgO1p68xDfrAjFnKWpX6UZxnCoAxw3x5MXlI4NNqi3zVXroU36/uLiE
	 gTDblghnSNwWqDoDunre960mh6LZdXkTCodaCBRD1MdlEEkPfgLSdiMfbpiYtwOsGWB9U
	 98qmXDZR53IDdcZHI6ROhezmMAoQnCJ+wPPXv6V4ojBTCkr28g2zC6S/EjfdO1Oe7M7Bu
	 8B3y86kWN/diuKOBvccOcRSATFtwVDjA5uIQaT92yOmYc/etI5iLX2r8S3KgXJQNZUZ0c
	 B9Yj4rZj72R2S+0Ic4gmuQom+xUbcRwz6UJZJfvGPmgIkbPp0nCmmG/dcY9/6unGmIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794212580;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Stat-Signature:X-Rspamd-Server:X-Rspamd-Queue-Id:X-Spam-Status:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=lxQRjwNzhgUme2zk4vouWgD/lFV/r7F9Q/0FYQ7yZG0=;
	b=w8gUwtruCwCnYrmbJS8c8BC+I6uWhyo2Vap7qyn0BgvPyJlmj+kuZmgu6FApIeP5RGhb
	 NSC4dVMfs7QUllGW7W+2Nohhg/rV9Tr+I9ppK4qmj6RmhKWBX4k2J9lqOK8fD3hzowslt
	 13P8xtmKp9Wb8bQDkVl+EY+wOGpsb1PJBSa/SU/rLhcxjWVe6MGpxOZfA45QL+NiTIKAr
	 ZtIRrt1IlMVJ10QjByczTU9nyGLACot9Y5x7SyqpGqDNXI7m3PUkLvGy/xSZWFylDdwXJ
	 qiL45n8Tl/MpUDng5eMQ15r5ovY9YfZn+uK5fORIET2ty5E5oarCYSyIMgJ2FjHdaUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=T5hrrgaF;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B2606A332;
	Mon,  9 Nov 2026 08:22:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F2B2606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=T5hrrgaF
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 302E4A820C;
	Mon,  9 Nov 2026 08:22:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 098D720010;
	Mon,  9 Nov 2026 08:22:48 +0000 (UTC)
Date: Mon, 9 Nov 2026 03:22:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort
 <vdonnefort@google.com>, Breno Leitao <leitao@debian.org>
Subject: [PATCH] ring-buffer: Do not allow reader to see unfinished moved
 head
Message-ID: <20261109032241.55e57d26@fedora>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: g8sr9p9x95fog3j7gzhuarq1zop4dru3
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 098D720010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/prPkD/Pipo7SBos5JqDxCjTyrb1Zb2Yg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=lxQRjwNzhgUme2zk4vouWgD/lFV/r7F9Q/0FYQ7yZG0=; b=T5hrrgaFApZvA5ajhhzY4Vvt9dJ4jRhFM8hD5Ve820WV5QISwd1D/8/3BrLDM+m2CGlldEqLz9ueArkKdWPdaNoGzMf4WO7QCvrVKSi2pfQ/PdEpZYslo3B5tebbtUS2tsHoIMXs4zQSs/HiVJ9O07tT9H37Q9E3thgu5s+D7hg=
X-HE-Tag: 1794212568-571396
X-HE-Meta: U2FsdGVkX19XV+9IhCqE0Odk1TRWUwda1u8Z14ntUtuRw+ijoRvdOUwWKcoEocIwaAsOnG7cqzWrpv9o8YQbFrnV+anIu/R12sXvH5LwqTv+9S6D2H0tFMmGsqx6YK3eYiC+hxHhdq9ceV3STFAyQO3I0wj8qLZOF8/GxOcU2uy0KVNwIGxlKCsDlXs0eHIA28djMqMnxj17HYYeM21Y0rQQfriD5YWCty8n9by5RbDizq62oiDul01qcU7LedesZ4i1AXxMwNDnH7+h8MOwZoumQN94/57pnFFSkRmEuYY0R+zwFwl6ESn92eQJYkX4IEjOBnmzSu5xyzdT7p7hW/eMl9A7olenyUkOQngefOrHzrbEeaA9HBdYDRxEKaFtmkNa2EKjdghVIY1Hwkjp3AreWysqrKzU9LhXU53rgKq25Acdg0TciJdzu8S90Fy1LKPaOX70CQE=

From: Steven Rostedt <rostedt@goodmis.org>

The reader of the ring buffer swaps out a blank sub-buffer with the "head"
of the writable ring buffer so that it has sole access to the sub-buffer
and doesn't race with new writes. To do this, when the writer fills the
ring buffer and needs to overwrite the oldest sub-buffer, it has to mvoe
the HEAD of the buffer that the reader will take next.

While it is moving the head, the reader is prevented from doing the swap.
This is accomplished by the writer changing the HEAD flag of the head page
with the UPDATE flag. It then sets the next sub-buffer to have HEAD flag
set as well.

The cpu_buffer->head_page points to the last place the reader saw the head
page. When it needs to acquire a new page from the ring buffer, it will
start at the cpu_buffer->head_page and search for the sub-buffer with
either the HEAD or UPDATE flag set. It will only do a swap if the
sub-buffer has the HEAD flag set, otherwise it waits for the UPDATE flag
to clear to find the new head page. The problem is that this
cpu_buffer->head_page can be stale, and if an interrupt happens while an
event is being written, and the interrupt writes a lot of events, it can
move the head page several sub-buffers from the original head page. If the
cpu_buffer->head_page ended up between the original head page that has the
UPDATE flag set and the new head page with the HEAD flag set, it can allow
the reader to see the new head page and swap that one out while a commit
is still in progress. This can corrupt the ring buffer.

Have the writer update the cpu_buffer->head_page to keep it pointing to
the old head page before it does the update to make sure that the reader
will always start its search outside the UPDATE and new HEAD sub-buffers.

Cc: stable@vger.kernel.org
Fixes: 77ae365eca89 ("ring-buffer: make lockless")
Closes: https://lore.kernel.org/all/20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org/
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c64e001c3fc0..0d37f8b529d5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1494,7 +1494,13 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_buffer)
 	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) != list))
 		return NULL;
 
-	page = head = cpu_buffer->head_page;
+	/*
+	 * Make sure that the start of the search of the head_page does not
+	 * start between the writer adding the UPDATE and the new HEAD that it
+	 * moves forward.
+	 */
+	/* Sync with the writer moving the HEAD in rb_handle_head_page() */
+	page = head = smp_load_acquire(&cpu_buffer->head_page);
 	/*
 	 * It is possible that the writer moves the header behind
 	 * where we started, and we miss in one loop.
@@ -3721,6 +3727,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
+		/*
+		 * To prevent a stale head_page from being between
+		 * the UPDATE and new HEAD pages, set it here to have
+		 * the reader check always find the update before
+		 * finding the HEAD page.
+		 */
+		/* Sync with the reader setting the head page */
+		smp_store_release(&cpu_buffer->head_page, next_page);
+
 		if (cpu_buffer->ring_meta)
 			rb_update_meta_head(cpu_buffer, next_page);
 		/*
-- 
2.53.0

