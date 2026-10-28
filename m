Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231741;
	b=EeZ3hUMyo7GnMy1lURL9jiicn2/HBIgFdp2u6k6C66cYk2BDB68v1k+TrPXi6l9zy6wX
	 sSxnLiXPo7ALi6k7CHswVufUGbk/zXsU1L+RNaE5EiT9Buzd4tS0muDA4udn/AQ77zJ97
	 3yKB4fWqxhG3N/DzdhfS4VBvg/MiKfh4/HOjYCO8IyqPOfQffGlodBrrSmMjx1bubR8/K
	 LwxTzltQHxD7wJhk+6sxntNDvewK8BKCCQNmrNm/4E/Cbwh6zB8ShCYgd5yBzz/9dQ9md
	 u5+XbutsfWRM6JO+xaut57x9o641AYaKqOBwz/yyLAlwBNT5u2a9XZw+l1PWOlnMqwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231741;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DFG1Jsjwt8/FAlxp4iBJYsZFk7sxWWq4BlOV1rwa14c=;
	b=yh+ZIkehZssSCms+iMWr4UQgGDYVfF9qNo9CwJFpxPJArDOSFRUlDLo+OWAT87ABhOEB
	 6gYZqh0K77/o5tYrc1nDs7k2OnEE+Vudn0ouKGDgpE5gP5PciVN2BV5hX85qbJTPietom
	 UYDFNVdfCx9sp/uqkXr5xAKft6D3d1ihAE7++oWF8KiEXo7K/mlFWR4JebDPSo6GP/s9r
	 Bduse8i8eiduoCtzuuFw2m4nj1/3qS5KgMCKN9H2wQHByDZ+kzbYgKVFUtLI6dVb5bzBv
	 ORioOyJ7P2GQ3oFsHjuiTyXg0aVTmZhE987Ehcz28R2HH9KzeTpgbRa058zGuel3U3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PPl/0NQe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6F606A31A;
	Wed, 28 Oct 2026 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPl/0NQe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0731F01825;
	Wed, 28 Oct 2026 23:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231741;
	bh=DFG1Jsjwt8/FAlxp4iBJYsZFk7sxWWq4BlOV1rwa14c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PPl/0NQekQphvLogChbYEWl3sq3TqKqR6K5FxV3wzdCTOgYUAp3SEKMfrBcs6y2Pp
	 AWMVIS0hS5kfGWjCd2WjoylqngSsygY744HB23FDd+DXJ9m8+snL4BvWTf623IqnRn
	 WxWJmqGXYV+iy6Z3d/Rbiw2ZMytgoQ25+YCHUVu0rbV8Uo3QAmI4oKFynwMaOrwoFV
	 ewjGRed7ln0gqU77C8X9uZbM9d6+zw8/XCtwSrI0FR07L0tJgz8J07/U8ImROzOFVJ
	 9ie6hkrNcCqkN4NcKKAUnim3UijVutkSiainqEaIoCkxRUhVQlD4ESKlEYTZouYIlu
	 pkVU/oOj4SRdg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 09/16] tracing/filters: Reject stray quotes and parentheses in unquoted function event operand
Date: Thu, 29 Oct 2026 08:55:37 +0900
Message-ID: <undine-1793231737781982017-eb6a165f6356f864@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261028095037.39c9109a@gandalf.local.home>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314828848.684037.8273600995293830928.stgit@devnote2> <20261028095037.39c9109a@gandalf.local.home>
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

On Wed, 28 Oct 2026 09:50:37 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 28 Oct 2026 09:44:48 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > In parse_pred(), when parsing an unquoted operand for function events,
> > the loop only stops at ')', '&', '|', or the NUL terminator.
> > 
> > However, calc_stack() parses '(', '\'', and '"' independently to
> > determine stack depth and string boundaries. If an unquoted function
> > operand contains stray quotes or an open parenthesis (e.g. "ip == foo'bar"
> > or "ip == foo(bar)"), parse_pred() consumes them as part of the function
> > name operand, causing parse_pred() and calc_stack() to desynchronize.
> > 
> > Reject unquoted function event operands containing '(', '\'', or '"'
> > by reporting FILT_ERR_INVALID_VALUE.
> > 
> > Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> > Cc: stable@vger.kernel.org
> 
> I wouldn't really call this a fix, as I can't see this breaking anything.
> Yes, the calc_stack may say there's more elements than what parse_pred()
> sees, but the parsing still fails.
> 
> This looks more of a clean up than a fix.

Agreed. I think fixin error_log UI issue will be a part of improvement.
OK, let me remove the Fixes and Cc: stable tags from those patches.

> 
> Unless, the current code allows something to actually be broken. Does it?

No. Hmm, should I split those "improving parse_error()" patches from
this series?

Thanks,

> 
> -- Steve
> 
> 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changes in v3:
> >  - Split from the monolithic function event parsing patch into a
> >    standalone patch rejecting stray quotes and '(' in unquoted operands.
> > ---
> >  kernel/trace/trace_events_filter.c |   14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> > index 96977eb9af85..48e16d75be74 100644
> > --- a/kernel/trace/trace_events_filter.c
> > +++ b/kernel/trace/trace_events_filter.c
> > @@ -1863,9 +1863,17 @@ static int parse_pred(const char *str, void *data,
> >  		for (; str[i]; i++) {
> >  			if (q && str[i] == q)
> >  				break;
> > -			if (!q && (str[i] == ')' || str[i] == '&' ||
> > -				   str[i] == '|'))
> > -				break;
> > +			if (!q) {
> > +				if (str[i] == ')' || str[i] == '&' ||
> > +				    str[i] == '|')
> > +					break;
> > +				if (str[i] == '(' || str[i] == '\'' ||
> > +				    str[i] == '"') {
> > +					parse_error(pe, FILT_ERR_INVALID_VALUE,
> > +						    pos + i);
> > +					goto err_free;
> > +				}
> > +			}
> >  		}
> >  		if (q && !str[i]) {
> >  			parse_error(pe, FILT_ERR_MISSING_QUOTE, pos + i);
> 
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
