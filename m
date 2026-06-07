Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA94117D2
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848882; cv=none; b=JJAtGZ5No3ZKs4L6OQIazOOoxsrzgaWrrWJqBOJT6zJLMK9/NgvUPPgNH5oYqrX2V4ReDui1y16S5eqxcbahdGt1ixsT2W3NAFU7wJtRMoSmdI3SgKEE8NCkW5nZCFBCyP3MUyPBfjCsT848f3NUeN/FnW4AJ6gIoqiFwI28ZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848882; c=relaxed/simple;
	bh=qRcbRg2kvaOTUbUuk6Al5IyrKHvBHPRPQhk+xs1j/Dg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgE0ozLvWEqK9dykQ9dC8PL5Aepbuu9N8K12YFwpd0eePdQibOYeqdoepkShIdo4nIUn59Kr/VWFbZjuFI2iZoaC42efC8PM1jWkXmVRy5JFHDJ8OCx+VCDNYQFF0tuzY1fycPdtsDpXWzJzBohh48KY3zz6TnUXZg9megcNKjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iBo59a77; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iBo59a77"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwFNsriPgqYIAIlhGCIFtiiXjQR40oHUeanwuLnxKUo=;
	b=iBo59a77V0x3vrXuc3Airj9soEek9NquXxA3lkZeX3X0RFGqot+vvX/9YyxBZG7G13mJ9M
	1Mb+88iDtmHj5dZ1ORi7Dh/5vtS63xq+vAyCWj3MhkcXbwndufsf3bAUbDop7KfozHblzV
	lAQVA5b5YWlZkFJ767xKoCU5tXgL0pA=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 4/9] rv/ha: fix ha_invariant_passed_ns silent bypass of invariant check
Date: Mon,  8 Jun 2026 00:13:52 +0800
Message-Id: <812b7b8e8979b4ab00ac7727e3fea578799f2a8b.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

The function is documented as "prepare the invariant and return the time
since reset", but on the first call (env_store == U64_MAX) it exits
early without calling ha_set_invariant_ns():

  if (ha_monitor_env_invalid(ha_mon, env))  /* env_store == U64_MAX */
      return 0;   /* ha_set_invariant_ns skipped, env_store stays U64_MAX */
  ...
  ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);

This leaves env_store == U64_MAX, so ha_check_invariant_ns() always
passes on the first activation regardless of elapsed time:

  return READ_ONCE(ha_mon->env_store[env]) >= time_ns;  /* U64_MAX >= any */

Fix: establish the guard before converting to the invariant:

  if (ha_monitor_env_invalid(ha_mon, env))
      ha_reset_clk_ns(ha_mon, env, time_ns); /* guard: env_store = time_ns */
  passed = ha_get_env(ha_mon, env, time_ns);
  ha_set_invariant_ns(ha_mon, env, expire - passed, time_ns);
                                 /* invariant: env_store = time_ns + expire */

Apply the same fix to ha_invariant_passed_jiffy().

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/rv/ha_monitor.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/rv/ha_monitor.h b/include/rv/ha_monitor.h
index 28d3c74cabfc..e5860900a337 100644
--- a/include/rv/ha_monitor.h
+++ b/include/rv/ha_monitor.h
@@ -365,16 +365,22 @@ static inline bool ha_check_invariant_ns(struct ha_monitor *ha_mon,
 }
 /*
  * ha_invariant_passed_ns - prepare the invariant and return the time since reset
+ *
+ * If the env has not been initialised yet (first entry into a state with an
+ * invariant), anchor the guard clock at the current time so that the full
+ * budget is available from this point.  This preserves the documented
+ * guard→invariant ordering: ha_set_invariant_ns() is always preceded by a
+ * valid guard representation in env_store.
  */
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
@@ -404,16 +410,19 @@ static inline bool ha_check_invariant_jiffy(struct ha_monitor *ha_mon,
 }
 /*
  * ha_invariant_passed_jiffy - prepare the invariant and return the time since reset
+ *
+ * Same first-use semantics as ha_invariant_passed_ns(): anchor the guard clock
+ * now if the env has not been initialised.
  */
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
2.43.0

