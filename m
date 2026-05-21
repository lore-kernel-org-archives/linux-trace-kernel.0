Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F603CC7F4;
	Thu, 21 May 2026 12:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365801; cv=none; b=NoypC9V+YAPVFPMi3MrAViQ9IesxlUu2kL+jeTCJMWeUIFqy+Cudo1OdhPHOxqneHekc400Hsdn0fZXHaGPeDMWJ6mHC0N2V/kVqB+wGVeilyQAaa8v+ktFKG+5w+URYuslxuR/xJ/qxKwTn66z7LRt078ZX9u/uxsTj8JJllTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365801; c=relaxed/simple;
	bh=e1My3C1cII1janYctECszAwvbGFMeC/1R2Ug/gDTvNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFK1O9fw4dRteGkAeTko/XKx0VWcVH1VxabroNbiDNoBs9BbbyMSSzaWfMp8cYZefqStcYSDNOfMGwqbhDthjtBaNxQc4YRSV3GOqhRk+1JMN+DKmVKyLfD+GqjN+Kf3ax7Y0QUN+h/lav8A+8YgquhT1S8Fnfo3tullBR77o10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfwTDMRb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfwTDMRb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC741F000E9;
	Thu, 21 May 2026 12:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779365800;
	bh=EHJsw16saDvwVq/ZjEb6ayD5x87Vf3b7QZFrAf1WM3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hfwTDMRb6CG6/U3xydwzY/SFJk737IMZIvF0Myksm7yqVJA5d6W1GCap9rh/4L44m
	 EJW/zRyM0+qtkeOiZLFdK8Cz6drv3g5ifWmDeR89NbYoIOFxpp1KXJ3ys4MiYDpUp7
	 G6xiF3HHovL5aPPQJLKgc7UxS5UfdFMg/UG5oWByb6Cv1vi+LuSbYLSFbbI/8PYqw7
	 VOH4qKuZTKo9FfLzP/Bl0QSds4FfFRYfnjS95H2GW6HTkZDVnXCmiP9MkM9u8omcny
	 c2MPPRBGM3quLGIi/+Eqvi9ZM2vTlrxKWe8exFerruKztRj5i3AU21GOroHvXRtrfl
	 xR+tj1UMoCJcw==
Date: Thu, 21 May 2026 08:17:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: Re: [PATCH v20 10/10] ring-buffer: Show persistent buffer dropped
 events in trace_pipe file
Message-ID: <20260521081700.044b916a@gandalf.local.home>
In-Reply-To: <20260521171859.dec135e45fb443b7bf5fb964@kernel.org>
References: <20260520184938.749337513@kernel.org>
	<20260520185018.470465795@kernel.org>
	<20260521171859.dec135e45fb443b7bf5fb964@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 17:18:59 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> >  
> > +		if (commit & RB_MISSED_EVENTS) {
> > +			printk("MISSED\n");  
> 
> Is it for debug?

Yes, that was left over. I thought I got rid of all of them. :-p

> 
> > +			flags = RB_MISSED_EVENTS; }  
> 
> nit: block closing brace is in the previous line. Maybe typo?

When I do debug statements, I end block statements like this to let me know
that the if statement is supposed to be one line when I remove the print.
But since I missed removing this one, I kept the above formatting.

I'll remove this in v21.

Thanks,

-- Steve
