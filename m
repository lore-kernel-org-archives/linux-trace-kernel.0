Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84345D8F0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718982641; cv=none; b=WgbsqFXek/HzbDry5QImn13g3NPLlk6wpVH0sWbwSXRFdAFQBJ6rshbtk5U3jHWwsMRWmkUS2cm0gNvFtZq2JGWqYZEvLfRtzCFv01Mhix3Uk1IGaN8r7NJTzM0MK8DjBG+oUMZAMG9SgWwyrJMrnIrzFEZ/Rz4lICO2Eq82iIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718982641; c=relaxed/simple;
	bh=n0yyI0xH+rKGRk6Y1c5yjFbmbpAnKs8Ed5uaTz9f4vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OKkzvXXBHPDeoGZdGoSIiWre0BQCteK3tDlUtkMRidTcFhFUUTTvuAEzgP9ff0W/EclMygB878YXu0vInACztUOk0/vJn38ShDU8UZj6WsAV8vb7Drqq0pMPvuCS/IPxI8dHAZOPy6DDpbBQ4GVG67o2ZO/R3XyYgxxpK/XQiX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g5UdkIHj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g5UdkIHj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217990f8baso20050985e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718982637; x=1719587437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trIhIa1l4EBBRllL40pfGpy0O1mYOGrhroFn2a/S/KM=;
        b=g5UdkIHjpP/NBwmE3o3D+rZaUXj93n18Y3VE6acnuP/+pWIaiTmJHZM/zD4e0JutHg
         Xr+9Da/2vLlw+A8lwKZqtKoip8lFaBXsQyCy4xvCL9MwKxHHIkL349qPc2HGAd4tCRam
         XpS4whxT70gAKiMYG7TYQfMCJw+j+4ba9UnKjl894uNtkB6FyfcMOMMyv+Ogokp8KXyq
         VXFz0VC1dwS+srrGE6I13KaUP4alpMeGAqyVSxNGoxg9/a6fTIEL+Mg6+LtPrrob6FFv
         S7qLOkx0iWZlj89VkRZbUyFluu3iDy3UYJn0zKCygig1iSRP5s1H2/FetXfaDKC5TbXM
         UVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718982637; x=1719587437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trIhIa1l4EBBRllL40pfGpy0O1mYOGrhroFn2a/S/KM=;
        b=O+KbTbgLA+A7QUZrmGHlI3xiJNmnAnuKjhx4/G7qLfYU1IfeOC3aZfZRhHNHaeie4t
         6OXMLgEr3Bh+RlKKBJKA02HPxdhmVA3ApHSWG5ei70hNnxA+amFxxfYXsgMFFubId8C1
         KppEJdmiha4Vq1qHBtwCvs+7v1CeBH0FerRrJSIR7CdHaXsGQ6WiH2u3/9slKiU/jf6X
         pYgtO+C+Gc4g6C5HCvYmbiFX87NgCozWJzrhparIFWTMFEp4Zoh11KChvceAPbYTfu+5
         /skXoKmrB8g61c7Qm51omwqv04WOYhRXCkUUamc1qWcHg9yHj1+4y7HXlslsjXOhvsPo
         woKg==
X-Forwarded-Encrypted: i=1; AJvYcCX1VLnrQaR4q3Bf5eh2c2lMYDkb3JxiDV2H67qCMHM+eE5i7yH5fdcFZoZ4dVSt5jnE+zii0VZGhD4lfIU3L/PdL6TNnoSG0RuyyFJ7rQGg5vfA
X-Gm-Message-State: AOJu0YzeGv+TaHIYMrapAWV6l4Zl47UMtlJokIt4r3b/4mo4idOdJaNf
	+eNjuia0BDGMPkpoU7ouvhMWkOdQsvSsdHjTSveXKN07W67TGVyue02Qwh+pZM0=
X-Google-Smtp-Source: AGHT+IHUyyUovuNkrF+EtFY2o30UqjW6jIrtwAnY2fSUhe2U+cdejyi+YDTKkpYYmzkD2F8lYHSmuQ==
X-Received: by 2002:a05:600c:b49:b0:421:7b3d:1fdb with SMTP id 5b1f17b1804b1-42475184608mr61381225e9.21.1718982637156;
        Fri, 21 Jun 2024 08:10:37 -0700 (PDT)
Received: from dhcp161.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b63b5sm68430065e9.7.2024.06.21.08.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 08:10:36 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] ring-buffer: Limit time with disabled interrupts in rb_check_pages()
Date: Fri, 21 Jun 2024 17:09:56 +0200
Message-Id: <20240621150956.24814-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Function rb_check_pages() validates the integrity of a specified per-CPU
tracing ring buffer. It does so by walking the underlying linked
list and checking its next and prev links.

To guarantee that the list doesn't get modified during the check,
a caller typically needs to take cpu_buffer->reader_lock. This prevents
the check from running concurrently with a potential reader which can
make the list temporarily inconsistent when swapping its old reader page
into the buffer.

A problem is that the time when interrupts are disabled is
non-deterministic, dependent on the ring buffer size. This particularly
affects PREEMPT_RT because the reader_lock is a raw spinlock which
doesn't become sleepable on PREEMPT_RT kernels.

