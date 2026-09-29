Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418C497382
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686166; cv=none; b=ZIgSWjOw+NwoS+sAOLoSqgf36bk6S7IuJdTjIMj2nGH5rStpV+zuQNNISro4D97twz/rrg+zSxdHmm4zvqKtquubYKQ2HBnbWqXPeI6tucS+c+JNAdAuUzHrMBoW2UuoNLTcY/2IL/Xki65ZG6FGfYcX/uzyx6btqScTN/w7XtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686166; c=relaxed/simple;
	bh=i/q49x4F/dPhzzkyNCesn7XVzXUo1VjAbq5DNZIo5a4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=RSL/psFq5BIkkXEkcDlqSVxXzBNWAnXk4aMYPfQk+GggVmFrZNv/exAqX3eqwDzZLBXsAh4ENmoh4tWDhWeQUuc+cKj1iJt2Jg4rrXzgTwO7e+HxaKCFJiGuqtURXYB8KCrn35/FcBfZTtFy+JC8qSrZL4Oyf+SlL8PZvdj1HlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4VGMAsV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4VGMAsV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790686162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rqo8Qfv+Yic2liv5cliRHnbM2cSeEarVnkvLudFMrNA=;
	b=H4VGMAsVjb6dFSt96pZWj9z+UnD/MSMtqdgb72HFcUMP98IK8oWbLVeQmjR47igWgQIiCu
	AUXzrFTeCr9nra3FtbaUrYvjYo0ihsQXFqZPQYacD+TVRZrY0MPSkXzHrOVisTrO4LAaDp
	+YGTOhHvP/K2clL5YG32WBvQtHXwS2E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-JydbV8kmOtyxZAn932xLSQ-1; Tue,
 29 Sep 2026 08:49:19 -0400
X-MC-Unique: JydbV8kmOtyxZAn932xLSQ-1
X-Mimecast-MFC-AGG-ID: JydbV8kmOtyxZAn932xLSQ_1790686158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2521E1800764;
	Tue, 29 Sep 2026 12:49:18 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72CF01956095;
	Tue, 29 Sep 2026 12:49:15 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH 00/10] rv: Add remaining deadline monitors
Date: Tue, 29 Sep 2026 14:48:58 +0200
Message-ID: <20260929124908.177676-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: n3aCh8Gn40zxYKUaNyQV_TTvXyb1o42yrbMpdLMF2NM_1790686158
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Add the following deadline monitors as already sent in [1]:
* throttle:
    validate dl entities are throttled when they use up their runtime
* boost
    fair tasks run either independently or boosted
* laxity
    deferrable servers wait for zero-laxity and run

Monitors are adapted to the new upstream but mostly unmodified.
Except:
* Remove enqueue/resume from laxity model
* Special idle -> throttled in boost and add period invariant in
  throttled states too

Additionally apply some fixes and simplifications to the hybrid
automata infrastructure and other changes:
* Reset on monitor start and drop checks for invalid variable
* Store timer wheel budget to allow checking for invariants without
  needing to know how the timer was set
* Add enqueue/dequeue tracepoints and check them in snroc
* Add KUnit tests for throttle

[1] - https://lore.kernel.org/lkml/20260310105627.332044-1-gmonaco@redhat.com

To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: Juri Lelli <juri.lelli@redhat.com>

Gabriele Monaco (9):
  rv: Force environment reset action on HA monitor start
  rv: Remove unused ha_monitor_env_invalid()
  rv: Cache timer budget when starting HA timers
  tools/rvgen: Default to HA_TIMER_WHEEL for jiffy clocks
  rv: Add enqueue/dequeue to snroc monitor
  rv: Add throttle deadline monitor
  rv: Add dl_server specific monitors
  rv: Add KUnit test for throttle monitor
  selftests/verification: Lower stressor priority in rv_deadline

