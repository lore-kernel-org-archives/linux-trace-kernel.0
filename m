Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D6F2AF1D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607626; cv=none; b=Cv1m3Qa1C2pOf9Basm/kn9yNS4DukWgs2vJ/OXEi2EOFKI7RSOGQr03OsJ3zuvT15EWK1+zyXMHhNlkJ/cdAU1r2/culyzStzQ+5PvAXQlSTwxpd0EoEg0zM9DUoJeh2O2M/VWbkOx2CB1xTkBwrCdjLk1no1tyChxFeuZL0dHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607626; c=relaxed/simple;
	bh=JWA380ctDhP6cb9yiDI+v1kSZBNiU/P0ELQGPGUNjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lp43m0n6MX0lZrubdo6ER+U1yR9LocMU3xteclqOpp0r+u3yea/p9Rut395LSoxNoETYI2gBrS3YYQpG67xVk16YOUkL1Ctaxqb4Jk+ahWjGgWLxIrm56C4t8T0xkfbXw1Jqjs8/FSdBkgQ+vymm8iJ1pux3hbnLsNRZ3cvdHps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg4yAB+y; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg4yAB+y"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49319ebb3a9so4633185e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 27 Jun 2026 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782607623; x=1783212423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lr5H8TFwybM+AlW1rdMOQH0Q1+oaaC7QfC19uDCbRGc=;
        b=Zg4yAB+yK5jIxwbJPoV0JS6WvmmpFKbf1j3pzVfrwKvj6j+pscPkCq27rGXLNlKiBO
         Y1TQKMLv/7K2r/eibKqN4pTRDHwSzizbEcqOt0YDKrGiEyHIg6F2vjPZD9/+Pj7QSjYR
         YdfpC27SXtq44wmH7IhX49Zs880oEMSTwd7cW6brOGvpQDk1uabvLf1EHYtU819x/Vp8
         h+6mKKwW//IkzltaKRj7iMoPi6xOlCMSzq6mnsAWWuUzkEsKIc7CfCOtQe2FFX4mDvVq
         1YrQ3IGVhCfzg9fJRq1Qt0IJkegd48wmO8El56e5zeds1b0vMH/3PqiTxFDxbfS+bLaO
         sxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782607623; x=1783212423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr5H8TFwybM+AlW1rdMOQH0Q1+oaaC7QfC19uDCbRGc=;
        b=k6Vg1ulEx+A/6Ts2S8iqpbIicttTGmqn46coEmCJAhZ5tcZIRHus7ctuQcFLjsgTVt
         3KywgMryr1GjaMSAEN8F6BLiH0oTyc0kgxE9iL+rv4kUEsFkwFsKWDTPYUiTFOKCVV+n
         SSNcHG/cSna62cb65Y6GN2m1QimBFLJOXyVdMtRwfXAXa+HgbSO4u1J5iJfUZaDiteO3
         aWcEJa8Kr5Ci+sxSUjjqH32VkGWNGibxgI1Ppqfpj1+fllH+lrxxe1q+Zu2vClvE4Gzn
         hRfsbG30AP14+dZPEmY8rAcCWADXV2BEUBXxGtEB3eSE6Z1WAciIFemuDp/rXbcWwIgP
         DcuA==
X-Forwarded-Encrypted: i=1; AFNElJ8r/NQNxvUcvfkeb3vRsjgW+YVnrYNhacJMwsV8PMdOQl/oj8tL4R3EKjoHgz5NqPJlkdZAHSZxqQ0mRcCpPKk5cI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMcR1Alig+EbdxeTfa0VSKOXKxZNIBuJjVOgkGei2qITqVq0Nr
	+Ot0GjLKYK/XlDdwjUv9QiUqro7jSSru+SkQ/EeHep2aeLCYa99FMk1H
X-Gm-Gg: AfdE7cm5SJ+wYGcybCPI7nI7heUfyf9Qqw6+AYxexP8GzMLi4B9gpMQC7vg5PAimnid
	rcqeKTzXebNvo0ywjBUHTmqulrdn3sHIgFDHu5x5avXUSd0gHgG0x+R6H+hCBTZDwbnCn39GeWB
	imXQf4eppnU5QRO/chZIsacM7x+2aDBnLL74AihZaUcIi885Dzx/lBe9QfcMpPRvfyxeDybzsrW
	KkNu7FPvAQn1dFMAm09Tx+t3vLJ81p5Lx5sPvDfsF8MvHCYHmZ9j8rkrfqehc3F5Rw5GCMHF4rO
	V18jFNNkyFSphgz3X+ExvsdH1d0RRnjkFJEHjz1tgrmMwm0CpXgaDaWVKrJBM9PjcQpt8pq8NlC
	h+cpAOs8/ovtlCJZlWwepCHv3ecEUth4IDGtFn+MZhj/wTjzfcGQFlASDz28HpwE9X9koQ5OiaH
	qHxAIVrlmK+ruz9r7AFOCZ7YCiEA==
X-Received: by 2002:a05:600c:1d08:b0:493:a607:f3b8 with SMTP id 5b1f17b1804b1-493a607f49amr14531755e9.0.1782607622662;
        Sat, 27 Jun 2026 17:47:02 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e6167c05fsm24063111f8f.25.2026.06.27.17.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:47:01 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] ring-buffer: serialize read-page order with subbuffer resize
Date: Sun, 28 Jun 2026 02:46:53 +0200
Message-ID: <20260628004653.28065-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ring_buffer_read_page() checks that its spare page has the current
subbuffer order before taking cpu_buffer->reader_lock. A concurrent
ring_buffer_subbuf_order_set() can change the order and replace the
reader page after that check. The reader then copies a larger subbuffer
into the old allocation, causing an out-of-bounds write.

Keep spare-page allocation and release under buffer->mutex, which already
serializes order changes. Move the read-side order check under
reader_lock, the lock used by resize when replacing per-CPU pages.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 kernel/trace/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..eed5d7cffdee 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6950,6 +6950,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
 
+	guard(mutex)(&buffer->mutex);
+
 	bpage = kzalloc_obj(*bpage);
 	if (!bpage)
 		return ERR_PTR(-ENOMEM);
@@ -7000,6 +7002,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
 		return;
 
+	guard(mutex)(&buffer->mutex);
+
 	cpu_buffer = buffer->buffers[cpu];
 
 	/*
@@ -7091,14 +7095,13 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
 
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
-- 
2.54.0

