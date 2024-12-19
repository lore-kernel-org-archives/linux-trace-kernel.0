Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DED01D3582;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734639185; cv=none; b=n2RIAbGpyQfCeQEXj+hGeK/+uTkxW57OsYPd6SovOP/lKhtJlRZoDhEYy8lCd03yn3XGpzGpia5RO0pEvE4j5qB0gIT1NpfH0rlzE6pe9IND/ES3GLqq3hvtHF6c9TYjH38a07+0SPZih6Erx4dAJ8g5H+RGsWbGpUp+PsTBeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734639185; c=relaxed/simple;
	bh=c9xMfKkig45A3mKtXwuwrFVEsdApjCBPwqRSYVLg/V0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ln4dZXyDaxuwHoPwMIZGXQTgkWc/cNh5V+9BREeluxMBdSfHctjzN9fP2iRSQRobALEocHA179zIGtnYUntuGBHNWc3g13Wk1nvABd8qSeW1B/lTZ01eTdhopdpyxj2cgnBlmqpAFMTFNucCDga25DZGAyi8Xv1B6DkeUrGXy3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AECC4CED0;
	Thu, 19 Dec 2024 20:13:04 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tOMu2-0000000AOLx-29dW;
	Thu, 19 Dec 2024 15:13:46 -0500
Message-ID: <20241219201346.371082515@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 19 Dec 2024 15:12:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 11/14] tracing: Switch trace_events_synth.c code over to use guard()
References: <20241219201158.193821672@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There are a couple functions in trace_events_synth.c that have "goto out"
or equivalent on error in order to release locks that were taken. This can
be error prone or just simply make the code more complex.

Switch every location that ends with unlocking a mutex on error over to
using the guard(mutex)() infrastructure to let the compiler worry about
releasing locks. This makes the code easier to read and understand.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c82b401a294d..e3f7d09e5512 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -49,16 +49,11 @@ static char *last_cmd;
 
 static int errpos(const char *str)
 {
-	int ret = 0;
-
-	mutex_lock(&lastcmd_mutex);
+	guard(mutex)(&lastcmd_mutex);
 	if (!str || !last_cmd)
-		goto out;
+		return 0;
 
-	ret = err_pos(last_cmd, str);
- out:
-	mutex_unlock(&lastcmd_mutex);
-	return ret;
+	return err_pos(last_cmd, str);
 }
 
 static void last_cmd_set(const char *str)
@@ -74,14 +69,12 @@ static void last_cmd_set(const char *str)
 
 static void synth_err(u8 err_type, u16 err_pos)
 {
-	mutex_lock(&lastcmd_mutex);
+	guard(mutex)(&lastcmd_mutex);
 	if (!last_cmd)
-		goto out;
+		return;
 
 	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
 			err_type, err_pos);
- out:
-	mutex_unlock(&lastcmd_mutex);
 }
 
 static int create_synth_event(const char *raw_command);
-- 
2.45.2


