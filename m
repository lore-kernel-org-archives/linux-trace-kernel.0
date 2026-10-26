Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057831;
	b=iqS0ySi+LmP/O7gBz85NxsggN6M6mssZ1vI35SWd64NrOrcXjgU3ZnRcGE8ic/mCjjd8
	 sfjNC4SjfLYg95K2FptnKKxixL/GZlGLZoxzbE5YoxDrxzErC22fDIQJOBcJ7cQ2uDdKR
	 bty9hgF2ESEiCsfRvghNEmwJCnI6sKf9fbv4T/vYwBteIyFyZbNxoH2bav4gfL/jDL6+R
	 7tYpWtMMPXV8A8yvyO3XhUt+njgVv2BwrE38DH4wRL4yIRDXf9v9intqCfNwkSDOmVKrx
	 TkcqKVzYTms91htBMoeC2Ty8ZjVO1WWJBWQhsc6GZaqt9V0B5mBNor7gSRqdqH4LYBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057831;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pk/mtS+0WhX623GdQEiMbzyi6Wx6/eJTJDB5Jrjhiag=;
	b=qlOjbmcnFqQ2ey4vDjmvN9rZm9Z8NaFlcB/DuTc0w3zKOfh60dawpDw6JMzBxz+BM1J8
	 Hv1ZYLW8T64hccrU+e2QMLzEN5st+zrKGOIOQKyyDZksfTXOdVl4cuDLZQYKnt35tpkRv
	 OrLYqkygIN4ijVOjNiHyRxoBlQi85Y87x6wGnmN28nKVJ04ptXwRioXBD5uygXuPhfxg6
	 TFK4UqruqZ5VizASnrwOOzVbmDLSBEWhrFDhH6Foa4ZGF6vy2PkEjjgA5dC/LgSo9PWmO
	 2ciCgCOaqH7eQsaThwIlWyhqiYOc9emShCb79AVWSmfA5xza+ranGBnaOQD30VG+X7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PcvIhIwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFAB606A31A;
	Mon, 26 Oct 2026 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PcvIhIwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD081F01825;
	Mon, 26 Oct 2026 23:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057830;
	bh=pk/mtS+0WhX623GdQEiMbzyi6Wx6/eJTJDB5Jrjhiag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PcvIhIwJJZQzDmtFm8vneQ6eepFRdOh5c5F2xHokGmHaOqAjp629FPLN41cvCxvdQ
	 OUlKZQr8OP5Tr0PPa9XGxa6T8fNOr3xkE1KrvNAEzR0l/KocvNgMVf9I8XAmHFqO7A
	 LiXKTqm91rlnyVAf0KQBaHNjQZoOjY6Xa/yVtlqQ/pGVEH+PQpvtTOzaEWlBoSXZb6
	 SAtjHfceJ0Q/kv9ljRvLemP8JYj9gHkeahepKBm3aChQSYcjL3my/3Xd3usOkC+gWT
	 vRGYaofYutuxLc8VzY1ACKLGqUaFz7DGKWwBPlOQEE8wNmPA7bfoUobv+87xKs3Iu3
	 EOe60m4ms7o0g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 5/9] tracing/filters: Fix function event operand parsing in parse_pred()
Date: Tue, 27 Oct 2026 08:37:07 +0900
Message-ID: <undine-1793057827062030336-5034219911522d56@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261026163257.434af154@gandalf.local.home>
References: <179291742944.492959.11659339795290028998.stgit@devnote2> <179291747675.492959.6739928041718890503.stgit@devnote2> <20261026163257.434af154@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 26 Oct 2026 16:32:57 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Sun, 25 Oct 2026 17:37:56 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In parse_pred(), the ftrace_event_is_function(call) branch has several
> > bugs when parsing the string operand:
> > 
> > 1. The loop 'for (i++; str[i]; i++)' unconditionally increments 'i' before
> >    checking whether str[i] is the NUL terminator. When the operand is empty
> >    (e.g. 'ip == '), this advances 'i' past the NUL terminator and reads
> >    out-of-bounds memory until another zero byte is encountered.
> 
> Can't this part simply be fixed with:
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 5e74d2dae40a..6a14c964c115 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1733,6 +1733,11 @@ static int parse_pred(const char *str, void *data,
>  	while (isspace(str[i]))
>  		i++;
>  
> +	if (!str[i]) {
> +		parse_error(pe, FILT_ERR_INVALID_FILTER, pos + i);
> +		goto err_free;
> +	}
> +
>  	s = i;
>  
>  	pred = kzalloc_obj(*pred);

Yeah, looks good the me. 

> 
> > 
> > 2. When the operand is quoted (q != 0), the loop breaks with str[i] at the
> >    closing quote, but 'i' is never incremented past it (unlike the regular
> >    string literal parser which does 'i++'). Furthermore, it does not check
> >    for a missing closing quote (!str[i]). Returning 'i' at the closing
> >    quote causes predicate_parse() to immediately re-invoke parse_pred() on
> >    the closing quote and fail with FILT_ERR_TOO_MANY_PREDS.
> 
> This is a separate bug and needs to be a separate patch.

OK. Let's make it a separate patch.

> 
> > 
> > 3. If the operand length is 0 (e.g. 'ip == )' or 'ip == ""'), it accepts an
> >    empty pattern instead of rejecting it with FILT_ERR_INVALID_VALUE.
> 
> Well, empty value ("") is actually valid. May be meaningless, but it's not
> wrong.

OK, I will also add this case in the test.

> 
> > 
> > 4. When the operand is unquoted (q == 0), stray quotes or '(' inside the
> >    operand are consumed as part of the pattern, desynchronizing
> >    parse_pred() from calc_stack().
> 
> This is a separate bug and needs to be a separate patch, although it may be
> the same as #2 above.

OK.

Thanks for your comments!

> 
> -- Steve
> 
> > 
> > Fix this by advancing 'i' and 's' past the opening quote before the loop,
> > starting the loop at the current 'i' without a blind increment, checking
> > for missing closing quotes, advancing 'i' past the closing quote, and
> > rejecting empty operands or stray quotes/'(' in unquoted operands.
> > 
> > Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
