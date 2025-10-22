Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C385126FD9B;
	Wed, 22 Oct 2025 23:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177581; cv=none; b=uFqN8JnJaWMbTkXg4LocY7kdiXTFIFF60ZsBh1hmtSNQTfCluBJjkxghuyWTyv88jIsdn71Zb/7A1tWy3CYrfFsS2/MRC7MC1QsMBv96aUAqr78Oqc2SwHfDV4sjJUWVsvVYgXCgXxdb+cZ/A9/JyAm3LsxAqex3PrpekqZhJWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177581; c=relaxed/simple;
	bh=A8YNX0TDyOlYquOCv4Wwly9V8rCb4XKy0zeVDgmtksY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j+ofvlrUwSgguAm8wym7MDEiueprmZEl651VBL7uuuC4xz/S/UAk5zcw2SCiFYQyvs7lgH6otysYTY9c/OSBMUqDdHxqWDIJNYRGy6xtLszUiMoRXM1kTj+FK8/GTumAZHboySLbveXxsA9eFjuDCfLSrc3SYAhFI28hHc8bNMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USPghZZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USPghZZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B72C4CEF5;
	Wed, 22 Oct 2025 23:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761177581;
	bh=A8YNX0TDyOlYquOCv4Wwly9V8rCb4XKy0zeVDgmtksY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=USPghZZx1SeGVOw/gZ3STAJU64kUtPBaOHREliSg2DAhFNJcN7QhIMBioRhIn6Xp/
	 pyfFhM+EHkFGbUgnAPKiP7TScY6pLWb62h6YAkvWD6Z7rm50fZXnEBm7aAcT3nkgss
	 /oW/9pmS7iAShJCpK9KBftk/a+mg2yt8Kp5pVEutu6qiYqsQn4me20Vubxwqcap4r7
	 SgEZ63fguzdGQ+P4Mb+y+a0Fq5gCzA9JZ6KWxEndYLQO+i+59KWZpwBFTIeNddKQQa
	 4EAkcK7UKzIajS1YiCX19xu3Nk9pTf4/nXtp3w7K4Igvm2W7Wu2+FkUx7+LxpnOtt3
	 UyvdP/WjgTaWg==
Date: Thu, 23 Oct 2025 08:59:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] tracing: Add an option to show symbols in
 _text+offset for function profiler
Message-Id: <20251023085937.0dbeac1fde692da17f5ec5a4@kernel.org>
In-Reply-To: <20251022123259.59ada139@gandalf.local.home>
References: <176114747153.315239.6863821259073466010.stgit@devnote2>
	<176114749146.315239.7968358300215825393.stgit@devnote2>
	<20251022123259.59ada139@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 12:32:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 23 Oct 2025 00:38:11 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -554,7 +556,29 @@ static int function_stat_show(struct seq_file *m, void *v)
> >  		return 0;
> >  #endif
> >  
> > -	kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
> > +	if (tr->trace_flags & TRACE_ITER(PROF_TEXT_OFFSET)) {
> > +		long offset;
> > +
> > +		if (core_kernel_text(rec->ip)) {
> > +			refsymbol = "_text";
> > +			offset = rec->ip - (unsigned long)_text;
> > +		} else {
> > +			struct module *mod;
> > +
> > +			guard(rcu)();
> > +			mod = __module_text_address(rec->ip);
> > +			if (mod) {
> > +				refsymbol = mod->name;
> > +				/* Calculate offset from module's text entry address. */
> > +				offset = rec->ip - (unsigned long)mod->mem[MOD_TEXT].base;
> > +			}
> > +		}
> > +		if (refsymbol)
> > +			snprintf(str, sizeof(str), "  %s%+ld", refsymbol, offset);
> 
> Let's be consistent as offsets are printed as hex every place else:

OK.

> 
> 			snprintf(str, sizeof(str), "  %s+%#lx", refsymbol, offset);
> 
> Also, did you mean to add the '+' after the '%'?

Ah, yes it is for the case if the offset < 0. It should not happen, but
for robustness.

Thank you,

> 
> -- Steve
> 
> 
> > +	}
> > +	if (!refsymbol)
> > +		kallsyms_lookup(rec->ip, NULL, NULL, NULL, str);
> > +
> >  	seq_printf(m, "  %-30.30s  %10lu", str, rec->counter);
> >  
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
