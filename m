Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFED3BF684;
	Tue, 23 Jun 2026 08:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782202190; cv=none; b=CoV6k/8l3DxTI35DYfQLlHtMuZGEgscnOQzmcoo9zPm8cVQ89RCA1KaPZJrgHXQ+qxnW8apM3/IaTB8JSSHPLW7JGFn/dwiD2mOA/g5wsb75wT+km0k2o9xdggjkuxe7mRNgXuPOi0d4rQLWkUfvVdkfEdFyOJMm320d0ZPXTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782202190; c=relaxed/simple;
	bh=FPtmP3w5W8OjFPZzPNl6YySJSHpvMn8QQQuP+5VoHSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T1SgR9d07zhiuIU7HE3bUwMA+5MUpgUDZi4fs5NQKz1yaAITiF9jI0aAUfHwBySTYK9cEQV4fu82qUJ5Bl3XGVA/iw6FbUdpGEVMvyHTPUt0IDVLgXmrTE1Oma88GMTj1jXa5nvkfcA+VkY6Z7mHd5EVnZkeQNlw2Rdt9xYJImQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EbUsWyTn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EbUsWyTn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE1D1F00A3A;
	Tue, 23 Jun 2026 08:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782202189;
	bh=ZCNpUo3vwDHt5hRias82PxiKBoduzBmSMgoXH+QRUMs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EbUsWyTn8rdBWNescP2jon9pVqvDpZBlPqST/Ql5nfcM2SCmvltMdt8gL89CiruTH
	 Uo8lYKBUoZ/9QzLP1XLWIG+ZqGy6fQvA85naKDDvoQpObsbsdT8aAuOmgN+YNO2GX/
	 TbEEdZSlspsjdYt5O4f+OVupvvR8VxRI2cHqr1hwhWSzadd/iQHQvwk7akB8kO8F89
	 tkvEFZzDGMjxVw8oDWR2xfF6kGfKP7VyYVPR1UjVFr8tKuoZQowOB4nR6cNJvEO5cE
	 6QHnhtZ/N0xqkriFGsONJuj0pfahmQiy390ksmB/KOmwV0ceGYy6MF573kUQWDX2Zj
	 EgK8bWXGaZunw==
Date: Tue, 23 Jun 2026 04:09:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH v2 1/2] tracing: Move non-trace_printk prototypes into
 trace_controls.h
Message-ID: <20260623040943.139d98b9@fedora>
In-Reply-To: <ajlciSfVixfYG_ln@yury>
References: <20260622130739.375198646@kernel.org>
	<20260622131029.655382134@kernel.org>
	<ajk7fN5v31kCfGVp@yury>
	<20260622112127.5763f5ba@fedora>
	<ajlciSfVixfYG_ln@yury>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 12:02:17 -0400
Yury Norov <yury.norov@gmail.com> wrote:


> > > Suggested-by: Yury Norov <yury.norov@gmail.com>  
> > 
> > Thanks, I'll add you tag.  
> 
> Thanks, but can you also comment on trace_dump/ftrace_dump?

You mean just add to the change log about trace_dump and ftrace_dump
being used here too?

It's there mainly because some bug code in headers uses it.

-- Steve
