Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F55F1D95A4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991504; cv=none; b=lmqTU2zCLh9nbQoCy+NgW9EttcgfEsp6rnTpXr0xtnaZRSHNdZBD79VNxCIEFeb0/HY/NXelBE5nkxucz8cMT2c093xnE+5a2h+0iOfH2oy42Hrb8pCXe1BbacAxAO3n+KCn3Y8S1TpWTcahWspbbPm2lBinCC+p0Uw0VhEacms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991504; c=relaxed/simple;
	bh=UQvVfDsN+wCSuoGr8Xs5sVe0c88UGdg9Wkzi7gsbGd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u87nAu/TIRrm+1I/HhBhh+/PXOBGyWSfloBP2WpAwsVp2PwLwHxCaA46gHLYT2mOcAD1X9TQVjZfk4Qy9dbQaHd7pwAjF/ESmZHCyatYXAVpo9SFY1xafXb7pyOlKkYjKmTkz6EjQI73UOqR42Ja3cgt3uBBk+woPk33IJyCvwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fdDLk2Wn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fdDLk2Wn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43057f4a16eso45736015e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728991500; x=1729596300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ey51TlE0yC24bR5TT4hURbiSeQAHlXZcKEm5xeeNSWk=;
        b=fdDLk2WnKV19JUqR/ILBJxkfOff1L1zkD2yCYeLCGpM0QB8c/iLnT9tcUMkJFstj6+
         27ClMZ41Jo4eFbhxI9hAJjT4pZs8Q5dXAoehEUyCbkLjAiBBavCLCWU6eb4i87t5kSoE
         apvB26eXdMmdGRsgTSQFr437QpEvjBo40wmWooeArx/4fSLmwwS/Qw7NE5jI27VoAgx0
         lgBVNGB/OIeDySZVJ7RFvurmEKhUimG6ZgY+A0WOWyZW1ttfjaFzEnYp2WDxv0bg+KG5
         KCI4CR7DvpyxNs6Va7uK4ii4jjAGIp0kgQYR9CCpDy5z7TFzkAlUZHOzljDFCozJxBhD
         XikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728991500; x=1729596300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ey51TlE0yC24bR5TT4hURbiSeQAHlXZcKEm5xeeNSWk=;
        b=fzE3r7sbMKaYOyFCS0JAjE3vFCRXWy+hXl63hYqHo62JWQsjgQVASv7MZ8KQKO5zvO
         GdbElF/WWnXTAAQA1c6U5d+RqzHzdTeDoXZx7oqTXdNbvWuoKvCmyL2BkrNbU5dkIf0e
         KGIic5INzVNR9a522dPnCMBZMkIVaq684I2JSUXrOqSw2nx/3RtphuG6DD//ao6xPwpr
         U9uMJqmsNAiyuLDLO3nDQk+Pv6qOFvgu6JzIYuxV4n8hrxCFCFCkmzX53NUa2EOTqPIK
         7h+GDrPcjEUYTg/BFpdyu4pn81JxWnFtYW5QTMNDGe+jEamrB7ntqDYGGla4vu0+zvgA
         COXA==
X-Gm-Message-State: AOJu0Yxuqx5VOzbA6+iLbKNbNCFqfFqXc0OzBrcxyaYeZ54eEeE1ZKGw
	/wgeqz6DqSRpvkpJP/twc4N911+o5taMBapJqDkf30LNPLpPtLgRx+2E9vPyM3w=
X-Google-Smtp-Source: AGHT+IGsA1lW0y1Xr625xyDZAXLEPxBdzu+Udz8r/9WbzxVdp1+43c5DolKE7kHXPHKVGsLDJA71Kw==
X-Received: by 2002:a05:600c:5122:b0:42f:8d36:855e with SMTP id 5b1f17b1804b1-4311deb5f47mr148180455e9.5.1728991500482;
        Tue, 15 Oct 2024 04:25:00 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c767csm14952715e9.48.2024.10.15.04.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 04:25:00 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2] ring-buffer: Fix reader locking when changing the sub buffer order
