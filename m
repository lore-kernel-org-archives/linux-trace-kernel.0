Received: from mta1.migadu.com (out-48.mta1.migadu.com [95.215.58.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE24B8DE6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Aug 2026 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787163371; cv=none; b=jLOtMoCwon6ffo0/ZE2itcCjUriKmvVuPq27ZWO6WCawuv+3mDs02wXjtL8sAhfadtzWFpC46cmf6IFUqLjPooTqJHKkEbGVitWg78p+sCwM9KSOpO8ur0nUQT8tZsGohxvkAv9nJwsR6i0Xm9HG2xTNkhqFrq8z6cGnGb87zM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787163371; c=relaxed/simple;
	bh=KgSsIn7n6rPCEzuv9vq7SpDsKMx4CvsjnRMQ9SjLX+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TjxAOvinNIUvUNvi0DzPxzZTWUhBVrGNMB+T8mDEPC4YmWGokQfELqJRb5vsaUPeMrq7dQvq+b+UgHy0ugZUIViRaxE0O9+WqlL+uB8c8zBkgFGNKdo7PXUa9Qecvmfp3Qr9QPkOmnmPQTJ3hD6iAsPBHtFZlcQUNo10a/CD30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xKdYHgKf; arc=none smtp.client-ip=95.215.58.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xKdYHgKf"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KgSsIn7n6rPCEzuv9vq7SpDsKMx4CvsjnRMQ9SjLX+I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787163363; v=1; x=1787768163;
 b=xKdYHgKfZLnt54gzaURDulM14Eq/PPEmdr2FhRQ4tMKDGZih1txVcsmZgQw2gEaC9cHx5WTB
 bQSGpjM2pbN5HJXEIw2I2b+voi7vlK6H8nsj8yQSLByu4XRJdTR2TayZiMDTnFSKWo9qymJCpj0
 79T+pcO1Go8xUhkDYrAvIoQw=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (180.165.15.98)
	by mta12.migadu.com with ESMTPS id 2a29fa37307592c7;
	Wed, 19 Aug 2026 18:16:03 +0000
X-Mizu-Trace-ID: 2a29fa37307592c7
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v5 4/9] rv: Fix ha_invariant_passed_ns silent bypass of invariant check
Date: Thu, 20 Aug 2026 02:15:21 +0800
Message-Id: <0cab75f11e598ffb0137209e009d02e5705dc127.1787161646.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787161646.git.wen.yang@linux.dev>
References: <cover.1787161646.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

When env_store is U64_MAX (its initial sentinel value),
ha_invariant_passed_ns() returns 0 immediately without initializing
env_store to the current clock.  Subsequent calls to
ha_check_invariant_ns() then find env_store still at U64_MAX, causing
the elapsed comparison to wrap and always report the invariant as
satisfied, silently masking any violations.

Fix by calling ha_reset_clk_ns() to establish the guard on the first
invocation instead of returning early.  Apply the same fix to
ha_invariant_passed_jiffy().

This is a stopgap: once the RV framework reworks the per-env clock
guard, this first-invocation reset should be subsumed.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 6e1c7fe5449a..e1738d199b28 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -355,7 +355,7 @@ static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum envs en
 	if (env < 0 || env >= ENV_MAX_STORED)
 		return 0;
 	if (ha_monitor_env_invalid(ha_mon, env))
-		return 0;
+		ha_reset_clk_ns(ha_mon, env, time_ns);
 	return ha_get_env(ha_mon, env, time_ns);
 }
 
@@ -375,6 +375,7 @@ static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon, enum envs
 {
 	return time_after64(READ_ONCE(ha_mon->env_store[env]), get_jiffies_64() - expire_jiffy);
 }
+
 /*
  * ha_invariant_passed_jiffy - prepare the invariant and return the time since reset
  */
@@ -383,7 +384,7 @@ static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enum envs
 	if (env < 0 || env >= ENV_MAX_STORED)
 		return 0;
 	if (ha_monitor_env_invalid(ha_mon, env))
-		return 0;
+		ha_reset_clk_jiffy(ha_mon, env);
 	return ha_get_env(ha_mon, env, time_ns);
 }
 
-- 
2.25.1

