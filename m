Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D8F3845A4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 07:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610446; cv=none; b=MM+v75cEB4CSZKryZBWqIW6LrNZ+CAFslQQ8guTzcJ1A4oZTi2KS14jkQy8TgQsYwGPh4xCgNJPt09H+ey6GA1WBTu+qaIORi11qeegpTIH8rwnIym1O3bRt+iaBSq0QKJVGaslt6U/7fdccix/T0GNK0OinmX6dbOtK1EWpSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610446; c=relaxed/simple;
	bh=yRckoB6ziQPF5Ej6okVCmWtfBamAAg/Ab3cCVaNmIik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KTjpnEHoJILj+Z/1r1Au3QxBEfTmtC9YqobtOnh2yBPBYerrgfs20JyFjp4IE7+7fHC7sIIereSsFxjz6jO48t8S3JmMcD6VOfYlCLYdjmK2GUmR5SzSbVMpXBx4oKW1MOURbzToylsHMb4NIz9QsIQzgWxr4CqkbOIqkruD4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=krmqqgLa; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="krmqqgLa"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3598c1ad542so1894591a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Mar 2026 23:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610443; x=1773215243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGWcCR+A6EXMnTgGJ2S1pAkRxkB7eLQpaJpcDvBiZQI=;
        b=krmqqgLaCZhCaQJ0k4ERQr6GLZ4KxeBTBkLWQMzVlct/O25x3zM1mckQR2ArVfMgLj
         AIkqg3Xx3fYV8T6VyO+XIPgx5Egs6FeIpw/QoAtpMiwCUs+SLWNyEIXzSN/5r0QpMHSL
         FmOdk2QhWc8R3EjJQJbdD94aBX95IRtMRpFlHbVWajJNhIP9LqvLyxhwewR1B4G4aJ0G
         96F4sJeAoCoWT0Fig9PWI6D7BH96wyMAYiwjcpubUXJAWM8AQcVKqeh3SHImYrS4kwzl
         kIBK7Z2dsS8i03BuL5RXOsYBC4PYnuYz5koK6CzqZArT4Pc+1f8C9yuyMiz/MWi87TiN
         w6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610443; x=1773215243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGWcCR+A6EXMnTgGJ2S1pAkRxkB7eLQpaJpcDvBiZQI=;
        b=f8wBPsfB8gujB49LVGByCa+wzGcXirmo4IrobeS/Sw54XxcMdceGhPhtAwFOjhJzl5
         fG1dR/7URWmC45AG4en9BQoGzXbU82VTnz3mJgV8pb/gO20Up/rO1fi10yF/LhC86+ZZ
         px8OnFUu+fSfHoDiKZhaRhdyKhxaxD+RGhy4323UvThGBmiALxEAoHmo743bvEaRbqea
         QdW6vd9DIyQlShDhZMRNN6+RrEluNci4xJ9lHh5ARrJMgj13ha+qVrNUEMMNcuE/wvoB
         6HUI6AyQ0gtv5Ptg3/p9vtjZaRs0ZZBhixnqRU6lUltMcdA9+Kb+ks52ODrpDI+5oa4t
         eSgA==
X-Forwarded-Encrypted: i=1; AJvYcCUGnmN1Vg4CbI/wt03GCLPn2hl5req7RH2vjRAzTB/eHexCy4IfZqI6JmnYKuGL8kl3BxbjU2Q/6fuLittyoR3O2RA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VcCa/PeyTmAbPdw18xi1dtuDY+C2M6RWdfDQI6vtdpaGtA5M
	Z2FmJzM0tQSPDIZB3hcAYFvaJ3ru7nH9U1Zikp4trDcYheVruOe4k8ta
X-Gm-Gg: ATEYQzwk5JNXw0tpxWKKmOOshdS48T1rdV5+4gKbOZrlMKsaA0V22wrDOXkhSjww0ZY
	lUR+0rKrS3VC0+ZtTp4aI7n+msp1/tiRULL3EcvrXvqY6btGSV0qDmKbrcfobIEQobPT0dvJlGK
	DwKl0izDtkaG9TJEK++UA4EFYVjaMMOkfQqoYdt5GwKCKf5T5bq7hb0k0TVtIv/31zmnHOuI6/p
	EQOF8tzzRc/a7UYtUtM41+GkyPShyDcgBHFKLRwUCm/cmptY0IXz8PP0FLJ90J3YVeHGv4y+gUU
	XMY4ABhvLK2JN7r7YYmSFuHUAUGPTeoo5A3fhVCN6z8WHqfx77NqqeIaC1hiMAiQ0/gEIkTdYaI
	8gHY2viTJXVvmPLzRpXh3CxoZmRPRJdNeiPPEQt+ejg7zJvVT3DuKUQw5Z/+g0w1vj2QWDGFEc0
	zUaJGXbHwnDNiDPpEf7JFk/b/3ZKuIw135Ciia3e3PrSqwxctvKNNi+VqcBJnNdA==
