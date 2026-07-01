Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71F1429825;
	Wed,  1 Jul 2026 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902306; cv=none; b=AwqyTMkVX76XPrnXPUbQ+fFY/nCXasS66F97eziGDa45YhlQGNcSF+d0ezoqkN0VQoaSWX+E3mS6gQEfcu5ldj5j1aA8Y876r3tyEvblAdtbT67NL7qY2Vlv3YhwwaUGeNjO45h0HFtHF2mLI+OjRrh6oGaoDc4SrwRepXE6564=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902306; c=relaxed/simple;
	bh=4LXEqCAvif8zDFMLINcUCz48g2yYBZT5CVZBv6+SILk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1G8Q9LcvEhcM+vEZUzH6kuRfs+1dldATMPSyA7ongQ2GaBMls7WtPeFhL0rlK96ncSu8BICOnMgipTWfOtLUeS4tUkzCJDbZdtukZTDutW3sqhCj0XERQaprkFJC4u49H7kGfpQJpeNuwvbeOYGFYGs3NqAave/N+4A52BxkUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 692E2167B88;
	Wed,  1 Jul 2026 10:38:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 97CE680011;
	Wed,  1 Jul 2026 10:38:21 +0000 (UTC)
Date: Wed, 1 Jul 2026 06:38:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 2/2] tracing: Keep pid and comm[] in the same structure
Message-ID: <20260701063822.3af87520@gandalf.local.home>
In-Reply-To: <20260701110407.31f7b6ca@pumpkin>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-3-david.laight.linux@gmail.com>
	<20260629164912.4c1c2855@robin>
	<20260630110156.5314e2e6@pumpkin>
	<20260630150348.149e318c@gandalf.local.home>
	<20260701110407.31f7b6ca@pumpkin>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 97CE680011
X-Stat-Signature: mjb48d1mztyxnb3rbu5run3twrdnibn3
X-Rspamd-Server: rspamout04
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/34CtKlOfOwqBuv4TeXC3JQDue1j8BuGA=
X-HE-Tag: 1782902301-219688
X-HE-Meta: U2FsdGVkX1+AkWTOW0XnRSC5SpVrYEwA4XSzOwJ4DMRh5H6VTBlSbMxLXD9jsbFDCXF+Fp4KK2MvQsR35p+xy5OTQSlKXcTnj+ujmB7nfGr9q/ukog2iJrjCSfcfos4kg5Tv7W3gu3KoxU0J4Ki9FJ/QaIO6Cmei40iDigUCDUWpyVJGQRoiqiWLtjhrt+vrME4oCnZWuA9kr6bROjgSw3z60jdOI2hdZuEBkPzNHZKXNrTujQFbpZbvWHIyHEgFeZGBTjOfEAGPbT2O4gLm1puGZKk7E4pXQ8FWHYKxMZEDUA7WngpygnF6coNf90OL9smNqRYy49pDKEcQH7mF5os9hZ3YJ9OR

On Wed, 1 Jul 2026 11:04:07 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> 
> I thought it was just used to do a pid->string lookup when you run 'cat trace'.
> But then I found the code that lets userspace read the table....
> I guess the latter is used by the userspace code that reads the raw trace buffer.

Yes, trace-cmd uses it.

> (I found some instructions that did it that way, the output was unparseable
> when tracing things that are happening on multiple cpu.)
> The userspace code could probably be given comm[] for all the running
> processes and those that exited while tracing_on() set.
> (I didn't see anything that would clear the table when the trace buffer
> was cleared.)

Well, that would break trace-cmd. As reading the raw buffers clears the
trace, and trace-cmd reads the saved_cmdlines file *after* it reads the
trace, as during the trace it gets populated.

-- Steve
