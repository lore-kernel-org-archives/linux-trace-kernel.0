Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2834C2E8DFE;
	Wed,  3 Dec 2025 22:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764801911; cv=none; b=Qb+HdvPRXz0R5oZmQEVxFllptnHBJnrJl5ldr6DZybiuq7ZByRrkSg9eEAUXHJoXr4RpH/uZ2V+EHABd7aOcNWYtU2Tbi47N9mBPe1PsJa6XmEBDA5fr8i8iEVwGYP0+vhkVJbZ9SasyLB43GLO12L7UK6uaRVSGMwHlk1SLrNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764801911; c=relaxed/simple;
	bh=eXCSv0usm+tDtU6Ofa6pcuUK3MO31ClbMcy0+tHlTBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pn+JHhzJcE549fpkgAY9Dqv8Q2EeeUOdlSd8GUr5d9osLyXgz4/+U7Xo1PUlx3Y2aXVM+DZBkrLkfntLB8dYanKXaYbmaNrAJyYTugKDqbO4BYGVI9wWpaz308DAnIgX926/mKwK+Scs5wjXDAddSYHZagotTf5tl8jhAfFdJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 37F3913BAEF;
	Wed,  3 Dec 2025 22:45:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 004E18000F;
	Wed,  3 Dec 2025 22:45:01 +0000 (UTC)
Date: Wed, 3 Dec 2025 17:46:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] tracing: Use strim() in trigger_process_regex()
 instead of skip_spaces()
Message-ID: <20251203174604.0405a90d@gandalf.local.home>
In-Reply-To: <9393741d90fff46709a2c9b0b04f406d5245d000.camel@kernel.org>
References: <20251125214004.396482401@kernel.org>
	<20251125214032.323747707@kernel.org>
	<9393741d90fff46709a2c9b0b04f406d5245d000.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 004E18000F
X-Stat-Signature: gkpa6557tqneks1qfj4th17hgc8ao4xz
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Vc6pAhPafw9mJOzg4zIWwZmg6udiFaNI=
X-HE-Tag: 1764801901-16849
X-HE-Meta: U2FsdGVkX1/hGTrXpDCHDrkcphMxwlVVyYyG7clUbNk1dDOZL+ZrzvWa3/aYYqDQ0ibgbIX+lvVoCDSCs45zeropLoA7flH7OnEMbsBbg0ebgMNswfIQ/HcSf9iv6GAEsz1ozJNcr5QOczgAs7E9Upvpa93kVumDAcf0wzmff/q/TcQ2SgSc39cFmLk5RaAPGBzeNxazN9kkEsL4LFAogSIQuNv51aswHB5/C8vEj8fA4dPX3DVFEgNIl+CBwN3TVIPhGyK7lBCjP63Y7F3xKgu6NJweQtifZSGtn1ARVPLHyLMhu/bUjUJVkwMCBVB+THS3KQ8VC/pjQe9YWXGZfTlkroZnOkJokiCcl/98r981iImZjr136vP4bwd8S8rMUAFOhN8C1fZRXmadF6LI0A==

On Wed, 03 Dec 2025 16:40:04 -0600
Tom Zanussi <zanussi@kernel.org> wrote:

> > Remove the strim() from event_trigger_regex_write() and have
> > trigger_process_regex() use strim() instead of skip_spaces(). The buff
> > variable is not passed in as const, so it can be modified.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> Looks good to me.
> 
> Reviewed-by: Tom Zanussi <zanussi@kernel.org>

Thanks for all the reviews, but I already did the pull request ;-)

Although it hasn't been accepted yet and there's always a chance Linus may
have an issue with one of the commits (I had a lot of commits this time,
affecting various aspects of the code, but couldn't use topic branches due
to too many conflicts). If it is rejected, I'll add your reviewed-by tags.

-- Steve
