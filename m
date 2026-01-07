Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8122D7B6;
	Wed,  7 Jan 2026 01:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749618; cv=none; b=TWoMSlNyIhVtAEe7uMjo1pLWKxeCkWYCdL7N172+3vVVOXv4rRxZt80CBgh7sJO/OfEjjhPbyQIS344KVn7aDjANMcF/AtlL4+FrjxCXFZ7L268s5L/qEk5jEICt9MOpPLQp0OaF/VCMwu9aM6/xJ3ddipbFxMzG1G06ADJYcNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749618; c=relaxed/simple;
	bh=uPnc33mJTK+Uaw3ZivFYK1+hLOL9aOS6ALtiqbWrYXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUigoy4T5qtZM49NlgN4INWW+dD3hdv61A8wNPkyINmxDq8//E+uEUM+N31jDIt4N8BHnRHjurMaqjUe7pa+MUVGvbfk+QzfOcGN6jM2sdwgOw7aj3VL23unQXyFGB+hxVgGZJMTG2YaKVVB51YrUYdLNCFRG2SyqRrmxhSsASY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 509025ECA6;
	Wed,  7 Jan 2026 01:33:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 7E9F52002C;
	Wed,  7 Jan 2026 01:33:27 +0000 (UTC)
Date: Tue, 6 Jan 2026 20:33:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ftrace: Do not over-allocate ftrace memory
Message-ID: <20260106203352.539b9548@gandalf.local.home>
In-Reply-To: <b13af4e1-3510-4240-9347-31459d5f0ef6@roeck-us.net>
References: <20260107002428.2904852-1-linux@roeck-us.net>
 <20260106194355.66cf869e@fedora>
 <b13af4e1-3510-4240-9347-31459d5f0ef6@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zj9ghmjtok8zbip8dbogxphn76j7ah99
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 7E9F52002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19/1yfN103ol7mKkIAfQxp542urFI7ySfY=
X-HE-Tag: 1767749607-296514
X-HE-Meta: U2FsdGVkX188CzcsvVjzylTs9u0K1uNazJU+cBSoXaF+SBQpNyYeLdq0ulx7+fX7FRFZLAr6j6lZnfw9wbUDFMRggYSr3Bv8JwVp/MfGWqZHEQlXYhJterLstvgynl093P4C7eDE/I443b8HCfKI/yNsZwZTquGzjWfPk75ANLGjj/r2FO6tM4qs1DqEV7hTJKcAOzi/OV6HjF6WHs6zM7rWpmmM2eDEu14jf78RER/Wc87MbsIJR9O5fKWEYhyMGLHekGlN8DFZmXjbxfFDEkROBrTnmgA3oZXKrZ2AjI92Ot97QaUbhD3lVpD2QCD119f2v0DbJVB6IBoO1d5aol+UkKPQcxJ76wz4ms+8ynHKOStF9L5eI353H9X8UTgm

On Tue, 6 Jan 2026 16:54:27 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> > Don't remove this block. It's still needed. A lot of entries are
> > skipped when adding the records. Weak functions and zero'd pointers
> > that were part of the count are skipped. This is the code that handles
> > that. It has nothing to do with rounding errors.
> >   
> Sorry, misunderstanding. I thought that is what you meant with "This will
> make pages equal the number of pages that were allocated. Then I'm not sure
> we need this extra logic."
> 
> What is the no longer needed extra logic ?

I meant the added logic you had there, as I was a bit confused by the
"spaces" part.

The logic still needs to be updated, but I think it can be done with the
following:

	if (pg_unuse) {
		unsigned long pg_remaining, remaining = 0;
		long skip;

		/* Count the number of entries unused and compare it to skipped. */
		pg_remaining = (PAGE_SIZE << pg->order) / ENTRIES_SIZE - pg->index;

		if (!WARN(skipped < pg_remaining, "Extra allocated pages for ftrace")) {

			skip = skipped - pg_remaining;

			for (pg = pg_unuse; pg && skip > 0; pg = pg->next) {
				remaining += 1 << pg->order;
				skip -= (PAGE_SIZE << pg->order) / ENTRIES_SIZE;
			}

			pages -= remaining;

			/*
			 * Check to see if the number of pages remaining would
			 * just fit the number of entries skipped.
			 */
			WARN(pg || skip > 0, "Extra allocated pages for ftrace: %lu with %lu skipped",
			     remaining, skipped);
		}
		/* Need to synchronize with ftrace_location_range() */
		synchronize_rcu();
		ftrace_free_pages(pg_unuse);
	}

-- Steve