Date: Tue, 15 Oct 2024 13:24:29 +0200
Message-ID: <20241015112440.26987-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ring_buffer_subbuf_order_set() updates each
ring_buffer_per_cpu and installs new sub buffers that match the requested
page order. This operation may be invoked concurrently with readers that
rely on some of the modified data, such as the head bit (RB_PAGE_HEAD), or
the ring_buffer_per_cpu.pages and reader_page pointers. However, no
exclusive access is acquired by ring_buffer_subbuf_order_set(). Modifying
the mentioned data while a reader also operates on them can then result in
incorrect memory access and various crashes.

Fix the problem by taking the reader_lock when updating a specific
ring_buffer_per_cpu in ring_buffer_subbuf_order_set().

Link: https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/
Link: https://lore.kernel.org/linux-trace-kernel/20241010195849.2f77cc3f@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20241011112850.17212b25@gandalf.local.home/
Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

Changes since v1 [1]:
* Base the patch on top of clean mainline.
* Add references as Link: in the commit message.

[1] https://lore.kernel.org/linux-trace-kernel/20241014141554.10484-1-petr.pavlu@suse.com/

 kernel/trace/ring_buffer.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index fb04445f92c3..3ea4f7bb1837 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6728,39 +6728,38 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	}
 
 	for_each_buffer_cpu(buffer, cpu) {
+		struct buffer_data_page *old_free_data_page;
+		struct list_head old_pages;
+		unsigned long flags;
 
 		if (!cpumask_test_cpu(cpu, buffer->cpumask))
 			continue;
 
 		cpu_buffer = buffer->buffers[cpu];
 
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+
 		/* Clear the head bit to make the link list normal to read */
 		rb_head_page_deactivate(cpu_buffer);
 
-		/* Now walk the list and free all the old sub buffers */
-		list_for_each_entry_safe(bpage, tmp, cpu_buffer->pages, list) {
-			list_del_init(&bpage->list);
-			free_buffer_page(bpage);
-		}
-		/* The above loop stopped an the last page needing to be freed */
-		bpage = list_entry(cpu_buffer->pages, struct buffer_page, list);
-		free_buffer_page(bpage);
-
-		/* Free the current reader page */
-		free_buffer_page(cpu_buffer->reader_page);
+		/*
+		 * Collect buffers from the cpu_buffer pages list and the
+		 * reader_page on old_pages, so they can be freed later when not
+		 * under a spinlock. The pages list is a linked list with no
+		 * head, adding old_pages turns it into a regular list with
+		 * old_pages being the head.
+		 */
+		list_add(&old_pages, cpu_buffer->pages);
+		list_add(&cpu_buffer->reader_page->list, &old_pages);
 
 		/* One page was allocated for the reader page */
 		cpu_buffer->reader_page = list_entry(cpu_buffer->new_pages.next,
 						     struct buffer_page, list);
 		list_del_init(&cpu_buffer->reader_page->list);
 
-		/* The cpu_buffer pages are a link list with no head */
+		/* Install the new pages, remove the head from the list */
 		cpu_buffer->pages = cpu_buffer->new_pages.next;
-		cpu_buffer->new_pages.next->prev = cpu_buffer->new_pages.prev;
-		cpu_buffer->new_pages.prev->next = cpu_buffer->new_pages.next;
-
-		/* Clear the new_pages list */
-		INIT_LIST_HEAD(&cpu_buffer->new_pages);
+		list_del_init(&cpu_buffer->new_pages);
 
 		cpu_buffer->head_page
 			= list_entry(cpu_buffer->pages, struct buffer_page, list);
@@ -6769,11 +6768,20 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
-		free_pages((unsigned long)cpu_buffer->free_page, old_order);
+		old_free_data_page = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
 
 		rb_head_page_activate(cpu_buffer);
 
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+
+		/* Free old sub buffers */
+		list_for_each_entry_safe(bpage, tmp, &old_pages, list) {
+			list_del_init(&bpage->list);
+			free_buffer_page(bpage);
+		}
+		free_pages((unsigned long)old_free_data_page, old_order);
+
 		rb_check_pages(cpu_buffer);
 	}
 

base-commit: eca631b8fe808748d7585059c4307005ca5c5820
-- 
2.43.0

