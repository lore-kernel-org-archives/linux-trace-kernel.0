Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58F717588;
	Mon, 15 Jul 2024 19:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721070820; cv=none; b=qb58n5zUcLl9ZvdjLRbtH2UzcvzVMig7a5VaGBqPHKRLE4mzC2zmuDc3VYXAmYYiWFvm/aRl+/LL7DE9Hk7cdYitdcpOJd99Gu1SU8us1Wh9iiL72+vM4z8MKtxejYHPde1YXGUECZUFUbh2cH3sGQkAbQY1N4OJ7tLouDizn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721070820; c=relaxed/simple;
	bh=Axb01+sORCpMfqjWaxP0z6U9BgpEpQG6R2NJGc8loJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIWHeM7pQ7NyxmLBk7zT9H5/E9yrghGYSWyqYQUipmWPwlikAcA6GaUVImzimwuXJ1R95jeJU4oCeYGCsUZgSxkMJebdE0Kv3GyswaDsefWYVhWhH5dAbgVSElDgsGv6gwi+vsZaKgjilvIwFVUEkkLr043gE87mJG84JRhulAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ABEC32782;
	Mon, 15 Jul 2024 19:13:38 +0000 (UTC)
Date: Mon, 15 Jul 2024 15:13:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ingo Molnar
 <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>, Kate Stewart
 <kstewart@linuxfoundation.org>, Clark Williams <williams@redhat.com>, "Luis
 Claudio R. Goncalves" <lclaudio@uudg.org>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] tracing: Update MAINTAINERS file
Message-ID: <20240715151337.2d47d003@rorschach.local.home>
In-Reply-To: <11fe922b-ffd4-4173-b1ff-d49745431fb0@efficios.com>
References: <20240715144745.51d887a9@rorschach.local.home>
	<11fe922b-ffd4-4173-b1ff-d49745431fb0@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jul 2024 15:10:17 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2024-07-15 14:47, Steven Rostedt wrote:
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> > 
> > Gone but never forgotten.
> > 
> > [ Also moved Daniel's name to be consistent with the alphabetical order ]  
> 
> Hi Steven,
> 
> You appear to have missed this entry from SCHEDULER:
> 
> R:      Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
> 
> Should it be done in a separate commit or folded in this one ?

That has already been done:

  https://lore.kernel.org/all/20240708075752.GF11386@noisy.programming.kicks-ass.net/

This patch is actually on top of that one.

-- Steve
