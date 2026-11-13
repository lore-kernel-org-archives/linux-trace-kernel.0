Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578649;
	b=CelXnl9nPXTxucBEvSElAunoBQKpgcWPI3N9RC2TJyHqsHrZFfxIMh8jjbPe5vDZoR9J
	 MLWep2yhn50DjW7jT5t+s6G5O8SCrXsAebseeEkVXWBFoB5+RhH5mcAn41m/1aHeK5TAk
	 rnMf6i7WsMja4kGf1bltH6iS+LTyEb+/+YldnIIHRZ15U+j71VfefuulY/UahE1jGSoM7
	 m54Jc7hCE7+6LWlnUYN/qM28wp3tmlstdYnMFsXNsvJL8+7pPM6q2Jvsbosd6dU643eXz
	 1bYQF7sXh6vVYUyG2yKIsAn3hiyPCGXl++zE8j2ixf/LKaXNkbCVqCFt66rqpH3pz/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578649;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=muqCZtCnODx5xWlYCZnvE31S5sIwWXI83ApgORpaH/4=;
	b=BcaXgRPHkkeI4lZgjIhDtXmdraZ8vuvySSDpvlJJO2R62vxTW2DxKItjX30O3vRuGebu
	 PmobGaTuTOWV3FPGTtZDKMw+0TJXZqVU8aH+whq0lFBJY4c7awNp2vNXqbI7nEX0RP/Yr
	 lWgUzU8itIZWu+iYmHt64N2Z4nObOlqRDYYO77vtPK0JaWHDjgP3ZOlLFmZBYLEYz8F6R
	 RTGrmToNKv160pb7ZOI4rttT1G7X2Vk0B27lr4CFywxMfR4DzEGXGCcPI+Z/DV1ezk76l
	 nFvDHzneZJ1XfBYOfJRS3HuP9+hc8kRaR5aZpOjpz9dKC+8Z6avi5t9B8CqAK68Agzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=+rkgeThX;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=RiuYxJL+;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32E606A332
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 14:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE32E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=+rkgeThX;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=RiuYxJL+
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794578633; bh=muqCZtCnODx5xWlYCZnvE31
	S5sIwWXI83ApgORpaH/4=; b=+rkgeThXaAz2kLQzPJ8WQNCG4x5vgf6u+qE+NaSVb+VD6twIM5
	+Ca4WG7iL/16ShVRMIJBNiuIZEZbs0b6sWBg==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794578633; bh=muqCZtCnODx5xWlYCZnvE31
	S5sIwWXI83ApgORpaH/4=; b=RiuYxJL+OSOJ8NfFm37Je3NAvoyEx5tquNTpNknWcxT4F4rHKL
	3Zjv4H2LL3VwFJoHoseLLAUtMpAFOYV5VEe2+gX7pfLFVzc6DT0jEXcnxmM4XCQ9IDK1TLxAOEe
	JiB9L6ZcQhxotCAxNqd16dcHaVo1BetGlfQHLsGdnqcs44YYV2Nwe+HOlTp3wabVfR1RuLU4wJE
	n/lGrK/0d/rKCsc2lmnQi+VeaL71+YH1MdwV4iGN3I46y2EcE6MEDlwSjndgMvIIrzzqOKRbADI
	zq/cvAsMaN1Bp9lPuuBRn2N4fVF/b4ifucF2ssGIs5UWiMijNiML31xvwdVz4/yOztA==;
From: Daniel Wagner <wagi@monom.org>
Date: Fri, 13 Nov 2026 15:03:50 +0100
Subject: [PATCH v2] rtla/timerlat: Lock the memory of the user-space
 threads
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2prOIA9Z+R+GRcEBqpSaFhsN4
 d8tuHV5knPPXcCz0+yhShZwHLTXdopAhwTaQU09C32LDCQpR0QSbh6VMKNtH4JUVlCHMktThjh
 4Ou70e49d6x/7V3Pndt4KmzFoP1v32d8Cbt7fcECB4oTlucwLxIbkxdjJmqN1PdTrun4BiIXVN
 7YAAAA=
X-Change-ID: 20261112-rtla-mlock-2a572f10533e
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 John Ogness <john.ogness@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 Daniel Wagner <wagi@monom.org>
X-Mailer: b4 0.16.0

With -u, the latency timerlat reports runs until the measuring thread
is back in user space. Nothing keeps that thread's memory resident,
so under memory pressure the kernel reclaims its code, stack and libc
pages, and the page faults on the way back to user space count as
latency.

On a Raspberry Pi 3 (PREEMPT_RT 6.12) under stress-ng --class memory,
timerlat reported up to 40 ms for the user-space threads, which took
283 major faults, while the kernel threads' latency stayed below
1 ms. cyclictest under the same load: 133 ms without -m (mlockall),
0.9 ms with it.

With this change timerlat reports 0.9 ms for the user-space threads
under the same load, and they take no major faults.

Lock the user-space threads' memory before they start measuring, as
cyclictest -m does.

Signed-off-by: Daniel Wagner <wagi@monom.org>
---
Changes in v2:
- Shorted comment.
- Moved the mlock up before the sched switch as suggested by John
- Link to v1: https://patch.msgid.link/20261112-rtla-mlock-v1-1-418986711b20@monom.org
---
 tools/tracing/rtla/src/timerlat_u.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index c80edaf07b00..5e7a23fb9fc3 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -15,6 +15,7 @@
 #include <pthread.h>
 #include <sys/wait.h>
 #include <sys/prctl.h>
+#include <sys/mman.h>
 
 #include "common.h"
 #include "timerlat_u.h"
@@ -37,6 +38,13 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 	cpu_set_t set;
 	int retval;
 
+	/*
+	 * Fault in and lock all memory before switching to a real-time
+	 * priority, so that page faults don't show up as latency.
+	 */
+	if (mlockall(MCL_CURRENT | MCL_FUTURE))
+		err_msg("Could not lock timerlat u memory: %s\n", strerror(errno));
+
 	/*
 	 * This all is only setting up the tool.
 	 */

---
base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
change-id: 20261112-rtla-mlock-2a572f10533e

Best regards,
--  
Daniel Wagner <wagi@monom.org>

