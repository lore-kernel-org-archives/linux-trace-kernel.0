Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7681D6DD8;
	Wed, 19 Feb 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739961775; cv=none; b=d+9VjtE/I+oAygUJZEKSgNZ50/vAzRgokRfAkxSBcRc4PBZ48pwQ4afoEsdvmiuhcn1AXwxbjNRQxLcarYjuBxqjEoX/uthfUkP8RTBHjKvb/TwbtxlCZ8b22HeG2r3NKU7i6q24qZP5mL6SLAfollrYVM/fccZN2qyHDmW+Xfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739961775; c=relaxed/simple;
	bh=p+hPLk0JhmrKHlRpP43gqWn7owWRPdmZ77cBOwe7hoA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIqiidztizsJNlvMC0TgBbKGKyvODboUdmdaWUZtihbjvagzp5ylqsJ6RTuvvbCYakfs0vQUUc4xShTcVZQp6HwlvG+KCBSvWFX9kLmJIICuUPxpJx61fJmPbLsjl5U3q+cShdPTk62OugtzTMw5mGp54CuBaq56f1CXX5z4Mzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak8rxXY3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak8rxXY3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220f048c038so85685085ad.2;
        Wed, 19 Feb 2025 02:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739961774; x=1740566574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2XnFU8EaOdq62LfxTov6x5Z3I/byCdSxv47oBiUyW3I=;
        b=Ak8rxXY31b7Xa1+Pb8KuTDMy/3RIUCLCqlw2fnSAuiUJ4HiAjNUdQYFOdqrRKqk41E
         CUrF7aad6zvVcWQTeO+RbkbpbDYwkFQfWnTHQ7Lz7zow1AsQ3kgkO29g6n6YnIi+yEwG
         Iwx/cCS3SV8L8dPaGIqQotwxPrf9AunLRqLqmKk9T4qf0lAwphCxG7NakFryfUkUuFM5
         hE1FANgXCpUERQLfppArx9pqU44Do6eHwxS+S6OZTYiuQxov3oFadQdeUCQs1y1e3oge
         IlTwMfLixVWYWOesFY++CmDOXo0Gvco2wAE2qmkFkx+dK//+kSHcRJMKBE61K2H0ww2u
         9LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739961774; x=1740566574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2XnFU8EaOdq62LfxTov6x5Z3I/byCdSxv47oBiUyW3I=;
        b=Sygf1SuB0ULtEJBD4OA1poH9RCwXTqYkFD+EkeRYLqFxAWLAk2mXCZlmE9zDgAsqpu
         8VrP4XsbXVjXeW6PCOJqY0j26EO1tUOYTmDuCVjJsChgbRzPhfGwrpA5+TuuhL8WChzI
         nmH82+Rj49qQXYaKPsAMcuHXCVgvxWKETV72z5bQQJYaWI33ek7qomPGA/Pvfue0Ny6H
         3BxvO7dqU4kH6O3WEfr/7j7BgtHOuu8MVSeIh0ldx5+lPwQL/FxPN6CWBFnoAGK4ww8t
         +ajXBZ5ZhI9bnfkgj7UhhwC+qpgFrBWDXfzjed3jc8aVhyRRoglNtvUHJ++pIjFwIYlB
         aNxA==
X-Forwarded-Encrypted: i=1; AJvYcCUPqAHngZNG+8IVONpx5j2LOxQMkRs2/62tsS4xgrrbBPi9D8RALb1t/qkqVzBgXx/kp15wNAIjs8546VI=@vger.kernel.org, AJvYcCX0E1bwlRFIpfclqCIR4TadArPOoNT1t3TVTNZnwOwlTq7Fn0EmF+w84rYT10LUvQpncoa4Z0c7r5pyLHx56aixjrb9@vger.kernel.org
X-Gm-Message-State: AOJu0YwTO2rkH+AEE9p5Z4Ko27LRVmlzGl9vkiDQ7hfASms0wgqbY0CO
	TzmzgF26AfL0gfUdL4eP4i28v07qvgbCaxvW8XybSxPouOwzvvV5
X-Gm-Gg: ASbGncu6sFqh3kRULXqk+hwL42bAgx7jUZLRb/rSYBX5V6dp/Senuex1KlaFjvd8TdV
	sGcaepHqROi2FoRyxhsDvWXdiSyFtlQYE24FwoQjES9iXSKBg/16ck1clVMNyhspE2qKjdW06pf
	DCoIUlMlSH+SkuPbKN7iKP3FcYt5RGqaX4skmAuZlZmDYxTpTX94Hu7DZecIRDv5e54cCw91PbJ
	SguAxisaLSYldpVdFZbvd22VW6rUyo6DWtyNmAUNJK+gt4kNm80jz00MINJK92fR50jduyTyQ8v
	OIlkqBZgy23P04wh1HNJx8KjDrznlXzJyLoeI9sN8q227r/fS6YZ7wmBCotlbh3t4hKUBOc=
X-Google-Smtp-Source: AGHT+IHjTS8X+w1k6uNV84RSXxe6rvfUywxmTyv8ppnFYs6uUU4/dVHdurSXskkGx1KBDXq6C2bJyw==
X-Received: by 2002:a05:6300:640d:b0:1ee:b033:6dde with SMTP id adf61e73a8af0-1eeb03372d7mr14817906637.3.1739961773660;
        Wed, 19 Feb 2025 02:42:53 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (1-175-143-196.dynamic-ip.hinet.net. [1.175.143.196])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-add3f326b31sm8246832a12.64.2025.02.19.02.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 02:42:53 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Adrian Huang <ahuang12@lenovo.com>
Subject: [PATCH 1/1] tracing: Fix memory leak when reading set_event file
Date: Wed, 19 Feb 2025 18:42:30 +0800
Message-Id: <20250219104230.12000-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Huang <ahuang12@lenovo.com>

kmemleak reports the following memory leak after reading set_event file:

  # cat /sys/kernel/tracing/set_event

  # cat /sys/kernel/debug/kmemleak
  unreferenced object 0xff110001234449e0 (size 16):
  comm "cat", pid 13645, jiffies 4294981880
  hex dump (first 16 bytes):
    01 00 00 00 00 00 00 00 a8 71 e7 84 ff ff ff ff  .........q......
  backtrace (crc c43abbc):
    __kmalloc_cache_noprof+0x3ca/0x4b0
    s_start+0x72/0x2d0
    seq_read_iter+0x265/0x1080
    seq_read+0x2c9/0x420
    vfs_read+0x166/0xc30
    ksys_read+0xf4/0x1d0
    do_syscall_64+0x79/0x150
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

The issue can be reproduced regardless of whether set_event is empty or
not. Here is an example about the valid content of set_event.

  # cat /sys/kernel/tracing/set_event
  sched:sched_process_fork
  sched:sched_switch
  sched:sched_wakeup
  *:*:mod:trace_events_sample

The root cause is that s_next() returns NULL when nothing is found.
This results in s_stop() attempting to free a NULL pointer because its
parameter p is NULL.

Fix the issue by freeing the memory appropriately when s_next() fails
to find anything.

Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
---
 kernel/trace/trace_events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 4cb275316e51..c76353ad0a4e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1591,6 +1591,7 @@ s_next(struct seq_file *m, void *v, loff_t *pos)
 		return iter;
 #endif
 
+	kfree(iter);
 	return NULL;
 }
 
-- 
2.34.1

