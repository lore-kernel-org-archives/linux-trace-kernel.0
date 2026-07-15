Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B772337B01F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101531; cv=none; b=jc81Ks/Ej4NUGEwrV0NTG3gP7t1bfiFHuDMW8ibT9Pcx8ehxE5IvGt/n+Vv/0MySRlsXmz02WMkTnYt00AB+JWT/SNbPM92h9xywi698feYQ5PfMnSvrDF2Nh5PoiG0nUIx22l1Ef1skjLludxciEHPSMHGWxAeiRoVI00lMMX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101531; c=relaxed/simple;
	bh=vT9PIOYECja89IIwuQdXqGlscaPpmMPvGwMWzKD7tiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LUOzChgEzjOUk/YjGgk4Qvk+3cQ2mH4+Vmy2aE3mVGjZ/ayp9GRJwURMTL6WGkfIb6tyFpIo9KA2EMoyDXL0wV/gdpm5/ND4fAprTpCzVz23z99RJ+5G+m/CI6vrrUuAgmD9ijBuofR5JD1tZD5Oh5ogKbTLhRFMBy8b5jdEGow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kAaTIWgZ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kAaTIWgZ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784101526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wnudDTQVQP4ONRjW1Y6g3NWcfdqz5PXw8KBZumVOFmw=;
	b=kAaTIWgZdfM4j0glHH29KCIsOkwFacHP0H4qnbHCnxOwxsSx4v1EVyWv7B1PI6X1TzOgQT
	w//Ha0uq3C3ANPK8EfjFWKIVyQMhuwVwnDAaZBBtP+D+ErpU2pfsg8YquF7SMRWdBXWwPV
	MIF7MoKxBAwX2d6cAVGkXxzfH5aMp2Q=
From: Jackie Liu <liu.yun@linux.dev>
To: vdonnefort@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Propagate errors from remote event bulk updates
Date: Wed, 15 Jul 2026 15:44:55 +0800
Message-ID: <20260715074455.3897-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

remote_events_dir_enable_write() ignores the return value from
trace_remote_enable_event(). If a remote rejects an event state change,
the write therefore reports success even though the affected event remains
in its previous state.

Keep trying all events, but retain and return the first error. This matches
__ftrace_set_clr_event_nolock(), which permits partial updates while
notifying userspace when an operation fails.

Fixes: 775cb093bc50 ("tracing: Add events/ root files to trace remotes")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 Changes in v2:
- Move the eret declaration after evt to follow reverse Christmas tree
  ordering.

 kernel/trace/trace_remote.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0f6ef5c36d84..daeaf1d3eb1c 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1150,10 +1150,21 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 
 	for (i = 0; i < remote->nr_events; i++) {
 		struct remote_event *evt = &remote->events[i];
+		int eret;
 
-		trace_remote_enable_event(remote, evt, enable);
+		eret = trace_remote_enable_event(remote, evt, enable);
+		/*
+		 * Save the first error and return that. Some events
+		 * may still have been enabled, but let the user
+		 * know that something went wrong.
+		 */
+		if (!ret && eret)
+			ret = eret;
 	}
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
-- 
2.54.0

