Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56F308F23
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jul 2026 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095499; cv=none; b=fU7ugA/cINOmtSuAWrxt/+lwkZTGOVDp5ZYTKiv158bFHrwusnLwBxEg0hBRAv1HocH0K5OvwfIqzsH8BWgwl3hX0B7ixaVn1eCD8PsDKCztsNfyjMDp9xBt68w67CdaAdWek05WyptWXWE/Ec/KLwSMpOELfn4xEScH9umoguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095499; c=relaxed/simple;
	bh=ph89zfv3qBiBWiP7CCnGL0Z3dZiwbt5AcB/WIbfuB4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MiBDOQ/fII2KKCjhmYiujoHIcZjLlyk0C8waP1I+wL279JQGwmF+M5Bo8pQ7Ov7Oo5GOB30o7Bdk4QNPPqGpidahbjOEOTk4BpD0oZCbpZdNmFa/UrU38OH44xloqW3omYMscpnqUZzqhW8Yw1A1RIusHUcbEFmrz0HvA7uH3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DdcS3mzW; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DdcS3mzW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0ZcLIV+MXtaZhotvtMI29MVfamql4gIPPd2IsLlUIg4=;
	b=DdcS3mzWPRDMrSp3vDEe+ebQuOnriQfu7+KyHSWTrpGaFiN1aVTBz9DkPjBibhVyUN1kKZ
	hkT5zGdLdTMZdxSthT6eX01p0bvtcyCgqiTKtJcKk5hA8/So0ytOSYv6D9NekmxFhx+8PK
	LPCSvlwv27J8Y8IyZpdmwo0b7iM1gRM=
From: Jackie Liu <liu.yun@linux.dev>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Propagate errors from remote event bulk updates
Date: Wed, 15 Jul 2026 14:04:48 +0800
Message-ID: <20260715060448.17674-1-liu.yun@linux.dev>
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
 kernel/trace/trace_remote.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0f6ef5c36d84..5212e685f0a3 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1149,11 +1149,22 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 	guard(mutex)(&remote->lock);
 
 	for (i = 0; i < remote->nr_events; i++) {
+		int eret;
 		struct remote_event *evt = &remote->events[i];
 
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

