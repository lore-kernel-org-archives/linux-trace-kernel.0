Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C336A2459DD;
	Wed,  7 Jan 2026 19:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767813971; cv=none; b=qpF674dVWm/8Ll4GMh2wtFI4ORlbJuk7jPzut9hhIN6pdOK5LAiyi7S5G7ac68sncw5Lqa1e0nQwUB6tP0QCeehJfbyqCyIx3XjdvNjqtdsI0wQEKWAjPNoJ4HqH8arTq1JSV5MHwdzKaXn6Hl4kJ0DtqHQFwyaNkZDyDr68RXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767813971; c=relaxed/simple;
	bh=kQoI40bzdL7ie1wnvtSaQYyVpPxjHRJemCKD3bwPjKE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GNvmc6L7yxT1EZ/rMVTXZBq/U4BTeQ4xsDsp0pLU57b3mqPCHl0aKtidmCn7dhlNksf/kcOIAFLDBr3tEq+thrFgnz5oUfEyrcVizuHfGRDTWdYU6RJLqubOOzAYnPFEB5eSQQTfP+M+Q7BMUo+vmkJFBg+MGJAGfedD1Gbhskk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 90B151AAFD2;
	Wed,  7 Jan 2026 19:26:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id BFF4520027;
	Wed,  7 Jan 2026 19:26:05 +0000 (UTC)
Date: Wed, 7 Jan 2026 14:26:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ian Rogers <irogers@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tracing: Avoid possible signed 64-bit truncation
Message-ID: <20260107142632.0dec5b10@gandalf.local.home>
In-Reply-To: <20251209213135.13eb68f4@fedora>
References: <20251209224024.2322124-1-irogers@google.com>
	<20251209213135.13eb68f4@fedora>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: p9ncoy6pp6kji5wgp9qwo4rk9k39oipw
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BFF4520027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1++PxF0GtOVVTpUMC7k69NqR3l0MN0b9os=
X-HE-Tag: 1767813965-283697
X-HE-Meta: U2FsdGVkX1+SRCuz3x5MKKVeOD8Qg7GV6B4yRzu1lWYL4AhzQd21Edwi29JE+6ZhMIA9IBF2k/FtokxZW/YyLxsiIdKn+j8Sd5ygzqhOU63aj+8/O9cGuNJon7hXvYD452jWrjo5wzz+08DL7SYwOgJ4Ne83XP7n3jnIfHylrdHGwAhFJyWqIid6cHFh25GSylcpPX8vz1nL5qpZwzaDPfo8WNW7/gwATSA4jvJf2UhGzWr8zXKb8UT03TL1TwAlQklkcYFXLsv7RpZQHdb9+IbvVrdJUTWxBSSY77vzVLRdsn0aXVsvX91GOA5+5lHnCUOtakaZIZWs14iN58/l35iGoKM/2ym9o2UA3aSewF8uBU/ISQX0hz1ixpmPe+v5

On Tue, 9 Dec 2025 21:31:35 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > ---
> >  kernel/trace/trace.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index d1e527cf2aae..e6a80cbe9326 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -6057,8 +6057,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
> >  
> >  	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
> >  		return 0;
> > +	else if (addr > ent->mod_addr)
> > +		return 1;
> >  	else
> > -		return addr - ent->mod_addr;
> > +		return -1;  
> 
> Could we still keep this down to a single if check?
> 
> 	if (addr < ent->mod_addr)
> 		return -1;
> 
> 	return addr >= ent[1].mod_addr;

Care to send a v2?

-- Steve
