Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102FA37E316;
	Tue, 14 Jul 2026 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028288; cv=none; b=rbeSTce6R/82UmqaLCa2trIeU2uizkSCyVkGWoMfBNAihjqqgBBxOiMMpRp7goXdKPsOROUmbm4AqkZYIIX0VkeOBAabTnG6+UGvRM3jgxTSDJKrrAi6aiONeUqyipU6aEyeTGivtLmfjwJYJXR5WLywWg6/7RsVYhmYmI1Z7C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028288; c=relaxed/simple;
	bh=xwnVB3jSCMT0uTIjvCYcV+Y7V8WSloPYMu8UDRYcicc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBn59dxmaPtWD20BmH6cgW9Jpaq624Yu82VeBQm4PRjtjCYBf6wk+qhOrBEUQCObHHx0eNRf72akSXqQ2yXWjmaYHxZp+aehGBvYKzQkf8XQl86dBbqryY6XyWs4xOb4ZbR+mO+ftWL/NwJgeZQ8ztnPGtyafpif3CaDazk2Vnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 812A3A0376;
	Tue, 14 Jul 2026 11:24:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 9B6BB2002F;
	Tue, 14 Jul 2026 11:24:37 +0000 (UTC)
Date: Tue, 14 Jul 2026 07:24:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Add mutex to trace_parser to fix concurrent
 write races
Message-ID: <20260714072440.4ff92b33@gandalf.local.home>
In-Reply-To: <059bee5e-6852-4afb-a993-dd5ddcd86d3e@huaweicloud.com>
References: <20260713134640.708323-1-wutengda@huaweicloud.com>
	<20260713153624.48fc4be4@robin>
	<ae69656e-fc50-4049-94f9-d460c2e1d5b8@huaweicloud.com>
	<20260713221318.63f741ad@gandalf.local.home>
	<059bee5e-6852-4afb-a993-dd5ddcd86d3e@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a6gqa6tj8wnp1t4puheieg117de5b1d5
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 9B6BB2002F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Yihg6SLCzDXeH97maO2Jf5p+X69uTAOU=
X-HE-Tag: 1784028277-762485
X-HE-Meta: U2FsdGVkX1/fKPjLnEThu8XEikzu1iNLPZXjS53UWV15qvagdhumby6QBqqKdu0tvpcTijkkmzvDM1npMOJaWTwUUwYBjIG+dAG9OjYyD36ZG2wGlP7BREtWNc8KevBDktizfvA0FkI8+jF40xMvd3frIP0wUFPc5b+Dqop5sdFbjxS6307siLAqhZq8Hn2KE64cvZSp5dqBLMAnpQclKzTopzovISlPUgBdf1OXKTdiEHe2SL0OqL7KlFq9Uiy01JD8PXg/Qm+kXPlTMJHYuqT2WR/Kr3TuGXs7g38Tjm2+TqIbLZVNCjUrIuPMsib63wqs+nkPmfwrqWFfWDuPp+51SaHjfrvb

On Tue, 14 Jul 2026 18:16:26 +0800
Tengda Wu <wutengda@huaweicloud.com> wrote:

> _Approach 3_: As you suggested earlier, build on v1 but add proper lockdep
> assertions to enforce that the parser lock is held by all callers,
> regardless of how the parser is used.
> 
> Approach 3 seems cleaner and more straightforward.

I thought about having a global lock as writes to tracefs are very much a
slow path, but I think Approach 3 is probably the most "correct" fix.

Yeah, let's go with that.

Thanks,

-- Steve
