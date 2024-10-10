Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD441CBEAB;
	Thu, 10 Oct 2024 20:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592387; cv=none; b=HxySDnI0EWW7ylhXSYniYpv8OXCS3uQAmARFHJYN/wsXlTrJrmUztC2BpBtPMmrczUTKUV+Kw/FB0yQciyNAXfaEHkuvbjQHo/fl1RVlDz4QZMGoQOOCEqQepQARp1DrWMuxtpY3NgZrvIMMBDNhlLCjN1TAiAxRoJANiry5B+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592387; c=relaxed/simple;
	bh=D9BJOsFOkn7PHyzm0nF0QCJsK5CqbWt+pRVpN5WAN6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MF0vJ6aZV6AhVrj21IlZelrovbHxG8lWCEFLq2VcPWjGui6OmVhMIwSyf2gRcAfTi+V8pVJz+nS6oYz9K4q+WAW1AhWAn44m3sbnn4RDJCq38Ye0eyCZVMQjO3o7YjEik8QqSud+CVHRdm72SNobFtFD1m9TCopHWH3BeC3GP7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32031C4CEC5;
	Thu, 10 Oct 2024 20:33:06 +0000 (UTC)
Date: Thu, 10 Oct 2024 16:33:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Helge Deller <deller@gmx.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, linux-kernel@vger.kernel.org, Sven
 Schnelle <svens@stackframe.org>, linux-trace-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] parisc/ftrace: Fix function graph tracing disablement
Message-ID: <20241010163313.631e84bd@gandalf.local.home>
In-Reply-To: <f2dd3a74-cd3d-4277-904d-223a8b393d56@gmx.de>
References: <5962b9e161b2b9296509c3d65c7f16c11b07bd16.1727904678.git.jpoimboe@kernel.org>
	<20241010154840.6e158c78@gandalf.local.home>
	<20241010195610.25mraxgovi4vowo2@treble>
	<f2dd3a74-cd3d-4277-904d-223a8b393d56@gmx.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 22:25:13 +0200
Helge Deller <deller@gmx.de> wrote:
> 
> Actually I do, and yes we have users.
> Of course in reality that's "fun" users and not "productive" usage.

We welcome those "fun" users as well!

> 
>  From programming perspective parisc is quite interesting since it
> has an upwards-growing stack, limited ways of atomic ops,
> and some awkward cache dependencies, so I regularly find
> issues in generic Linux code which would not be found otherwise.
> 
> > I still see some git activity in arch/parisc, so apparently so...
> >
> > I only stumbled on this by accident (code inspection) while making
> > another unrelated change.  
> 
> Thanks for your patch!
> I'll apply it in my for-next git tree and push upstream at some point
> (unless someone else takes it before me).

For architecture patches like this, even if it is obvious, I rather it go
through them, as I wouldn't even compile test it.

Please take it through your tree.

Thanks,

-- Steve