X-Received: by 2002:a17:90b:390e:b0:336:9dcf:ed14 with SMTP id 98e67ed59e1d1-359a6a531e6mr1125726a91.23.1772610442466;
        Tue, 03 Mar 2026 23:47:22 -0800 (PST)
Received: from localhost.localdomain ([2409:891f:1ba6:a29e:d73:6202:f71f:51b0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c39def7sm4352078a91.12.2026.03.03.23.47.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 23:47:21 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH 0/2] disable optimistic spinning for ftrace_lock
Date: Wed,  4 Mar 2026 15:46:48 +0800
Message-ID: <20260304074650.58165-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
==========

One of our latency-sensitive services reported random CPU %sys spikes.
After a thorough investigation, we finally identified the root cause of the
CPU %sys spikes. The key kernel stacks are as follows:

- Task A

2026-02-14-16:53:40.938243: [CPU198] 2156302(bpftrace) cgrp:4019437 pod:4019253

        find_kallsyms_symbol+142
        module_address_lookup+104
        kallsyms_lookup_buildid+203
        kallsyms_lookup+20
        print_rec+64
        t_show+67
        seq_read_iter+709
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

This task (2156302, bpftrace) is reading the
/sys/kernel/debug/tracing/available_filter_functions to check if a function
is traceable:

  https://github.com/bpftrace/bpftrace/blob/master/src/tracefs/tracefs.h#L21

Reading the available_filter_functions file is time-consuming, as it
contains tens of thousands of functions:

  $ cat /sys/kernel/debug/tracing/available_filter_functions | wc -l
  61081

  $ time cat /sys/kernel/debug/tracing/available_filter_functions > /dev/null

  real    0m0.452s
  user    0m0.000s
  sys     0m0.452s

Consequently, the ftrace_lock is held by this task for an extended period.

- Other Tasks

2026-02-14-16:53:41.437094: [CPU79] 2156308(bpftrace) cgrp:4019437 pod:4019253

        mutex_spin_on_owner+108
        __mutex_lock.constprop.0+1132
        __mutex_lock_slowpath+19
        mutex_lock+56
        t_start+51
        seq_read_iter+250
        seq_read+165
        vfs_read+165
        ksys_read+103
        __x64_sys_read+25
        do_syscall_64+56
        entry_SYSCALL_64_after_hwframe+100

Since ftrace_lock is held by Task-A and Task-A is actively running on a
CPU, all other tasks waiting for the same lock will spin on their
respective CPUs. This leads to increased CPU pressure.

Reproduction
============

This issue can be reproduced simply by running
`cat available_filter_functions`.

- Single process reading available_filter_functions:

  $ time cat /sys/kernel/tracing/available_filter_functions > /dev/null

  real    0m0.452s
  user    0m0.001s
  sys     0m0.451s

- Six processes reading available_filter_functions simultaneously:

  for i in `seq 0 5`; do
    time cat /sys/kernel/tracing/available_filter_functions > /dev/null &
  done

  The results are as follows:

  real    0m1.801s
  user    0m0.000s
  sys     0m1.779s

  real    0m1.804s
  user    0m0.001s
  sys     0m1.791s

  real    0m1.805s
  user    0m0.000s
  sys     0m1.792s

  real    0m1.806s
  user    0m0.001s
  sys     0m1.796s

  As more processes are added, the system time increases correspondingly.

Solution
========

One approach is to optimize the reading of available_filter_functions to
make it as fast as possible. However, the risk lies in the contention
caused by optimistic spin locking.

Therefore, we need to consider an alternative solution that avoids
optimistic spinning for heavy mutexes that may be held for long durations.
Note that we do not want to disable CONFIG_MUTEX_SPIN_ON_OWNER entirely, as
that could lead to unexpected performance regressions.

In this patch, a new wrapper mutex_lock_nospin() is used for ftrace_lock to
selectively disable optimistic spinning.

Yafang Shao (2):
  locking: add mutex_lock_nospin()
  ftrace: disable optimistic spinning for ftrace_lock

 include/linux/mutex.h  |  3 +++
 kernel/locking/mutex.c | 39 +++++++++++++++++++++++++------
 kernel/trace/ftrace.c  | 52 +++++++++++++++++++++---------------------
 3 files changed, 61 insertions(+), 33 deletions(-)

-- 
2.47.3

