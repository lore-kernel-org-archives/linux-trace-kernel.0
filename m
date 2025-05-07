Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7E224FD;
	Wed,  7 May 2025 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746629685; cv=none; b=EkBBTJ0ogwTy1My1ro9/ao1Om1ea23Adr0Q0Y2GzQeD42X74GFEFTWKlZw4tgI2bdgSM/T5vxdH5CwKihlh7BDEERcjvsmTYUSnJsLiJjGXzhuy9+w5lhoMRvX93O6hirQjaFo9cgJCUDyjOzstMuNGYmKgLyIASd5pPkx7qObw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746629685; c=relaxed/simple;
	bh=IwiAp9uOFERXy3htrC3HNT9zno3w4ocXT/bL16T2jVQ=;
	h=Message-ID:Date:From:To:Cc:Subject; b=SfY8fP65dp/4Aq8zqKWpcDbfS58WS4FdRQONuPv7y7XpNC3MBg2B9rFAPikNUz6+NYXO7C1ycMv7ExTa6Ub0hGjzWHhxUP5cYXU+p9BRGqzYzH/LWzzG/Zn/J9HBWRPDIQSVSqhUBl+NR36oKHWXQFIJ9rkBJs2V+cUkh2F+8Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC551C4CEE2;
	Wed,  7 May 2025 14:54:44 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uCgAh-00000001q9T-383q;
	Wed, 07 May 2025 10:54:55 -0400
Message-ID: <20250507145305.730136036@goodmis.org>
User-Agent: quilt/0.68
Date: Wed, 07 May 2025 10:53:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/3] tracing: Some cleanups of event trigger code
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

These are minor clean ups of the trace_events_trigger code.

- Rename event_trigger_alloc() to trigger_data_alloc() as it
  is supposed to be freed by trigger_data_free().

- Remove unneeded goto outs

- Add consistent cleanup in event_trigger_parse()


Miaoqian Lin (1):
      tracing: Fix error handling in event_trigger_parse()

Steven Rostedt (2):
      tracing: Rename event_trigger_alloc() to trigger_data_alloc()
      tracing: Remove unnecessary "goto out" that simply returns ret is trigger code

----
 kernel/trace/trace.h                |  8 ++---
 kernel/trace/trace_events_hist.c    |  2 +-
 kernel/trace/trace_events_trigger.c | 64 ++++++++++++++++---------------------
 3 files changed, 31 insertions(+), 43 deletions(-)
