Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E31F131A;
	Wed, 25 Mar 2026 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774399149; cv=none; b=BvDA58OweuztBMMgkmwM3tz2hVQ+fS93ewKOk8//dbgzWc2IRR93y1aOY8Rj5EkQ8HBi8R2gCmQ7dJHSV8QTC4F/pxGQsOXLfQUB8953yQAlliwra224HqIi/A8Jqj/3Up0vbZpGq1zxoNnbI7T8zUfA2Z3271E2ZkqX1fmKTcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774399149; c=relaxed/simple;
	bh=v9nVtkgomUSc1IRScY47sFc/pRIQ0acbwpwiN/eIRWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJiRz/B31m39X57L87lnTbhUjYjJkLHTI6jh8wkIujtKRxn211xeKXxzRe7VEarI2ZRTNyz5yRKzodfCPviwYmELVeRS1JoGnJKgqX7wDKmrVR1hTwZrTLtHK3EbarCewdywztoFCieCTIKc7onynkWD3E1Jcs5rF7XiosSH3Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 103CE16056E;
	Wed, 25 Mar 2026 00:39:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id DE01820034;
	Wed, 25 Mar 2026 00:38:58 +0000 (UTC)
Date: Tue, 24 Mar 2026 20:39:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v12 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260324203941.2bd628d9@gandalf.local.home>
In-Reply-To: <20260325091304.c94f4e9505660202f96006a1@kernel.org>
References: <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
	<20260324172557.04cfc2a9@gandalf.local.home>
	<20260325085644.4310a1295b0b962ed87b5b60@kernel.org>
	<20260325091304.c94f4e9505660202f96006a1@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jc441idujywbpsh9gwsaqm3hrsxmdd1o
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: DE01820034
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18bA6cn+APvAiOfPT0eIDe3Rn4zS6WCY+E=
X-HE-Tag: 1774399138-146996
X-HE-Meta: U2FsdGVkX19AGGIdAcOz3Mmrs96VrddLYT4WCQh+lHYqcIePSum4Xzc0DPsI6Ud4FrUtM56ozce4tjO2LEeMm41+ZxoXkQd+U7mDu5/lsh2S+A7FwWjhyje21s3VBG9GlaUpmZotKDaCbNdknZGtl+lqZpyg9VfJYnKKce5M/4Q306Vm2wM+iU+1dJi2Uf0nYHSeCSRKO6wlRtQpCYf/O2gITSjXjhW3sM/KeIucX75vNliLg1kB0wcFWNQF+4pm4pbGrDsSu7VkHaRQ6/40WpW68PlZNTQoF4DEx6C5ckVWn20gjQdNQOsC5m5LYR25smjsLKm2LF31ZmisQc+Po0km5FZ3eXjZ

On Wed, 25 Mar 2026 09:13:04 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> I found the branch does not have a fix [1] and it makes a conflict with
> [2/4]. Can you update it to merge the trace/fixes branch?
> 
> [1] f35dbac69421 ("ring-buffer: Fix to update per-subbuf entries of persistent ring buffer")
> 
> I can send a series on ring-buffer/for-next but I think it may
> cause the same conflict on git-pull later.

Ah crap. OK, let me merge in that commit to the for-next branch, and then see if it works.

Thanks for letting me know.

-- Steve
