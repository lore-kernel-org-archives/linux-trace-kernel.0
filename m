Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54123148B2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534429; cv=none; b=RUYklIOn957iniKYLOHh7V3I0793Wg1DB/o3xiQeBse8bw0H3ynJVf6v2RHZVz1H74lEMSFNoEJH0lJ8yYEOGsqjgr8U65b27whdPQcKSVlBY8l+ztlqrhDzAMWqxMZOBWX4HZSRL8XgksFfrEAo1qz+OV0AJLJbEEh2ajV7kMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534429; c=relaxed/simple;
	bh=uYlX4fmdzkT05HrS2faYkmZtyUoE1RuQNRwTRsrG7BE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EczZgERW4wTZraIHeLUp2db2bbv6emZw64qtv0ftOjJtQYbnjqECFc/TV6Xx/MkCMB+o0WzSAFMwx9BawGgdAQ3Sj3B4qXHZyt/mruNse0O9Sq2TlL5IsAdk0g56tSNqoIP4+TJZEOYPBxLBZIMjJ3u6nfqZhM53gjD7yWiLtMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtMxQuWB; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtMxQuWB"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b6dd81e2d4so5704127b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 22:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763534427; x=1764139227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9hJTLbrXY3Zk2Mazdcj2lBmSYITWPXkEzE1ruAm+XsI=;
        b=GtMxQuWBlcxZWVoyd8VLQ7fWa1K8f+fMwqFYLnhep7Ln8oUehjpybrZAK3g2jsAUOU
         Z5Tg5wJfmTRL7p/4KNqrCxvKuQxF6LHLRRjG0yxpFcUkO2c3m6YZDYadncth7jXpZqoc
         /rq29XL2AsuXl9ME1upWkYFw7aDzlCm0rR9GYqDCnGQJuZCtEoIqUW6dXwvH7XX9gkLY
         /Zh8+JAXY6z90mj3gl/BH/oo13Flii7JH1raHlz+Xne2tmplxa0tHWtjD8GfyxpKDM7P
         qLGwnTHtdKAgNy+jt8Qg+NQpayo2qwnsjHUsQfcolJ8OSOd7SiFViXoW5uYO8kJQKDnM
         FlwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534427; x=1764139227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hJTLbrXY3Zk2Mazdcj2lBmSYITWPXkEzE1ruAm+XsI=;
        b=f9MJjKWpEyB1La/5/fPGwV4uqunGt1VK+PzT2Ug32i7yO3/t34z1gdADYpOAkSO7tN
         VHj8cqTS6YEaYcZouHN2/lGI6CDXUVWGIOwHBm1vORRXNZryBZL2nfr+EWi5dLqaTJVo
         QKqYYMXbrwl2TYMQWGBz1SWmSz8+qJ00dgIc9bbjBgUzhmDVsIxmlAMCT1FcC+prlSpq
         9J2VNILp73BsCsYZcxbjcAgMrszokHTF9j5L+zRBARA9zMYHGHREuvXOj2RxKYexC42a
         QLQWUk1IDOiQQpwaYzGAusB3snZR/CBw9p1UECHL/IQ64KPhFOc7oHXx2xxq9FZabTlV
         x+Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUqwdGlfxDDGPRq8qre5RzvO8Q1g5jYHLJ3sWq4I1PC+VlZBtiRfikTSfgPIztvX138Ld+ONMtE0ZY+GKjAZY/Q+zk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1azYTgoNxLJyfAFSKGgAEYRWtXiAqOoA3WNbGpwhcfqEYCtI2
	v84DEh8Kzh9nbM9lSTWtQsqaLJCERWQ7BBcGIbnkf7S6HpqoKxC4xxTs
X-Gm-Gg: ASbGncsbOh2qNqzQxyTln1CXsJeu0JwJRPFo9bAY5oP2vySVMNeZ+3InokDmgktZ7+v
	w0ZK2UwVcTelgDcDVtkhe3J1Ziwmo1aceIgBCheggu2P5QGVlDAwbm8LGvUq4x2cvSzRww2kR+K
	NyE7bMq6VRjK/PjBugXXDYfkjG3k7ItmZtyuXipYwurwNjd9iRq3zQD1BcOZGNv0M8CBt8Q/PSX
	9fBA8LPx6N1EK1Gv6afxb7WPRn+X0seMBf4TtZJUPb1pYByf3Rq3Riok/SrPDb3nE43QpJmwr1d
	nkkr3REG1w6L5nGw/7dLA8Xr2p9sEAU6YEfZOd3IV3P25lU4dcayRn/T4mHuKYZ9K9914aj1j4p
	p/OlodTSZmoYkDZZ59A0tihfVuXOq4l08yGB/kgw9tdzFNn3chxYZh415n1jMVA+7WECODHhiGT
	gs/mYSwxzTYRTc8fAHj6MKbrrqkzKQ5v8/swo=
X-Google-Smtp-Source: AGHT+IHHLoXX9tuzDBj0adgiYnwI42e1BIRw1X3IqgnSOH8/zKZs59lQFSzkqtFH4Beek4UISxG6WA==
X-Received: by 2002:a05:6a00:986:b0:7b7:ac37:9235 with SMTP id d2e1a72fcca58-7ba3be8dae4mr19441356b3a.15.1763534427003;
        Tue, 18 Nov 2025 22:40:27 -0800 (PST)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:8374:24de:cb92:e673])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cd969sm18467014b3a.23.2025.11.18.22.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:40:26 -0800 (PST)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com
Subject: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close for split VMAs
Date: Wed, 19 Nov 2025 12:10:19 +0530
Message-ID: <20251119064019.25904-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a VMA is split (e.g., by partial munmap or MAP_FIXED), the kernel
calls vm_ops->close on each portion. For trace buffer mappings, this
results in ring_buffer_unmap() being called multiple times while
ring_buffer_map() was only called once.

This causes ring_buffer_unmap() to return -ENODEV on subsequent calls
because user_mapped is already 0, triggering a WARN_ON.

Trace buffer mappings cannot support partial mappings because the ring
buffer structure requires the complete buffer including the meta page.

Fix this by adding a may_split callback that returns -EINVAL to prevent
VMA splits entirely.

Closes: https://syzkaller.appspot.com/bug?extid=a72c325b042aae6403c7
Tested-by: syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com
Reported-by: syzbot+a72c325b042aae6403c7@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 kernel/trace/trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d1e527cf2aae..304e93597126 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8781,8 +8781,18 @@ static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
 	put_snapshot_map(iter->tr);
 }
 
+static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long addr)
+{
+	/*
+	 * Trace buffer mappings require the complete buffer including
+	 * the meta page. Partial mappings are not supported.
+	 */
+	return -EINVAL;
+}
+
 static const struct vm_operations_struct tracing_buffers_vmops = {
 	.close		= tracing_buffers_mmap_close,
+	.may_split      = tracing_buffers_may_split,
 };
 
 static int tracing_buffers_mmap(struct file *filp, struct vm_area_struct *vma)
-- 
2.43.0

