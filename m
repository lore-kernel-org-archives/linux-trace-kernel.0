Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A092F5085;
	Wed, 23 Jul 2025 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283962; cv=none; b=HTD+Kovw4rmKw+dJWdXwjDpV+Be++DTMSKh/L+Ivv2dYAxl/FMHRZ93XIxj4UlPruzTcznqz9kk0CjRhT7Hyh+gOVtJ37Ccplqi3JUGSGKqwEgaaKzqE7w5J5ODxrLrRlEExIU5XnvxEtTLDN999NRwwe23nllgUjACCJ4y87qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283962; c=relaxed/simple;
	bh=8UN6DASqeD8gpngnMjYkM6uwfRkgPxDPQgRstexiqRY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iAE34kLNFoWmLQGW7lR8OjEGkDEf2r7fSnblhR/MkMi1cSvkn6H0JGVatUBmpdBO2Ifv5PCibjmSOrGA5LxwtMgJLRIiWKpghKMEqeOtWR8EQqhhU7fQOWRFfFxTT3jUVWlE4CziLodwXQoq7+AgQFMVMbidIZAegjOBJ+IynEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mC2UrbcP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mC2UrbcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C61C4CEEF;
	Wed, 23 Jul 2025 15:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753283962;
	bh=8UN6DASqeD8gpngnMjYkM6uwfRkgPxDPQgRstexiqRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mC2UrbcPXgsO28Slg8j29/SR4gAPvr7WDyy+5p38ld6llFXr8TefdNm9i0EEMsYQ1
	 xpY6dlJDANhnC3adx0TVH9ThJOGflvHiRMHKnTcL60xKschM3cudaL27pMayQ683xU
	 HCezYKq2nngahhMMbeZGWMWxde+TO5XgZKMTOgttDlH0iRVjI1GIgMFZ0wkzkE6+VE
	 teq7UEdOR0B1Xm0i8XJq4HrhIa244oFP2qntshzKaEtePxSwqLHVbvDOABYQP34l3K
	 mS1MPn8fnyousj9W3tYeBKLgAFyizhO3wYgKFWE2DxjaRr6rDX01xP4IdbGKCdYgdK
	 Vg/Z5e65zb0mg==
Date: Thu, 24 Jul 2025 00:19:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] tracing: probes: Add a kerneldoc for
 traceprobe_parse_event_name()
Message-Id: <20250724001918.9dac6c9e5e36d7536fcd1eb1@kernel.org>
In-Reply-To: <20250723100049.46e8ec7c@batman.local.home>
References: <175323423662.57270.14650807176845939538.stgit@devnote2>
	<175323430565.57270.2602609519355112748.stgit@devnote2>
	<20250723100049.46e8ec7c@batman.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 10:00:49 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 23 Jul 2025 10:31:45 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > -/* @buf must has MAX_EVENT_NAME_LEN size */
> > +/**
> > + * traceprobe_parse_event_name() - Parse a string into group and event names
> > + * @pevent: A pointer to the string to be parsed.
> > + * @pgroup: A pointer to the group name.
> > + * @buf:    A buffer to store the parsed group name.
> > + * @offset: The offset of the string in the original user command, for logging.
> > + *
> > + * This parses a string with the format `[GROUP/][EVENT]` or `[GROUP.][EVENT]`
> > + * (either GROUP or EVENT or both must be specified).
> > + * Since the parsed group name is stored in @buf, the caller must ensure @buf
> > + * is at least MAX_EVENT_NAME_LEN bytes.
> > + *
> > + * Return: 0 on success, or -EINVAL on failure.
> > + *
> > + * If success, *@pevent is updated to point to the event name part of the
> > + * original string, or NULL if there is no event name.
> > + * Also, *@pgroup is updated to point to the parsed group which is stored
> > + * in @buf, or NULL if there is no group name.
> > + */
> >  int traceprobe_parse_event_name(const char **pevent, const char **pgroup,
> >  				char *buf, int offset)
> >  {
> 
> Much better.
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thank you! Let me pick the series in probes/for-next.


> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
