Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DE47DD66
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 23:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788304426; cv=none; b=l51bMyEHCUIhYJQ4bChA0BY8MsreDVv65Z8n8MXiX3Ga3cUlLq2gBQvW/at1I//axWA0cN3zZU2EBYE4wgE0BOZ3sGrEhEakZQKdvd3GWVuBLfdhssSAV/Gz6VYb7Muaq1smx/F9lREItQp7N3KarJFdqI3zn1JrB+dKGRjFWEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788304426; c=relaxed/simple;
	bh=CMg8EnicEcBtJJY6z/2G7WoIQ6/fvphazvoroAr7x0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GZY6S6iIx06QLxZObSD+XdWa3BlVQPBW0iR/TVh2KwW58DHP+SVvJqb9omzIRVn/5iFTR5V6NvACYzqGID1F5VbrYpOpAFYqqB+S5wNx05Ii7FsiA0Ka1GvMyChGr2oG3vnXd/CQRnMwTf/7tZ+3T7ehYMlggs+Fb3L//wDXPHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=KQY9VhMC; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="KQY9VhMC"
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id BEA06A4402;
	Tue,  1 Sep 2026 23:13:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 3B33319;
	Tue,  1 Sep 2026 23:13:41 +0000 (UTC)
Date: Tue, 1 Sep 2026 19:13:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Take trace_array reference when opening
 options file
Message-ID: <20260901191339.25a5a060@robin>
In-Reply-To: <20260901205421.5832E1F000E9@smtp.kernel.org>
References: <20260901163620.6cbe0ada@gandalf.local.home>
	<20260901205421.5832E1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: y4gwk7bankse1xsqoiyhczpnnwtou531
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 3B33319
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+d1yI+SllBX+/x/1VAQa2tyusVLFyiG3w=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=VpZd83Dau/0k0soWwaL4NH7We7iw+l/e5YU5ZKkI9ik=; b=KQY9VhMCIR11aXfm5SfsLEbZK3upNoxglcqK41k9pNSmBDYVUL5f8yMExc7gF46gy7F/Q0gYbcCVUBSZYVB1sYujSASEKP7heyuxl8Z1Cxj7eatA1mGeAmkPmNjKI4PytPgury/tEXhlRAL6LOHIyy3VI7+MGCm97qe5ElnXkE0=
X-HE-Tag: 1788304421-134859
X-HE-Meta: U2FsdGVkX1+cO5+8/HWq9sSXJaW4Sd/adHEvsf1HeFvEmoCRVbOBJwrB4gWLAb9v7HmxMhmB3iyGbTleqwKxpx8CqUGM5Ck4BdwN0GP4rx778I6ek35qjvJS/g8S4iaX7eU173AqcgrgN//i6Ac+Q96JPSpV1uFq8Kh8yUj5O1+h/e8o8Oguq9WPOw0OwqwygFzpx4TaDcRT0q9vOgZ1zBemLiF0rimcLm9st6+K49NW9Rl+8sB0lFUjtW+zuIyXJDaLHenf6+yiu04ILYbSLERCjO+4yycfpPhTyVsWYbKoL6/K2NEAuCvZYv/zlJux7ileS868MA0TjUFL3/LLOF8K7SBke2vq

On Tue, 01 Sep 2026 20:54:20 +0000
sashiko-bot@kernel.org wrote:

> [Severity: High]
> Does this raw memory address comparison account for reallocation of the
> trace_array struct?
> 
> If a trace instance is deleted, its trace_array is freed. If a new instance
> is subsequently created, it could be allocated at the exact same memory
> address. Could a user holding an O_PATH file descriptor to a core options
> file of the deleted instance reopen it and manipulate the tracer flags of
> the newly allocated instance?

Yes, and we don't care ;-)

If the admin is deleting and creating trace instances and opening
option files at the same time, it's their own fault if the wrong trace
instance option gets changed.

> 
> > +			return __trace_array_get(tr);  
> 
> [Severity: Low]
> Will this compile successfully? It appears __trace_array_get() is an
> undeclared function, which might cause a build failure.

Really?

Then what's this: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/trace/trace.c#n614
?

> 
> > +	}
> > +	return -ENODEV;
> > +}  
> 
> [ ... ]
> 
> >  static const struct file_operations trace_options_core_fops = {
> > -	.open = tracing_open_generic,
> > -	.read = trace_options_core_read,
> > -	.write = trace_options_core_write,
> > -	.llseek = generic_file_llseek,
> > +	.open		= trace_options_open,
> > +	.read		= trace_options_core_read,
> > +	.write		= trace_options_core_write,
> > +	.llseek		= generic_file_llseek,
> > +	.release	= trace_options_release,
> >  };  
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this same Use-After-Free
> vulnerability also exist for tracer-specific options and other
> per-instance files?
> 
> While this patch addresses core option files by replacing
> tracing_open_generic with trace_options_open, files like
> tracing_max_latency and tracer-specific options still appear to use
> tracing_open_generic, which doesn't take a reference to the
> trace_array.
> 
> For example, if a user opens a per-instance tracing_max_latency file,
> keeps the descriptor open, and the instance is removed, could a
> subsequent write dereference the freed memory?
> 
> kernel/trace/trace.c:tracing_max_lat_write() {
>     ...
>     return tracing_nsecs_write(filp->private_data, ubuf, cnt, ppos);
> }
> 
> Where tracing_nsecs_write would perform an unlocked write to the
> freed pointer?

Possibly, but this one was a bit more complex than those others will be
to fix.

-- Steve
