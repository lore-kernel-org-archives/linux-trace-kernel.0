Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52C3FE4;
	Mon, 23 Sep 2024 03:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727063993; cv=none; b=rzZ8QSctURc9UvI4J6pa8s18rXmUuedCiF4PNLWXZrwi77L40lHAljhfBuIe6YZ6p3cDw/rVzm6urEEDHlob/s/EkuIPFFHSfIvzgx7BYBNY0ubbHNfrK86vnJLBMqjZegghQREBalMMD4cut7awpHpn3XwLXXnTc+znT10p/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727063993; c=relaxed/simple;
	bh=flf5fs08m6nwFou6VuxHcfEhuPJQqrpb0xWwYDz0XHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5VBojJnewbp5aDmPoWxKWIiDkDn3Vr4qaNA7RXD5fLCaQ8cCMN4q93YHJxT+Sjipn8crgBkjvUnc4kxAd8JsmkI+ywldEQ3AUQbR9cfE4+7wl+BZcywLux42fsFFcKy9BRW3w7iiUTd/o9MSftDyoNxBnXEMlJ7OHo6P2GaFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5KrbesH; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5KrbesH"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7db53a20d1fso2368469a12.0;
        Sun, 22 Sep 2024 20:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727063991; x=1727668791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9vWSfWfegAN1Rouk3V+ma1Oz3R4yoVwe8VY8Ox45QeM=;
        b=J5KrbesHc5OSmEwr9yl6iAEhI9uuR3/vf99wT7EhGfZ74oa9c8/4M+I+cOp26GEBa7
         Zg1AGNBXUoN/+7sD+wU7iIoFkVfjtHpF3na5WiJ2bSOLyrzZLQM/UIJg3O7AcYqspaoG
         Z6YZweEBfX1kDBa//l5ATy/d+h2T/MCbyASndUK3+iZ2lxgt7j0Q2cj+c1ZElqXd2SwU
         FHdISt2HEE65wOxCypQQojiOsOXQKUuokomoWbGb4Le38qrdkAdfuKu1Mcp8zDIEjq6N
         ikvjG0i0TEKQXrWBhZxELv7zNZFH1NhzozIFP44Q0Yu1lkniaP+McRCEGUTUeszg2zQU
         Zanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727063991; x=1727668791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9vWSfWfegAN1Rouk3V+ma1Oz3R4yoVwe8VY8Ox45QeM=;
        b=B/xLMjuPK1OmfBzKlmmiQaGI2cL1A+uWhabyeVz6ZPOXa4eMMzkP0vxGTN0oNlyJPo
         /j6kZlZrfBx/DzyhVs+djDCRDyRSuBoiECEfnMM2IAi3n03yEWT2Ywnou99yKc3oRbkP
         UbZr4TYM8ReB4v2IJO47PSXjLp7eHBAxwICTKCUuy4KjjtoqF5Qfxx84neqXyGe4QFYj
         ETJU/4fScqPZNwYrYvtHvIcC1WWckO6oi50WW5cufPGswstzgMJ97O1NrRJLqkE15FRE
         0hED5Qqn5Fvphk34SFgSzzUCY25bturtthdfMC3wYtNhce+g711DumrG1sx7Yvey7C9Y
         Oklg==
X-Forwarded-Encrypted: i=1; AJvYcCW1h+XfcuGjPbSuUQc4MAhNgx6BwrgiHZeg7jZy1L6XPXjvMprQYZGRppAWphBktEG7WHdF2ugV/wPNvkxcpxWssqm2@vger.kernel.org, AJvYcCXJ0cfHxcSa7bmxjZuS39S0QHPRLQrA+DFjm0Hiu2LYZYL0JTq+6v0DEOpvZDZVJ14d0u4yex1gXTmJ/GA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUIOUgbhQMzPSytIA3jAPVp1GeUI1BOO4eT/nr4gcS5sF2Obj/
	7TwKMG3w1owRfEbuCD5GQe1a+XYR7Ay7YCgQhSgPHMfhgeGcChZP
X-Google-Smtp-Source: AGHT+IE7nNRhO1v4BqYlPdXQ15r7kg6MiuZWEdjs4cv7Aqqwz3KeTt2GJhqvRkBUeMXyHYHxZ/7jlw==
X-Received: by 2002:a05:6a21:a247:b0:1cf:4da0:d95c with SMTP id adf61e73a8af0-1d30ca206e0mr14258710637.23.1727063990988;
        Sun, 22 Sep 2024 20:59:50 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db4990cebbsm14571877a12.37.2024.09.22.20.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 20:59:50 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Hide a extra entry in stack trace
Date: Mon, 23 Sep 2024 12:59:15 +0900
Message-ID: <20240923035916.6567-1-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A extra entry is shown on stack trace(CONFIG_UNWINDER_ORC=y).

    [003] .....   110.171589: vfs_write <-__x64_sys_write
    [003] .....   110.171600: <stack trace>
 => XXXXXXXXX (Wrong function name)
 => vfs_write
 => __x64_sys_write
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

To resolve this, increment skip in __ftrace_trace_stack().
The reason why skip is incremented in __ftrace_trace_stack()
is because __ftrace_trace_stack() in stack trace is the only function
that wasn't skipped from anywhere.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3b2c7dfadef..e0d98621ff23 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2919,6 +2919,8 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
 #ifndef CONFIG_UNWINDER_ORC
 	if (!regs)
 		skip++;
+#else
+	skip++;
 #endif
 
 	preempt_disable_notrace();
-- 
2.46.1

