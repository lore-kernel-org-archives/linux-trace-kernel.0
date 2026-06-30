Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D0282F3A;
	Tue, 30 Jun 2026 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859185; cv=none; b=fuxS3Fx4Ij8kjbzUPrtgkYFBbvcRTqOnzzjeMKr14Lul/2P0HIdbpJOr83RG20LyXulUT1gNS0S/6+/LbmLfUtYpjSXWHnGmS1srqk2FVD0BUmoLeAHQvlJAZaBDubGhga0sMYAFFd66akZ1CBih3vZ6z9sGJCUiTMYAdrY06zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859185; c=relaxed/simple;
	bh=bcmFRuTRz3xFXMFsvy1OnWTU+QK2rBR/OGAUL5fqFgY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Rth4xOJqcEGny7r/c6RIT6+h84zvDyRhLtROGy/sBct1mDPIdEm7H9p81CXoWhbPnuSNsO22b/fcrFDlLUZH6Pd7yIVu3QM8/LfBf4SPVgzLcjsoHU304J3kJXG3LKucvJvN/s+Ukb7FE8auX3x3nXg2gvXPyVf8jXTmY3Y9+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtVgdWpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtVgdWpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859541F000E9;
	Tue, 30 Jun 2026 22:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782859183;
	bh=4G7kaaTAc8WYqpYxAs+aIasDlm+/YN4ZAPXD3DbZ28Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UtVgdWpuj6qBAEbVSFQ1jTrgtA55E4/juVPjoELVUwYydsxebJvYt3SN2UWMOD01q
	 Xo6yoYX8JymhGFvvwNEyjPNO/bU3R8QW8jSVHfmcLJSX7bRrpgpcj4d8rGiLP7sFr4
	 1kyrCgV+cAjKRnaKP//QCX3u0Gnx2J14rOg4i9DeYDS7Dqaa/TX7q/cchfTrBxNQVb
	 to4uDHYLQmecXXkyrpoeIN4hXi7JgERrL1A8MJ2Mdzwr/y7xMdC6R6zLj7AnnooQT5
	 qvpy5uzjJTIHG21PsTpp/ATGQyyiJ08ikaMpx229jHcpT2TQqa4tw5KuwDjXyBjGsh
	 KQQAX+KyMpMmQ==
Date: Wed, 1 Jul 2026 07:39:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 04/11] perf/probe: Ignore comment lines in
 dynamic_events/kprobe_events file
Message-Id: <20260701073939.81842d6f6bd139a329c45c7f@kernel.org>
In-Reply-To: <akMO53eG_4YKJH0j@google.com>
References: <178271357142.1176915.7193483024740701480.stgit@devnote2>
	<178271361825.1176915.16095297120719039761.stgit@devnote2>
	<20260630073211.2a505d1f31e5fae1bf03b81a@kernel.org>
	<akMO53eG_4YKJH0j@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 17:33:43 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Masami,
> 
> On Tue, Jun 30, 2026 at 07:32:11AM +0900, Masami Hiramatsu wrote:
> > Hi Arnaldo, Namhyung,
> > 
> > I forgot to CC this. Can I pick this patch via linux-trace tree,
> > or would you pick this?
> > This is a part of typecast series [1] only for debugging.
> 
> Thanks for letting me know.
> 
> I think it's better to route this through the perf tree as we're seeing
> a lot of cleanups all around the code base.  Having this together would
> reduce chances of future conflicts.  Does that sound ok to you?

OK, thanks for confirmation. Then I'll drop it from probes/for-next (and probes/core).

Thank you,

> 
> Thanks,
> Namhyung
> 
> 
> > 
> > [1] https://lore.kernel.org/all/178271361825.1176915.16095297120719039761.stgit@devnote2/
> > 
> > Thanks,
> > 
> > On Mon, 29 Jun 2026 15:13:38 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Since dynamic_events/kprobe_events files show the fetcharg debug
> > > information as comment lines, its reader needs to ignore it.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > ---
> > >  tools/perf/util/probe-file.c |    2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
> > > index 4032572cbf55..4d12693a83b3 100644
> > > --- a/tools/perf/util/probe-file.c
> > > +++ b/tools/perf/util/probe-file.c
> > > @@ -197,6 +197,8 @@ struct strlist *probe_file__get_rawlist(int fd)
> > >  		idx = strlen(p) - 1;
> > >  		if (p[idx] == '\n')
> > >  			p[idx] = '\0';
> > > +		if (buf[0] == '#')
> > > +			continue;
> > >  		ret = strlist__add(sl, buf);
> > >  		if (ret < 0) {
> > >  			pr_debug("strlist__add failed (%d)\n", ret);
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
