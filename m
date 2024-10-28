Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE4191473;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730099539; cv=none; b=N8+XRH4sD+7Q9bEU0KmwjwrV36psc85mHtB+p0gFAOf0KRfwGF29sib6BEsaiBQcS3Hh4hy2wVIXrMi7KdqKUPrcLly1CeD3LKlc15Glzm4GMIUAyV7UT7+8ehkkluTi+oBfiMAAQdlv4/8F6iAtTFVtAVM/FYZjoz29mWz7oEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730099539; c=relaxed/simple;
	bh=9vBWJH11IbK66QgWVk9H9Vqyr8xXbIoeCjdz00lvw7I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RbuvSxBfZWswrDtTlIHmpuWKIF60XLR33b+eJXbPkEBS/zbLRu7fDOUf1bU3A4IMrne8YUCRzH3OVi3pbFF/Fvt/BziabhoteewW+9BGGHkUwh/5qho1N3BasY9UoqLX/fkpBmv2uNz1RJIINOzlfkg0hEYquLBdBUXH3WMQFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3A9C4CEEB;
	Mon, 28 Oct 2024 07:12:19 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1t5Jw4-000000053E2-0xwV;
	Mon, 28 Oct 2024 03:13:08 -0400
Message-ID: <20241028071308.088458856@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 28 Oct 2024 03:12:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 3/5] ftrace: Use guard to lock ftrace_lock in cache_mod()
References: <20241028071228.575900713@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The ftrace_lock is held throughout cache_mod(), use guard to simplify the
error paths.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 44adc34643c9..64997416415e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4947,14 +4947,14 @@ static int cache_mod(struct trace_array *tr,
 {
 	struct ftrace_mod_load *ftrace_mod, *n;
 	struct list_head *head = enable ? &tr->mod_trace : &tr->mod_notrace;
-	int ret;
 
-	mutex_lock(&ftrace_lock);
+	guard(mutex)(&ftrace_lock);
 
 	/* We do not cache inverse filters */
 	if (func[0] == '!') {
+		int ret = -EINVAL;
+
 		func++;
-		ret = -EINVAL;
 
 		/* Look to remove this hash */
 		list_for_each_entry_safe(ftrace_mod, n, head, list) {
@@ -4970,20 +4970,15 @@ static int cache_mod(struct trace_array *tr,
 				continue;
 			}
 		}
-		goto out;
+		return ret;
 	}
 
-	ret = -EINVAL;
 	/* We only care about modules that have not been loaded yet */
 	if (module_exists(module))
-		goto out;
+		return -EINVAL;
 
 	/* Save this string off, and execute it when the module is loaded */
-	ret = ftrace_add_mod(tr, func, module, enable);
- out:
-	mutex_unlock(&ftrace_lock);
-
-	return ret;
+	return ftrace_add_mod(tr, func, module, enable);
 }
 
 static int
-- 
2.45.2


