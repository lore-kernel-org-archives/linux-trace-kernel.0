Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8839374E6C;
	Tue, 23 Jun 2026 11:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215417; cv=none; b=otBXoznA3idB3/laO0oWTtHo3F46+gJZTgmSIc3if/6R/X7xRyhhG5t3/O6pNVd6ptkJO57tYUgoqRaEdO6cRro4MkktLWJwrBsNJGkVn3JULyW7fzOz8PjjSmtVg6hM1GuLA6MOURG7THrNsFtcNJTrC7ZK3wZ/uGkcJy2CzuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215417; c=relaxed/simple;
	bh=n9OhQRcivBTU+0Hw5QfVQWAdoHhSvvpTs4h0+H96Yv8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g5XgzlJhsavMn/2uj17D0VKUIx4KkP9PzdFPiQcnpYeIw6OSsuZ7kcfk1jbvhmtCrdlhlTXis0zDRlqGgrMTOmJN8rmXjnJj96nsDYlbSOReXNOf8/13IbiOUAmbJulBmlz1oJmirsV/n0hwjTU/zMtRTZY7ySMgKg0W1rrwE0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoytTKJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoytTKJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554ED1F000E9;
	Tue, 23 Jun 2026 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782215416;
	bh=d62k19kj1SfRjgL7jcO1Hvgy3SxR7Y2lcNyjJKm9tsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aoytTKJpKqwrv0PxU7BckYroUsYWDez6dmQNqqy/xFmhsf4WiIX2f0iDLTacI7n/0
	 prIGaAvGrMEq29qEsx89JxkRvNnp3w8vIiHPSGQsmTxO4RhTSFeMFP7C6cU0Uvq3nA
	 P0qfK+RBTWf2NHRbIF0RK1rOKsqV4rqIYP7SyrWRbBELcnEDwXfiZzPYzHIow/dfmb
	 R8XbxHZYzpEmLI0OeHqnWtA0Hu4jv5g/T7xNgcifsXb8h1H+lm/hYohWfPQ/H9pYrc
	 IkPWQ7w+AqL6qzcP2WGTmDJzKdiuH/09lYcsVRcXTskKy3tCkjlngeYp1pl4xCaF4R
	 C7NlqrVd62+0A==
Date: Tue, 23 Jun 2026 20:50:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v7 06/10] tracing/probes: Type casting always involves
 nested calls
Message-Id: <20260623205011.6f295bbf425412435f25b72f@kernel.org>
In-Reply-To: <178217910709.643090.6379198143797177881.stgit@devnote2>
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
	<178217910709.643090.6379198143797177881.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Sashiko commented:

> > +	}
> > +	*close = '\0';
> >  
> > -		ctx->offset += 1;	/* for the '(' */
> > -		/* We need to parse the nested one */
> > -		ret = parse_probe_arg(tmp + 1, find_fetch_type(NULL, ctx->flags),
> > -				pcode, end, ctx);
> > -		if (ret < 0)
> > -			return ret;
> > -		ctx->nested_level--;
> > -		clear_struct_btf(ctx);
> > +	/* We need to parse the nested one */
> > +	ret = parse_probe_arg(tmp, find_fetch_type(NULL, ctx->flags),
> > +			      pcode, end, ctx);
> 
> Does routing the nested argument through parse_probe_arg() instead of 
> parse_btf_arg() break the documented eprobe syntax (STRUCT)FIELD->MEMBER?
> Since this patch removes the TPARG_FL_TEVENT handling block from
> parse_btf_arg(), and handle_typecast() now recursively invokes 
> parse_probe_arg() on the extracted FIELD name, a bare eprobe FIELD name 
> that does not start with a '$' prefix will hit the default case in 
> parse_probe_arg().
> This causes it to be unconditionally rejected with -EINVAL (NOSUP_BTFARG) 
> because eprobe flags (TPARG_FL_TEVENT) do not satisfy 
> tparg_is_function_entry() or tparg_is_function_return(). This acts as an 
> ABI breakage for existing user-space scripts relying on this eprobe syntax.

Wait... Did the type-casting support patch accidentally allow access to
event fields without the "$"?

Hmm, if so, it should be documented, and need to support correctly
with/without typecast.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
