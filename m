Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097F515B0F2;
	Thu, 10 Oct 2024 19:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590173; cv=none; b=szYi06zDrnH4toysEODD3ZJYEfg/Nmm/Gt7PG9/+0hh0F07HfBgkJlAIZRGCIEKiPyp1RjEn+DZDmWrsHqqNIsqrshwEqyCEL+UvsICMTn2CeoGT+IHy9jF8jVi7k3Z7XU+k6qv9tNVMZJfpNMs/UnViwlicmgVCtW1w9WjV/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590173; c=relaxed/simple;
	bh=MkUEUVGcuuhQE68KsERgu8vbOlc8YB+zuF14JiQ8QrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEwOV4C9J57tds13TYax3a/nrEWsYgg2fuge7teIrmO8p438xV32Efl+uRsKv1iTc6Hfd7ykr4nninUgMlauAiUVJABwSX7iASN9eW1g5Sp39w77F9gOcot9SRnZpzX5iMngr0XsnxMIWTTEzeFsaqgvcahop8Aml6cVLB9fat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azDC+v2p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azDC+v2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DB09C4CECC;
	Thu, 10 Oct 2024 19:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728590172;
	bh=MkUEUVGcuuhQE68KsERgu8vbOlc8YB+zuF14JiQ8QrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=azDC+v2pYvXDTaQ2tJSkkBwsoE4vg2Ma7W0FClxtYW8UFxPSVYr3aEgbXiQpnmKTH
	 GrLfLKhskiXqdxkJXRrFcp+f7Hkssn3rQLvciVEW21B95mcLKtxUSuVsllbbzavNC2
	 vsjID/wJ1vMPoyxx5cQcTKp+4pwTfFHFK3NakLNsbJwf2r6wf3zVpGu+X6rzJ8+mXE
	 LljFr93BEK8sd9PcXkDdn4CyMdjEKT54g8MXy3IBlz/4vBoZoNBn5ewT2lxYwyoay4
	 dvL7sT085KzacjlylnKSKJDGXarFJa9FSJQDt0lFFVGMqDZywJuFrJXHeiWDT+2tXM
	 NwnGZ9sR3lq8Q==
Date: Thu, 10 Oct 2024 12:56:10 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
	Sven Schnelle <svens@stackframe.org>,
	linux-trace-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] parisc/ftrace: Fix function graph tracing disablement
Message-ID: <20241010195610.25mraxgovi4vowo2@treble>
References: <5962b9e161b2b9296509c3d65c7f16c11b07bd16.1727904678.git.jpoimboe@kernel.org>
 <20241010154840.6e158c78@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241010154840.6e158c78@gandalf.local.home>

On Thu, Oct 10, 2024 at 03:48:40PM -0400, Steven Rostedt wrote:
> > +++ b/arch/parisc/kernel/ftrace.c
> > @@ -87,7 +87,7 @@ int ftrace_enable_ftrace_graph_caller(void)
> >  
> >  int ftrace_disable_ftrace_graph_caller(void)
> >  {
> > -	static_key_enable(&ftrace_graph_enable.key);
> > +	static_key_disable(&ftrace_graph_enable.key);
> >  	return 0;
> >  }
> >  #endif
> 
> Awfully quite :-/
> 
> I wonder if anyone cares about parisc today?
> 
> Hmm.

I still see some git activity in arch/parisc, so apparently so...

I only stumbled on this by accident (code inspection) while making
another unrelated change.

-- 
Josh
