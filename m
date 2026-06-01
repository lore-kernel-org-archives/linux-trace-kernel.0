Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0452773F7
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 15:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780328333; cv=none; b=hdUF9DgUXV9Zi+GVJcx9G6H6xMgYxQeJ0hoEk8b1UJ1weVDjmu+wY2wBdbq1g/cWpNiqMwy21zv8Sd+G9g3B3iiUevRx9rnmSh7S3nQcwz1jfVvCmiz7MLK0bhHS1IwrWvhc9OU4PCiaUpoi100tGQeFol1NkKHludvI4p4FpSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780328333; c=relaxed/simple;
	bh=6eVxesrUjXAU7UFckoOPZAYVs4OcfNXOUh8IycxJgCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=kzjNPUNV4Fo2dIAC58Qyga7QTLBYfjLso9JqTNjw0nWQv9bhka3M8Y8OlqQUxGHbwjWt56AUGtobNySDFJZZgIIYZSMheN9yENPh8CS5SozsWHLbuqR4ofJxaE2WqhaqaElM4eGjjRCkhaSznIEd4jESKXr6Z11chm4JYDrt5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YE9xBLK4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YE9xBLK4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780328330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LY1DeAwMRC8pRzb7/yyEkzeaupMPdZReEI7Yykc1684=;
	b=YE9xBLK4m0NvKfItvve5dcamwRpYt58G6HyTJLLxnAVI1Bd3o+G5mgoscOSY1W++8icNiR
	i/lFjNH/nxciDC0WqB9hJL+Fv57uaqVNx8Bzu3oYpj0B9ElsiwsmfG03dtoiEdp5CKDU5i
	rFz5u9aGlNFouawmAc4RnuByEJ5/5Zc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-GsjfY8OuMkyGEWxwisTCsw-1; Mon,
 01 Jun 2026 11:38:47 -0400
X-MC-Unique: GsjfY8OuMkyGEWxwisTCsw-1
X-Mimecast-MFC-AGG-ID: GsjfY8OuMkyGEWxwisTCsw_1780328326
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D64571955EBA;
	Mon,  1 Jun 2026 15:38:45 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 289BE18004A3;
	Mon,  1 Jun 2026 15:38:42 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 00/13] rv: Fixes on Deterministic and Hybrid Automata
Date: Mon,  1 Jun 2026 17:38:27 +0200
Message-ID: <20260601153840.124372-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: FzlO6TaJjvqrV6Cywh8EPy6fVIfMrSLJ0SFVdGZxFE0_1780328326
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

Differences since V3 [1]:
* Use separate reset functions for HA init/reset to avoid globals
* Reset monitor before sync stopping the timer on HA per-task exit hook

Differences since V2 [2]:
* Applied from reviews changes to commit messages
* Rearranged order to put non-fixes and not-reviewed patches in the end
* Synchronise monitors before resetting them to avoid rearming
* Protect against racing timer callbacks during destruction

Differences since V1 [3]:
* Fix memory consistency with timer callbacks racing with resets
* Add per-obj deallocation hook in rvgen generated code
* Do not rely on clean monitor when initialising HA
* Add tracepoint synchronisation before returning per-task slots
* Fix suffix strip in dot2k
* Generate stub deallocation hooks instead of failing build when per-obj
  miss those

[1] - https://lore.kernel.org/lkml/20260530141652.58084-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20260527062313.39908-1-gmonaco@redhat.com
[3] - https://lore.kernel.org/lkml/20260512140250.262190-1-gmonaco@redhat.com

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (12):
  rv: Fix __user specifier usage in extract_params()
  rv: Reset per-task DA monitors before releasing the slot
  rv: Prevent in-flight per-task handlers from using invalid slots
  rv: Ensure all pending probes terminate on per-obj monitor destroy
  rv: Do not rely on clean monitor when initialising HA
  rv: Add automatic cleanup handlers for per-task HA monitors
  rv: Ensure synchronous cleanup for HA monitors
  rv: Prevent task migration while handling per-CPU events
  rv: Use 0 to check preemption enabled in opid
  verification/rvgen: Fix suffix strip in dot2k
  rv: Fix read_lock scope in per-task DA cleanup
  verification/rvgen: Generate cleanup hook for per-obj monitor

Wen Yang (1):
  rv: Fix monitor start ordering and memory ordering for monitoring flag

 include/rv/da_monitor.h                       | 145 ++++++++++++++----
 include/rv/ha_monitor.h                       |  91 ++++++++++-
 include/rv/ltl_monitor.h                      |   1 +
 kernel/trace/rv/monitors/deadline/deadline.h  |   3 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c      |   4 +-
 kernel/trace/rv/monitors/opid/opid.c          |  12 +-
 kernel/trace/rv/monitors/stall/stall.c        |   4 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  19 ++-
 .../rvgen/rvgen/templates/dot2k/main.c        |   4 +-
 9 files changed, 234 insertions(+), 49 deletions(-)


base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

