Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA14714A85
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718047227; cv=none; b=NkghMTckd+RDLarLD+FMXHnYo9x0mvIJ4jVzi4YH6gwu7ZAEAAPMvwuMTjrAe1MsadYcpjXw+ebLtud+eh0jaroxyxFO1eTU07Xg1YUvgUgxVGS46vdrPyqQg1w9xTAujjAm/RBVQ9Zuydpg0Gxw9NP3R6uqRaaFYc57/vfna9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718047227; c=relaxed/simple;
	bh=y6UMp+m9utYZgleNENyTjU9jhHksT+GMIMx/yKH2WLk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KLPbWo+71rlNcDTtQjloXzaPnM/5kSGbtKH93ps3OAwIygI5D6M80qjZMOb3KpVuSiP4CSXnGEXoSGjibFG67ACcEKLr2wLipgm+VHObPmmLIe7vsUJzrmXh65DKCz7PAIZsaYMdGFwy7pa9bie5dMPNZ6f07cPIPjr+Tl0IVv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=hqVtsydn; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="hqVtsydn"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-35f22d3abf1so1399814f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718047222; x=1718652022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Guz7MjyMNC45VGVGtnc1o6ogeR5taFihB6DV18NWqFk=;
        b=hqVtsydnmMw9Uvu8OGiLOStNOKANZ4ZbHr4i3N+JvxKxwT+Thf/Pg3H498Ao+y81Fr
         m4sOGnBErVW0Yi7PKL1p0W/bXQVLftRzi1ycZfAVJk2zZmEVblPiAG8iItsF2QZwm4GV
         slNX7uxO4uObcdCupaP4ZVJLIZFqE8Xr0joz/K0yvVY3WsIaaHeDcgSQajtflqrnsG+q
         aMppXrw4XvQdd5Ymr4ND92SQgu3ctIhRCaQX3xW7LokojoCup0CTdv16ZW5EbdAB1SAo
         EZr0r+Vzqd5bkQPJYLim/4iW8qRXWTK04lc8pZ3TNFphOWP4KvD56H4bt6wXHu9dlteX
         oUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718047222; x=1718652022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Guz7MjyMNC45VGVGtnc1o6ogeR5taFihB6DV18NWqFk=;
        b=u52NiUtK7KVLoG14ub3vAHQhsN3wYCYCrtTPOM8D9qDnogfLrw6suIgNQhXgTsQUBZ
         I2WOp1eV3Kw4C6fewawN+fO3ORrdN66OuAruacGSMfZjG1XqFj2O8ZS3BWjr0a0e2J5D
         O811ihy9r8uwAckHHt/TGsXkY08isf3H+8XBYycKVQh9Y2iYq+l7jZBEudUO4oFaB5fp
         IvRiImpBvTmbcf3xxBftvCY8cMc0R+ftpZRMcunKtTs2Zysj3TMQTSwzLhboR7ILFFMe
         CEMl2slSb4XUyzaU2VH60a2/iewntXWu1Su71/Eyvbi6uj4Bwp8wrOZtKdRajg6MQNfY
         Kpag==
X-Forwarded-Encrypted: i=1; AJvYcCUHgznvM0gbdqg/R0QfD9Rd1Ep6qWqgtSPYgPVd1oVQ1hT8OLfLrEbpw+wfFgbpQYzhFukApKun9zJlYY29m5ud6ynrzftGOXoLVGIdYG6oLbPR
X-Gm-Message-State: AOJu0Yyday76THC4cbbiF8zDhGTQh+TogIgJasU7yw3V4F+FNChdRQJN
	B6cCIPVbFpkbOXiRAlljjJjhoP0VWX1zFbqJrYJo6T/aY4/xHJ3vQQsjGuhbfOA=
X-Google-Smtp-Source: AGHT+IHq8jSEMkw7gwkS01+qTAl/yGpwM7w1xlBZWuVyZXGP6Ki1z+5dsHApq2plP2vN33SQwO/EeA==
X-Received: by 2002:a05:6000:1886:b0:35f:17c8:fe2d with SMTP id ffacd0b85a97d-35f17c8ff54mr6394663f8f.37.1718047221959;
        Mon, 10 Jun 2024 12:20:21 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1f30c3ccsm4988326f8f.7.2024.06.10.12.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 12:20:21 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Metin Kaya <metin.kaya@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 0/3] Clean up usage of rt_task()
Date: Mon, 10 Jun 2024 20:20:15 +0100
Message-Id: <20240610192018.1567075-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make rt_task() return true only for RT class and add new realtime_task() to
return true for RT and DL classes to avoid some confusion the old API can
cause.

No functional changes intended in patch 1. Patch 2 cleans up the return type as
suggested by Steve. Patch 3 uses rt_or_dl() instead of 'realtime' as suggested
by Daniel. As the name was debatable, I'll leave up to the maintainers to pick
their preference.

Changes since v5:

	* Added a new patch to s/realtime/rt_or_dl/ as suggested by Daniel.
	* Added Reviewed-bys.

Changes since v4:

	* Simplify return of rt/realtime_prio() as the explicit true/false was
	  not necessary.

Changes since v3:

	* Make sure the 'new' bool functions return true/false instead of 1/0.
	* Drop patch 2 about hrtimer usage of realtime_task() as ongoing
	  discussion on v1 indicates its scope outside of this simple cleanup.

Changes since v2:

	* Fix one user that should use realtime_task() but remained using
	  rt_task() (Sebastian)
	* New patch to convert all hrtimer users to use realtime_task_policy()
	  (Sebastian)
	* Add a new patch to convert return type to bool (Steve)
	* Rebase on tip/sched/core and handle a conflict with code shuffle to
	  syscalls.c
	* Add Reviewed-by Steve

Changes since v1:

	* Use realtime_task_policy() instead task_has_realtime_policy() (Peter)
	* Improve commit message readability about replace some rt_task()
	  users.

v1 discussion: https://lore.kernel.org/lkml/20240514234112.792989-1-qyousef@layalina.io/
v2 discussion: https://lore.kernel.org/lkml/20240515220536.823145-1-qyousef@layalina.io/
v3 discussion: https://lore.kernel.org/lkml/20240527234508.1062360-1-qyousef@layalina.io/
v4 discussion: https://lore.kernel.org/lkml/20240601213309.1262206-1-qyousef@layalina.io/
v5 discussion: https://lore.kernel.org/lkml/20240604144228.1356121-1-qyousef@layalina.io/

Qais Yousef (3):
  sched/rt: Clean up usage of rt_task()
  sched/rt, dl: Convert functions to return bool
  sched/rt: Rename realtime_{prio, task}() to rt_or_dl_{prio, task}()

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 14 ++++++-------
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 33 +++++++++++++++++++++++++------
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 53 insertions(+), 31 deletions(-)

-- 
2.34.1

