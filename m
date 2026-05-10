Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8367A191F91;
	Sun, 10 May 2026 18:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437100; cv=none; b=bAYSigqYk0kfhy1mJGSTEDvhOzdRhGnW0ifiSQKtJxjihXuzYH2EVJVz2QscxtscBXAukBNIRdKZveZeLSQtgaL3IXzbrDlNhRUe4BlqSKV9RVDF/xQ3LemYmfxOHyCWJbHReydAKSiMj+D/BGzdtGPXSopJxscSSnkbi7hqdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437100; c=relaxed/simple;
	bh=klhXiGEnh78/qkvm14b96X31j5eZbl3ECBGiz7K3A8A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JS65KoLu6Lrzi2fJYKI7GAnC6yK4Xw8L2L1IcLNiIH5ejxi+oF54FPN8t3XYVKgkgbDFm14vNfg9wWXCHFMh7C46fc9lx2mJBvfcca/gh0108anUb+4ZIUJM6vR3ak0i5QGFsOHWaqT1g7biSrrpeF1iqL+OZEMM/68H61dz9Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pJf1KXHv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xFsG0ELY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pJf1KXHv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xFsG0ELY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778437092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klhXiGEnh78/qkvm14b96X31j5eZbl3ECBGiz7K3A8A=;
	b=pJf1KXHvkpPub4c6ekmRrwJtXtYoHYOb8P4vaC1Dg7/12L6oTcbJBepTpn+6V8mc6znaDf
	mGNjB0AIvjzj870bABWcILIEqdOiU4oyxTLHAwkwFGT1OXzJ62P52Coh9Q4evNlPI+RQ+j
	8JG1lbV/dJZUjwmWI5QKPKXndNv/K3Xa9FD4gWn9JHLY19WmsoRIrtEukJryXq3JTAHCYH
	YLK3QL5RSfwQfVRMmG3W0Jg7yRxMJnOjoRRdgWKxr0VaW43eqSIYb2jj4Q1VqEiDUcLCUP
	KnPpvc2UT/8m/DoUfRj7yKOhs+Ur/kDImjjxtFmT1kqAnTRwRU41ZX05DGbJ9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778437092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=klhXiGEnh78/qkvm14b96X31j5eZbl3ECBGiz7K3A8A=;
	b=xFsG0ELYoEZKwL7LlY1yDDIoulqNk/lj6rTFYanBdI49LBGB8Q/L6A4YY0u7pCkPA3lISJ
	vgCpirU1AjCKhhAA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] verification/rvgen: Switch LTL parser to Lark
In-Reply-To: <41f74dec0fab9d49a9b77ec994b102ba73fe060d.camel@redhat.com>
References: <cover.1777962130.git.namcao@linutronix.de>
 <85aaa8cacb31cfc78619a07aeae9a86d059a4cc1.1777962130.git.namcao@linutronix.de>
 <41f74dec0fab9d49a9b77ec994b102ba73fe060d.camel@redhat.com>
Date: Sun, 10 May 2026 20:18:10 +0200
Message-ID: <87zf272knx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> It looks very neat! I didn't go through it fully just yet, though.
> This one works fine but there's a nit: the ASTNode's id starts from 1, but
> apparently the new grammar consider RULE as a node too, this results in
> variables in the generated header file starting from val2 (rather than val1).
>
> Unless I missed something here, we should probably start from 0:

Yep, thanks!

> Also it doesn't gracefully handle an invalid syntax, but that's probably still a
> work in progress.

We could catch Lark's exception. I will look into it.

Nam
