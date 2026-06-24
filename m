Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1201D2E8897;
	Wed, 24 Jun 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311551; cv=none; b=UhsvuDwwldEJBIVfnXmZKO6SZHoN6TziEWXA2PwHvqJrFdSFd505ytzbjCQ2ozEY55yHkc1FAVDm2QCE5z0ziV7RlV3MhtPPW+O8LVS6Kxj3c4ndiQNmz79jMRKdJCmoOfmWz2ytuRI15ZEyqV6Clm6mWpjpZ4rR5czgvjPCXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311551; c=relaxed/simple;
	bh=Ltzy9N2Ct1YFt0HBLgAytdk2KKYtDwPRX4wdssbVauM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJT2IEEtyGcehf1rAjsDjS+1BvER2dKQxVTU11okmXea89Z7Vgq9h7Q1v7CH0R26oDC+z+2oHMP6Q/eWmoXqu0rORxeBQmBHneo9kOBNLOwrIqLkBVZlLkWCLfDiyrTNAU/Ea9uSETYIbl1LqXIKzd2N1/6O6jEARFYAhEkWIe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hhs7zuPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hhs7zuPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB041F000E9;
	Wed, 24 Jun 2026 14:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782311550;
	bh=qsK5IzzPhKFXovhsNgY6jYi9QNblCAQFQdzePht7neQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hhs7zuPrg1Iy3HX5dIuJUivxGhJcf5qedVa4PR4LRXFvv30KdDw7Fme1Qdj2NWQte
	 EgedfusHPjLs0lU0dq/w6Wpt7+kqmN4ybml9W41Gk/5YM75zRZ5c969uY0doSaHgLw
	 p/cZ3LyQ7upwFuSFZTZ+0AdGZBZw2+s5Kib6HjyThoyI9hNUS7eJhaQ1sz6ts05/oe
	 jGp98jpzJRcZEbBi/Jeuq7NQ5sy2mSxOTzGMThHbP0xp8TP+AKZd2IapSVtiMlyfNL
	 XJH3JlWtR1QgbBGqafzuDeIQw9yWRncqU0PQ33SchFxlT+SHlp9YXu2xT2SVrbdlCb
	 bJF4BwP/z8vew==
Date: Wed, 24 Jun 2026 10:32:25 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v3 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260624103225.77116713@fedora>
In-Reply-To: <20260624111152.75476a46@pumpkin>
References: <20260624081806.120105649@kernel.org>
	<20260624081948.301578807@kernel.org>
	<20260624111152.75476a46@pumpkin>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 11:11:52 +0100
David Laight <david.laight.linux@gmail.com> wrote:

> That is all about changes to the file causing everything to be rebuilt,
> not the contents of the file slowing down builds.

I guess I should say it better. It causes more build time if that file
changes. That's what I meant. I update the wording to say:

   There have been complaints about trace_printk.h causing more build time
   for being in kernel.h it if changes. There is also an effort to clean up
   kernel.h to have it not include unneeded header files. Move trace_printk.h
   out of kernel.h and place it in the headers and C files that use it.
> 
> The part you are moving out of normal builds is just a few #defines.
> They won't have a significant effect on build times either.
> 
> So there is no point splitting out trace_controls.h.

That is a completely different reason. trace_printk.h is about
trace_printk() usage. The stuff split out into trace_controls.h have
nothing to do with trace_printk()s.

-- Steve

