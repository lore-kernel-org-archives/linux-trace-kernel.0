Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0D38C11;
	Wed,  8 Jan 2025 00:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736296856; cv=none; b=ipfRpK0Hs3U/SsJVPnlvzuetcKuS52pBNWtQntGqwoX06/tBS1DhZkF/9MD4xxbQi04WNhQrMYTFUftRjGwSI8l+StOAIY1YlXr7Xq0dGH8ZUxhyfXqdukscfnXnf+UsF6T1dcxEGimvDkxMYUnAWvRDNv5TLr900ZcZHdzw+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736296856; c=relaxed/simple;
	bh=aAAqSrdYw/6CYdqxsIxmH0jE9VI7tSVpHjTF9M9tTV4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c+OTk0wECc00NDJAgThMIfwrKcRS9M9ozLxGcNUddQQFK6KAzA8mvlWpc30oh295kkLjl9g5ZEWX0pBI/kfx4SWMbB4BP7vQhQatLQWVzVwXnNsc1D9ythPBxuNr/Df2+oM3R+hOgmdp1uuzNTCpbXHggfl6v5rFDUdjTrnU4o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aa6WOi2j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aa6WOi2j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D866C4CED6;
	Wed,  8 Jan 2025 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736296855;
	bh=aAAqSrdYw/6CYdqxsIxmH0jE9VI7tSVpHjTF9M9tTV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aa6WOi2j5yBum1D1q7Cdk21yTehxkak725evXaZND2g/MDsYgtL2ARyBn81sH+Lco
	 UC/NfvzhyANEea3bUyVpznjgzJgYv9BGHs16exy4+J6KfkK1OsEhb2aedhrCtnh2ys
	 lJ5KEC7FifFMnStXf89CD2/BYM5FToE0eQ899SomYpJOKlsgMyazy0+9oMjsf8jzFC
	 Wh1odt/ayX4MDzCaUpIcL5cyfYFuBW97cEi3e6RTtDveksDzIFeP2tPFfBvfehT9SE
	 Hur7W8KzS9/iOdmguuxz8KZOcopUe49XwCDJV7HvhMn7bJJZ1sUUj3K0Z/OX5uI8rE
	 8LMFQO/4cAZmQ==
Date: Wed, 8 Jan 2025 09:40:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Oleg Nesterov
 <oleg@redhat.com>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>, Naveen N Rao
 <naveen@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] tracing: Use __free() for kprobe events to
 cleanup
Message-Id: <20250108094051.f6b72d853fd9a67638ec5bc6@kernel.org>
In-Reply-To: <20250107104231.06eeaca8@gandalf.local.home>
References: <173625060316.1375434.11048027439794595989.stgit@devnote2>
	<173625063552.1375434.16867809967348842161.stgit@devnote2>
	<20250107104231.06eeaca8@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 10:42:31 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue,  7 Jan 2025 20:50:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -1898,7 +1899,8 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> >  			  bool is_return)
> >  {
> >  	enum probe_print_type ptype;
> > -	struct trace_kprobe *tk;
> > +	struct trace_kprobe *tk __free(free_trace_kprobe) = NULL;
> > +	struct trace_probe *tp;
> >  	int ret;
> >  	char *event;
> >  
> > @@ -1929,19 +1931,16 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> >  
> >  	ptype = trace_kprobe_is_return(tk) ?
> >  		PROBE_PRINT_RETURN : PROBE_PRINT_NORMAL;
> > -	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0) {
> > -		ret = -ENOMEM;
> > -		goto error;
> > -	}
> > +	if (traceprobe_set_print_fmt(&tk->tp, ptype) < 0)
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	ret = __register_trace_kprobe(tk);
> >  	if (ret < 0)
> > -		goto error;
> > +		return ERR_PTR(ret);
> >  
> > -	return trace_probe_event_call(&tk->tp);
> > -error:
> > -	free_trace_kprobe(tk);
> > -	return ERR_PTR(ret);
> 
> 
> > +	tp = &tk->tp;
> > +	tk = NULL;	/* 'tk' is registered successfully, so do not free. */
> 
> I wonder if we could change the above to just:
> 
> 	tp = &(no_free_ptr(tk)->tp);

Ah, that's nice idea. Then I can remove 'tp' as;

	return trace_probe_event_call(&(no_free_ptr(tk)->tp));

Thanks!

> 
> ?
> 
> -- Steve
> 
> > +	return trace_probe_event_call(tp);
> >  }
> >  
> >  void destroy_local_trace_kprobe(struct trace_event_call *event_call)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
