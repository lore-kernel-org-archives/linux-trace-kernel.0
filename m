Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602721D6DA9;
	Thu,  4 Sep 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756967258; cv=none; b=Zwf7y6fLZcREMg4YvIRlChrwTwPNMhIGX7TPMyhxVJbTfnZTm/DBjc43BN19uYM/1Ok/G+zh+ViA61E62TnzKazoEFFNEJORNdDK+wCgD56F0dApg60elzc9ecsVBCD2ZQkvXa93yHxGeOHTAQUo90ss9l8zP93e6rvIx/nHvp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756967258; c=relaxed/simple;
	bh=qOoQqzPhHA7l7oQFCN5z160cyXP59PoS/2n9Sqlsw0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Df3rQbdv2WW0NVZzC13LARv8rtDBCA6UQW6jaBJ34HcS9IqJojHnMUIVLm0WefIeeRkaS+UZ/6y4iwcJUs/QXQFacShfG7hLWw4lIEy99aVq43062If5+pSCzNUqifwOVa5Lqpdzg6NPrx2boWrOzMst/zxeOQ95+M4z4G5k+KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fx8As2OA; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fx8As2OA"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-24c89867a17so7434205ad.1;
        Wed, 03 Sep 2025 23:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756967256; x=1757572056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qOSN4kCmnmr6woSnWWSU8/9jXudpqtML0uUdQZcKdA=;
        b=fx8As2OAjVmtlXuyJ8HBCrzV+J6/lX4m1tjZUbYenZbQAKATW5YaWmVohXnZySXX1l
         652OQP7fgvNF6NDroATGaiHZjvUyyOJ/XYB4kFmMMcFZjiQZNHAUFQbNIsTiXbp73yGP
         nq6pc+daXZ2jJxcljQWziVTQeBR1kZy1/Vn8swDQyej14uE/VmSXY2ylz2kQomnk9OLN
         TJfO4ef0UEhCQPjZ56vF21O7mpg6u0ihxqc5xBZEpSub9/Vj+ZfZLubvP5ynIVK3wC0m
         c3K40A5mLwtT4v8HsnKAIfl7EBNVAIAZF6Vro3gOy/e9qEjJrzHNdt5fl4/tV9q6XRTD
         S1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756967256; x=1757572056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qOSN4kCmnmr6woSnWWSU8/9jXudpqtML0uUdQZcKdA=;
        b=iscQXJVsGpekG83lWjL86vuVYi39TZbARoVgoC8DuVepXUg9MHeBoWYJYoPfR2dAix
         FhqyiEUDbltCl9ik52AmDnkxi3po54mU5Z/mjSNY/V0TF+NCVQVn3gd48OtOtbFKrxQi
         hR5daF9d9fPtaEQ/PqX/YkWP1kL1Tb2D+NVFSzWIrHVzArNenKKPtPIBcbdKkdNxWQh0
         ugXOkG6115cRgpjVCHSfzOzFxayBGW6i8EsQMbWdDncyIp2JXd2B/sIR3Zkfq/J9ERvq
         /J3Z1M5q2DnmmsC1LPcXjrfHxP76ha20qf6ADpviX4eQ9wDQa1di4Bdhb2XOhLjccwek
         MAWg==
X-Forwarded-Encrypted: i=1; AJvYcCU4BMdIFIQuwNkNppx4wW+WmvEfqCiq5lPWVpYPRVzgGgCujz+rwEhtA11aiF/CSpksnPbpL6K/i9keTipgBm+/TRpM@vger.kernel.org, AJvYcCXi0/b8Ik+yBvYSDRqKo42LSMkYZdjY+H83x7GoEdVQsU/ufSQSwBce4jduVss/JXVy3817sxAcUJuXJpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtHaIDDSZrCqTwllQzF+cqyNSEAbzMAhNjDcopQu1/wlEXA6Hf
	4bZpI+bphiO0rKYHXQLRvLyDENT8ObN8rv8UvfJtXZiB+PO+U64xdxz8
