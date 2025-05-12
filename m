Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EB7258CE6;
	Mon, 12 May 2025 09:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042979; cv=none; b=QVJds+yrOySKXlLh2g4xH9POeaF7B7buktAN9UvHp2eR/sbFn7KBal1IFMEX5L2pZ6uaoI/ffzb1bbRuTB/YlPqAW6Tq3maJF2kzhz2Iewop4AVc1WFaQ1pLixUx1v1USxtRyc6vLNRfOybw4RV15ZKqGKVmJTniHzU06nONVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042979; c=relaxed/simple;
	bh=g87IjcS11qwylOolOjsOCW+6eOD27cPqZIuUzpQR270=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ri9RjjZAcRzWTuVv3WWpuRBmdJNWgz13I8DgSQqMSs6qmJfUlAeLj2ZGhfdr87Vy5zn8v9rK4/xXD7Fm6ama+aoTw328tMWGMdWTxDOLFzQCowC53zekJa95OupwSUvBBDtVzK42StgABL+9luUNY7FO5hp48sOJS+PLRube8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m94etcuu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m94etcuu"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7424c24f88bso2323330b3a.1;
        Mon, 12 May 2025 02:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747042977; x=1747647777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgQZLPEYFrxBxfwuQxF+//qgOVlSrUVg0yL7meN0Cbc=;
        b=m94etcuuckDHer9+dmpR52E1Vq2FTKdfGPgLgympcREOGvQdzwZKJdV7U88jzbsmLu
         v+i/CvHVQhrMOy+ABiwrzslV0rIxpNQqlk1JpItcU2vT0m+n0bsJlUhtf02jC3pljSqs
         aXwXGNpeAvL+YeumoVJ+caXGPXJaB5TzRp3bxpIKMeTIr9rn8+GmDpvHpL47P3AF4oK4
         P3RP30dbuhICKuWkW/zbsuytHlJVtus5ZHODhKg+vj8UJjnp4FHYk9EvfXqmpzHgqiln
         w+lRQ60gGWCvJ3EoRGp5AHUq37fwk1uZEl5tbJpKtHecB1+lO9RDmsSUz2f3IuVZ3Yjp
         BCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747042977; x=1747647777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgQZLPEYFrxBxfwuQxF+//qgOVlSrUVg0yL7meN0Cbc=;
        b=A1rEjWSSLTvUdYe9AWTcO6NMd5AesgKYz/JCUTUstDZY3XHzbb5ZfzrZyRd8+Ncc0D
         vW/J4DdmjVtTjImGd299IMBHCjcJmr8AViIdp3m0EEfwjFqPBaR6oY//Md1jBAIi/JTt
         MQSYCcxYDl0nq73WTQlnik+2jB2BG2r4dFDj60wQJYOmDBnAz+0jfATs5NCsq+MDBK5F
         rphv5q0PVSwc12bTBhYN+3GNx6CQmlVB7F1/QD6H2o4loocoTgsFJ6Jxz64cw6YhzrGE
         C7RKQ8pzbVh+osY+b3r2QsefIKIqYCXE76wRldS1xHmMRkOcldCAb1ZSjcgzRh8Bo/NQ
         UqZg==
X-Forwarded-Encrypted: i=1; AJvYcCVUG2ApwCEc/zG00JoebWBLeJGYH4iPhOPOvLsNTJXOQYS8VGpyxi5vHCKBW6SCrTDx+Xxjx1khpKKs9qbUAkbCVkWb@vger.kernel.org, AJvYcCXSRgmqGvMqeYl7UxkjQTkNRHllm/8CsDkW9eVoJJUjXcBkIwXtnYhjEhcgVq46kJudYMu/hXhzqnjGs8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2CcosEckdZBNcAnGJ4W2f0IKiWnKE8VCSsE4Q2id6ybzIyBuU
	MERekCZUPBDp0hcs0cm4mT5nhjFQuyORRiXTGBCVw4b5A1uKgC7m
X-Gm-Gg: ASbGncti86alQWx3jlNXaNjJr0BK+QL1hiriv+QjxpYsgbKz6Kgkb2wiYTyo2PRMWgP
	agMvwJAOp3AykDKBkzJNcqO9pfxHfyyUIcdIYuI36u2D3CWGwb7aN5wGqY8HSzea+/8WVL/gnea
	I5bp36/SQuohqJgxv9wyLF0mUZXoC9akWCLzPfJBdp9NXHuvqU+lGpqNYjaWUpn1oLXN0E5nIRM
	EwI7+vXohpyjyXYbRzaNJVDm25pye45frIBNi+0mhiY6Qs5Ue9Bib+8XhGqcDz/j1M7jMK4KNer
	d/DtcHuIShBWMjkX26pMYLKdWHfZLly2J3Sw2gTV3w+xXeSCiUqtIitzdd7ZBut0Girc
X-Google-Smtp-Source: AGHT+IHOjl/ffuOFZtsaSbrXiX7Leg58u7j0tG1e3j1yyGmKl9g0bqXijIqXBUQTQKMXqfGZ+ORsKA==
X-Received: by 2002:a05:6a00:ad0e:b0:741:b3e2:6351 with SMTP id d2e1a72fcca58-7423bc5238fmr18255978b3a.10.1747042977329;
        Mon, 12 May 2025 02:42:57 -0700 (PDT)
Received: from pengdl-HP.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237703f2asm5649809b3a.35.2025.05.12.02.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:42:56 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>
Subject: [PATCH 2/2] ftrace: Fix preemption acounting for stacktrace filter command
Date: Mon, 12 May 2025 17:42:46 +0800
Message-Id: <20250512094246.1167956-2-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250512094246.1167956-1-dolinux.peng@gmail.com>
References: <20250512094246.1167956-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

While using the stacktrace filter command to trace ksys_read, I noticed
that the preemption count was consistently reported as 1, which seemed
incorrect:

$ echo ksys_read:stacktrace > set_ftrace_filter

   <...>-453     [004] ...1.    38.308956: <stack trace>
=> ksys_read
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

The root cause is that the trace framework disables preemption when
invoking the filter command callback in function_trace_probe_call:

   preempt_disable_notrace();
   probe_ops->func(ip, parent_ip, probe_opsbe->tr, probe_ops, probe->data);
   preempt_enable_notrace();

This patch uses tracing_gen_ctx_dec() to obtain the correct preemption
count within the callback, resulting in accurate reporting:

$ echo ksys_read:stacktrace > set_ftrace_filter

   <...>-410     [006] .....    31.420396: <stack trace>
=> ksys_read
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/trace/trace_functions.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 98ccf3f00c51..4e37a0f6aaa3 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -633,11 +633,7 @@ ftrace_traceoff(unsigned long ip, unsigned long parent_ip,
 
 static __always_inline void trace_stack(struct trace_array *tr)
 {
-	unsigned int trace_ctx;
-
-	trace_ctx = tracing_gen_ctx();
-
-	__trace_stack(tr, trace_ctx, FTRACE_STACK_SKIP);
+	__trace_stack(tr, tracing_gen_ctx_dec(), FTRACE_STACK_SKIP);
 }
 
 static void
-- 
2.25.1

