Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC930E0D6
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Apr 2026 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021851; cv=none; b=EDuSHyrr9ojjNlQ/ybuTHXnWRHxZKRV8kKaN+oYxkexrkU5WlGvYkCi8/ewMSVoTBEb4+ZdRLS+xc5VGvtyXSkix2HG4dnEu4cmWly370lHP1D+bkgwz1YOmgAsE/oCInx2Zjg4GVhf1TAmuhFYVxkD83cBRcBrJyv7FXHq5/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021851; c=relaxed/simple;
	bh=g7Ed5EWs6irGU3euUlogWHAf8XlbAn4lOy8PpKGTXJ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UyXqQ9TBCJdRKFMO9comQBdYzf2/RDjOTYhMTPeWkAmCnIy7r7lv5M9w38UGmyY6f/Yn8eRMkWr3Tx5puEJ/dKkh4a7by6xtY0JSHMFP/kc1+JqAesJfeAmRu3/fbpFddovA3NhwFLRxwxuvWsYbckb/OITsq7sbx//ybOQ34EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fW0pWqpn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fW0pWqpn"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4888020f5daso9205885e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 22:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775021849; x=1775626649; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBLhbC6YBGjXwUzmIRUHH3YF/N1tH9WoVcrhDPGIIHw=;
        b=fW0pWqpnNxGobl+hmwt+jaG5DrbH1oONqXM30ldhscnVq/5kasZrBSftdhTYdktU7a
         QRSlGMGJOM7gLcRCsyPn7mZKzSJWzfUHYZesU9X8vUzIXXwF8zTmI6Kf4wcYnOX5HsUv
         BjmWjKIKR7tGeeZq6Sk6H7u6L6Tq7gzyS+k4zDGjHoY+JDTtDkWjrMEVPLnFKByWccF1
         o2qF8hTg4UV6ZAMQcKTGVhNZ4Kklt/0WIcW3MZrk8VfoZ5vVdFl5n1eilra6TAgxC7S2
         Lermm+SznM5VimAJXg/6nj4DzNb86q5eVy/fXLBKHpzAIvtQAxEwgQxKnHKEEqQz41Qo
         h/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021849; x=1775626649;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBLhbC6YBGjXwUzmIRUHH3YF/N1tH9WoVcrhDPGIIHw=;
        b=NQbaYZSebW/fN79ssa/4c2Ya5tkYwYtBQXVn5w1M6hj1rLBXGc3GM59ymz/ES6ZeXy
         BQi/e6fnk1i3FSiQD8ANW6fN4+DjwfJKB4aw7bIhlrJgLAM95utwoJ1Ye5kbaXc5V+WO
         O6jhpIgdaVduniz0vbTV8Ce661BK5baZWpWdPE8DXMiXFWuul3DRIE4I8xXm2vYNi3vx
         gWgcMTTJDeoRCvxKcNp51YlchLuWwQ/osp3oXSERDQQLqYpD9X1El9vC3mViKw3QL50j
         NkkUnRiTCTOBaqdxFSBTfL7KfJ4v36J6RLobZ+HMch1M1G6ss/hMcpKYyVebPHnRnfhv
         r90Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVx9ixhUD37UF9yPkgKXDop5P3hLLMd0z0s0TBuUb/n2OILlSLx9Wx07hRDJoMwQvFZO3wGwyFAjXqGFfAtfRyDwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXAeX/r8h1VXQkYW40dH0aB1uSxAZER8zEqA4z7VUt2iiRGXCS
	shsDL/8IJ40wOiQYLyNxx9LB0qrZOrVU1bSN9ysJBPA6ZSgjrPCnVOo0dfGfNnnL4h3/eu0CUiw
	bZ1GFOZa3whpwJlwO1LpRhA==
X-Received: from wmby19.prod.google.com ([2002:a05:600c:c053:b0:486:7a8:4f4e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:818f:b0:485:3423:727d with SMTP id 5b1f17b1804b1-48883595de9mr30905495e9.26.1775021848954;
 Tue, 31 Mar 2026 22:37:28 -0700 (PDT)
Date: Wed,  1 Apr 2026 06:36:59 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401053659.3458961-1-vdonnefort@google.com>
Subject: [PATCH] ring-buffer: Enforce read ordering of trace_buffer cpumask
 and buffers
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

On CPU hotplug, if it is the first time a trace_buffer sees a CPU, a
ring_buffer_per_cpu will be allocated and its corresponding bit toggled
in the cpumask. Many readers check this cpumask to know if they can
safely read the ring_buffer_per_cpu but they are doing so without memory
ordering and may observe the cpumask bit set while having NULL buffer
pointer.

Enforce the memory read ordering by sending an IPI to all online CPUs.
The hotplug path is a slow-path anyway and it saves us from adding read
barriers in numerous call sites.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 170170bd83bd..10d2d0404434 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7468,6 +7468,12 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 	return 0;
 }
 
+static void rb_cpu_sync(void *data)
+{
+	/* Not really needed, but documents what is happening */
+	smp_rmb();
+}
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
@@ -7506,7 +7512,18 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 		     cpu);
 		return -ENOMEM;
 	}
-	smp_wmb();
+
+	/*
+	 * Ensure trace_buffer readers observe the newly allocated
+	 * ring_buffer_per_cpu before they check the cpumask. Instead of using a
+	 * read barrier for all readers, send an IPI.
+	 */
+	if (unlikely(system_state == SYSTEM_RUNNING)) {
+		on_each_cpu(rb_cpu_sync, NULL, 1);
+		/* Not really needed, but documents what is happening */
+		smp_wmb();
+	}
+
 	cpumask_set_cpu(cpu, buffer->cpumask);
 	return 0;
 }

base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
-- 
2.53.0.1118.gaef5881109-goog

