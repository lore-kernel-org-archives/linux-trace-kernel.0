Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC61B86E9;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639183; cv=none; b=tN5vVULJ1N9D6nIttYE4egPqOEIFbCOukN/Y8ZqlFOs9tlyHulUxKojat7TZNoeoyw1NktUZYkI4XgqZ21R0pQkyDvgwD7wi7PCoJJwEAIs/S+AoHrI3gQBQd0+/og9d0z3xYacg391hAORUrrDCe6Ls7X0piVFGurXp/PGlPTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639183; c=relaxed/simple;
	bh=gnK8OaB4/+UYeDkhNemmc5kgL3lyFNoGNyInAzUw5zM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ju8P/dyi9rqE7QnczBEpcr4Hhc0WwvE4TNt5JvK9q4/RjgdxA5tqni3VURfsGJhI9vytaGDm1gH+GmeDQjd6WNDakCK7Ub/8zEy5UCxa0DsGYKbOyeE0S+eiV0jWIP18ZB6ymFfW5gkU2ufOBn8T2nEJ/QYTXTr4lY8C5S8wlAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3F4C4CEDE;
	Thu, 19 Dec 2024 20:13:03 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu1-0000000AOHx-0iRy;
	Thu, 19 Dec 2024 15:13:45 -0500
Message-ID: <20241219201345.025284170@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/14] tracing: Have event_enable_write() just return error on error
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The event_enable_write() function is inconsistent in how it returns
errors. Sometimes it updates the ppos parameter and sometimes it doesn't.
Simplify the code to just return an error or the count if there isn't an
error.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1545cc8b49d0..f4eff49faef6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1549,18 +1549,18 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	switch (val) {
 	case 0:
 	case 1:
-		ret = -ENODEV;
 		mutex_lock(&event_mutex);
 		file = event_file_file(filp);
 		if (likely(file)) {
 			ret = tracing_update_buffers(file->tr);
-			if (ret < 0) {
-				mutex_unlock(&event_mutex);
-				return ret;
-			}
-			ret = ftrace_event_enable_disable(file, val);
+			if (ret >= 0)
+				ret = ftrace_event_enable_disable(file, val);
+		} else {
+			ret = -ENODEV;
 		}
 		mutex_unlock(&event_mutex);
+		if (ret < 0)
+			return ret;
 		break;
 
 	default:
@@ -1569,7 +1569,7 @@ event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 
 	*ppos += cnt;
 
-	return ret ? ret : cnt;
+	return cnt;
 }
 
 static ssize_t
-- 
2.45.2


