Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=49.12.199.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518610;
	b=3Ph9mPxMZHzQgd5zVkfCLxKgdVpPJ7cEmL7zYGqA9BU2CJzAaALFfyrpTMKCVJfQkG3U
	 hP1ua4cb3Qays8hCw7EifsAbnFAu4/ePaQGx+R0RBDo0SLowJzaYz7uAfW7LGIxEKB4IV
	 bQ07wsuYnAFZc5vtpGqwYTaitOFOR6sOz5rt1Hr1kb8IGIiT1y1tb4/mT9zxJ276nEXE6
	 3F9tu8jlQYL7KC9/qMutvubcCHTedqmShYJfQVCwK97dx2V8TNzK20oIYzPWgNmfJyJYp
	 71uIWp0Gnl6saKeJdR3ibCmX7FXlYl0hU5UcZ938bKSWcD2oshDJpOZncYIl6Ci+Iwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518610;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=VKqu1LDK1DyR5uT5qK1U0I5HptGHmXgz5DOcJEJsV4c=;
	b=BN4qBn6H3QEihwa/Zn9YPvRFeloyqG3mp3w/Le/XjRnHlx/twrzNUMeFXhJEUQWU4OXy
	 Xu70G3C1EpqpZ40rHK59WPwmH+Zuf3Vi+Y3B4pchefioHyFIZOOuot8ZMeoUnLA52LtSW
	 m4J4csTV8SsB1wnn8g5R/3FTi1ll3oQPinu+IE9gI6VF/HmjBKz2yrhuUrO3r1rghEgr+
	 6CdN/9UgYIRrYltEEkL1GjbNk2G4oH7sasy9tDGA25fjooxfYO3IFv40AxJYjQx6muUTR
	 dAncuYCs1CZyYgtYqzyGHZEK+xo8aHxMzDS5PmXP5zjJY2K82FOV6NxC+1XhDV7/RUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=monom.org;
	spf=pass smtp.mailfrom=monom.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=vhNUORO0;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=eni4VG+e;
	arc=none smtp.remote-ip=49.12.199.46
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D4606A8BE
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 21:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D56D4606A8BE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass header.d=monom.org header.i=@monom.org header.a=ed25519-sha256 header.s=v1-ed25519-20260726 header.b=vhNUORO0;
	dkim=pass (2048-bit key, unprotected) header.d=monom.org header.i=@monom.org header.a=rsa-sha256 header.s=v1-rsa-20260726 header.b=eni4VG+e
DKIM-Signature: v=1; a=ed25519-sha256; s=v1-ed25519-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794518602; bh=VKqu1LDK1DyR5uT5qK1U0I5
	HptGHmXgz5DOcJEJsV4c=; b=vhNUORO0VzoDrhJq2z0XXAnKs4rZm4bO/q6oM9ks2V+4SJrjx9
	K5V3rjLL6BWeRvyVnsiVo/Cbs3HMYgah5SAQ==;
DKIM-Signature: v=1; a=rsa-sha256; s=v1-rsa-20260726; d=monom.org; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794518602; bh=VKqu1LDK1DyR5uT5qK1U0I5
	HptGHmXgz5DOcJEJsV4c=; b=eni4VG+ekc1f46wbH9+Od+xPcfswVlAdKqb/c7hSFz6JALxYSB
	HOVhbr8sU3ABn4/+hJV7mBlZoqY6e4n2mUp24QMqo0OKxKtL1s+4kQn5Hs6gbfN2I2wPGGRh8Dj
	T3O5M8gEPPvSHSpMVrcv/L/Np1BGysH70fmtt9D+WFczUxL/mowvN+CMhWmyBiwoF1enc6nNSNX
	qgXEEZXajJVxrPlPvY4kEOLYKvacwByk+C7KiSrY6jNx7rwH2h0Th6pIK/cc16cMY3KdW4t2KhV
	TTbKxyyyKmjSsBJavhl9D0oYhV2dgGhaeiqykl+rSmClJ809akB3f9Efz7mBhbu48Nw==;
From: Daniel Wagner <wagi@monom.org>
Date: Thu, 12 Nov 2026 22:23:18 +0100
Subject: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
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
Message-Id: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDUxI0hcRSyqBuM/LSIRd1csv
 8V7Fzi2wg7y4ALLhzhZZg8MAzCdnltWUnsDRZQiIim7jVpN42IGRTrJqMEoiWMGH6yWGzm/WVH
 +dnvVs9neA9z3A5GEOSVuAAAA
X-Change-ID: 20261112-rtla-mlock-2a572f10533e
To: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>
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
 tools/tracing/rtla/src/timerlat_u.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
index c80edaf07b00..42aaf1d7f216 100644
--- a/tools/tracing/rtla/src/timerlat_u.c
+++ b/tools/tracing/rtla/src/timerlat_u.c
@@ -15,6 +15,7 @@
 #include <pthread.h>
 #include <sys/wait.h>
 #include <sys/prctl.h>
+#include <sys/mman.h>
 
 #include "common.h"
 #include "timerlat_u.h"
@@ -69,6 +70,15 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
 		}
 	}
 
+	/*
+	 * Keep the measuring process in memory: the latency it reports
+	 * runs until it is back in user space, and a page fault on the way
+	 * (its code, stack or libc pages reclaimed under memory pressure)
+	 * would count as latency. cyclictest does the same with -m.
+	 */
+	if (mlockall(MCL_CURRENT | MCL_FUTURE))
+		err_msg("Could not lock timerlat u memory: %s\n", strerror(errno));
+
 	/*
 	 * This is the tool's loop. If you want to use as base for your own tool...
 	 * go ahead.

---
base-commit: ee83899302a0457a3ba47464a13e8682bd7ba27d
change-id: 20261112-rtla-mlock-2a572f10533e

Best regards,
--  
Daniel Wagner <wagi@monom.org>

