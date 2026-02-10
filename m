Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6472EC09B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737951; cv=none; b=tdmquB/trmrQEa6LDESCcExCdk0w4MA1vKdFY1AaLSHLGQgJlbsBa6sHio+P6LpoZfExyHfpwP+jIQ4TAX/F2lFP2bc2RgYVk1YmtBmJvMiDTty71edtdbJGjzR+zp37SH675dp/MJHwWP3t+hDeGv01ahI6kuDjVCUofG9dacs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737951; c=relaxed/simple;
	bh=CbDTDq8IiPhqMJ3H/nKyYlg7mfNAlGOPDEH1nMBSPcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cj6cjsGbwI+Liaky5ayj3YaIGySsangfZYSO7frQzcnpxE7LLHHNfWaI4c4WfOMj+RzwtNCD3E32/OjBWT0/GZj1grkdr+UibstTGcJGR7GR4cI9HJE/W4MUc/0m0ciKV4J2tuawkpKPVaTiQQ6ox7ulPfKHszkW/5bUTpqfBaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HItzFTpY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HItzFTpY"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-823c56765fdso545179b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770737948; x=1771342748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBkYum8SYSh4Va9P3EMS/6EJPSJtNBojrua2eI9xgyg=;
        b=HItzFTpYKFn3JDqRbGXE3oylPcFxHi6eDxtwdoRg/08EvudWeI+RJy+QzDeZtjp4ea
         WYOlPiqqbu2CxBXknzBxyvwbDUcPht4mDk6sraDIFfJWcFQG2xWiG9r0HcORJCfHWWUX
         +QNsfvsSwUpd9a2I/DH/YqgRmxVLOJj/nrWakEVHMbtngtEOUuYntqNrCGN1v6j7h82f
         9uJuDlCWrGWF0P6wbe8fJZTTaH/9PeakJUviu8z4cT+b3XFpskji7xzDmXIj/Jn2HMMJ
         MMfB9rfMb84qEM6i2wwKgbvta251lNrZMfI7hePHlTiSoyI0iq3uBHRVnBch+SR2hEzY
         d/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770737948; x=1771342748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBkYum8SYSh4Va9P3EMS/6EJPSJtNBojrua2eI9xgyg=;
        b=jeYxDwbQCQH3ZS2QTAqaFO/R3Xop0jgcpEooaKH53f2ouObjOCp0Z5J+oESkixRIyJ
         F6jGEVF8hAjnvbmfnoJhBEq6wqUCyvaHgjZwSUpv5LXLqHCaI0P82BPi2LU9E9/5Cu11
         VYBmsxmXE+7k1n05DyliYBuZxScnzzXa8XGlb4ipStnTJ6hoinNwNaLVbymbCFB3VDOj
         3lkvSwErM/vlv0mq5LOM3ifKpih8v1NjciEgXwXCvVaKX8Uh2eq/dfh79iEAxtzMZIYq
         bizaSwv1GAnXvrCO7CLgOy7gaLFrWJANigiJgKc7GTWGekLbswrG1O7SwP1QbmWsuhtU
         Xmww==
X-Forwarded-Encrypted: i=1; AJvYcCWLP8twwEf6Z+uUQwfCKtJLcuXGyEFYtDySEI8M4AHn4kS7gtFTftQ4D31+WdEpfPc9dGyd+CatEppqafdflPAfIrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHcJFkzPi/JfQju7F4kFL2PG6uu6Wm3b1n46YB4q9KJUcOmmXO
	QaorLyg4MWIrdEP4LX/JM0E4S70tpmdWYjYT6TwFUpUR6XouDt0vb7VA
X-Gm-Gg: AZuq6aJLnVxU1KWK4b9v5tCDDBtBV5hEUMkFf+MPtRQR2ALbH5p+gCfvM2w1xBngibl
	jLXiSrpb0cwpwBSIT3gv2SP+P/rT7EfDrpeAIPKc08BNA2eRVzqDODqLibnFqWF58fHZn+tvWzC
	7+h3Atk5vn36nqzSOcnKXogBTvWANCFGZOQJOxtedpYNuHrRE86EITV0Q5d3CKWcqK/OKnsV/Rn
	3KyNtr4YYq5KRcCsxubWmeOqrcL2RnoZNeC15WFOS905hBkqzj/detj7v4mfH8/lfeoTlCWDOn1
	fv8tQzQOnzblFqwTy9HLiBPVKZT817fF13CGODwKY5ajr7fPn6FJR2ftiwotxPoi9faEdUE14Tm
	DZaico7SkJHg14KA6QmKbAUHh20DD8+ZPGeYzV7xUJWvl5Oy5KcSiYCMIHqIjNU2RYK0mbCK8lT
	0e0wmlkvhMJkM+l8plLKVa7LIrOqg6pIdLrn2+LKcx
X-Received: by 2002:a05:6a00:348d:b0:81b:d5d9:a83a with SMTP id d2e1a72fcca58-824417a9d64mr14705784b3a.61.1770737947982;
        Tue, 10 Feb 2026 07:39:07 -0800 (PST)
Received: from russ.ust.hk (wf121-083.ust.hk. [175.159.121.83])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418a8139sm13376290b3a.46.2026.02.10.07.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 07:39:07 -0800 (PST)
From: Haoyang LIU <tttturtleruss@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Cc: tttturtleruss@gmail.com,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-trace-kernel@vger.kernel.org (open list:TRACING)
Subject: [PATCH] tracing: Fix indentation of return statement in print_trace_fmt()
Date: Tue, 10 Feb 2026 23:39:02 +0800
Message-Id: <20260210153903.8041-1-tttturtleruss@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return statement inside the nested if block in print_trace_fmt()
is not properly indented, making the code structure unclear. This was
flagged by smatch as a warning.

Add proper indentation to the return statement to match the kernel
coding style and improve readability.

Signed-off-by: Haoyang LIU <tttturtleruss@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8bd4ec08fb36..bf0ce2aac177 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4286,7 +4286,7 @@ static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
 			/* ftrace and system call events are still OK */
 			if ((event->type > __TRACE_LAST_TYPE) &&
 			    !is_syscall_event(event))
-			return print_event_fields(iter, event);
+				return print_event_fields(iter, event);
 		}
 		return event->funcs->trace(iter, sym_flags, event);
 	}
-- 
2.25.1

