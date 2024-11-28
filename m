Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA422199385;
	Thu, 28 Nov 2024 11:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732794807; cv=none; b=i1Psannum+mdlNMdRCWKO+OLLcViIrH3IzQP9/fO9K15RMmagmPJlCgEOfdWPjgRsC/MeX/RW0dUOlE6jpeGdDHMkXqbnPioCDk8p8wiuZaThfJ5SEsdKXhNLpCO9kAebboV1ujwValNVe1PcJ/Tr8LBl7S4PHZjcac94m4E3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732794807; c=relaxed/simple;
	bh=Q+5aXLju2qGji4g7hO+AvJweB4OhUwScEYcBQk7lGLU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iqoDOZ/1kRBi22s2YFBUXVbfkGC9525BWiHw8XGHabXU3aygACqFxPPO/yXd2QSwhJD8MCYmt8/gS/KiLPV0uC3U8kp4dgXOiUqbQnkTy18e/v+EheqYQs3u2/OGPHPG04NtGJgDLwt+CkV7YkyVyjggWQkx1BQ3irSAZPrGntc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhnqdpjw; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhnqdpjw"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-214d1c6d724so6063575ad.3;
        Thu, 28 Nov 2024 03:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732794805; x=1733399605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eaqF1as5WDhovn3U6THZoOBRpS96MOnByr8G/+D/WuQ=;
        b=jhnqdpjwjjOXO2q90IsBLE9Dj3l8IoanN9j3ek8TmUO3cbpWNz+ASkUC1SGsOPSSZC
         QmJa1yaBKRKkG7cwqAOwkNGgQY4D+R1NkHmhiDpr4+e3CAaFPvx2onEhalGHdP5Vc8+A
         KK0cvzgt787OdcAhSt4TjkDJCRHi6xzFm+ztrpF2kJ+atSI+UhVLoPvT16ajgb6nLqf0
         GyZathJ8pgegkSmNFspNICMw81+Q1fjPw0GVAmMHanSB42Mhr3R7DV+rzZcYPUQbKKW9
         S38Xiuc7C7AEo21r9prc5yVz11q9Ns8KygqA3yZQf5AEExNh2r1ULoTk54XPNz8muS9x
         nZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732794805; x=1733399605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eaqF1as5WDhovn3U6THZoOBRpS96MOnByr8G/+D/WuQ=;
        b=e5CCwKPehv1MLdIg/oiHiSttBxfmHwIxD7iuCCByTdt6lErEzAuzwrC6ME+s777O+W
         Wp3cwRuyGixiCDtnjnSrp17wX5fpbWrrBD9udy3MvTXTiDZ2Nq9XWN9WW1WB0QRrFeTf
         1pffrC92P8S9MWdLyDeEtLNmUAGW5Gpdldms1te5K2+ZUGD4/tdxiKnNQuBiiFlO4rF7
         TFoYlvPEJDhFE3Wf4BDME99ivwmCwjBiaLEvJdqSfTcIesiCQZZuyZvu5l2qa3eo+L5O
         Gcw85Y5wTILlrrpG7L1zFFzrOqwvwwCIDn8zi+FXl+R2wuWT9jTSdP3dlguUd+Fkltgt
         VcIQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1Po/u2oxaAZjxRW6fE/13UMCcohgPZzgFmvn5Khnr/u0sBpH1dXmO2EYdrMtCdbwnayVszPjtH8cpXztG2REQdC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxfoWdFuTbdFMV/Dh+Z8QPF1OdbHoK1Oi+nR9Hwn1DXAejRP5R
	GB4J5tiblCgJGfy9RlD7I9qbpAnGIsGf5ar2DGTqD9jIl+Ym6X/l
X-Gm-Gg: ASbGncsdEGiwCpz2oPuGpvv7VpV13ECemRRxRFV+wlatJfH6BS/yjUQ4NyuN6w1Hshq
	o2mOPkgTD3fS4ZWehiTKCCMHS4sLxG+lzVF0lI87+VZRdvEwFMlRxNQ7GgJz40bXA4ki+uaC9BU
	KLabodLwlND+RidmnQYR+q1YFDDZankI7e58MFhRlEw+Q1nxbBdokn7f68hGSfmu96lmnMGLi7n
	nbpCVYkSElRHHMMd57ayMg2gItTY0h1vcZ8zaTD/uJKFbv10w==
X-Google-Smtp-Source: AGHT+IHRrXKX8nlMrAcW/oga2ynDRlgfR/zKtBUNbzMY9BA+HKjIHb6lhyDr0m+Ag03La2BxEGv39A==
X-Received: by 2002:a17:903:244a:b0:20c:9ec9:9a77 with SMTP id d9443c01a7336-21501c5ff2cmr70779075ad.37.1732794804860;
        Thu, 28 Nov 2024 03:53:24 -0800 (PST)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21530753d15sm4843125ad.52.2024.11.28.03.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 03:53:24 -0800 (PST)
From: Tao Chen <chen.dylane@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	chen.dylane@gmail.com
Subject: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
Date: Thu, 28 Nov 2024 19:53:19 +0800
Message-Id: <20241128115319.305523-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, x86_64 kernel not support to trace syscall for ia32 syscall.
As a result, there is no any trace output when tracing a ia32 task.
Like unreg_event_syscall_enter, add a WARN_ON_ONCE judgment for
syscall_nr in perf_syscall_enter and ftrace_syscall_enter to give
some message.

 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>

 int main(void)
 {
	int ret = open("tmp.txt", 0);
	return 0;
 }

gcc -m32 open32 open.c
echo 1 > /sys/kernel/debug/tracing/events/syscalls/sys_enter_open/enable
./open32

[  109.214595] ------------[ cut here ]------------
[  109.215625] WARNING: CPU: 0 PID: 170 at
kernel/trace/trace_syscalls.c:304 ftrace_syscall_enter+0x55/0x1c0
[  109.217111] Modules linked in:
[  109.218190] CPU: 0 UID: 0 PID: 170 Comm: open32 Not tainted
6.12.0-rc4-virtme #10]

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 kernel/trace/trace_syscalls.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 785733245ead..19c3335e7d84 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -300,7 +300,7 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
 	int size;
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
+	if (WARN_ON_ONCE(syscall_nr < 0 || syscall_nr >= NR_syscalls))
 		return;
 
 	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE) */
@@ -339,7 +339,7 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
 	int syscall_nr;
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
+	if (WARN_ON_ONCE(syscall_nr < 0 || syscall_nr >= NR_syscalls))
 		return;
 
 	/* Here we're inside tp handler's rcu_read_lock_sched (__DO_TRACE()) */
@@ -585,7 +585,7 @@ static void perf_syscall_enter(void *ignore, struct pt_regs *regs, long id)
 	int size;
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
+	if (WARN_ON_ONCE(syscall_nr < 0 || syscall_nr >= NR_syscalls))
 		return;
 	if (!test_bit(syscall_nr, enabled_perf_enter_syscalls))
 		return;
@@ -687,7 +687,7 @@ static void perf_syscall_exit(void *ignore, struct pt_regs *regs, long ret)
 	int size;
 
 	syscall_nr = trace_get_syscall_nr(current, regs);
-	if (syscall_nr < 0 || syscall_nr >= NR_syscalls)
+	if (WARN_ON_ONCE(syscall_nr < 0 || syscall_nr >= NR_syscalls))
 		return;
 	if (!test_bit(syscall_nr, enabled_perf_exit_syscalls))
 		return;
-- 
2.43.0

