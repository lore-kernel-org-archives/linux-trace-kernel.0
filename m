Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DE310A35
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 23:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716853520; cv=none; b=fHvSTK5pgH6fwRf9Wg/nP5XgES55HU9VMp0tN7jlXxkYUpMJ1uEox+QYH9ICUPn/XCSPoR6Tj6I2fj5yzVa9D/p/OphhC/u0vx0yvy0tUYerqjujP8/Ik0gLbvH9N41Eg1LtD4KK8cIdK47tJbqeSpKB+ZHdt83iH3AQuGvH6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716853520; c=relaxed/simple;
	bh=ilnFqztr6YvKOP1wiWFQn72ziqayuZkyKp9feAbsV5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZWAPuc5zgEZHRPqU23Rxf3oI50PNu8HpLIcU/KxN62gTef74kZAc4qXyLFOr5IC8Ozx6Ay84wXs8YGh0Dms3qqeKzB7FE3R+BqUSyMROePmtEqY2ovI1Mc0LM7dYVYcaeqlbuq5+ADICY3hNhTgCxLbzgrn8w8QKPqkQds2sO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=zi77ixl2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="zi77ixl2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-356c4e926a3so164307f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 May 2024 16:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1716853517; x=1717458317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRO/CnRPtpBsbl7nBhwPcIaynZHQudWyGgLN4ebnUfQ=;
        b=zi77ixl2RElbuX0WbF4Yz3H/D0XISXLJIh7v0bUM8mDk8K7gUaIlsNk+wG+CeoIc+i
         HZuO8hKnRr7arFfxPo+/KGIq/EJeJ8KJnsIye1XqISfn9SfFo2U+uw/re6ceeHVekQx2
         d/yJsVbBNxatKEZ5ot/gJP5Zncn+bkIQrCUmoc5zTvTNUNq7l0eBEnSHmQPBYVd1VDHw
         3KV+aYaR09ptHGgGvRu6lVw12cecdMdWSFHu2LioFVJwI8WpyQj+v2uadESWA8ySo1Ub
         9Tf/9vfIA8knJto9G2xmoGxBoayMXSrW0c59xAdv2Z7BNTW0xxYxxICnlW2xLMY43N5J
         mXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716853517; x=1717458317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRO/CnRPtpBsbl7nBhwPcIaynZHQudWyGgLN4ebnUfQ=;
        b=WK0qw55PdpkffLzcksQAGovUW8wKOxP8HC4jfCq+NA6NvFF7jyfX7Hi38+D0KoKdE7
         fkVJN1KAk4MyM+mCvI5P9rPsyVGNMboCk9vC2Z92WeCVQ3gOFVlE6h8gIiE2k16LJkpx
         d4zTna2yfv/nOes/+dnuP4OtMKovINKMImm44GnzwmHyZZixF3vAjg3//qjoHGZxeWUv
         DNe303sQOZAgXMk0L70ezIK+r++HW9dX+yYMBYgPOMmCy2mYLdReGzJlU+zVL9Ez5g9v
         mACEi3PcvIMg+d2CwRlcc0zzaeEFLWBs1aABSAbog/Nn6N7JKa3VFRaYcpoKLmsYrn+d
         EiOg==
X-Forwarded-Encrypted: i=1; AJvYcCUiWMMyAfTJiJmeSufeDqtAxQ+XVaPqAeZRfDKWI9quPZvsEgFeXAX+LRKoRJ9dz5Bi9swpXsUdP0DRui5Me+l1kAk6i4iEaZLIDQxjQIwBCMdY
X-Gm-Message-State: AOJu0YwuLoHqIjhT4KIdeL9rm4KZCCgReP6MNydlMzLjv/l59UfHZwJs
	nbwQgQvCwt+x1TM7vMP2wQHs2X0mshEDfRxFjjrhATEC/XnPDTEO4bqlqeSzcKY=
X-Google-Smtp-Source: AGHT+IH9cpBoOavUU39BKyiX5ZVVtYqsyiD57pc9wsnRSAnUTzf+Xg02xdlAzGi0KOkEJdwOY+claQ==
X-Received: by 2002:a05:600c:6b04:b0:41f:e7ac:cc72 with SMTP id 5b1f17b1804b1-421089f9a09mr75891875e9.40.1716853516966;
        Mon, 27 May 2024 16:45:16 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42108970967sm123535515e9.17.2024.05.27.16.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:45:16 -0700 (PDT)
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
Subject: [PATCH v3 0/3] Clean up usage of rt_task()
Date: Tue, 28 May 2024 00:45:05 +0100
Message-Id: <20240527234508.1062360-1-qyousef@layalina.io>
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

No functional changes intended in patch 1. Patch 2 changes hrtimer users as
suggested by Sebastian. Patch 3 cleans up the return type as suggested by
Steve.

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

Qais Yousef (3):
  sched/rt: Clean up usage of rt_task()
  hrtimer: Convert realtime_task() to realtime_task_policy()
  sched/rt, dl: Convert functions to return bool

 fs/bcachefs/six.c                 |  2 +-
 fs/select.c                       |  2 +-
 include/linux/ioprio.h            |  2 +-
 include/linux/sched/deadline.h    | 10 ++++++----
 include/linux/sched/prio.h        |  1 +
 include/linux/sched/rt.h          | 31 ++++++++++++++++++++++++++++---
 kernel/locking/rtmutex.c          |  4 ++--
 kernel/locking/rwsem.c            |  4 ++--
 kernel/locking/ww_mutex.h         |  2 +-
 kernel/sched/core.c               |  4 ++--
 kernel/sched/syscalls.c           |  2 +-
 kernel/time/hrtimer.c             |  6 +++---
 kernel/trace/trace_sched_wakeup.c |  2 +-
 mm/page-writeback.c               |  4 ++--
 mm/page_alloc.c                   |  2 +-
 15 files changed, 53 insertions(+), 25 deletions(-)

-- 
2.34.1

