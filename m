Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC61C2E;
	Wed,  2 Oct 2024 05:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727846193; cv=none; b=h/yqkmri3CwxBBRF/hv30WCQVK/t2TiOvCMgegOdZQv9x9erMGoSbh2aCYXf72b2Ew6pEdquOd6icDG4TEz2HmoUZIopqAv4pYwUqnFr+S0MJ5X7/+P8HfuQQHy0itsYU+ddEooL4inE4e+yweowJLBMRJV7GakuqG7Ss8jT9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727846193; c=relaxed/simple;
	bh=POqbTVQkBfyYouV2OWpajfzUVSx7N7+PG1c3MgO3rVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gf1AzUkuVNxiwrSoD2acgJbIYLacb65QrQfARudcBuwk5CFi9YFr9tzA868rIbk9AlsbGIqxZw0TzAlU9gpIhUXiZ/Fx6JffiUFeQujr/tBEuvj6MxONZgkqqwZjAmd6AvbHL/iGHi4k2QAHsyBhaJUc/ZZ6DXOZxjMio+9x06A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPMrn/wZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPMrn/wZ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e06f5d4bc7so5335518a91.2;
        Tue, 01 Oct 2024 22:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727846191; x=1728450991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WCqeEc4kHjJN+qKJxeRl8YtHyO81TTDTeJh40XSBpyw=;
        b=dPMrn/wZ3SoTGkAQ0uUurAaXsnwkjjeDGqoiFY9L5TrOgITlw/3oW9bxtx6fb9U9q/
         /wcqe7LgqqK4n5VuOIK9L4+OfR/UzyN4Uv/zVMFGGfs+jm6HNr6bim4kG0cFnoK/QSh/
         rhEjD75UyVukekSY9aanAOxcqtf6W6SGHzCGhplNxZZT2d3h3oR9FPHl/XVXYfBiAxcM
         REHUbP3zdPzuKQb4kDDrYfRYSJngwPo34rO7J0AVMP+8l+njrn0SD51KEcyv64vBb6ui
         dmZkFnRJJsuOL2PvGNtf3EA9fOKrMXLD/vyTAow4WrHK9dZg4mSayDRK1zqd7/iLxORd
         +PhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727846191; x=1728450991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WCqeEc4kHjJN+qKJxeRl8YtHyO81TTDTeJh40XSBpyw=;
        b=gmnOolEl24PdUYidFgqbjk8AFQhSAyrg065LFb2wMG4c/dz7YQHEOpX2zUO4rbMsiH
         HDBZ9jtyR/0Wa5vi3OeX9Ua+5iXKCqK2qOM39qWiWQvGjwM8DMObR88CywLwO2zx1iDm
         Kj51YOtPpCEsFXUvp3JS/N3nXVTJLu2b2Irk01+wOZbRMxIZ0lR/TFlWlqQ2q9q3Crv8
         D90u/hYiPgqdC5SikTDeNWhTZXCR8YFzabL1YVMA+W23ufnYibv0O4syhdnkbREq+NVY
         zMVy7S/1b4ySp7wgs+8F9JVQvyJ/+6TX1jpZhsuh6rjggRXfFsZzkKXulJq5EPSo016g
         YL0w==
X-Forwarded-Encrypted: i=1; AJvYcCVh/QaJazWt+DC3d92OODScWOAuh6ucGjPi6H18zNATbsVOP4cX+cHQa9lpdZPVlqIx6TOnHhR/IAIp54o=@vger.kernel.org, AJvYcCWlRg34BoX+8l2yehCFcpYkkVEa2MWXTvX8LKEEGNdk6PJFwwk/AY6+4aYU6zxBJC5JPxCjZ6ZH8HK1zgOfxn8ObGrk@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhi9thVOT3jedgorcNLYRbJ9k5g/M5sb5LxfKZcW38puk2y6l
	qcMWsJOdy2q06i9zyamU4ehsAnbfkx0DXvv6IeqOne3XhKSq8GiIfdnbh59P
X-Google-Smtp-Source: AGHT+IFW70BLwEBHPfhDcV07fv7397/t7EEbzfh7xCzuTU0inUzEF9f5/ZQ3vLoVFTQAZJmkYCfxZw==
X-Received: by 2002:a17:90b:b06:b0:2c9:9f50:3f9d with SMTP id 98e67ed59e1d1-2e18452703emr2849392a91.5.1727846190818;
        Tue, 01 Oct 2024 22:16:30 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f799b60sm624405a91.29.2024.10.01.22.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 22:16:30 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] ftrace: Hide a extra entry in stack trace
Date: Wed,  2 Oct 2024 14:13:48 +0900
Message-ID: <20241002051347.4239-3-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.46.2
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
=> ksys_write
=> do_syscall_64
=> entry_SYSCALL_64_after_hwframe

To resolve this, increment skip for __ftrace_trace_stack() in
function_stack_trace_call().
The reason why skip is incremented for __ftrace_trace_stack()
is because __ftrace_trace_stack() in stack trace is the only function
that wasn't skipped from anywhere.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
V2 -> V3: Changed the place to increment skip number
V1 -> V2: Fixed redundant code

 kernel/trace/trace_functions.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 3b0cea37e029..27089d8e65d4 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -203,23 +203,21 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	ftrace_test_recursion_unlock(bit);
 }
 
-#ifdef CONFIG_UNWINDER_ORC
-/*
- * Skip 2:
- *
- *   function_stack_trace_call()
- *   ftrace_call()
- */
-#define STACK_SKIP 2
-#else
 /*
  * Skip 3:
- *   __trace_stack()
- *   function_stack_trace_call()
- *   ftrace_call()
+ *   Skipped functions if CONFIG_UNWINDER_ORC is defined
+ *
+ *     __ftrace_trace_stack()
+ *     function_stack_trace_call()
+ *     ftrace_call()
+ *
+ *   Otherwise
+ *
+ *     __trace_stack()
+ *     function_stack_trace_call()
+ *     ftrace_call()
  */
 #define STACK_SKIP 3
-#endif
 
 static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
-- 
2.46.2

