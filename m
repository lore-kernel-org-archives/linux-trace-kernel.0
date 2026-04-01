Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290833E374
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775070699; cv=none; b=VzT+PiUu4ULmXv+lwSKf5MrbUDcme3QyaEEzMdsjm/7uH03mwPdFBxFAssDafXzQXlr4n5KdZRNIMcOkcgtiwm5f473jvI8hCqSESkiziY9p2HCZyKAgMscwvz2MjWAvQcV1U/bGcJ0pGpmq6m7c/M3XK8A7f14Z8nFU6GulRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775070699; c=relaxed/simple;
	bh=q3ZOqC2BhdTy35OYL6LcDHUcdwNZjlwbTTvSLQkzK+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVXYn4KVkqkG/HXcnk1MkhDvqGR1lMQh5Y3TxoNNepcTupVFE47NL1c1TLzdcoRt5h6JsMfYMNyQFlPT3DA6bBSanrSmWScqrU1F+faZG7TC1BCeepuzm5oZE6hySJ7hNJdBXmYTifIq+NUU4dC+RVGzVfJLYkpvDuPNmorAfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q5zeNPBl; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5zeNPBl"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a871daa98fso405865ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Apr 2026 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775070697; x=1775675497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+B8Q0W4Gy+zs8q+Iwav3Y7Wha/cbHTp2+GwBNv/9+v4=;
        b=q5zeNPBlCbyQwOjRnUPxxAwzmg874wSoSpZw/GTU5nz2+ho/fvGbrORaR46R6DJL+3
         M6Zj6Z2ww6ffYhJpd4lPasxbJVoUzBLr+3awvHN1xuQvLBEqv+FR1hs+hVr6/BVa0r5d
         a/Djtkk+R24xORiJj4CVIb6VRVoIRbe+pGsW/XWHY76x4uzDZiF42OBdpI1GQ/zXpF9w
         ZANAVVTKaEGFxkTshx3j1TT0FHYq0nS0zsxJHQL90g5lIC7KMQR57X8cMdAqiG1Ungcf
         AXi7dPJVzGJD0w0snnhe3KTvjMY6G+pzGFoKSx5YxoxWJD4HSER6OkOdAJ7c3MxoFrYP
         OWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775070697; x=1775675497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+B8Q0W4Gy+zs8q+Iwav3Y7Wha/cbHTp2+GwBNv/9+v4=;
        b=OA62LJezAOIkyaOecUCa7ntzXhgbyGJqAa3q1XMvArPx2DyWYBaRzJRsV5/zKLfsZ7
         XrE/f3kRJPbmu/0M/+f/JJ9LpA+8eFq1WU7StwVbvxLzVOmtfioN46qUmo90eEdazRUD
         5y2e5DDRXFMVbdiaB5Si9uaxBHJrtDPFRjciietQjqrakDfOD4Mp2vqx2tOtvisqJcMg
         LSP8Gcal6D/cIZt12VftbKCySQVO8VV5eZtxwnaWxDpzMpG7zXjIrlu4uwbhMQmy4bEK
         OBe/EugYAYt5js+cZEgzQcjRMoiNaiRhL5JXmM4G0UfggC7RqgBfpsM14lB0zeeqKhOV
         rvcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf3GsKHpXlrN5+QG99sR+tjObiMUjFdYNisdSCmNeoECylg/QOy75Xx1sKDxu9bbpJ7R5c2cB7J9YkWLWJpNdQLIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJSSKcQGe8yqIaJSYllbRXSsRnc5zgWw5ll17S8P5mPUh21YZ
	hcYKSdRL5BZQBKqnDCnR4qp0FhbSH7kiZ2q14gxFfxRoRzNRguwgopR0
X-Gm-Gg: ATEYQzwEMXGZJxF7dIcBaSYwHqHAk+az1gpEiLyjOqHzYkEykSVSQFMDnogdWJMndU6
	ImmRz5fVSSmKiUklQxa+IJM0Jb+EA2LAbOE+01wbs2lX2drpCkyM1+gMLC5wvK1Ry/D7HVCL2Tz
	50I7RfQmIVkyevqZFGjehbXvPrbwg97VUXUfyIfrkKRsXcYah3aViqWQxwQW0jaKEzXIj0uSQXf
	FKuR+/xDp+gKvVtmVPAiChWQ0of9E7d7taY59CG7nMGhXWuH/LIXMWGtIBDEQo1h2ogw6k6JX+i
	bIDLcrxb4sYcspMZnn4KOIsjOa7ypsJlYyMuxRUtFR4uBWnfoJNBq3Sp+QYNS9TbcJUqQVOxDRb
	Hfu6FScD8YqQ+/RIjBRhoKOi5kaQKZ2K5YVwIGVq/3CtDfJPa/lNBUqF+dPH/kM90hzgpJywM81
	fLz6fcFvun/WsRtkuIb7gm/HObU+h/t2bnICZlM76mSBaH63f6/cEsLkxLpw6/ykVifiHX
X-Received: by 2002:a17:902:da8f:b0:2b0:5a4c:7263 with SMTP id d9443c01a7336-2b269ac0b62mr48831415ad.18.1775070697196;
        Wed, 01 Apr 2026 12:11:37 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm6805875ad.27.2026.04.01.12.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:11:36 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf v3 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu,  2 Apr 2026 00:41:25 +0530
Message-ID: <20260401191126.440683-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
-- 
2.53.0

