Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80213B4417
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975637; cv=none; b=kaYGtS7bE9vY6RxLyI0JI8Fht9vyu+a5QJ8vfrhmuLwUUY2PJnVaIe8fz5LvP40eGwwZUydv0wDU2YuME3/p44cdqOcCJzuUvMn9JoI4AWxforMO4KobgddL6RAe9nFCK784fJRQwoBJdtlJKYGEAahCKlV2GEbCM/2FPWi7Tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975637; c=relaxed/simple;
	bh=IfA4RcyEEepafQjD6vZ+iwdtqEflKw8Y5zNbQ3WkdlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yw01OfSfJBPSe/Y9UlV2+PZlm92UfdHYvyuUqb+K607TC8wviGh7XTTSOyX4fX7KjzxcCEnwGyS2L+BBbiEGv+EgKSAGstBtJv+Ap8sqS0BnK2kmGo0iy5K7iDLFKHl2yr9bOSutM5szQv9fUKajGkqg8aJt89kJXqCI/MP2I5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O94DbQrB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O94DbQrB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3256561a91.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786975635; x=1787580435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7R7rzLw9gb3ERMXW4LdXL81RMv+1OVwFG3xXvh/QwrY=;
        b=O94DbQrBEia3NWhMB5HtXmuPDSmir/Eq/Vud9JNJtRabrqDJ4ARn+oMrHTbY23cOhi
         wIn1xRLPg6MokMq5TT52hIA8fVXELQ0boC2a0xKeGlJ2Lhjqk9RJi5N6/YXebr9Jg9tJ
         IdCUG7swe47F0NS2hbIT0K76OMbJFRZo6EulY8+DJeZNGE84XfZSCs7hj7z3axSMCr+9
         8kektY22TpRscKTpTcOz5cj6bmHP1rtu8qFvOqh7SU/bOhk0PGCkedUv7y6/W7k/8XfK
         L8MVCp7bO4zQ5xrvhR27cy0GQ4+R6a/OcMySAJ1wb/jJYMZvBtfyavNf/TSwUTF7GUr8
         71eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786975635; x=1787580435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7R7rzLw9gb3ERMXW4LdXL81RMv+1OVwFG3xXvh/QwrY=;
        b=GXb7fMAyRkSWU/6TOG2WwZnpESH+MDP+6Ab84HJgSccwGLDaPu1P2sHXOGkUbyEjLJ
         WgKSpS2opcL5HDqizfoJLBMdE0EQnXYx/35NRTdCI0blorxIUDgNrXKtRpnvfLCldKy0
         M8dHWbM+MqpztUtdm6l3PyrlDbIUnA3Ply+i7P2qtbePAWEYSAyvyopcWFwHj2eZz3BH
         DfyCQxFEMWihVoJ9LQECn1EXpi3S0yvvTjEq4HQJ8G/k8NAhycf0y5S1pFaYxT3ydh3/
         fcrGdBM6gb6Xswz/2yry/LYxNVUN5UAUlq6EQgCGod9jsA8snns6AxXmRET57ufM5DKp
         gIFw==
X-Forwarded-Encrypted: i=1; AHgh+Rp4qayieHk6IYIQsTXB1heTdY5qBwr/r63d9YdoaMPFwK3jP1F9h4d1joEc//2dEfi4mvjaXLuHFu3pTZhh0zkFSsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW2cXQtpjDrK1KhlG8ZbALfEurXw5nN5zbY9pF2xwlLoj8bSWm
	LV5cNsiUhcI0kbv0DxiWXv3aYVsAXbQdVrs39O4hiZHyPfS1OrkeGF12
X-Gm-Gg: AR+sD10V0Wo0jqwMoUFu25Dg07+0j5BFnlDe/xbQ26IkMUMQScPOtBEH5SE9V9Lbxt3
	veOhY851XQR36eriaw78qqyjH8HNtcXYrWPBeqkDkoBKCPlRrx5Kp6dWy/KxpDoDnqquZyhxXuU
	1ciIjYGXFmhqe4aYh3/4uwEfdqIjNo7tmatulf0f8NfECI6yhZc1SnkfXf6/ANdm5c9zT0aWDUb
	aFv7ASjGWZuNb48ZuPuTL36bxVbs0F3S3yEfMuMD6PUV6oqFEz3swoCr9xQYFeetC1tOpTwc7xm
	jlI0q2L56R+C2oRm0W1sl19KPVDVHMLfwZ0MZ9keWSuaMFL0TpKDFKJlDLQ9Z7KlCF25JNMKQsE
	DBN/LtzJV+fJpSSLQJ2omKXifW1OMIDk4P6hjunLvnuwyFCx6qOea/I9rXyIIfDW8kHMhPkJBtb
	UfvkGvM5j51SyT5z/3AEtO54bqSD48SY3F9lGX37X4TjG4ZT8NsaZjCF2i1+L7zR3yJVc3et3up
	U2+NK2RqIvEwlPPGjVf5hyMUGRZw2LEmLwcvrg0xz86ozHZfDo=
X-Received: by 2002:a17:90b:4f:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-3933b833613mr29953901a91.0.1786975635227;
        Mon, 17 Aug 2026 07:07:15 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:f2f:4085:2896:a1e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954d2b6efcsm2415655a91.1.2026.08.17.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 07:07:14 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: tz.stoyanov@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Subject: [PATCH] tracing: Fix use-after-free in trace_pipe read on sub-buffer order change
Date: Mon, 17 Aug 2026 19:36:55 +0530
Message-ID: <20260817140655.5694-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing to buffer_subbuf_size_kb calls ring_buffer_subbuf_order_set(),
which frees every sub-buffer of the ring buffer, including the reader
page, and replaces them with newly allocated ones.

Readers of trace_pipe hold pointers into those pages. ring_buffer_peek()
looks up an event under cpu_buffer->reader_lock but returns the event
pointer after dropping the lock, and peek_next_entry() then calls
ring_buffer_event_length() and ring_buffer_event_data() on it. If the
sub-buffer order is changed in that window, the reader dereferences
freed memory:

  BUG: KASAN: use-after-free in ring_buffer_peek+0x3e0/0x430
  Read of size 1 at addr ffff88802a4cf010 by task syz-executor989/6002

  Freed by:
   free_buffer_page kernel/trace/ring_buffer.c:398 [inline]
   ring_buffer_subbuf_order_set+0x1325/0x18e0 kernel/trace/ring_buffer.c:7444
   buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:8221

Take trace_access_lock(RING_BUFFER_ALL_CPUS) around the order change.
This is the lock trace_pipe readers already hold across their entire
peek-and-print loop, so the swap can no longer race with a reader that
is dereferencing a peeked event.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=685955db58555575fdd2
Tested-by: syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 kernel/trace/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 395238b2b715..c38a5de602e0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8214,6 +8214,8 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	/* Do not allow tracing while changing the order of the ring buffer */
 	tracing_stop_tr(tr);
 
+	trace_access_lock(RING_BUFFER_ALL_CPUS);
+
 	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
 	if (old_order == order)
 		goto out;
@@ -8253,6 +8255,7 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 #endif
 	(*ppos)++;
  out:
+	trace_access_unlock(RING_BUFFER_ALL_CPUS);
 	if (ret)
 		cnt = ret;
 	tracing_start_tr(tr);
-- 
2.43.0

