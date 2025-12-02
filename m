Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com [209.85.217.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6432D0C94
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764699699; cv=none; b=p/qtefceQ+KW9Coh+YXE6QAT47bYpr5ZJpko8gDGxmfwugw0W2I9VQMd7QboPcPDmLB40MqtjbcJiPEoASCHWcecEquxBk8cOvN0aYdfDJ+5pLE4jOMihpFlx5jSyiMjhc54mSVXuVPCnaTVwd23/b1qm6nEXFiv8qCLdGSjBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764699699; c=relaxed/simple;
	bh=Q6nsMG+HImyaJULK738xtVp5TUb5J3iQjwpkt/Zf/8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaHq3KDGBvIaC3c16Gsnl7ShZrgLpi55Mw4X5hljs5/KddcZzQrg/RKqihMFXJsXoa1gPTFaktTuTjAbNymN7vlnsLL6g50OvAp3e0wnynsl+Ou64xcTIN7QJcCtoLsThfm1bsANqufc7NPdx6vPUGygntjwLGRQUUBbzjVLcdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=SajWek0c; arc=none smtp.client-ip=209.85.217.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="SajWek0c"
Received: by mail-vs1-f99.google.com with SMTP id ada2fe7eead31-5dfac1bac03so363096137.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 10:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764699697; x=1765304497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iAKSM+YFIoffRWnIvZh2aZxrHWdwn+486YXWr5hu1CI=;
        b=SajWek0cIcXVqtpD+GU5BNiMqKNEMPY+DBxtH7Yas1aLi+HVzrIJfA54L/dmjRnWNy
         VtN1Dco0L3zGPoh7CK2Jtyt5GP919MIZaRb+RFhFNluIhXc2AEiXzfZoRAumCFyPq5jK
         hzB080wexSBWwVXs+9cx48NetPKm1NbULQSDU/hu8UoKvE9CRGeiX/JliUgzHGsjouz3
         Dr4cV8wq7cg/YhfPqoBnpqqoq7X5vjyDqo44vxpCEkBxyWV6waaLbKV9zIVfytvq5Aa4
         07FUZFKv9NnIdWhBSj3WUPWnbMKkRS3qZbVnRg5h/ON4UDvMU95YHx/hq1n8L77c1GVs
         lhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764699697; x=1765304497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAKSM+YFIoffRWnIvZh2aZxrHWdwn+486YXWr5hu1CI=;
        b=CdBfRBg8xeOHs4OG1iyHgF038LigPwlUtXrV7TeRgORTAxX3PKHkpFnE1UE3N50M06
         HUSSUPcv5IGhbZ+WK0Cl2waHfDG+48TXHoFr5z9TpQYtTUrf2GP39/zdNDj8PV/gEq4i
         ArmvP6pKLnivV2ei/jOO9fist1GvoMYnMVimOgqw2zIttdMvTS1mY4/oOoyDrKLXZYuO
         jyzqbTjaqHnwV8zlPozxG09qyuTxHHL8BmqU8PkuYE97OtOvYLV6pOTDAub+jMDO9ovZ
         +eJEWQouaTrEkL8VYliJ1ZzIOufb6AcQ/7GI02h40DiiWdaa18fLVkrojK1IVRJ8JZ5T
         JRrw==
X-Forwarded-Encrypted: i=1; AJvYcCVWHrHHZp7o0q/X5Ug6a67ip5uAZzB95tDwat0sWeC/Wh3O2IFa1l6mK5o/NYV556wSKmKRGgMS979TYAVJl4Mv2ec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDJlbKKzFMHj2/mTo+VPQnxAEaW/4UeH9DMpm5JoJIdhXW6nSW
	4/K/1Q7S1YT5UCs19DD1FjQ6w0IcRG72iZ8CwxEv8JaLI05nA1BTBkTHqU5GJFomc0SS+LL279P
	u1Ryy/hWqjyzAYVjn7qmiDXGpzMxDp0tkyef+
X-Gm-Gg: ASbGncsJkNxFfffvct4yGhJZrzHzc9qBIYc9zfCUEdAGYJ325oJnqVY1dN74JppHFCV
	ZZNOZul4/CQa4+Y7s4yhWDSXfsauHT4lG9tkB7j4bKrV9jHo0uBr0gSK7eWnNeyqLy0xbZWh5jW
	QTZvEaYuCy09jKt45H0QOoMcKmtSzo7fZb2vyx/zukS/4CDD1PSpVS5qV+9MGS0IaZ0Fds5roCb
	kDd/ouBKKI+qF7RC9gtEmnmllKUdtiRBWzIGNjSmNw4Cvz8MeUl78hPR85+GgIOZ5tAmlqlzk6M
	Yv6tjkBhrFPS2go+AFNHaEC56i/6wWoHqtXvQDf+96fHuFGGbEgLocW7TWmjDSSTQvAHXFeV466
	Yf8g/6qxo3USWg9DAuthG9W99JJ9UrzHvc4+4pEwqYw==
X-Google-Smtp-Source: AGHT+IESuDUtU77Vl0nma1WiRhfiGkS93Xa+aCOm+aieYgupGxGL2OnR6elfzfyHjGVzalPvSGEdXG5HuxeL
X-Received: by 2002:a05:6102:374b:b0:5db:cc92:26f3 with SMTP id ada2fe7eead31-5e1e69fbcf2mr10232117137.3.1764699696634;
        Tue, 02 Dec 2025 10:21:36 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-5e24dce43basm996090137.4.2025.12.02.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 10:21:36 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7C01F3400C8;
	Tue,  2 Dec 2025 11:21:35 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 76598E414BC; Tue,  2 Dec 2025 11:21:35 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] io_uring/trace: rename io_uring_queue_async_work event "rw" field
