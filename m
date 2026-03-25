Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4992D13AF2;
	Wed, 25 Mar 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397587; cv=none; b=A8jf570iHqemawo1RH5WPLzp8flZzc0OgFdRm7QQMSdshKwXHmwNdptm+ZhM1neP2Ro75imrBMMdpkW+kmVlQmgMqkVl9xFyMG7M0D0LReqFiaWK7Y1B1WOhN7ONwVU44fI8Y1PyyO100cD+s6ld9m4kvtn7Vuvq72KUKICKQ8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397587; c=relaxed/simple;
	bh=k7P8ZSVzOlxZtdMtv/s4Zoijnz5Yzm//QXOtvGV/WiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NiZSA3ubesz44UB/2MhAeI9AbX8NiMnGDpaP2Hh3dUrvtyDY213HsiSjF/uCU/7tb4SRDCqWKYAHBEYYwty8Pw50M2qEG3YH2S0IQEfyx3BFojrv2J6VZh0W/Cfhb7TIADaAEMDR+n6XJCQl1vTKM6ar5hEyOtGDOuOfGa+p0X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9z6H8GW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9z6H8GW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002DDC2BCB1;
	Wed, 25 Mar 2026 00:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774397586;
	bh=k7P8ZSVzOlxZtdMtv/s4Zoijnz5Yzm//QXOtvGV/WiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W9z6H8GWnnBbOO0TbdJPRV5aVk/IMQwAzYtHUbNQAMF5UcD7zhGA7zm/ffwpUE3jv
	 C3KCGJayxMkNcqR3WcVNutMeOBDjbaWhN9KPGUA4LBkP1naYzKfkkwBjJrruBXv1o6
	 cjG1PbjcUhGsIPumbZKCLAHnZxgTeXPjxR9iyFVj0soMzGe7h/sL25kyl2WQ3gnJsQ
	 4T0xlpPY3rp+gBk8Kxg5kC7F2pL0m9+4xFdJLeqlCacYSUuqlUVpO6q1ylOoJJJnhW
	 CCL84UqrBH7LC7F7JOgrij3DG8T9memH+BDW/PevHIK5KuuYRKaxOB0U5ZB47loMLP
	 vJxXnoPTU5NHg==
Date: Wed, 25 Mar 2026 09:13:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v12 0/4] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260325091304.c94f4e9505660202f96006a1@kernel.org>
In-Reply-To: <20260325085644.4310a1295b0b962ed87b5b60@kernel.org>
References: <177431040276.3708637.10277850418341653677.stgit@mhiramat.tok.corp.google.com>
	<20260324172557.04cfc2a9@gandalf.local.home>
	<20260325085644.4310a1295b0b962ed87b5b60@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Mar 2026 08:56:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 24 Mar 2026 17:25:57 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Tue, 24 Mar 2026 09:00:03 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > Hi,
> > > 
> > > Here is the 12th version of improvement patches for making persistent
> > > ring buffers robust to failures.
> > > The previous version is here:
> > > 
> > > https://lore.kernel.org/all/177391152793.193994.8986943289250629418.stgit@mhiramat.tok.corp.google.com/
> > > 
> > > 
> > > In this version, I rebased it on tracing/fixes branch (thus
> > > the first fix patch has been removed) and fixed
> > > a build error which came from a copy-paste mistake.
> > > 
> > 
> > Hi Masami,
> > 
> > Can you rebase this on the ring-buffer/for-next branch?
> > 
> > It has the remote updates for pkvm tracing, and there's some conflicts.
> > That branch is also used by the ARM tree so it can't be rebased.
> 
> OK, let me rebase the series on it.

I found the branch does not have a fix [1] and it makes a conflict with
[2/4]. Can you update it to merge the trace/fixes branch?

[1] f35dbac69421 ("ring-buffer: Fix to update per-subbuf entries of persistent ring buffer")

I can send a series on ring-buffer/for-next but I think it may
cause the same conflict on git-pull later.

Thanks,

> 
> Thanks!
> 
> > 
> > Thanks,
> > 
> > -- Steve
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
