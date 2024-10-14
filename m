Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CB1AAC4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728915381; cv=none; b=dXMFMJErno/k0DzevCl7zc4Zb3GWsXfMLYYoiDOO+IoQZLMOHTR5lQLf/3OQQdF2l21bH1CP+sCE6tcntZJ7LqArmW3TkbQMlgS4isdJrWZN17HrgzajJNeYUN+upQSV4jCaFrp0xh4keD1QfYQnNrWeK/dbgWIp23Sc1vnIOqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728915381; c=relaxed/simple;
	bh=+3JoPyfViDOSYGIGmaDGQ5GejIpMVlgVxF1zysFNY2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aag3wQ5F+qyIDk/Sr6jgPtQn40ljfnYJ+3roBOr11quzUuk+DasqyOhkQdAP9l1WZIUrg+e36iWIUX927SnfkmQaNGL4qeLbsckqMB0HJY/JZSG+P8A/bOsMGrwS8y8wPRdERyTc41D9/G4jiIwIfPO+yqrtNz95BKlnw4ckZ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WrqWDkmy; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WrqWDkmy"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539f4d8ef84so1343702e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728915377; x=1729520177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FS5y6tjwukPP7nUod0+Z8GD04hhTWg7qrJ6MFmiMFQM=;
        b=WrqWDkmyfNwqYQ/OEnzatpvVygtFF3q7RUpR351ZB4cFpPy83MgeUkO2WnQPydv7Yy
         IOkkVyz+0rshhOqAKQbOMDPBc5c1KdapjGSI9msGmpyxJ11RB2yEmEvJlYTp3v8qLkZ9
         W9jOHgQrMICpc/ogUNKbaRC7t5bqITlqw1y6YZdJY/UCSNxBPDyYPpEz0UUYGoWeuJC1
         ZWfGFI9DT9BbILnEo6hNTyA7PBlq6RopFySMJ5eGl5BjkbzF1YIdROGUMIvF6E0sDUUJ
         DsbNRQW2SSHmTNH/rWKNm84lW9x6404Kaz8DlBCZ5USrxa/3qRwXdzDlvOwBkU/YeopB
         K7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728915377; x=1729520177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FS5y6tjwukPP7nUod0+Z8GD04hhTWg7qrJ6MFmiMFQM=;
        b=wIH3iYUGlJAa/8kg+SUiuYw9/yagsS5u2uyqJs8NKoBNym9rnzXLFVp2EeK1NwDWqx
         /ylcOZNXQqgu7vGgoDtPf4FZKDDnVYC0wtlH62249B1YM3ZS9muVG7Evjmu1vw4wWO0I
         pxdFleWJnbePxYdKx1zKf1K6vyckqMgqdjtTAcUYsQ8v/G+iAfnk/hhKG+PV+8+5ogVm
         KR6A35auLZPd47BiiKi93qd93VoMdyMlqJ437psEEqFCZUQ2LtwT4q8D3P8hAmrcCaZ6
         cgkHymQJv17UIcAh2VLbnh3WMVHHyRBnDMTPRLjLZfoVNKRr6aV2K3ch4oD3EDuL+rrQ
         Gljw==
X-Gm-Message-State: AOJu0Yx6R1M/w7NGS8D0sj/ywIYS2bzahYgbJuDmV+TcFI06JIthFsme
	HxgBXob5BIlutz+80E46oL/WM47L1uaLseOyj0Dk84EHOC+GOGoQFTBwy5GfJJrIqmb1Fbd8YdN
	U
X-Google-Smtp-Source: AGHT+IH+x6gckUKGQPodmKlRhU6+eUFT5W7nAxkPdJHXwHqYmJ+m5hPXdXqYMM6344OIvumOQrL8eg==
X-Received: by 2002:a05:6512:2207:b0:539:f748:b568 with SMTP id 2adb3069b0e04-539f748b8f0mr1708206e87.32.1728915377153;
        Mon, 14 Oct 2024 07:16:17 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf22d46sm154251805e9.10.2024.10.14.07.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 07:16:16 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] ring-buffer: Fix reader locking when changing the sub buffer order
Date: Mon, 14 Oct 2024 16:14:16 +0200
Message-ID: <20241014141554.10484-1-petr.pavlu@suse.com>
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

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
References:
https://lore.kernel.org/linux-trace-kernel/20240715145141.5528-1-petr.pavlu@suse.com/
https://lore.kernel.org/linux-trace-kernel/20241010195849.2f77cc3f@gandalf.local.home/
https://lore.kernel.org/linux-trace-kernel/20241011112850.17212b25@gandalf.local.home/

 kernel/trace/ring_buffer.c | 44 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4c24191fa47d..adde95400ab4 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6773,41 +6773,40 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
+		list_del_init(&cpu_buffer->new_pages);
 		cpu_buffer->cnt++;
 
-		/* Clear the new_pages list */
-		INIT_LIST_HEAD(&cpu_buffer->new_pages);
-
 		cpu_buffer->head_page
 			= list_entry(cpu_buffer->pages, struct buffer_page, list);
 		cpu_buffer->tail_page = cpu_buffer->commit_page = cpu_buffer->head_page;
@@ -6815,11 +6814,20 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
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
 

base-commit: 6485cf5ea253d40d507cd71253c9568c5470cd27
prerequisite-patch-id: 0aa81c18abaac4990d14c431e12b9e91696aa053
-- 
2.43.0

