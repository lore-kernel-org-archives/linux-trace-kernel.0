Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126446D567
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790711289; cv=none; b=rNl9qQocRbFZT8GT3030Sfj/VZQcMQTr9y3GWlikn74IZ45h7L83fbwW0hxMTyVamW3h1EVMwolYxzerDBUHEMC4Jya1wc2wI7V4AMzeL1+277FLWu2kBLw/XzeHfW1r4x/DVflpXglJp/GFfx7E7JefNW/PMuPX0zVO1Wb2c/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790711289; c=relaxed/simple;
	bh=DNUlYcJcSEUFHMm5obKzwX9J6libSg16uQzAP1pKcQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XFf8nafIlr3JUbI+RZzNQGFzamR8qGTFxxmc4QHGMqeToiDCsygCxFVLSw+OfqsFi9Ko1yVVoMeB/wJCQzkofiEU+d+UikJzl05YNCFsTDpJFHyLCSU4EBi3JSTeNhdhPfA1d3NgCCO8ZzACdwF1U6hyYQeRe03GETtYOPJ0hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=Q/vE5jO+; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="Q/vE5jO+"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E3658401C8;
	Tue, 29 Sep 2026 19:39:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id BC27120018;
	Tue, 29 Sep 2026 19:39:09 +0000 (UTC)
Date: Tue, 29 Sep 2026 15:39:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, sashiko-bot@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] fprobe: Protect fprobe_return() with guard(rcu)()
Message-ID: <20260929153906.6b1f9c29@fedora>
In-Reply-To: <20260928212251.58fa1f68f33d4c967a8e8b1c@kernel.org>
References: <179055575009.241711.6358052647499787191.stgit@devnote2>
	<179055575973.241711.6618845269004184577.stgit@devnote2>
	<20260928005114.9C9FC1F000FF@smtp.kernel.org>
	<20260928212251.58fa1f68f33d4c967a8e8b1c@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BC27120018
X-Stat-Signature: 64rxwjxc7h8xzymq7yf5xeybsu56coga
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19EJTXI6Y25m7rHCu8yDfU5KgFid2hBqK4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=jjbDCGbXfyKSSVMX4uWSBtgxjUjoFTH1WWvMXYQ5xp0=; b=Q/vE5jO+eO2yzw9ZhHjRYjYfdACrM+b7Nrh55JffvIvJbJHRGGTn8zeKuOUTdMwcrR7tgbpbADF7ZFoqHTjelLmSxaQbIljq/iq4q5A7sIRb0KaypUMEGdE6WzPfoBnx4/3v4TP96JABqqIsJE61YHDa4LsQWMDFdcYSslpydcM=
X-HE-Tag: 1790710749-136500
X-HE-Meta: U2FsdGVkX1+7Asc9l6BwE9XzBFYbgHRhNF04fNCkailSZIkioM+DDR0DbXeJnPdiFRn1ib7iJH2jDjVxQL1Zi41lx0MPtGUsMVgVw0baOMX7H7djyukoLxFc9dvgAAG1dv3gF3MJcbQLb8B1ywlRZVTrbQatDkpIAN/atmPch/YU+/Mo34APRIQsF+mskG1kFgk/qXHdpShuc+AElaySxZpOKG1nwY8orQUiJWINazFILgk3pB/I6qbVSoOZwckY7mJZVcda5NpbAA4JXGdE7eVTdr8vN1Mp88KJIDML9g4scKWBcgaxByIY/T/ym30Oxlw664IBfsXDMQ8FSPGP59n6Im52ez3x1Wj3bXvU8sDj9MnNp7GcWg==

On Mon, 28 Sep 2026 21:22:51 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> 
> Hm, OK. Maybe we need to add something like checking rcu_watching, but
> FTRACE_OPS_FL_RCU does not work correctly because fgraph_init_ops() only
> configures subops (gops->ops). ftrace_startup_subops() does not propagete
> that flag to graph_ops. (I guess that is yet another problem?)
> 
> To guarantee no illegal RCU usage or lockdep splats if an instrumented
> function returns while RCU is offline, we can check 
> 
>  if (unlikely(!rcu_is_watching()))
> 	return;

If rcu isn't watching then that is a bug.

If you enable CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING then the
ftrace_test_recursion_trylock() tests for rcu_is_watching(). We
actually had that as default for some time to trigger any ftrace calls
that were outside of RCU watching and was fixed.

Perhaps we need to enable that on more test machines to see if anything
came back and allowed ftrace to trigger without it watching?

-- Steve
