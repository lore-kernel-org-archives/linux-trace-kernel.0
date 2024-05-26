Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0B8BE7;
	Sun, 26 May 2024 23:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716765190; cv=none; b=GkYa1zOKzNceTHbbkqjVvfFQYnp02A2iLZZLa1nhrmdgEdN++6GOxloOJ5dlZwi9IpaY/Pz2C3wXTxsmVX4C+xNqNwwBaEjLH5iPnYXGkvu72KgsS2f5rQHvS+fWzldG+hXmzG9n6SuyoDH3+mBoRqjKsHdp3KuvQrBgaMy5HII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716765190; c=relaxed/simple;
	bh=5XNbmK1GMH0k0hqdPzWAk8W4SET/yQZHDoHkWs60AHA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ih3HwLA0Dh0hqTh1wPAP1+eNMN3kA+FCuihxHxm0uEAfujinScePuZwCYTT7MQKKH9OVXSBgJlmoKVwBcVlBnAGc1Dkh/koZZllFZk5F20o/gks6Ed66daDI1Xtx5Wj8m3m/roiSia2i7foenS+8yGU74oc2AkIrA8IXN9Xx8jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaC4aVav; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaC4aVav"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511A8C2BD10;
	Sun, 26 May 2024 23:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716765189;
	bh=5XNbmK1GMH0k0hqdPzWAk8W4SET/yQZHDoHkWs60AHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IaC4aVavecDuaPc3f+KW+vB5Zf9a6oNsGMubqfHm292P13hsLogIHU7AVDnJZBgVG
	 yI7wda9yb9c0mji1UZZEtHqibjiekAFCG1bR1LBZlKWTs/Sov+Hy3smPWky8wVDg5X
	 kE2cigOTyYd5tqpmUhVNzGFpSaIgvAfAxkr/9SKYVn+f8ncXIEULTSVaxnmnWsOl95
	 B6sFMDyDQgMPZ8nTjLVUyLNiEWde6aSKR0O11LfV0hbXoDBt8YVWC0oizzURr4Xd5p
	 h3SmNxJCKT/KmvGkK/sKBnT6fVMedTR3NIjEYYhYkUdCXBnp+LJ/9xzWmCUkwPLtBJ
	 J6aEl4bC3vyPw==
Date: Mon, 27 May 2024 08:13:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Carlos =?UTF-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alan Maguire <alan.maguire@oracle.com>, "open list:TRACING"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/probes: fix error check in parse_btf_field()
Message-Id: <20240527081304.8b91f75548838a0781288688@kernel.org>
In-Reply-To: <ff240b23-4143-4171-8dcc-1fdbf1802e8c@suse.de>
References: <20240525182131.15740-1-clopez@suse.de>
	<20240526191708.860651c915600a535cc2e579@kernel.org>
	<ff240b23-4143-4171-8dcc-1fdbf1802e8c@suse.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 26 May 2024 14:27:56 +0200
Carlos López <clopez@suse.de> wrote:

> 
> Hi,
> 
> On 26/5/24 12:17, Masami Hiramatsu (Google) wrote:
> > On Sat, 25 May 2024 20:21:32 +0200
> > Carlos López <clopez@suse.de> wrote:
> > 
> >> btf_find_struct_member() might return NULL or an error via the
> >> ERR_PTR() macro. However, its caller in parse_btf_field() only checks
> >> for the NULL condition. Fix this by using IS_ERR() and returning the
> >> error up the stack.
> >>
> > 
> > Thanks for finding it!
> > I think this requires new error message for error_log file.
> > Can you add the log as
> > 
> > trace_probe_log_err(ctx->offset, BTF_ERROR);
> > 
> > And define BTF_ERROR in ERRORS@kernel/trace/trace_probe.h ?
> 
> Sounds good, but should we perhaps reuse BAD_BTF_TID?
> 
> ```
> C(BAD_BTF_TID,		"Failed to get BTF type info."),\
> ```
> 
> `btf_find_struct_member()` fails if `type` is not a struct or if it runs
> OOM while allocating the anon stack, so it seems appropriate.

Good point, it sounds reasonable.

Thanks!

> 
> Best,
> Carlos
> 
> > Thank you,
> > 
> >> Fixes: c440adfbe3025 ("tracing/probes: Support BTF based data structure field access")
> >> Signed-off-by: Carlos López <clopez@suse.de>
> >> ---
> >>   kernel/trace/trace_probe.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> >> index 5e263c141574..5417e9712157 100644
> >> --- a/kernel/trace/trace_probe.c
> >> +++ b/kernel/trace/trace_probe.c
> >> @@ -554,6 +554,8 @@ static int parse_btf_field(char *fieldname, const struct btf_type *type,
> >>   			anon_offs = 0;
> >>   			field = btf_find_struct_member(ctx->btf, type, fieldname,
> >>   						       &anon_offs);
> >> +			if (IS_ERR(field))
> >> +				return PTR_ERR(field);
> >>   			if (!field) {
> >>   				trace_probe_log_err(ctx->offset, NO_BTF_FIELD);
> >>   				return -ENOENT;
> >> -- 
> >> 2.35.3
> >>
> > 
> > 
> 
> -- 
> Carlos López
> Security Engineer
> SUSE Software Solutions


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
