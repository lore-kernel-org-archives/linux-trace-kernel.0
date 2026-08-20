Received: from mta1.migadu.com (out-22.mta1.migadu.com [95.215.58.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0147CC97
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244359; cv=none; b=fpqG7TFqvfkyRlqDUqtUJX12Sy0Mkg2KgA09Fs+qEppBr3FrWzGs3PzIj5nLxFwVwW4E8uk8ey37cFPBb+09CZ1lumOSylpQ+iqArCPI2j84iVL+fRvCVyyfw/fs3I3srG00KRIQXHCXsDBrt7gGA8N96X4FN+YplzftmSn49ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244359; c=relaxed/simple;
	bh=KgSsIn7n6rPCEzuv9vq7SpDsKMx4CvsjnRMQ9SjLX+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+xu0dqqAxyMtsGEI7UeRGhrBj0htUo80t+CAl9cEobk/p/OatYWk7jEeg1k5jnYiZMReYCFpuGK0IWR5qsPrIu6whWC3kyQSXFfDOblrPCnCKvp5J8CznccnHiVoCFr/IWAaun3Nktz7RYi5u6xMw/RjV8vwrcq/bKd4XKDZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w085SKAk; arc=none smtp.client-ip=95.215.58.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w085SKAk"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KgSsIn7n6rPCEzuv9vq7SpDsKMx4CvsjnRMQ9SjLX+I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787244355; v=1; x=1787849155;
 b=w085SKAkjtEfFILc+ugM57cW7n54cgT4wgKxzJ+K6to35zUtWyl5I4JOv0YGCfrFN1Q+XV1X
 66EAKO7xjpG3iNxnx/snLmCKKXNOJ7nn4T7SG/HU/AN8gK5HONhS768vllrRkCz2+H3au1Rblxi
 5nv3BQnViOVnNMHGn6ec7AkY=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: from localhost.localdomain (218.1.210.138)
	by mta11.migadu.com with ESMTPS id 2d47d8cec57a80ce;
	Thu, 20 Aug 2026 16:45:55 +0000
X-Mizu-Trace-ID: 2d47d8cec57a80ce
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v6 4/9] rv: Fix ha_invariant_passed_ns silent bypass of invariant check
Date: Fri, 21 Aug 2026 00:45:13 +0800
Message-Id: <b12480afcae971936571d9c0def64d3a8fa0be99.1787243842.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
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

