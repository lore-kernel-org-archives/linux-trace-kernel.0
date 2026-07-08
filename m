Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616AE1940B0;
	Wed,  8 Jul 2026 20:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543050; cv=none; b=WLCwpwnAr4uCCzISAT1jNHNR5nymm6F1LJRQWJtaCagueODYQUu+GfqAkd9E3w18yeW8/DE7dRLYRNFxiR3u/wLTngS2YI/m70dnpWEHMMAtyBm8o7Zwbi8ybilMqyguIt1z3ir59wjdgSPJkCwSoRM6gxR9RlUUqW09HPSkXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543050; c=relaxed/simple;
	bh=SIZPl2XcxXs1LXQsnyGl35vATLD4HdMWfX/gLbZBvhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lFFN0xt4aST/cQvs9pmudIJAKQkbIRMJrHrKqhRJB4BO0kNUOPYctfIPB2WjNTT0K1pwjEKKN5DNX/9Dxi+1F7GAVZDkA+Qxr2aVMeSTzsc15wbUXzQJ9NzUMV/jNPslnK0Wl9dCiqmcFsUICTdYo5X/LWmHBdQBYFyumtWKymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id D7606402CA;
	Wed,  8 Jul 2026 20:37:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id E4E4920026;
	Wed,  8 Jul 2026 20:37:25 +0000 (UTC)
Date: Wed, 8 Jul 2026 16:37:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>
Subject: Re: [PATCH] selftests/tracing: Have trigger-hist-poll.tc use
 sched_process_exit
Message-ID: <20260708163731.566a86aa@gandalf.local.home>
In-Reply-To: <20260708163539.1e1d845d@gandalf.local.home>
References: <20260708163436.058cc3df@gandalf.local.home>
	<20260708163539.1e1d845d@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E4E4920026
X-Stat-Signature: iq4p6wmauoah3suimyaq4y3smgy67r1t
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18w2NwUejGEK5hI6GQl5ax4ESd7w6A3IC4=
X-HE-Tag: 1783543045-743290
X-HE-Meta: U2FsdGVkX1/BLqEC4HSEpZVSq3jaEhPzMKJK8awTYW/T0SuzeFNSyIbRi1KFSbq1xqE3jgK8jOcFc+OIOcIvH9LAQHVUIilMxXWAECEYHhXpxfznlHo4u6GyfzJwsrhP4cCI6ZZ7SQfLuQ8Lnz6RkeaSlpVZLaIRnkP9iVbzAtlQ5xYT7xheEY7ze1HEFujzLd4RFEP4YLiTv+9N2IdMzXMlKOgSU5cRThV1BqUUQcCNJd8ad77ANrzwu2ITmmo/8eQ2egFCjHL3hxOLN8Ghgv7xml6BYE7sw0D9HXbCDJCt75SHLq0SyMbkTDK5YWgbMHF6O4ARiCZm5HUG5lNE8q5VDa/gEga7JUiq+1Ng8qwPbHrAPT+WRtS3hkAnBjUe

On Wed, 8 Jul 2026 16:35:39 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I forgot to mention that I tested this with and without CONFIG_RCU_LAZY.
> With that config disabled, the test passes. With it enabled, it always
> fails.

And I also traced it with:

  trace-cmd set -p function_graph -l event_hist_poll -O funcgraph-retval

and it shows the sched_process_free being called for the sleep process
*after* the poll finishes.

-- Steve
