Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C2241CB5A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Jul 2026 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525163; cv=none; b=oQ9dIhwChlxlDI/PturxmD1FhWWlt1q0DxlbTFnyqmbaSDqOWuN0/9F56dK8sGQMNFyYq/4iTV1BEidrj+22uGnXSTbO5DfYIxdiUK2rKOrJX0j4whXWFl975yrXw3t3of40yZk7QqgHLYc54CMmK1ScLZ1YuDiPq1lKzMNKoOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525163; c=relaxed/simple;
	bh=nY4SWFLYIixvCSlJRfHv8cZQPX48Q8Y6mEE2vEUraJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dkp65o4R6WrtuJHo91QFUDyLgd7VmuQ2lnBEutCo6bihwCx4yEU0geijwzoYE3jzYpNkR+ZnGtb9+DV3EiwMVHUaMF8dCjDmw1fsygnfHKrUx6Ekd3vqR82BWZnMLqbR61sN2hcjDELmObYHuEg5ftQJo6cNb/HyfjcqTq43Ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TxQ4j7E0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TxQ4j7E0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783525160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CqHkdl+60f9/63R7GCGJP3HdRCb/L+LlnCxXcUtxWKI=;
	b=TxQ4j7E0px47pixPt1zlw3iYUqWA6Jfiv0GYUrI2jo1KYhOKQs6NRqG2YCfh5ttb0/dsSo
	t6/tjP7zthfbtNLfVNBsa3LLmvHrK149eEsuqGkJxLGt/eYI7xLXecMcfJMoLkvZ/uQxWX
	RsNNgNZTWIGsAyElraYScqQRoGF+3Ww=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v4 4/8] rv/ha: fix ha_invariant_passed_ns silent bypass of invariant check
Date: Wed,  8 Jul 2026 23:38:30 +0800
Message-Id: <d83c7bff76922ba464d328758ec24b7bf41d4824.1783524627.git.wen.yang@linux.dev>
In-Reply-To: <cover.1783524627.git.wen.yang@linux.dev>
References: <cover.1783524627.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 83199f90afe8..dddf5694bcc8 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -375,12 +375,12 @@ static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
 static inline u64 ha_invariant_passed_ns(struct ha_monitor *ha_mon, enum envs env,
 				   u64 expire, u64 time_ns)
 {
-	u64 passed = 0;
+	u64 passed;
 
 	if (env < 0 || env >= ENV_MAX_STORED)
 		return 0;
 	if (ha_monitor_env_invalid(ha_mon, env))
-		return 0;
+		ha_reset_clk_ns(ha_mon, env, time_ns);
 	passed = ha_get_env(ha_mon, env, time_ns);
 	ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
 	return passed;
@@ -414,12 +414,12 @@ static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
 static inline u64 ha_invariant_passed_jiffy(struct ha_monitor *ha_mon, enum envs env,
 				      u64 expire, u64 time_ns)
 {
-	u64 passed = 0;
+	u64 passed;
 
 	if (env < 0 || env >= ENV_MAX_STORED)
 		return 0;
 	if (ha_monitor_env_invalid(ha_mon, env))
-		return 0;
+		ha_reset_clk_jiffy(ha_mon, env);
 	passed = ha_get_env(ha_mon, env, time_ns);
 	ha_set_invariant_jiffy(ha_mon, env, expire - passed);
 	return passed;
-- 
2.25.1

