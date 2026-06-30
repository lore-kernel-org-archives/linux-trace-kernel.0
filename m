Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483115B998;
	Tue, 30 Jun 2026 00:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782779626; cv=none; b=BS3+ZSi9zuCHCZV4oWrtJ6cZjeSO5XU29Y/hnSmZgp4LpSX+jK/U2Vlx9xG3KpSoAPDWC8wDIPWKLnkWbJYzjOFD+aAHsEvPHll7H42p3MD7YJylwoXRleE5PXJwozrZD8J0ryr9gjdVc3AKRjCjl1l60vdMv5AzwJ4Mtm7rHu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782779626; c=relaxed/simple;
	bh=/6w/l1WZWkW9CW/8+6g8VS9FlwTRUuHQu/QVJQe7A/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBgFPxWMAS0I+gSulOY9PzJzTq6HZNTYViu7IXWH0+pbz7ZNSoey/jeXr1gGFuW1xUW6oxqHBvSZfAhk7UgHCsKgwdA3cj3ILcj9NQpMk2fkYVX5xzhJxdtG0TuO0tdjOkhwhN+R0AwUJUqv+9c70YcGmpo1yAqxv5l9u3LTrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCc9vUup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCc9vUup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC4C1F000E9;
	Tue, 30 Jun 2026 00:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782779625;
	bh=qPEgJXw22gBmOw6FP4JRG+1whERjS/vG4zIbCsgWbT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XCc9vUupU5hhkT3bZRifJd/hbrBjgxXmCdsJaVUJPKx88+XjGRX62PWN098zZSUQb
	 Mm1iLLtgeE2FMyx75XgXbiHFp+83ibyL+0ZEJuz+f8/jKIThcBAzT1uI9AeUJn9Lj8
	 u1U5bSO+X/2JXOXkTDok5dTSnuPbXfE7oLL4yePrIdLZ0NDImnRqWdxP5C6mluKn/S
	 lY3MnDXw09mAMjPHMWLLs/rbEHzAUf6HKNG94CiavNPTdkO5sQ/dyblRL68WOYovG2
	 mbAaxxf3306BTSj8+/8ktCRcPVJboWJgb78R5B49ja2w7UdaDPOGWx6DYXgJDq1ZEx
	 bCYJpWHuUZRLg==
Date: Mon, 29 Jun 2026 17:33:43 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 04/11] perf/probe: Ignore comment lines in
 dynamic_events/kprobe_events file
Message-ID: <akMO53eG_4YKJH0j@google.com>
References: <178271357142.1176915.7193483024740701480.stgit@devnote2>
 <178271361825.1176915.16095297120719039761.stgit@devnote2>
 <20260630073211.2a505d1f31e5fae1bf03b81a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630073211.2a505d1f31e5fae1bf03b81a@kernel.org>

Hi Masami,

On Tue, Jun 30, 2026 at 07:32:11AM +0900, Masami Hiramatsu wrote:
> Hi Arnaldo, Namhyung,
> 
> I forgot to CC this. Can I pick this patch via linux-trace tree,
> or would you pick this?
> This is a part of typecast series [1] only for debugging.

Thanks for letting me know.

I think it's better to route this through the perf tree as we're seeing
a lot of cleanups all around the code base.  Having this together would
reduce chances of future conflicts.  Does that sound ok to you?

Thanks,
Namhyung


> 
> [1] https://lore.kernel.org/all/178271361825.1176915.16095297120719039761.stgit@devnote2/
> 
> Thanks,
> 
> On Mon, 29 Jun 2026 15:13:38 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since dynamic_events/kprobe_events files show the fetcharg debug
> > information as comment lines, its reader needs to ignore it.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  tools/perf/util/probe-file.c |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > index 4032572cbf55..4d12693a83b3 100644
> > --- a/tools/perf/util/probe-file.c
> > +++ b/tools/perf/util/probe-file.c
> > @@ -197,6 +197,8 @@ struct strlist *probe_file__get_rawlist(int fd)
> >  		idx = strlen(p) - 1;
> >  		if (p[idx] == '\n')
> >  			p[idx] = '\0';
> > +		if (buf[0] == '#')
> > +			continue;
> >  		ret = strlist__add(sl, buf);
> >  		if (ret < 0) {
> >  			pr_debug("strlist__add failed (%d)\n", ret);
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
