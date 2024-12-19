Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C141BFE0D;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639184; cv=none; b=pYLhEIeV5vR14zZawMkvmJdqFJD0BBGhJqCZp0oiStAtnvERbhkfwQBiettO/Bw4/ZK4SCcv27v/K1XoJT5XUq3shjvs8x9TfMwTtxPkyttE8KSihTiIo1sWxf5rvjoDmq1H1IgdV819a2qUExELXtig44vAU50fBqNjEAHYUfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639184; c=relaxed/simple;
	bh=kvAMisu3ML+/eLW8vclpmuOSMczyjoXGnxfkus1v+rM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DdWrowQGmBhvlUbKFx5jb6IsoW6HkuDTBlOHj8wu2UoxKz4AEyX1EjjVCSsTB/pMpjJMEZ5mhjufdnTX/c0teK4PV2O33YDggFCBUQ6SzFASWXpyBJIYTcIQErdiH5pzWMf0nZ8QJoPY0/vsrgT4crOO+OuRndp+qxbt/Yv5SAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D78C4CEDE;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu2-0000000AOKw-0kbR;
	Thu, 19 Dec 2024 15:13:46 -0500
Message-ID: <20241219201346.029319524@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:07 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Kees Cook <kees@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 linux-hardening@vger.kernel.org
Subject: [PATCH 09/14] tracing/string: Create and use __free(argv_free) in trace_dynevent.c
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function dyn_event_release() uses argv_split() which must be freed via
argv_free(). It contains several error paths that do a goto out to call
argv_free() for cleanup. This makes the code complex and error prone.

Create a new __free() directive __free(argv_free) that will call
argv_free() for data allocated with argv_split(), and use it in the
dyn_event_release() function.

Cc: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/string.h        |  3 +++
 kernel/trace/trace_dynevent.c | 23 +++++++----------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 493ac4862c77..c995f973a59a 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -10,6 +10,7 @@
 #include <linux/err.h>		/* for ERR_PTR() */
 #include <linux/errno.h>	/* for E2BIG */
 #include <linux/overflow.h>	/* for check_mul_overflow() */
+#include <linux/cleanup.h>	/* for DEFINE_FREE() */
 #include <linux/stdarg.h>
 #include <uapi/linux/string.h>
 
@@ -312,6 +313,8 @@ extern void *kmemdup_array(const void *src, size_t count, size_t element_size, g
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
 
+DEFINE_FREE(argv_free, char **, if (!IS_ERR_OR_NULL(_T)) argv_free(_T))
+
 /* lib/cmdline.c */
 extern int get_option(char **str, int *pint);
 extern char *get_options(const char *str, int nints, int *ints);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 4376887e0d8a..a322e4f249a5 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -74,24 +74,19 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	struct dyn_event *pos, *n;
 	char *system = NULL, *event, *p;
 	int argc, ret = -ENOENT;
-	char **argv;
+	char **argv __free(argv_free) = argv_split(GFP_KERNEL, raw_command, &argc);
 
-	argv = argv_split(GFP_KERNEL, raw_command, &argc);
 	if (!argv)
 		return -ENOMEM;
 
 	if (argv[0][0] == '-') {
-		if (argv[0][1] != ':') {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (argv[0][1] != ':')
+			return -EINVAL;
 		event = &argv[0][2];
 	} else {
 		event = strchr(argv[0], ':');
-		if (!event) {
-			ret = -EINVAL;
-			goto out;
-		}
+		if (!event)
+			return -EINVAL;
 		event++;
 	}
 
@@ -101,10 +96,8 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 		event = p + 1;
 		*p = '\0';
 	}
-	if (!system && event[0] == '\0') {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!system && event[0] == '\0')
+		return -EINVAL;
 
 	mutex_lock(&event_mutex);
 	for_each_dyn_event_safe(pos, n) {
@@ -120,8 +113,6 @@ int dyn_event_release(const char *raw_command, struct dyn_event_operations *type
 	}
 	tracing_reset_all_online_cpus();
 	mutex_unlock(&event_mutex);
-out:
-	argv_free(argv);
 	return ret;
 }
 
-- 
2.45.2


