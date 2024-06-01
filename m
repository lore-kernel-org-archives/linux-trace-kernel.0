Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C21EA8F
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Jun 2024 21:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717277613; cv=none; b=MRL4LZYIulA2wYLy/UuFMmh5IqTuwPy/RJl1UwH0xqZOmARQ6OPwY22gniqJRt2J2DLNzXgfFYYk3IDrxchzt6iT0qepz1gnkzs/vomDPoKTbk1JY4a6MCPxDXse7H3Yp42qLjMGhWD3NB+PptrsWc5Qhr/Lh4z5jiIHPn+pN8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717277613; c=relaxed/simple;
	bh=3sBwYo/AqZ+0RfDJFg+GCK+aWleW3pxMfuHyAah0dzA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m30IDPOeF+WiSOEz69hpm6ui9p+IGho5O1ZZ1MJ6GMjxl6GJyLgz544Dm7AJ7mK9u2dp3e1aCOSEssZgpb5hGPt5j+6D+GVb+09kRdyGAw4NdIqt+lMzQZJPBp2AeVhqEhPFr1phbMmA9zxP0qfaRI2gKTsi4Kfer4tX2UJ+/mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=TLwXvDBd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="TLwXvDBd"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35dce610207so660518f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Jun 2024 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717277610; x=1717882410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HJt3Ya3JYlNDKcCqPU+4dBowkDesFTehUTcWLYXANYk=;
        b=TLwXvDBd2KibpGurTDNi0sS+F1f2zelbruqHlBywSWqKU0TBnjVDV2I9he92JaYU+J
         wkztfGH/CioZVK4nKw0NVukUyatKtpyj/Qw9a7+0w6AOW61OOyUmKQQK/YDiWuohdgj1
         7hq0QEZu++TL9htN8+fffSxcA1BTQRsNaE9fv082V56CEc+wTYar/pfjMOhwxek2VFGc
         HqkJRulNSTqpx5rfrUIglt6di5bT2mYLGJr/3yYSZMybL0C/13lEHP5uOSiipbdXvaAL
         /d0ROzAFVNH7iXSpNoOgKPIn1MbQtYIMiooXq6730LwBebTl3KzTYl6xueNsTXl4Bx0S
         JVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717277610; x=1717882410;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJt3Ya3JYlNDKcCqPU+4dBowkDesFTehUTcWLYXANYk=;
        b=w5bIA/a1ehIv0vyF93ykI18JXNaRA8LD5N9x7lXqRA3YlqsK64mxvJjJ73ge4shRyb
         c9H+6qosqTFqr5s7adCimd2TfoZgBPlbDsdoUHDB/X2HT6g93n6MYg8vfebD3F0uFOwn
         GAfJtFhlWJAlhCoT6RdNJ4w+gsAFAQ8G+O7x+b4BG/MSKVdFuGFLq3z+KqemLvnZY8Ty
         H04XlYVslYcAgmP/rZskcpsVmj1QtsASZKLI1ToQSo/BDtARpgdLJLfm8uw7b85VFxTI
         E6mBcbtmcjfHhMdUeIDpd+91AaJKFTum8bmFchB73Uj+iHk3uK7YMQ3DHoBz9B++V2VK
         byJg==
X-Forwarded-Encrypted: i=1; AJvYcCXcBZbuj+kMlV35zxZTU854aT2HnhRTj4eGffeSxltx9ErXar62rtoqmRqAG++fMnGbrnl9/nkePEGlLMQFlSrWTEnEWMCJppalSnODO8i/LeSE
X-Gm-Message-State: AOJu0YywbQUeW/E639r237nNYu6O+ceOYOeBjNM2LHSGJZ4/toMV6Osu
	N98AkUwivQial9F+yXojjSjuWsxoArx6mMxt4Xw1JOCIPDwWtVKSUwdLsVc61t0=
X-Google-Smtp-Source: AGHT+IGl9Hl1b8VRJQpVpXl7hCsSBOPLOHgRsVLux3bAWL4Geb2ApKKwM1lVHyceYADVoADXs17YOw==
X-Received: by 2002:adf:e80f:0:b0:354:f724:6419 with SMTP id ffacd0b85a97d-35e0f25509fmr4554299f8f.8.1717277609843;
        Sat, 01 Jun 2024 14:33:29 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0839sm4751324f8f.23.2024.06.01.14.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 14:33:29 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v4 0/2] Clean up usage of rt_task()
Date: Sat,  1 Jun 2024 22:33:07 +0100
Message-Id: <20240601213309.1262206-1-qyousef@layalina.io>
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
suggested by Steve.

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

Qais Yousef (2):
  sched/rt: Clean up usage of rt_task()
  sched/rt, dl: Convert functions to return bool

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 14 +++++++------
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 35 ++++++++++++++++++++++++++-----
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 57 insertions(+), 29 deletions(-)

-- 
2.34.1

