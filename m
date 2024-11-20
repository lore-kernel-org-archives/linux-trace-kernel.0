Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A277F5FEED;
	Wed, 20 Nov 2024 05:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732080510; cv=none; b=Zj+XyU20lCgtTbClEYzecbqTdOX+WVSwFlGiNMHHBcdFNuwmXNInd0ZFHhqnzCDDz2vDgtVm5ehJ/QknhJFkX3qBYJwfGuuVKPt804TkiQyMV/qxLML63qmNiPtxuAFqGh6jr/tNY5qR32L/+61kzXvyZINieTumYr9Vq7AqyO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732080510; c=relaxed/simple;
	bh=g0ABFwOfv9Z7uMkw/fLb/Ss/HrjR6pHmCv9cOLP63oE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jzl+oi8t6DGkRUHQoiHcLgY1rgycnhte9fTL4/bMvFEQTuPmgY3ZjohzyZhPU1PEYU2ndV8Mn+/fGFoNqenSfIvB6bGmjp1G4gj9ColJLuTfdsWGBi7tzGGXKb3FwzWpuxpgOEW18TfCB/WFe9JREe9qfTT87yq9flMBxEg1xRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMlFzVea; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMlFzVea"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e79f73aaeso1359254b3a.3;
        Tue, 19 Nov 2024 21:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732080508; x=1732685308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEt8x8uA6QY5zfb3wIyIwmAeiyil3XO7lOS3kdlD814=;
        b=CMlFzVeaOzm5R428tQtpSuHczHperuYaQYCXWmxoT7cxedQlKGgnJO15kZ5Ovml3Fd
         iD7gUMALDOqdyasSXTxaVivdPewTcQSRlbd3m6rgyYeJVvRVQgirVbWiBBDRLLGrO0rr
         MuJHBu0s+iC+H1Qcbd7caOh2xPRw2Rg/L4tJynTMvHskO16WZGNG5+LOVq6tpAtacrDE
         aagRUxaYc1m0tKUhe3uMsM5Ww76AVkfzN9PiOEKXWx16GtJhPMq7TS/GFHOyU+Z4YzG5
         MLJ1UJ9bl8/LJnd+sNr8d3FP7sClR6ymktSqeJfvL7bHwkHSQvbi1fsFNZ2Yc7LfYnyM
         yD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732080508; x=1732685308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AEt8x8uA6QY5zfb3wIyIwmAeiyil3XO7lOS3kdlD814=;
        b=IbKptmICfE9BE5BDEf8IjJahZm8L67xGxFyW651qPSjmP9VzoIqOHklaGcdcdWZPLr
         Zb6Y2KP6xjwr/QmB5vuElpSXC94giVibfms6oEM3V7mQGe1KlQJcppFwzSIeDTsqV6jb
         Dk93M5oOHwS3VuO13Y/ZS55PCBuDfYld5WZNW16AUAUdnaiszkjXwTi6P/e9BpkNyh9n
         OQEX/7sfO0lZTXPvEx62Au1wY5CtRJFT+qrqC/5PWWmxPOBxeXcm4+60UIUqIq2JgFv+
         xPL4TLOAZhsF9DSmjhM7nfmpY/T9TTfgNUleXV2Q0ZboV5OBW37zXqtbRDFSpTpo1tDn
         En1g==
X-Forwarded-Encrypted: i=1; AJvYcCVyfGccVF8hB9/qnkTjtoXAupA5W+OZYkdPexDm3vt13vy104A6HzbftYqRqRu7mrmfCMiChbqKjrczo4w=@vger.kernel.org, AJvYcCWT0zieanNRAflLncTbRJ67cAs4uOpdf4qTsq4lDTnE4X3Q0ol0WSj5BaVwwFO3jRKWKDumtY8hZ7Ev2HO0RQgOecaL@vger.kernel.org
X-Gm-Message-State: AOJu0YyFaDlvXesMgdKfw2i4Xaje5RYTd/cTKs9XqyvDM+hTUblSLtWd
	wRm+q+pgSbRtveJvBSFO/+1kveDQP8I6AjknpVMrqqquA8Fsz5kC
X-Gm-Gg: ASbGncuZQYc2XxpdkpkvzP6Qj1TIg9Wd9Iz85edNFmIZM19nUB1BhkQXueNXXOCwKMC
	1euQFbqx//wtC3zMfhU3UvUiK33r8WhOQq0bRPH4s1RXmj7u+MJQ9WWa/ttUE2fkrepPFgjzryf
	6xzWVo+vBxoCrzrEPVT6mVMdWxcWxCJJKD3FaQ+Sh3eWYt2Snka4kpFOPxqatBwojQ2nnYEJy5y
	ns2FyexyMO2LJp6R1SM68sacGDJYAz0/lSOUgX45BkCjdjmQtlKHfO2cyNME2pGTTcI8Dkjkg==
X-Google-Smtp-Source: AGHT+IEywVmvgtOyfVoXyz1cQIIh1Ixw+QvBpAoS2cf3h/jfGKgFa9I6ioDr10mqUTIDF5og0JCMBA==
X-Received: by 2002:a05:6a00:1747:b0:71e:7cb2:57e7 with SMTP id d2e1a72fcca58-724beca5143mr1990577b3a.10.1732080506270;
        Tue, 19 Nov 2024 21:28:26 -0800 (PST)
Received: from localhost.localdomain ([36.110.106.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beefea75sm668124b3a.78.2024.11.19.21.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 21:28:25 -0800 (PST)
From: guoweikang <guoweikang.kernel@gmail.com>
To: rostedt@goodmis.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: guoweikang <guoweikang.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Fix regression with module command in stack_trace_filter
Date: Wed, 20 Nov 2024 13:27:49 +0800
Message-Id: <20241120052750.275463-1-guoweikang.kernel@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When executing the following command:

    # echo "write*:mod:ext3" > /sys/kernel/tracing/stack_trace_filter

The current mod command causes a null pointer dereference. While commit
0f17976568b3f ("ftrace: Fix regression with module command in stack_trace_filter")
has addressed part of the issue, it left a corner case unhandled, which still
results in a kernel crash.

Signed-off-by: guoweikang <guoweikang.kernel@gmail.com>
---
 kernel/trace/ftrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 71e53eaba8bc..9b17efb1a87d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5093,6 +5093,9 @@ ftrace_mod_callback(struct trace_array *tr, struct ftrace_hash *hash,
 	char *func;
 	int ret;
 
+	if (!tr)
+		return -ENODEV;
+
 	/* match_records() modifies func, and we need the original */
 	func = kstrdup(func_orig, GFP_KERNEL);
 	if (!func)
-- 
2.25.1