Nam Cao (1):
  sched: Add task enqueue/dequeue trace points

 Documentation/trace/rv/monitor_deadline.rst   | 201 ++++++++++++
 Documentation/trace/rv/monitor_sched.rst      |  39 ++-
 include/linux/rv.h                            |   5 +-
 include/rv/ha_monitor.h                       |  73 ++---
 include/trace/events/sched.h                  |   8 +
 kernel/sched/core.c                           |  12 +-
 kernel/sched/sched.h                          |   2 +
 kernel/trace/rv/Kconfig                       |   3 +
 kernel/trace/rv/Makefile                      |   3 +
 kernel/trace/rv/monitors/boost/Kconfig        |  15 +
 kernel/trace/rv/monitors/boost/boost.c        | 276 ++++++++++++++++
 kernel/trace/rv/monitors/boost/boost.h        | 146 +++++++++
 kernel/trace/rv/monitors/boost/boost_trace.h  |  19 ++
 kernel/trace/rv/monitors/laxity/Kconfig       |  14 +
 kernel/trace/rv/monitors/laxity/laxity.c      | 253 +++++++++++++++
 kernel/trace/rv/monitors/laxity/laxity.h      | 133 ++++++++
 .../trace/rv/monitors/laxity/laxity_trace.h   |  19 ++
 kernel/trace/rv/monitors/nomiss/nomiss.c      |   4 +-
 kernel/trace/rv/monitors/opid/opid.h          |   1 +
 kernel/trace/rv/monitors/snroc/snroc.c        |  18 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |  46 ++-
 kernel/trace/rv/monitors/stall/stall.c        |   2 +-
 kernel/trace/rv/monitors/throttle/Kconfig     |  15 +
 kernel/trace/rv/monitors/throttle/throttle.c  | 302 ++++++++++++++++++
 kernel/trace/rv/monitors/throttle/throttle.h  | 116 +++++++
 .../rv/monitors/throttle/throttle_kunit.c     |  44 +++
 .../rv/monitors/throttle/throttle_kunit.h     |  34 ++
 .../rv/monitors/throttle/throttle_trace.h     |  19 ++
 kernel/trace/rv/rv_monitors_test.c            |   2 +
 kernel/trace/rv/rv_trace.h                    |   3 +
 .../verification/test.d/rv_deadline.tc        |   4 +-
 tools/verification/models/deadline/boost.dot  |  48 +++
 tools/verification/models/deadline/laxity.dot |  36 +++
 .../verification/models/deadline/throttle.dot |  44 +++
 tools/verification/models/sched/snroc.dot     |  30 +-
 tools/verification/rvgen/rvgen/dot2c.py       |   2 +
 tools/verification/rvgen/rvgen/dot2k.py       |  18 +-
 .../rvgen/tests/golden/ha_percpu/ha_percpu.c  |  17 +-
 .../rvgen/tests/golden/test_ha/test_ha.c      |  17 +-
 .../golden/test_ha_kunit/test_ha_kunit.c      |  17 +-
 40 files changed, 1939 insertions(+), 121 deletions(-)
 create mode 100644 kernel/trace/rv/monitors/boost/Kconfig
 create mode 100644 kernel/trace/rv/monitors/boost/boost.c
 create mode 100644 kernel/trace/rv/monitors/boost/boost.h
 create mode 100644 kernel/trace/rv/monitors/boost/boost_trace.h
 create mode 100644 kernel/trace/rv/monitors/laxity/Kconfig
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity.c
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity.h
 create mode 100644 kernel/trace/rv/monitors/laxity/laxity_trace.h
 create mode 100644 kernel/trace/rv/monitors/throttle/Kconfig
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_kunit.c
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_kunit.h
 create mode 100644 kernel/trace/rv/monitors/throttle/throttle_trace.h
 create mode 100644 tools/verification/models/deadline/boost.dot
 create mode 100644 tools/verification/models/deadline/laxity.dot
 create mode 100644 tools/verification/models/deadline/throttle.dot


base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.55.0

