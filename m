Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C24339B3D;
	Tue, 29 Sep 2026 23:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724647; cv=none; b=szA2pZudqi7TnK7NaLKh+IPatITeMKw/H9qBn4lMocdnAwPQCdmn50Csk63unGXUn+yx3MmCqak5CI2Fd+AFAUur5R7DBoUnupTOiHBvarWSK/lI52LGi9LUsZ9FEyRYRU0XfsuakXjr3K3Vnh0L20yE+o80CzHLMECAJHnkIRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724647; c=relaxed/simple;
	bh=0U1s4tu2D0tjxGkQxbuSrL1MD4ytiEf10AqeLeorRRs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XxP+uRXvODaeY+qhxNVTCakl3P3fEMRAyl/WLW2WpHQ56j1iOOj+92clwnLU6In8ES26uXyb7Uvo235payuGTqbFWp8NT8oI/96Oraw/h90feKpdeEK13aZ2uybj69hUZdu7j6MbMrAwj9/8vBcXTPYiXTw/VHMuK/sUHCNGSrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVLE6t3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVLE6t3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF251F000FF;
	Tue, 29 Sep 2026 23:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790724645;
	bh=6ei53C3n8CMzaAPhq0hSD1cKMQlwaFDoDcA1UxxYGKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eVLE6t3YZp3+n2UvhLvsMzZkABp1K670HU50Yi85vzw/528YItpICqCY41y85Ks3X
	 HYGzRKcmAwTVG7vZ2jyD/QkAqB9FWGsLHFIjKnnwOm8FEGoUUCHhgoHA3ANt7V4Scx
	 10qeRFOSqbmNexfVzDn2bjXwZBLiVBYdH2NNLmHyT+kRquHJRQicwmYjOw+YozVMiT
	 eMQKQ7t5TvLMCsIuHNFIHIl/anX7U/lp2+DF4Zt5X8ShjnhChiToaKDmE6Ej7UMApL
	 OBEW9p7WBMfZNBcnQUBCJb12kKjnhEuuR/d0vegtP1lUsiCPRfkBGTm8MPRExmbUVh
	 UKUlXdj5IHL+Q==
Date: Wed, 30 Sep 2026 08:30:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Message-Id: <20260930083041.69ae294f887dd22c919e9cc4@kernel.org>
In-Reply-To: <20260929153906.6b1f9c29@fedora>
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
	<179055575973.241711.6618845269004184577.stgit@devnote2>
	<20260928005114.9C9FC1F000FF@smtp.kernel.org>
	<20260928212251.58fa1f68f33d4c967a8e8b1c@kernel.org>
	<20260929153906.6b1f9c29@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 15:39:06 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 28 Sep 2026 21:22:51 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > 
> > Hm, OK. Maybe we need to add something like checking rcu_watching, but
> > FTRACE_OPS_FL_RCU does not work correctly because fgraph_init_ops() only
> > configures subops (gops->ops). ftrace_startup_subops() does not propagete
> > that flag to graph_ops. (I guess that is yet another problem?)
> > 
> > To guarantee no illegal RCU usage or lockdep splats if an instrumented
> > function returns while RCU is offline, we can check 
> > 
> >  if (unlikely(!rcu_is_watching()))
> > 	return;
> 
> If rcu isn't watching then that is a bug.

Yeah, I made another fix for this bug.

https://lore.kernel.org/all/179064115227.394389.16910234241400391996.stgit@devnote2/

> 
> If you enable CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING then the
> ftrace_test_recursion_trylock() tests for rcu_is_watching(). We
> actually had that as default for some time to trigger any ftrace calls
> that were outside of RCU watching and was fixed.
> 
> Perhaps we need to enable that on more test machines to see if anything
> came back and allowed ftrace to trigger without it watching?

What about adding that config to tools/testing/selftests/ftrace/config?

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
