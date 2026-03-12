Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69938AC71;
	Thu, 12 Mar 2026 21:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773352020; cv=none; b=lhVsoMoSruowKUnxw944M578CwhABRf5MUJYHLBjefdai5zkMhRx5fkZ2FPgUPunQIjCh/FtiGhwAKUcQa8RSeyUS3H7Dqds6XZTr/hewOH9u5uEiFy3g2inbSP7KR9D3dTAVVa5pLdvUghEfIjcJ4Mjo3jaPQ97F331YgTo7bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773352020; c=relaxed/simple;
	bh=cCKAqv7NOI5zr34VoOUPzcEk48XcYp9FLpXQW+TuYGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KQ+LHomL3yPorA2vrv/lv6ghBqAlVd1holv0kAjEvU5r2rSOqx/NOgaqihRTCQAvUsj5H7Yq7wyLWLGu6HkGwV+3VwR/qx+WrmBypwBV+NimQBhz/wdwLHVS5sr1ddodFtizubu1FsRu7DKEbMA8MEdfmfkBNYSQVx7MGuRktXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 8C23CC19CF;
	Thu, 12 Mar 2026 21:46:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 9829620024;
	Thu, 12 Mar 2026 21:46:55 +0000 (UTC)
Date: Thu, 12 Mar 2026 17:47:10 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Josh Law <objecting@objecting.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] lib/bootconfig: check bounds before writing in
 __xbc_open_brace()
Message-ID: <20260312174710.22557776@gandalf.local.home>
In-Reply-To: <1bd0e36d-0ea0-4a79-bbee-e38de553f1ea@gmail.com>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-3-objecting@objecting.org>
	<20260312170643.4b0f926b@gandalf.local.home>
	<143ca1aa-d053-4947-9817-72462876c224@gmail.com>
	<4c426803-91f8-48fc-ae8e-20676479b370@gmail.com>
	<20260312142809.cb92d6b5197e89645edab80b@linux-foundation.org>
	<1bd0e36d-0ea0-4a79-bbee-e38de553f1ea@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9829620024
X-Stat-Signature: oyrcbejprmh3e7oywrugzigdgndx7dj5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/JrVtdbFJSHWIwfhjkLpxZr24/iWGYD5k=
X-HE-Tag: 1773352015-83925
X-HE-Meta: U2FsdGVkX1+Gs32zyWgBl4z8e3eG/qoJMgQmeeWUY5DuzvXtqQ6rPBAwy2JU4t6aWt6DjhA8HIqEj9RakHsj2L2+5u7dLsRcTHh/IZXs/ntcKl6jRMQEZkKbGNUkjSy7CCxtUmZ5VZxkvAfOW3fI9rke6opjxsws9lEy5YFLjgBpFAHsWwH9YRjg3FAOywu7gYhUnQSqExwTAKGriqBCvwmdnZ/jujmyw9ZmINfss3eWyZwgA0GjJdOTCt1l7uaI64RY6dG/EFRjGCXorK1EaliDvKmK6ZVWVMh6kr1lOdX6psKPKMNQGwOXabS5JE5f3MkRnh2BR7dH7SK+RnWJQ7d9x3NpigjfhnwKwmRfPJYxo7IbaKh663QaYKqYQgqM2NSgAU57ewQYWUcPzuM9QQ==

On Thu, 12 Mar 2026 21:30:10 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> 12 Mar 2026 21:28:11 Andrew Morton <akpm@linux-foundation.org>:
> 
> > On Thu, 12 Mar 2026 21:09:52 +0000 Josh Law <hlcj1234567@gmail.com> wrote:
> >  
> >>> That's a fair point, Steve. Given that brace_index isn't touched
> >>> elsewhere and the current check effectively prevents the overflow, I
> >>> agree this isn't strictly necessary. I'll drop this patch and stick
> >>> with the fix for the off-by-one reporting error instead. Thanks for
> >>> the feedback!  
> >>
> >> Wait Steve,
> >> Thanks for the look. I see your point that it's currently redundant
> >> given the call patterns. It looks like Andrew has already merged this
> >> into the -mm tree, likely as a 'belt-and-suspenders' safety measure.
> >> I'll keep your feedback in mind for future cleanup, but I'm glad we
> >> got the other off-by-one fix in as well!  
> >
> > Please wordwrap the emails.
> >  
> >> And in my opinion, merging it is a decent idea.  
> >
> > You've changed your position without explaining why?  
> 

/me wraps your email (claws-mail does that nicely ;-)

> Sorry, I think it should be merged because it's better to be safe than
> sorry, I know there is different methods of implementation, but this one
> still works... I know it's churn (and I'm sorry)

It's not the only place that does that. And since the value is safe as is,
I rather not touch it.

-- Steve
