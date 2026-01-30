Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB282D8376;
	Fri, 30 Jan 2026 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769786485; cv=none; b=YsK840mW7zYJk7QEf7fLX+UueKQdJiRtub5848dWD3oqXJAkN++1DsLImCRlxPZsL56jKzu6A3Fnze45jHZMKymBp6TRzY8ISy4xJ4NgArVz5BLyp+Rh+WUCa3LPe7mIfrhMf8Jipd4DvjnNAeUK329H8NW1M+ZqqtgJPhDix1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769786485; c=relaxed/simple;
	bh=eehxvFku6xaN+YRPVFqBOSNi2iVVZS1WyABsio0lm2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2pRZ6MHEV1bmCgtKVxWgxOjROoGX2hkTrEzCsNf5Zt0CUEAaveZwDZHLfo1bp2s/5rwDajL6YAHmhm2nwcexChFpUKzRWyGj2BAqEbKFJeRRJWebW1rfBrwob/rnpaZVXvYLE5oBUlDN5ZiT/F+LopVXc5nlzouMA+gK2Nm8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 156861B1889;
	Fri, 30 Jan 2026 15:21:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 59F262002A;
	Fri, 30 Jan 2026 15:21:18 +0000 (UTC)
Date: Fri, 30 Jan 2026 10:21:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] tracing: Make the backup instance non-reusable
Message-ID: <20260130102133.2ab84911@gandalf.local.home>
In-Reply-To: <20260130182058.abb5c2b401f104afd25261d3@kernel.org>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955899639.2786091.8716448298561300937.stgit@mhiramat.tok.corp.google.com>
	<20260129150745.1f9ab283@gandalf.local.home>
	<20260130182058.abb5c2b401f104afd25261d3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 59F262002A
X-Stat-Signature: u58dfjurfi6xccof1yat7amxk3tyiydj
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ORASjS3h1H1IZzf+mpFYzHFukq8gowic=
X-HE-Tag: 1769786478-103906
X-HE-Meta: U2FsdGVkX1/ut4GS4UutJeOeHLkei9yVh/85oHRUFYeEOgvnyjj/3OhwYlBPqtSDq8x46nqAIsftNuONQwJ2NdEyx3j6cxLw7yo5cpBVEsziwxRBE04rDsgRlZxaxDHNqmvTrvAojqpOTVZq0v6HH4Q2LVZCmn6AtpqUNzubvmWkbzYXIu3n2n8OQYWDU1Vejo77xkLY7urTaBvKkQof/v9zEP6MgoZ1jTSou4QZyZSVGw5ymVjVlfY5DzSGGvIK6uE02AgZ8pomo2NLde4C6QVSqrNrT7X0EWGNfjCn/1ZvBNKrjamnjMSn6hpJeOk766jf+dvr5slO4Zw27Gyi0mBiM52YQHu7

On Fri, 30 Jan 2026 18:20:58 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > -	trace_create_file("free_buffer", 0200, d_tracer,
> > > -			  tr, &tracing_free_buffer_fops);
> > > +	if (!readonly) {
> > > +		trace_create_file("free_buffer", 0200, d_tracer,
> > > +				tr, &tracing_free_buffer_fops);  
> > 
> > Hmm, why remove the free_buffer. It just shrinks the buffer down to a
> > minimum. Perhaps its useless, but I it doesn't write to the buffer. Sure it
> > removes data but so does trace_pipe.  
> 
> I can keep it but free_buffer and free instance is a bit different on
> the persistent ring buffer and its backup. For both cases, since the
> scratch area needs to be kept, it does not free the reserved memory.
> (but the minimum ring buffer is dynamically allocated.)
> IMHO, the buffer resize interfaces are not useful for persistent ring
> buffer.

Ah yeah. OK, lets not add free_buffer to read only instances.

-- Steve
