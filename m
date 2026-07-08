Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678A2E7378;
	Wed,  8 Jul 2026 20:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542939; cv=none; b=LVVsyWxNKDA8kzqKXGAmr1i/NXHwNUiUO+ILLjk7YX5WRrKgd0rKs6S08Ifa9D8qV4y+h/i68yZGaGCBKBssgedbrCnTh+WJAISm6F8sOqnSH94rnWWKrp3wr2mdaRvZgOxKxlb5turiHfwefWun/7H7qia8dWXdQZTLLGH8nBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542939; c=relaxed/simple;
	bh=uJ/al909Jw5KQaOQUGDEhmhbqX9/CNuZenlTkjYA8Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nL5C5gxBpG9EWf4Ke11xx7EvexhTVIO5fao1fRjE+JygaIoB+iEpEWg7p+KkPeHxujLB/qq9IckEFCefZb3jZfWM0IF0dJ9tpIKP7rHzm8KcLTQfxtFsLOvG+iatyI/Dg1DGjVsLdfQRCeGjDBvdVlDMWw1HmdttSmfPrZOv3ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1B95E1A02D9;
	Wed,  8 Jul 2026 20:35:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 18E3D20038;
	Wed,  8 Jul 2026 20:35:34 +0000 (UTC)
Date: Wed, 8 Jul 2026 16:35:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/tracing: Have trigger-hist-poll.tc use
 sched_process_exit
Message-ID: <20260708163539.1e1d845d@gandalf.local.home>
In-Reply-To: <20260708163436.058cc3df@gandalf.local.home>
References: <20260708163436.058cc3df@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 18E3D20038
X-Stat-Signature: xos39t5dr4rttfu48kcu3t5ttzme17ok
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SBzRJUUXL9BDUEWPAJ2i5aX/sn2hzb3Y=
X-HE-Tag: 1783542934-279708
X-HE-Meta: U2FsdGVkX18bv8rWv1DfqOBVv4ss3CPLvysZcjyqSoL61XPLnkmGyOFlPFrzxharbLSpBIavWYmn+pe02r4xgL0fx6Epd6SNLkfA9NV9lVPQMIHE0zKfXbrMtxXVUUP3DneBb2oQN43hQRRNFENP4ViuMibEGjoQ2I4ZdqxfVVJCBUzXnyJlzy+eS6ueNK99pUA66kUJ1U2F/d/XdTf5okIDYBmeg2Fkc6Leq3EVFwLC+QKJ5XdDBah0YFKwt3nYYWdAVsR0tE9MVCzHfRLQyrk/miKyMJm67DGV97jLxKWhRlz61Q7X6Q/mf4dA0lsjQPMiV/jPC1Or7QevIVh/kS6xTWdKvirCGMLN1+53Bw5v7ZQrMJyb0B2CVTyZGs3R

On Wed, 8 Jul 2026 16:34:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently trigger-hist-poll.tc uses sched_process_free to test the polling
> of the histogram file. The way it does that is to run sleep, then execute
> the poll.c code that polls on the sched_process_free for up to 4 seconds
> to test that when sleep triggers the sched_process_free trace event, it
> will update the histogram and wake the poll.c code up.
> 
> The issue is that sched_process_free trace event is called by
> delayed_put_task_struct() which is called after a RCU grace period has
> ended. If CONFIG_RCU_LAZY is enabled, RCU callbacks are batched together
> and do not execute right away. This causes the delayed_put_task_struct()
> to be called after the poll.c function finishes and it will report an
> error that it did not wake up on the event. That's because the event
> didn't trigger during its wait time.
> 
> Use sched_process_exit instead, which is called when a process exits and
> doesn't depend on RCU callbacks that may be delayed.
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---

I forgot to mention that I tested this with and without CONFIG_RCU_LAZY.
With that config disabled, the test passes. With it enabled, it always
fails.

-- Steve
