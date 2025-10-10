Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD603286400;
	Fri, 10 Oct 2025 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760094135; cv=none; b=cnYanpAqACRhT/kmPxhuJqK1eGTR2Fvyyug2NvVKXEr6W3vfOPyGZ/5l8MRI/9yccmi/rDN9aDdcNb+vIrYd27m+wrT7WKxOa88lckOiR9cGiAyUi2ZR/EJYDQ8zP4grZVGUtihjki+g/hFFhd7/E0SAIsqHE4+6DcrAraJwWbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760094135; c=relaxed/simple;
	bh=nWv5X8S/qaxTGFYmD5w0ZTLO5xlpB9Ti5yrab9M93WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0b0BJvdPpklCt9Ap4Zrz9+/hrhLm7jmSDSEiv+ffqlLRZtLmthWcuBGRzf8i6jAQHR3MhV1nrU/BqwDKFyGD1VrjYzuwq6vL/laxNjyBE7Xu4Wbwt82VTSvOkIENOAbD1G6eTxti2zfiFC1Sk30WLA6IVgM7pRlvA9wJlZabBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tOrdDBBN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IYm9b8C+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tOrdDBBN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IYm9b8C+"
Date: Fri, 10 Oct 2025 13:02:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760094130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhA87/u2mAPHsYuJYI+0fGHiSpP15kQi52IOFFmfKQE=;
	b=tOrdDBBNvCKlUjErfcG3nKZa2KG/m0iZROp3DlCYuofno+TyvrWCWMhcNVzvW85skVDL3y
	MJPk9h7/GVLsgJ7YHebMvhfX7p0FWrF8QHJKYnT785GkdEOQA/HmPTt9MgMMCOwVMryLgj
	D8JGNjGMoOBh+lf0UnMSc6tevd+64fqQnP0o7fHG/ODe0z3e8FPZjk2VrgT9J7+jI76TxE
	FHfATUFGbscm+NRglhGB9iDJoE08n31llCNvg46MfFR/7ucEdALESGs0iA84gTEL2MxlG9
	/8TShf6CZH6eUDTzPHbx7r1utP+tnSqz28DJiJXWKfnhW5YhGvaqADNoEG/v6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760094130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nhA87/u2mAPHsYuJYI+0fGHiSpP15kQi52IOFFmfKQE=;
	b=IYm9b8C+jkV+BU3F9UoGH9EeJOPu9RjUQuREwSRqPaSMITLfNps9qyda4LBhRpPYpjddMi
	0mX8T7/pOjWFhKDQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Add signal reactor
Message-ID: <20251010125823-9bcb33be-96b9-4753-8ae0-11576f0e8d40@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
 <20250922162900.eNwI7CS0@linutronix.de>
 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
 <87ikgxqrna.fsf@yellow.woof>
 <3c55441187b869b5bb07b74ef88c10bfd51f9fb1.camel@redhat.com>
 <20251006115555-9822f5f1-fc9d-4d6a-9735-274b242e0eba@linutronix.de>
 <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2536a7777eb54ede40a335fa4204e87301b13040.camel@redhat.com>

On Mon, Oct 06, 2025 at 05:19:24PM +0200, Gabriele Monaco wrote:
> On Mon, 2025-10-06 at 12:10 +0200, Thomas Weißschuh wrote:

(...)

> > > For instance, what's the exact use case of the signal reactor? Isn't it
> > > simpler
> > > to do everything in BPF? Is the signal needed at all or something else (e.g.
> > > perf) would do the job?
> > 
> > The signal reactor is convenient to write automated tests. It can be used to
> > validate the monitors by triggering known-bad systemcalls from a test
> > executable and expect it to be killed with the reactor signal, see below for
> > an example.
> > On the other hand it can be used to validate that the kernel itself does not
> > regress with respect to RV-validated properties. For example the test program
> > can enable the rtapp monitor and run an example RT application using all kinds
> > of known-good IPC mechanisms without it being killed.
> > 
> 
> Yeah, what I meant is: having a signal isn't your goal. Easily understand if
> there was a reaction is.
> You could even restructure your test using tracepoints without any signal.

Agreed.

> So if I get it correctly, you are both "voting" for removing reactors in favour
> of tracepoint-only error reporting.
> Am I getting this right?

No, it is a suggestion for a cleanup/optimization where reactors are not
directly called from the monitors but instead from a tracepoint which is
triggered from the monitors. It would decouple the monitor and reactor
subsystems.


Thomas