Modify the check so it still tries to walk the whole list but gives up
the reader_lock between checking individual pages.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

This is a follow-up to the discussion in
https://lore.kernel.org/linux-trace-kernel/20240517134008.24529-1-petr.pavlu@suse.com/

 kernel/trace/ring_buffer.c | 96 +++++++++++++++++++++++++++-----------
 1 file changed, 70 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..3aefaf8a4d58 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1454,40 +1454,91 @@ static void rb_check_bpage(struct ring_buffer_per_cpu *cpu_buffer,
 	RB_WARN_ON(cpu_buffer, val & RB_FLAG_MASK);
 }
 
+static bool rb_check_links(struct ring_buffer_per_cpu *cpu_buffer,
+			   struct list_head *list)
+{
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->next)->prev) != list))
+		return false;
+
+	if (RB_WARN_ON(cpu_buffer,
+		       rb_list_head(rb_list_head(list->prev)->next) != list))
+		return false;
+
+	return true;
+}
+
 /**
  * rb_check_pages - integrity check of buffer pages
  * @cpu_buffer: CPU buffer with pages to test
  *
  * As a safety measure we check to make sure the data pages have not
  * been corrupted.
- *
- * Callers of this function need to guarantee that the list of pages doesn't get
- * modified during the check. In particular, if it's possible that the function
- * is invoked with concurrent readers which can swap in a new reader page then
- * the caller should take cpu_buffer->reader_lock.
  */
 static void rb_check_pages(struct ring_buffer_per_cpu *cpu_buffer)
 {
-	struct list_head *head = rb_list_head(cpu_buffer->pages);
-	struct list_head *tmp;
+	struct list_head *head, *tmp;
+	unsigned long flags;
+	size_t pages_read;
+	int nr_loops = 0;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->next)->prev) != head))
+	/*
+	 * Walk the linked list underpinning the ring buffer and validate all
+	 * its next and prev links.
+	 *
+	 * The check acquires the reader_lock in order to avoid concurrent
+	 * processing with a potential reader which can make the list
+	 * temporarily inconsistent when swapping its old reader page into the
+	 * buffer and obtaining a new page. However, the lock cannot be held for
+	 * the whole duration of the walk, as this would make the time when
+	 * interrupts are disabled non-deterministic, dependent on the ring
+	 * buffer size. Therefore, the code releases and re-acquires the lock
+	 * after checking each page. The pages_read variable is then used to
+	 * detect if a reader changed the list while the lock was not held, in
+	 * which case the check needs to be restarted.
+	 *
+	 * The code attempts to perform the check at most three times before
+	 * giving up. That itself is ok because this is only a self-validation
+	 * to detect problems early on. In practice, if it even happens that
+	 * this code runs concurrently with a reader getting a new page from the
+	 * buffer, it should take the reader a bit to process the obtained page
+	 * before coming back for more data and so this check typically succeeds
+	 * at most on the second try.
+	 */
+again:
+	if (++nr_loops > 3)
 		return;
 
-	if (RB_WARN_ON(cpu_buffer,
-			rb_list_head(rb_list_head(head->prev)->next) != head))
-		return;
+	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
+	head = rb_list_head(cpu_buffer->pages);
+	if (!rb_check_links(cpu_buffer, head))
+		goto out_locked;
+	pages_read = local_read(&cpu_buffer->pages_read);
+	tmp = head;
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
-	for (tmp = rb_list_head(head->next); tmp != head; tmp = rb_list_head(tmp->next)) {
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->next)->prev) != tmp))
-			return;
+	while (true) {
+		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
-		if (RB_WARN_ON(cpu_buffer,
-				rb_list_head(rb_list_head(tmp->prev)->next) != tmp))
-			return;
+		if (pages_read != local_read(&cpu_buffer->pages_read)) {
+			/* A reader updated the list, try again. */
+			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
+			goto again;
+		}
+
+		tmp = rb_list_head(tmp->next);
+		if (tmp == head)
+			/* The iteration circled back, all is done. */
+			goto out_locked;
+
+		if (!rb_check_links(cpu_buffer, tmp))
+			goto out_locked;
+
+		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 	}
+
+out_locked:
+	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 }
 
 static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
@@ -2215,12 +2266,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 		 */
 		synchronize_rcu();
 		for_each_buffer_cpu(buffer, cpu) {
-			unsigned long flags;
-
 			cpu_buffer = buffer->buffers[cpu];
-			raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 			rb_check_pages(cpu_buffer);
-			raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 		}
 		atomic_dec(&buffer->record_disabled);
 	}
@@ -5150,12 +5197,9 @@ void
 ring_buffer_read_finish(struct ring_buffer_iter *iter)
 {
 	struct ring_buffer_per_cpu *cpu_buffer = iter->cpu_buffer;
-	unsigned long flags;
 
 	/* Use this opportunity to check the integrity of the ring buffer. */
-	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 	rb_check_pages(cpu_buffer);
-	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
 
 	atomic_dec(&cpu_buffer->resize_disabled);
 	kfree(iter->event);

base-commit: 50736169ecc8387247fe6a00932852ce7b057083
-- 
2.35.3

