Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4141BDA8C;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639184; cv=none; b=NIdJCF2kEuufEf32L4+/q2vdxzax3gLHbDMkvaEs8qEU7b52UZzbakfQambacTgi2mJhDYZwaAb/44ZwXQZFumUgkUbusYX7kzOEBbicSCyihCrfdOVME1QZb8GDncSzbS75GhV3ucgpJek2ooeyvNrLRABapDfQQ9AmLDjAcCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639184; c=relaxed/simple;
	bh=T8WRxF34jKy0NLGUlt6un0JtZ0rU4gLUtrXUkcpRk70=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=VLauEkC4BY9cTNUSejvBGO53n6vycc3Iapbe/catJNYPcQGv5mA5w6tyMK6wpq11G+EHJNWBMuPItihWYfxSSGn06x/9x3tH3KomnGrr8b5sRifJGva9hRKOCkinh6OHEu1t0F6Gj3gTvw3fkAqlZwl662xFNMhL2rMXCS+6QrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47A7C4CED0;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu1-0000000AOIw-26iO;
	Thu, 19 Dec 2024 15:13:45 -0500
Message-ID: <20241219201345.354746196@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 05/14] tracing: Simplify event_enable_func() goto_reg logic
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Currently there's an "out_reg:" label that gets jumped to if there's no
parameters to process. Instead, make it a proper "if (param) { }" block as
there's not much to do for the parameter processing, and remove the
"out_reg:" label.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 43e9545b5cf3..86db6ee6f26c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3799,24 +3799,22 @@ event_enable_func(struct trace_array *tr, struct ftrace_hash *hash,
 
 	ret = -ENOMEM;
 
-	if (!param)
-		goto out_reg;
-
-	number = strsep(&param, ":");
+	if (param) {
+		number = strsep(&param, ":");
 
-	ret = -EINVAL;
-	if (!strlen(number))
-		goto out;
+		ret = -EINVAL;
+		if (!strlen(number))
+			goto out;
 
-	/*
-	 * We use the callback data field (which is a pointer)
-	 * as our counter.
-	 */
-	ret = kstrtoul(number, 0, &count);
-	if (ret)
-		goto out;
+		/*
+		 * We use the callback data field (which is a pointer)
+		 * as our counter.
+		 */
+		ret = kstrtoul(number, 0, &count);
+		if (ret)
+			goto out;
+	}
 
- out_reg:
 	/* Don't let event modules unload while probe registered */
 	ret = trace_event_try_get_ref(file->event_call);
 	if (!ret) {
-- 
2.45.2


