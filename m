Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98255368D76;
	Tue, 26 May 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809583; cv=none; b=Juq/da3kSaS8EAAIbUNuWl/yqpw7YLyg8H5b8E/QCVhO7rqotU4zkRth34eTYRlnBzrlJH9aEkX/KJY4COBvXshs4cjtOKRTy5aLhKIhvUHCa82K/flU10IE+jJHs/mtkjj5rkfGxFmaDPpRHqcLG1LS2SaePEo7VcqtDL8iDY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809583; c=relaxed/simple;
	bh=28dI9Mpdlp2cJAFfh8cNULH9GtSVf7CkHM+HxNi8MDs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjVOIqXpONU3fBmiqxA6nsiPeL137D1KQmy5bP28lj8ETUgun11CRLji7acfaO4m0Nq7NpRr+vqeDb1Tj1zjoyZ2p93q0rSLViFEubvt5CBqWpd7C6a4p1MrbLulHPUftdnb03m/uWixApnZJm8vtTtc6QgpfZVY/F8on1aIFhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQBDrSLt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQBDrSLt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ABF1F00ACF;
	Tue, 26 May 2026 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809582;
	bh=kRBDHmc5BfTBjzjut4J6dPGhMph9nuv1qNcdKe7YuE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oQBDrSLtBrTOGAqyOWi6yaverYpWbF0Ghw2W6t0x/UYDcH5nNgz5AAZM0ShSiInNq
	 HZIQJJ4dGqeNiUlA0QvMoMJFNZ9V5cHdF7rcrkyieKNgq1PpWP/fSll+3Ry1kBBdns
	 SHHl04UNKvoHpO2ds5UD3/Q3muI7mIbxuZl3LUHEisWpqcpQq5AKLVOlY6oOhcvZGr
	 ugmfNnSLaW+d1MatjHQtBJeDUjeiA2ARVSZcOsxkIp3TdWyWMs29xswGhKcsUhhOeR
	 2d64cqoN5tP+kCEv1f6neD1ESX5qMRl000vvQHD88CTIIH/ku4mGLWvu1lTC6XdhXO
	 wAWIzCNm7+JuA==
Date: Tue, 26 May 2026 11:33:32 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Douglas Raillard
 <douglas.raillard@arm.com>, Tom Zanussi <zanussi@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ian
 Rogers <irogers@google.com>, Jiri Olsa <olsajiri@gmail.com>
Subject: Re: [PATCH v6] tracing/eprobes: Allow use of BTF names to
 dereference pointers
Message-ID: <20260526113332.1880146e@gandalf.local.home>
In-Reply-To: <20260526090910.8aae5c9357e119bd0043b18b@kernel.org>
References: <20260521225033.56458336@fedora>
	<20260526090910.8aae5c9357e119bd0043b18b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 09:09:10 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 21 May 2026 22:50:33 -0400
> Steven Rostedt <rostedt@kernel.org> wrote:
> 
> > @@ -640,7 +673,7 @@ static int parse_btf_arg(char *varname,
> >  	int i, is_ptr, ret;
> >  	u32 tid;
> >  
> > -	if (WARN_ON_ONCE(!ctx->funcname))
> > +	if (WARN_ON_ONCE(!ctx->funcname && !(ctx->flags & TPARG_FL_TEVENT)))
> >  		return -EINVAL;
> >  
> >  	is_ptr = split_next_field(varname, &field, ctx);
> > @@ -653,6 +686,20 @@ static int parse_btf_arg(char *varname,
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (ctx->flags & TPARG_FL_TEVENT) {
> > +		int ret;  
> 
> nit: parse_btf_arg already declared @ret. So we don't need this.

Ah, will fix.

Thanks,

-- Steve

