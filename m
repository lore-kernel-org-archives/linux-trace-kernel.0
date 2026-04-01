Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79784779A5;
	Wed,  1 Apr 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054430; cv=none; b=HNuXIc87zyhklYqN4DyXtAssNOrk/zdApr/oPm4xLCrAeBK+tB8655V/s+DRguuYcp3Hf+dNb3kTCKVJL33P8qWEYv0eRh6w+iYSQXKZtSycEe+iWtavQwTRtKZP1KRfpTcfSK597WNcQ3b/d2aGB1kHSOx+1Ecu3sHXB0uBBWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054430; c=relaxed/simple;
	bh=Va7sdOM42iHClAcV5UsPJ/Z7QJQwex4SsOc4e6A691k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YM5a9V6M4xP3GRio9R0xM4oR65JTB8LQMUoReTRPXu+b/pRFLgwI2lEpwSYUHYDPwkGmmLq1OJQkELtXen3n/HsMEYueWSKAfOj8SmrY4dGJotFi7TAD0ZfP3AjiMg5dppWYbOlBO2HeC1B7AI5TZVHIyJff+gBqsK+4GWI3Lng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id D205514094A;
	Wed,  1 Apr 2026 14:40:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 01D4720013;
	Wed,  1 Apr 2026 14:40:19 +0000 (UTC)
Date: Wed, 1 Apr 2026 10:41:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/3] tracing/Documentation: Add a section about
 backup instance
Message-ID: <20260401104120.0e4a364a@gandalf.local.home>
In-Reply-To: <20260401121541.e2c8c549ae172ccf2d5e3035@kernel.org>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497476117.569199.18085846838539980210.stgit@mhiramat.tok.corp.google.com>
	<20260331172105.609d59aa@gandalf.local.home>
	<20260401121541.e2c8c549ae172ccf2d5e3035@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 01D4720013
X-Stat-Signature: gh1po3cyb937saonukdxhdzs94fsm5oa
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+ORugR7/XsZXsHFVkD2bE2kkzCXP3+eaw=
X-HE-Tag: 1775054419-894820
X-HE-Meta: U2FsdGVkX1+ZvXSFD3OohE0Zm7RJKnbNK5lTmXj2m9geKDELPSNfl5vf6w5BYH19r7z8pPLkDcJPwVtaxMd18L3K0uGOztGpzdB1mkbXGpno44sfcWW0nRxoS45ycWqk9MZljT64XNWdPjOBKO3xpUw52fRe0Eo3dCApq3mSlMf1X+ubSJ0zkV3wBI8ODbYFaz4VyNGHQ7CmaYecGlr05IqgNrDUjbHv2hydpLh1dw/oxUZhJiTBEOYbnNUqsvahMi9nCbgc+QdvuoWJAm7Xw2XSSqQVeK9vPHp+yzJgeaZu87YVJOXYZ1odnf/kWdD+LTs1yLE4YkPaquda+U4YgGofk5LV+b/4

On Wed, 1 Apr 2026 12:15:41 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > +It is also possible to record trace data at system boot time by specifying
> > > +events with the persistent ring buffer, but in this case the data before the
> > > +reboot will be lost before it can be read. This problem can be solved by a
> > > +backup instance. From the kernel command line::
> > > +
> > > +  reserve_mem=12M:4096:trace trace_instance=boot_map@trace,sched,irq trace_instance=backup=boot_map  
> > 
> > The above didn't actually work well without my patch to enable events on
> > the persistent ring buffer with the backup. But keep it, as it will work
> > with my patch ;-)  
> 
> Ah, thanks!
> Let me rebase on it.

Well, my patch hasn't been added yet ;-)  But don't change anything. When
this goes upstream both patches should have been applied.

-- Steve
