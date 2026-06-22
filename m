Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC3A1547C0;
	Mon, 22 Jun 2026 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141693; cv=none; b=OYSJ/bVzHTCIi4p/W253AezpvF+/juRPK93eC5CIglX2ykql4FZ9cj1jA4oCZBaf/Y4sWC0ge7OLFdKewt5GS2SLL1WOvG4ksqzCSjQBIjcFiHAaLyTsL0nVcwp9entOWVR7UpVh7JNPlZTjOeRui8nKkXpvfeaZT2NsQYgCb+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141693; c=relaxed/simple;
	bh=A7EsyfoS+QDNjUA5lAcxk34cZXl91nrRJUrO1ALq2os=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eggRqR06L3EBAHWdOfVpG6c1VFm+hqWOLgMM8irNyNBX9cXA8qVqHZiXo4n6L50CiXlXkiHkMXAdTMbs28Dg/X+IB+nkyHJ08cKlGqfxWJlqBmWjgXAGz70AmNl68uEzpBW0gy+Opkp38srkwiavMoDR4LyJNjjNYTCA5zrHGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TaO7VhhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TaO7VhhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01671F000E9;
	Mon, 22 Jun 2026 15:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141692;
	bh=Lr+SBaFaR+hMEGntl6oFN62eDSQVVgfspGlk04ujMPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TaO7VhhQn5gI6MFwhQvoQw3hNwao3B9Ctyyxfm96NwulPNfogA6mR2lz+EZhUXrIA
	 KLy0++EgkTTW3eLnJcF9fslxBmT7tJkyjpUHMQBIguOgge46wb4q+UPZFMEN4sTELc
	 jv4rBASghAxkQztJPxzmsAPf3D0u4/nL1Qh++ymp12Rvljrv9BVPEaKIxZ3DCG9N/u
	 yxuT99o7hyqY5ieaq9tS9nfJ7g7dYTexyDhXbCEpaaZ3diAhRgHOjxCMhRSDHhbZ9/
	 4/EelHEhQqW2f9gbnTEfaqYwWlF2T6Q2tgY5RVt0T/alxkO7+cMTKrs5/Bm446REhc
	 GFoiVpGZxv0Ww==
Date: Mon, 22 Jun 2026 11:21:27 -0400
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
Message-ID: <20260622112127.5763f5ba@fedora>
In-Reply-To: <ajk7fN5v31kCfGVp@yury>
References: <20260622130739.375198646@kernel.org>
	<20260622131029.655382134@kernel.org>
	<ajk7fN5v31kCfGVp@yury>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 09:41:16 -0400
Yury Norov <yury.norov@gmail.com> wrote:

> On Mon, Jun 22, 2026 at 09:07:40AM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > In order to remove the include to trace_printk.h from kernel.h the tracing
> > control prototypes need to be separated into their own header file as they
> > are used in other common header files like rcu.h. There's no point in
> > removing trace_printk.h from kernel.h if it just gets added back to other
> > common headers.
> > 
> > Prototypes are very cheap for the compiler and should not be an issue.
> > 
> > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>  
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>

Thanks, I'll add you tag.

-- Steve
