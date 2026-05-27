Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4981E32D6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 May 2026 06:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863017; cv=none; b=KvfhmIszhcKeUE0xJIPCpIaQXSWv3g0J8V+pTjywDt2lxGts0Cyk0pE0bGrY1cjyKGyOX+aDkt1rjxdRBt8K8iiUWGvINHm4m5vtV8pKtsH9MKEIhfszfD4kT7LhjSdA+mouuqAemyJzUfF+EuIOZJdzhZ5GjM1/T6egXbVlszk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863017; c=relaxed/simple;
	bh=aV27GZ6bg4q8c1onYJbWx64LuxyOWkGbYqwHnOU5n7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=OJ2bBbUCy6dmXb/09+PcT4v5OKlwlAgUNRBM2ryMuN6QyYfedDjbYvtuZ/Bw/3Vr2yWxQHPZcfYOnN+sJ6v4MOX6emz8z0ydsGwJVgTym8m32v+sSA8hx1czwX+NKvkn5NMK1CmmqbXyt7yzj7Zv/E+6PPKwh3MdxxetIoHFMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHD4G7s2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHD4G7s2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779863015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0LRM00p/jYHvi1V4KO6hiB6jk2DmX9kvZCEKFRXvm8E=;
	b=FHD4G7s2t4HMdX5U7JTCdflFBEo2A4Xk9rTZtuoXJDc3Rn7FAhEsicI45vM29DEP18YIgI
	loEvBstIatZDKfXx2lShxJBv18dlM0gBu04BwZHEdqzY+VTebVyNUldpPFVgBGfmXN0f0y
	+BQ0LYwOEMyg4paopdPrq4S9bi+RdG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-ojEU5VvyNf6AZjk2xmkW_g-1; Wed,
 27 May 2026 02:23:32 -0400
X-MC-Unique: ojEU5VvyNf6AZjk2xmkW_g-1
X-Mimecast-MFC-AGG-ID: ojEU5VvyNf6AZjk2xmkW_g_1779863011
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ACFDB1956080;
	Wed, 27 May 2026 06:23:30 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.86])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD14B1800576;
	Wed, 27 May 2026 06:23:27 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 00/12] rv: Fixes on Deterministic and Hybrid Automata
Date: Wed, 27 May 2026 08:23:00 +0200
Message-ID: <20260527062313.39908-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: B4dhrKX_yStY6UyrcXLGBf9DbzsbfKGYH8EJDNxEmmM_1779863011
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Fix issues that were reported by bots or visible only after integration:
 * Make sure timers are always terminated and waited for when disabling
   the monitor or when the target terminates
 * Run per-cpu monitors with migration disabled since preemption is now
   enabled from tracepoints
 * Fix a wrong __user specifier in a helper function
 * Other cleanup and concurrency issues

Differences since V1 [1]:
* Fix memory consistency with timer callbacks racing with resets
* Add per-obj deallocation hook in rvgen generated code
* Do not rely on clean monitor when initialising HA
* Add tracepoint synchronisation before returning per-task slots
* Fix suffix strip in dot2k
* Generate stub deallocation hooks instead of failing build when per-obj
  miss those

[1] - https://lore.kernel.org/lkml/20260512140250.262190-1-gmonaco@redhat.com

Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (11):
  rv: Fix __user specifier usage in extract_params()
  rv: Fix read_lock scope in per-task DA cleanup
  rv: Reset per-task DA monitors before releasing the slot
  rv: Prevent task migration while handling per-CPU events
  rv: Prevent in-flight per-task handlers from using invalid slots
  rv: Ensure all pending probes terminate on per-obj monitor destroy
  rv: Ensure synchronous cleanup for HA monitors
  rv: Do not rely on clean monitor when initialising HA
  rv: Add automatic cleanup handlers for per-task HA monitors
  verification/rvgen: Generate cleanup hook for per-obj monitor
  verification/rvgen: Fix suffix strip in dot2k

Wen Yang (1):
  rv: Fix monitor start ordering and memory ordering for monitoring flag

 include/rv/da_monitor.h                       | 67 +++++++++----
 include/rv/ha_monitor.h                       | 95 ++++++++++++++++++-
 include/rv/ltl_monitor.h                      |  1 +
 kernel/trace/rv/monitors/deadline/deadline.h  |  3 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  4 +-
 kernel/trace/rv/monitors/opid/opid.c          |  4 +-
 kernel/trace/rv/monitors/stall/stall.c        |  4 +-
 tools/verification/rvgen/rvgen/dot2k.py       | 19 +++-
 .../rvgen/rvgen/templates/dot2k/main.c        |  4 +-
 9 files changed, 171 insertions(+), 30 deletions(-)


base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
-- 
2.54.0

