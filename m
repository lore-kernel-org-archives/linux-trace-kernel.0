Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568933A8393
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594585; cv=none; b=tdCrvblIAggC2ghJrlvGMl+D+k1a6ieaptAlPt0uBjOgCkz4cpYQBZN53PbRtjtnyMA21C6Upt1NIYe9aTpq6lUFbdwT7Murq9iKywNeFYOYbZRfR+5tTqK08ElPDgrRwqTnVzTJ6IT4jhHXF2CmwZQijFJj+7/9/skdDj+gTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594585; c=relaxed/simple;
	bh=rvv/4ZVzUtdZiyBdXjHTLupCyJ00TjU+j++lc8rQc4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=SDZ1IlAXAvv/NTAYEVYh0U35xIxw3GPb5YYTmZ+oCM7tIex0fDivWL2mo6P7vd8Wpu5RW+0L0s1zR4kX7+I1ZDIBB793ezhAvXbjggN7HKsjzYh52fzAg7K0vYx1vn7A65k5nfdig1BnU074MYj31J0Cu3d1eIMbKoiUUIz2QNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aib9UADT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aib9UADT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778594581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xmZt9BqXCZYEHK8AZMSBBksICbjl3FHaprdItk12Ifw=;
	b=Aib9UADTWCuabW7z/NjWz80UAy3pOWrGzGXssskKywDcl4MxMtzcvtvs8GRUUuXc5+gEBv
	fQR2vAAjCPDYw4K9MpbL2StluGFYc/eYfXNYCa5/caALsKknkaT1JSjxJL80qBqK3GCJPH
	dkyX4mZY+YUsH4FEovZGgd9dCaNcCYU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-KcPm5rZHM5Cx3d2v1AEkqg-1; Tue,
 12 May 2026 10:03:00 -0400
X-MC-Unique: KcPm5rZHM5Cx3d2v1AEkqg-1
X-Mimecast-MFC-AGG-ID: KcPm5rZHM5Cx3d2v1AEkqg_1778594578
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 195B11800744;
	Tue, 12 May 2026 14:02:56 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84BB21803A93;
	Tue, 12 May 2026 14:02:53 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Nam Cao <namcao@linutronix.de>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/9] rv: Fixes on Deterministic and Hybrid Automata
Date: Tue, 12 May 2026 16:02:41 +0200
Message-ID: <20260512140250.262190-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 2qmY284XHBBERxfsKLU8YpiXZQKsVQvaPx8t-A2YI98_1778594578
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

Cc: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (9):
  rv: Fix __user specifier usage in extract_params()
  rv: Fix read_lock scope in per-task DA cleanup
  rv: Reset per-task DA monitors before releasing the slot
  rv: Prevent task migration while handling per-CPU events
  rv: Ensure all pending probes terminate on per-obj monitor destroy
  rv: Ensure synchronous cleanup for HA monitors
  rv: Do not rely on clean monitor when initialising HA
  rv: Add automatic cleanup handlers for per-task HA monitors
  rv: Mandate deallocation for per-obj monitors

 include/rv/da_monitor.h                       | 66 ++++++++++---
 include/rv/ha_monitor.h                       | 93 ++++++++++++++++++-
 kernel/trace/rv/monitors/deadline/deadline.h  |  8 +-
 kernel/trace/rv/monitors/nomiss/nomiss.c      |  4 +-
 kernel/trace/rv/monitors/opid/opid.c          |  4 +-
 kernel/trace/rv/monitors/stall/stall.c        |  4 +-
 .../rvgen/rvgen/templates/dot2k/main.c        |  4 +-
 7 files changed, 157 insertions(+), 26 deletions(-)


base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.54.0

