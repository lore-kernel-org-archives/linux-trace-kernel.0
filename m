Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563C1301481;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764106788; cv=none; b=D8ZMqekJbybrtSGBT9YcpSDNshvnyZ/ArcwEzBbJSm1Ran80yjGYptKAnmWK+0w7aOnKsAA7b7UXKbgGpQlcDN4yunCEh0NnZCHz8Ss/G/o2MJuLj1JDfeGlS6M4IuPxUh/ozL8p4Fs1Lu1Z2y0TKhuTccsaXZr+qwjIc12tUwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764106788; c=relaxed/simple;
	bh=Xokl0hfcRa58KbExXeNKCxrDCiPFSBZOqgzvcMmCh6Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OhgVL0RpD2HOxVaeRqrIDGYWS6uJbFSKmTstaHzxEbGqb9UWkKC1yaeK27v8Er7ZX2/GO28sOf/fUun+vSyuy1iLBgnA+klTe8MO04Aj/2BYh31ROFePBmiolFf6W1bFMDGAFZC6Se8dypoKFMeugJHMJubrNF3FPRErSXZhIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VibIE6Rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VibIE6Rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D7EC2BC86;
	Tue, 25 Nov 2025 21:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764106787;
	bh=Xokl0hfcRa58KbExXeNKCxrDCiPFSBZOqgzvcMmCh6Q=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VibIE6RnYt8vuQwjSGR+jSbyFE21VPcNc5f+wWAteNauU2npfm3IEEqhS6bZx8/nh
	 MHkqGLZce1dGx6aj1b6yOJVy1wsdtpOfSPzd2lI/ROeg04MSe2wP2zkMw64IeuHh+S
	 8Q5cQSzRPITZNm385rfpKGVaTWGDbODIgoJFrJk8+O36gUxFEyUW2USPIaoWiPVa5H
	 OInM21WAEdKIBLzwF3w6+fTj/y3rRhC3Onzi47QNAkU2qyeQpaInEn7QXWCow1ymJi
	 07j6A/FCw3ucqf60+VcxwKXnIWrNGTEShI7soG1sRlvFYaZ7uznEGIo10kkbTB9l3I
	 aNm/6OR9KxnlA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vO0m0-00000005rOt-1xos;
	Tue, 25 Nov 2025 16:40:32 -0500
Message-ID: <20251125214032.323747707@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 25 Nov 2025 16:40:07 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 3/3] tracing: Use strim() in trigger_process_regex() instead of
 skip_spaces()
References: <20251125214004.396482401@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function trigger_process_regex() is called by a few functions, where
only one calls strim() on the buffer passed to it. That leaves the other
functions not trimming the end of the buffer passed in and making it a
little inconsistent.

Remove the strim() from event_trigger_regex_write() and have
trigger_process_regex() use strim() instead of skip_spaces(). The buff
variable is not passed in as const, so it can be modified.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3b97c242b795..96aad82b1628 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -308,7 +308,8 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 	char *command, *next;
 	struct event_command *p;
 
-	next = buff = skip_spaces(buff);
+	next = buff = strim(buff);
+
 	command = strsep(&next, ": \t");
 	if (next) {
 		next = skip_spaces(next);
@@ -345,8 +346,6 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	strim(buf);
-
 	guard(mutex)(&event_mutex);
 
 	event_file = event_file_file(file);
-- 
2.51.0