X-Gm-Gg: ASbGnctbzf2ErZ8p5kC8c1vKvLY62EVQeh0aEbm8KpSUOyF4IH9IXUXMa1sxzeFBDsk
	CRakA6MOXtBLGSJBB5cRkyRJj/AEz69uNEqykK0XJxfpQzrUZOni5vyPQzAKdjW2Smj+YHIJ9yH
	Srjri9IWh5jQfibbtBSqPrq2q0IzpJb81kyD/syVJb0cgKgxWlXbeHiQ31+TYo36gwoJT2b8vNM
	U6az/oGFi1dzftv29LTtkopEtVQgWriN+qmIJc8uL7r/1+Ya+NuuTnbxCCCclDsJnKqmjtxHLrx
	B6rYpWCWFXNaVjo1F10/VqD9jXQt3iJgZtS5yeOne34XEYfLTMwc4A9CPXIr5Nc3zOYyTaTHogA
	Z6Tfb5jlmqnn3ecynnjadfSZ3MfgYWdelhA==
X-Google-Smtp-Source: AGHT+IFnwKIjS0BSLTsgBA1i8cQ/1rxTC5iKDDrbTHPxatrjhRdlRWcMwvNS67YAhvCoTCa9DvR4lQ==
X-Received: by 2002:a17:902:ebc9:b0:246:7711:87e with SMTP id d9443c01a7336-249448f3188mr227495115ad.21.1756967255486;
        Wed, 03 Sep 2025 23:27:35 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c7bdfe9edsm48003905ad.141.2025.09.03.23.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 23:27:35 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: fprobe: fix suspicious rcu usage in fprobe_entry
Date: Thu,  4 Sep 2025 14:27:29 +0800
Message-ID: <20250904062729.151931-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rcu_read_lock() is not needed in fprobe_entry, but rcu_dereference_check()
is used in rhltable_lookup(), which causes suspicious RCU usage warning:

  WARNING: suspicious RCU usage
  6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S
  -----------------------------
  include/linux/rhashtable.h:602 suspicious rcu_dereference_check() usage!
  ......
  stack backtrace:
  CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: G S
  Tainted: [S]=CPU_OUT_OF_SPEC, [I]=FIRMWARE_WORKAROUND
  Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.1.1 10/07/2015
  Call Trace:
   <TASK>
   dump_stack_lvl+0x7c/0x90
   lockdep_rcu_suspicious+0x14f/0x1c0
   __rhashtable_lookup+0x1e0/0x260
   ? __pfx_kernel_clone+0x10/0x10
   fprobe_entry+0x9a/0x450
   ? __lock_acquire+0x6b0/0xca0
   ? find_held_lock+0x2b/0x80
   ? __pfx_fprobe_entry+0x10/0x10
   ? __pfx_kernel_clone+0x10/0x10
   ? lock_acquire+0x14c/0x2d0
   ? __might_fault+0x74/0xc0
   function_graph_enter_regs+0x2a0/0x550
   ? __do_sys_clone+0xb5/0x100
   ? __pfx_function_graph_enter_regs+0x10/0x10
   ? _copy_to_user+0x58/0x70
   ? __pfx_kernel_clone+0x10/0x10
   ? __x64_sys_rt_sigprocmask+0x114/0x180
   ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
   ? __pfx_kernel_clone+0x10/0x10
   ftrace_graph_func+0x87/0xb0

As we discussed in [1], fix this by using guard(rcu)() in fprobe_entry()
to protect the rhltable_lookup() and rhl_for_each_entry_rcu() with
rcu_read_lock and suppress this warning.

Link: https://lore.kernel.org/all/20250829021436.19982-1-dongml2@chinatelecom.cn/ [1]
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.com
Fixes: dfe0d675df82 ("tracing: fprobe: use rhltable for fprobe_ip_table")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use guard(rcu)() instead of rcu_read_lock()
---
 kernel/trace/fprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index fb127fa95f21..6a205903b1ed 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -269,6 +269,7 @@ static int fprobe_entry(struct ftrace_graph_ent *trace, struct fgraph_ops *gops,
 	if (WARN_ON_ONCE(!fregs))
 		return 0;
 
+	guard(rcu)();
 	head = rhltable_lookup(&fprobe_ip_table, &func, fprobe_rht_params);
 	reserved_words = 0;
 	rhl_for_each_entry_rcu(node, pos, head, hlist) {
-- 
2.51.0