Date: Tue,  2 Dec 2025 11:21:31 -0700
Message-ID: <20251202182132.3651026-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The io_uring_queue_async_work tracepoint event stores an int rw field
that represents whether the work item is hashed. Rename it to "hashed"
and change its type to bool to more accurately reflect its value.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/trace/events/io_uring.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/trace/events/io_uring.h b/include/trace/events/io_uring.h
index 45d15460b495..34b31a855ea4 100644
--- a/include/trace/events/io_uring.h
+++ b/include/trace/events/io_uring.h
@@ -131,28 +131,28 @@ TRACE_EVENT(io_uring_file_get,
 
 /**
  * io_uring_queue_async_work - called before submitting a new async work
  *
  * @req:	pointer to a submitted request
- * @rw:		type of workqueue, hashed or normal
+ * @hashed:	whether async work is hashed
  *
  * Allows to trace asynchronous work submission.
  */
 TRACE_EVENT(io_uring_queue_async_work,
 
-	TP_PROTO(struct io_kiocb *req, int rw),
+	TP_PROTO(struct io_kiocb *req, bool hashed),
 
-	TP_ARGS(req, rw),
+	TP_ARGS(req, hashed),
 
 	TP_STRUCT__entry (
 		__field(  void *,			ctx		)
 		__field(  void *,			req		)
 		__field(  u64,				user_data	)
 		__field(  u8,				opcode		)
 		__field(  unsigned long long,		flags		)
 		__field(  struct io_wq_work *,		work		)
-		__field(  int,				rw		)
+		__field(  bool,				hashed		)
 
 		__string( op_str, io_uring_get_opcode(req->opcode)	)
 	),
 
 	TP_fast_assign(
@@ -160,19 +160,19 @@ TRACE_EVENT(io_uring_queue_async_work,
 		__entry->req		= req;
 		__entry->user_data	= req->cqe.user_data;
 		__entry->flags		= (__force unsigned long long) req->flags;
 		__entry->opcode		= req->opcode;
 		__entry->work		= &req->work;
-		__entry->rw		= rw;
+		__entry->hashed		= hashed;
 
 		__assign_str(op_str);
 	),
 
 	TP_printk("ring %p, request %p, user_data 0x%llx, opcode %s, flags 0x%llx, %s queue, work %p",
 		__entry->ctx, __entry->req, __entry->user_data,
 		__get_str(op_str), __entry->flags,
-		__entry->rw ? "hashed" : "normal", __entry->work)
+		__entry->hashed ? "hashed" : "normal", __entry->work)
 );
 
 /**
  * io_uring_defer - called when an io_uring request is deferred
  *
-- 
2.45.2

