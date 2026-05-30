Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26C630566E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 30 May 2026 14:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150625; cv=none; b=GNdOYddIcX93A7ubIA6LjQ0x6F1UzKUI0291VrJoJZbRDTptrTOrNUHxwUkC+LVJoD4QqbEpjYZNT58kgbytuKGhCe7qhCOCoFrETm7wXoHa4VHFOzLrY+sug9H2+UWZnhYxHO20P8yS3+5Bmq5lblYIg6kkCHrJY+KANcCNAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150625; c=relaxed/simple;
	bh=wQmM+B/etSxc3r7oglcYRx5GBL7Psfwi5nBrCEM6VJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=d2cQ8wAlWdcqp77arV+iTL9pz/IZh/86hzjyqJyyxJycgADo0eKVwnvP2ufi+3GxO5MWPiapednxZcyCHkctKGlq0ldJlhU1swKKIq+sNWRHig+LGPnWg4TXaKdC2XlCAS4SE6Ee+Fg5b0YwUlYzt9Qkzbue//4/1FBmJ9oYrkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W87UBWfg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W87UBWfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780150623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FmjxPhMl7IqKMVqSSr18NHFLgBHYZJBkjofMsn+R/3I=;
	b=W87UBWfgsd3GntrL09j8qk1+q9MBDwZn01/esRnY0pLBrQtB+bL7u6TvjoaonN1yyns0D+
	nnynSim9NCSrHz2JbsQAWJmTuAUzTNYKkXict2mlW77zX/hf5hSOx6hBjmyT2Tn5hJ251O
	rXTfw47YWWI0pMZTJFFtVA4I3qw6eLM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-Y2dQvpetPriylzCdlSfpnQ-1; Sat,
 30 May 2026 10:16:58 -0400
X-MC-Unique: Y2dQvpetPriylzCdlSfpnQ-1
X-Mimecast-MFC-AGG-ID: Y2dQvpetPriylzCdlSfpnQ_1780150617
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B58D818005B3;
	Sat, 30 May 2026 14:16:56 +0000 (UTC)
Received: from fedora-pc.redhat.corp (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A47FD30001BB;
	Sat, 30 May 2026 14:16:54 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] rv: Fixes on Deterministic and Hybrid Automata
Date: Sat, 30 May 2026 16:16:39 +0200
Message-ID: <20260530141652.58084-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: kTICjAM8mgfLiwkDdeOmV00LYP3Gr1Y5-5B5QWhGvTM_1780150617
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

Differences since V2 [1]:
* Applied from reviews changes to commit messages
* Rearranged order to put non-fixes and not-reviewed patches in the end
* Synchronise monitors before resetting them to avoid rearming
* Protect against racing timer callbacks during destruction

Differences since V1 [2]:
* Fix memory consistency with timer callbacks racing with resets
* Add per-obj deallocation hook in rvgen generated code
* Do not rely on clean monitor when initialising HA
* Add tracepoint synchronisation before returning per-task slots
* Fix suffix strip in dot2k
* Generate stub deallocation hooks instead of failing build when per-obj
  miss those

[1] - https://lore.kernel.org/lkml/20260527062313.39908-1-gmonaco@redhat.com
[2] - https://lore.kernel.org/lkml/20260512140250.262190-1-gmonaco@redhat.com

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

 include/rv/da_monitor.h                       |  67 ++++++++---
 include/rv/ha_monitor.h                       | 104 +++++++++++++++++-
 include/rv/ltl_monitor.h                      |   1 +
 kernel/trace/rv/monitors/deadline/deadline.h  |   3 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c      |   4 +-
 kernel/trace/rv/monitors/opid/opid.c          |  12 +-
 kernel/trace/rv/monitors/stall/stall.c        |   4 +-
 tools/verification/rvgen/rvgen/dot2k.py       |  19 +++-
 .../rvgen/rvgen/templates/dot2k/main.c        |   4 +-
 9 files changed, 180 insertions(+), 38 deletions(-)


base-commit: 8fde5d1d47f69db6082dfa34500c27f8485389a5
-- 
2.54.0

