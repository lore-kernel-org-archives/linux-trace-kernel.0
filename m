Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F8368E17;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763672198; cv=none; b=QUBoP8/c59FyRxU1nLteIZXolPVQEyqRoSg6ZFoteKC6d4ZuljnJBN1K/Qlybdkuc1FV1aHwh+XV73rNpt7cnRegfUkAHrHvoZyB/o3iFSbL0XHyRaSNn8sCgDu9Saw7+1d9zT2T4YtYBpwEJSRgcuN/2KfaHuGPh90SCoX4U20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763672198; c=relaxed/simple;
	bh=8C5Q1w4EPe0MTRU5lmtulPwfzR7CqMI3MLyK+6S7Wk4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fSAIfHGpFlmkeYaMsvToDA7WiyAm/Uuf9ya17fQWcRldm4GvBmSQyXV0r+4lcnH36xb3dEsJY6HeTMq+J1wisBjZbK8BrtxcD0ajmAo3Jt+8m8LSxYwK4dLVxduh1ruyncx0Zxcbk67S0Wmo0vURWFY3JqSPGKFM/UYdGOh0d/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNco/rZ/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNco/rZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB9DC19423;
	Thu, 20 Nov 2025 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763672197;
	bh=8C5Q1w4EPe0MTRU5lmtulPwfzR7CqMI3MLyK+6S7Wk4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=BNco/rZ/hU49q0cYoAOOiI6Zi7ZRK3+w9OEPKFf7An88yFHc5WCCeXNrUDN8gFp3/
	 G6PZWIuBT7YqLVb7NQFRbVXM50GkkenmH7nMoG7WnvrTr2Zht04WzKmt6VKVmmcp0e
	 I419D3QwUiEK3POK70LkD5TxOcWIvPz8RH1N+j4H3Cse/4LAD7EsrgVGBayPEcH+AX
	 pWSfyOFTR+bsLQKsYcwxNVzsQ4sB3qIV30hJIe6Y/DxuTfEoilKg95yQv6OoQ6SMp+
	 BMCzCA8A/89gxpopDMZXtng10FJi9RocGPDH0jI4nhZ60h1U/mq01tZhCKgzw8I5Z1
	 Pb5/M5SPIOudg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vMBiI-00000003zCO-1vTj;
	Thu, 20 Nov 2025 15:57:10 -0500
Message-ID: <20251120205710.314839538@kernel.org>
User-Agent: quilt/0.68
Date: Thu, 20 Nov 2025 15:56:03 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 3/3] tracing: Use strim() in trigger_process_regex() instead of
 skip_spaces()
References: <20251120205600.570673392@kernel.org>
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

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 16e3449f3cfe..1dfe69146a81 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -309,7 +309,8 @@ int trigger_process_regex(struct trace_event_file *file, char *buff)
 	char *command, *next;
 	struct event_command *p;
 
-	next = buff = skip_spaces(buff);
+	next = buff = strim(buff);
+
 	command = strsep(&next, ": \t");
 	if (next) {
 		next = skip_spaces(next);
@@ -346,8 +347,6 @@ static ssize_t event_trigger_regex_write(struct file *file,
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	strim(buf);
-
 	guard(mutex)(&event_mutex);
 
 	event_file = event_file_file(file);
-- 
2.51.0


