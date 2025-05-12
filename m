Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C048E258CE6;
	Mon, 12 May 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042974; cv=none; b=lL11b94OHyeSFyuV7Ay2V9obdl8BPe4N+8Uf89qXl3Gol3n2jLSM89Ai+JkqlKVu503BRExzTL3koWuuWkKyNhVTH/gDkKqM6mXGj+pBPkt0R6dHaJsPMo6dOAoeKl4VeNnNm5KDYrJ5/ZST3FtMiisSilIn/qi1CmT1cKZgX5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042974; c=relaxed/simple;
	bh=8LASTqAvpEekTiicfwi+mOmYj6T+ZLHwoM/UxVWX0s0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LToz6BXM8S2c1MsIQZxmX64SuxLiWJjMeeaDlno6+gEZchEcp77vvr0aXSI6+opWN3A82vxw24BPHjGRJylHdkcVn3FttKTKBX9h52dUVP8818S+WEfCOlcQLOWdOBdbZO+W1JyAA+ZFZ4iG0KBM7GFVNTz4d+i3H2nM7ul8qtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYDL3UPQ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYDL3UPQ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7426c44e014so492869b3a.3;
        Mon, 12 May 2025 02:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747042972; x=1747647772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtKo/BrEUjpAzcnHm9yhSMQhqU2TQ+B8EC9VEWsvZBc=;
        b=bYDL3UPQxOdimGyVM9EoWBLn2gTV0UltAjp8yzVHrZb+DieHPIoELdgrxp4KkQqyIG
         AtPTY1c0CYPBJ0PXzKLgRGDWlmXIXBMZftMznd/qQqSVFCPlH3M9EWHAJDx2lLgr9uPw
         nHXpQ6EkA1MHr9VHeBFIl4JcxfulbdTDndke4Ef3xqVGjxaI34Qs/WRmiqLYrLcn/1P4
         NBEKBcYJqtripVy/ZiR1LT/bGupx3Upc3P7algf1vpFtQzcWEuxR0xSPyiCz3jhhpWc+
         Cdy5iEYnFjIW2OaGF7mthaupyhH8pOmA7q4bjCdr3AD0G3ejRhXrpClUU2hR3kOq24Eu
         dizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747042972; x=1747647772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtKo/BrEUjpAzcnHm9yhSMQhqU2TQ+B8EC9VEWsvZBc=;
        b=aHNdNdPYd4Ej8xBlxRxkojZQ7DuQbUtggk4Serq+LW3muZiqJsYq4IJCsVZuJSokhV
         3/rYYV3hGVe3Q1L2/BjFrIWPUH3TfB6/nuM8epY0R2vZ1XC/GhO/YxEzzf3Z1QX1C9WL
         7yqxzdz79tT2mplCvoQ0wEm/a727lDbwoYSwRzQ88wg3+Flx1l95kMvoehXsNPWTYR/6
         84JySf5SOWmc8fMpvh3kE2Ic9CYGmb/Sm9YevziG4S4eI6aTb78Cbuozr0XPfHzpSGws
         /lChaUbSOdZ+TUDZ7jrB4rEAi9nxPr7MZ30+T6+zpwxnts+6HrBSU5uZgtBLh2aOi1i2
         /eXw==
X-Forwarded-Encrypted: i=1; AJvYcCU7m8cRzoy2Np+JyhhVtbom4vRERGmMOvcZcR8V0SjVTfMFxLY1R8wELLg/M8yP9lQ1S1bYfCwvgDS9fgI=@vger.kernel.org, AJvYcCWNNxeKypdAYoSClBfs3RLhRQ2uPpTgVtv2siel+OrqDaBM6JUwjSGAMurWcRFrX/6I7SHhH3briTAOf5S7jMsIkLQu@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSDAdBt55pb83btgA02SgqIMlVg1CTlwnTlY05BzEG+GcSZZZ
	/JpWM7/aTpw3SJqllDohOq41W/WdJaYaLFIz+0KXKRNLF4vR+hoC
X-Gm-Gg: ASbGncsMTRZZ+5peAlUkbQaX9ycxkQbTcofiC8Q+pUHhiXJUTBveATS+s9lDIEFsfAJ
	bV5gTY5gxWeXh8+PHk2lPW3NZYquZF2YyThT5jJMel1xn8kNY0QKQZceyWI5DSqsbG+gfbomP+5
	An79LzXzNBJw7pFgmYJW50T+LXC/G0xEWZh93BOmWeLzCEGKDEvuR3uZDpfcoVXRO9XYC51jmSX
	OLK8JZHwNcbT1pV+u17sN8u+6brIlOBixX3QxX0nN/6HXCQvuCJLw6ji9LTv0woH8Dcy+CQO7Ph
	TPH5WB0NwLmixYi1g7syM386UzI+LcymXSxikXEdHA27dIuXknXoQrF85p5Zaq7WDpKy
X-Google-Smtp-Source: AGHT+IGPzYCMf7scDLohrgoy/AafkhLgNaeTVd8pn6YrqynEQa9d5vN6I4UjmrLZnmR2JwFNkwX9KQ==
X-Received: by 2002:a05:6a00:17a7:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-7423bc1d336mr18706592b3a.4.1747042971925;
        Mon, 12 May 2025 02:42:51 -0700 (PDT)
Received: from pengdl-HP.mioffice.cn ([43.224.245.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237703f2asm5649809b3a.35.2025.05.12.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:42:51 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	dolinux.peng@gmai.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>
Subject: [PATCH 1/2] ftrace: Fix preemption acounting for stacktrace trigger command
Date: Mon, 12 May 2025 17:42:45 +0800
Message-Id: <20250512094246.1167956-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

While using the stacktrace trigger command to trace syscalls/sys_enter_read,
I noticed that the preemption count was consistently reported as 1, which seemed
incorrect:

root@ubuntu22-vm:/sys/kernel/tracing/events/syscalls/sys_enter_read
$ echo stacktrace > trigger
$ echo 1 > enable

    sshd-416     [002] .....   232.864910: sys_read(fd: a, buf: 556b1f3221d0, count: 8000)
    sshd-416     [002] ...1.   232.864913: <stack trace>
 => ftrace_syscall_enter
 => syscall_trace_enter
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

The root cause is that the trace framework disables preemption in __DO_TRACE before
invoking the trigger callback.

This patch uses tracing_gen_ctx_dec() to obtain the correct preemption
count within the callback, resulting in accurate reporting:

    sshd-410     [004] .....   210.117660: sys_read(fd: 4, buf: 559b725ba130, count: 40000)
    sshd-410     [004] .....   210.117662: <stack trace>
 => ftrace_syscall_enter
 => syscall_trace_enter
 => do_syscall_64
 => entry_SYSCALL_64_after_hwframe

Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/trace/trace_events_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index b66b6d235d91..6e87ae2a1a66 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1560,7 +1560,7 @@ stacktrace_trigger(struct event_trigger_data *data,
 	struct trace_event_file *file = data->private_data;
 
 	if (file)
-		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+		__trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP);
 	else
 		trace_dump_stack(STACK_SKIP);
 }
-- 
2.25.1

