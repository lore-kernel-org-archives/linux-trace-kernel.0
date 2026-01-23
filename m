Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678BC239E9A;
	Fri, 23 Jan 2026 17:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769190122; cv=none; b=KJ+6i8VbV1GyoNP+h32ipl65qL4ma8tja44oXDb1HZo1Z1O9DwfRpCfWHfSMK9n2ibOw715m8fTgjHt3EDjX4rQc9A+4ROURbHamJahcnxHn14JhVGCDB5FD3s6YEHPnNpYovj1K6x4ULNRlHXAG0IiMeGgQcnKDc+rkttWzItk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769190122; c=relaxed/simple;
	bh=RfMmAoVyjDRNcU9D238omex5NDRcm+yblcLBmObhjig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzkKAjXCnYjWqOI3C3JU+sNsWuljKb8ynrYt4d+EV5iB6+ybEgloj0GNWkj+VyBCgma9EA6j9sy+OtER2Z1w7QYT4YVqINm8/ff8/tOn/llWTC3s9BjNo+aNDPaJ0+S0CYoThRj4mLIMD9ZC0bA8Lk+E4mUVwcBP7+/EQOzC1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 2BB738BB50;
	Fri, 23 Jan 2026 17:41:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 6FCAE20029;
	Fri, 23 Jan 2026 17:41:51 +0000 (UTC)
Date: Fri, 23 Jan 2026 12:42:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Weigang He <geoffreyhe2@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/tracepoint-update: fix memory leak in
 add_string() on failure
Message-ID: <20260123124219.689f35f1@gandalf.local.home>
In-Reply-To: <20260121112253.3e02bd1ebb50ad6d1651bb1f@kernel.org>
References: <20260119114542.1714405-1-geoffreyhe2@gmail.com>
	<20260121112253.3e02bd1ebb50ad6d1651bb1f@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6FCAE20029
X-Stat-Signature: rpb17mx11mbxug6t6bqpgydoarms7wb6
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18TrLh5zTfvz7ZnIcwzLF4fSLNLZ3bj3Es=
X-HE-Tag: 1769190111-900534
X-HE-Meta: U2FsdGVkX183faBbw9ocLezPCAfZ0ybROsv1wMu9JH8Dl/d317mJ/xfc0FDD9ABiOXqj5HcUCy3P52qq7AishljnkNfoecAl3UyUC7vBMcCNwA0OFmS4o+q6OOmvPCbdbPmeggoNSITWlBdf8cVYhSt9C6M3n9qVmIcm01bUCuHd06HsVOFl9BWXWeXvtGN4r8U0sWMiz9okIhs1xQKz3KeAp9d8KW7EyTbIQQ/3Ha/NFKTvLYc3SjWfxIcRFf01uoxN2cLXcZgqCsNb2aBBJoTmRICK7mmVLZHmV8fo1plafmhHDpclf61MIsIMINew//yDKN9jFV4yrMZX25pmFOGL5VedoXnO

On Wed, 21 Jan 2026 11:22:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > Fix this by freeing *vals and setting it to NULL when realloc() fails.
> > This makes the error handling self-contained in add_string() so callers
> > don't need to handle cleanup on failure.  
> 
> This looks not enough. If the memory allocation is failed, it should NOT
> continue anything.
> 
> I think we need to make the command itself failure when it fails to
> allocate memory, as below:

That's a separate bug. I'm taking this current patch as-is as a fix for the
leak. Not stopping immediately is a separate issue.

-- Steve
