Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE10C286298
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154911; cv=none; b=cOtFaYcFlbd8R+bTOn5hPoKBV1psOiS/EEb8bfhsypGVDly72cliHkknKdq1ZrAO6YGk9WQGKb584EU1BwAN3Ld5UFgG8Bkhu5yDuLaWOaFH4QZ1+DbUU0MY630kXAhH65lENXvPUWejYifDLet4xfw6EB9barx3wcs+Zlin19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154911; c=relaxed/simple;
	bh=JXXDhl0nQx8ambNwC5NcULIC1KZ5B+o5lMThPcTak0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCqe6JZomx+vTeQqLJoxLW4dY9X8KIBb7oxDSA2vfBgyJwertFSmAJzzL2iQKxH9IkQkgJgGKvsGJ023CWFuGdL+bCwAFSm0MEQFTVayVWzNWXFkzSOt2LqnBIwUSFdFPVNwk9gmfb7fGF2qSv3sFuzBL9/K034rr6rYkLvDdXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ttq10+1z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qkyHEI97; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ttq10+1z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qkyHEI97"
Date: Fri, 21 Feb 2025 17:21:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740154907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA4k5F6EACYZgIJqap1nUVHDZ6mAhivK4Kn2VFbKjYw=;
	b=ttq10+1zAuPBqrizPUXC80Tz2RwSz7Rr8qHQKTaaH2oYiN/H2visli+TyCHgQHlz6blhWl
	hzMHMjUxMnPZ4jYnojp0bMsb90l04szTnngISRekFdSOJUIzKEnNuvZgI5zFrGdCsEFXQv
	wDo2wdEF9/RFP8Nz8lq+N2pIMDQLcIH+fnwJhgc/7RONMi1FeVs/sc0i4izdQ5vPrkxA7H
	F7Go0WU92hJDQYaO1dGtskYZFNpQPWWz0g20tCZBq+rhWcCc4+bGs7oU8QTLYOdWfEvIiM
	RE1Lhzzu2sJQNhzODNUOCfoprJpLsevR+E0rQ2woMDqk1gkZpi6aw3MhXsgGSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740154907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PA4k5F6EACYZgIJqap1nUVHDZ6mAhivK4Kn2VFbKjYw=;
	b=qkyHEI97a68yz06hiQtRmnWZWX9bzMChqr2wHOo2MSeBsBvtFl+SzSXqqsO1RodrX1ivQh
	uP1b47rCBSkdHlCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Wander Lairson Costa <wander@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ftrace: Correct preemption accounting for function
 tracing.
Message-ID: <20250221162146.9KWeIdA0@linutronix.de>
References: <20250220140749.pfw8qoNZ@linutronix.de>
 <44ymxgot422oetab62w55rth5tqrzseyhwirxg2ho7vzvvkaud@qiada52ckt25>
 <20250220115400.4d75d881@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250220115400.4d75d881@gandalf.local.home>

On 2025-02-20 11:54:00 [-0500], Steven Rostedt wrote:
> >      kworker/0:5-88      [000] D.Zf2   211.983391: igbvf_reset_L14: (ig=
bvf_reset+0x62/0x120 [igbvf])
> >      kworker/0:5-88      [000] .N...   211.983396: igbvf_reset_L16: (ig=
bvf_reset+0x7b/0x120 [igbvf])
=E2=80=A6
> > (Except in line 6 where it show 'f', which seems to be an unrelated iss=
ue)
>=20
> But it appears to be consistent.
>=20
> Let me go and add some probes and see what they show. The output you gave
> me that I requested didn't show anything unusual.

Since I just noticed that you posted the patches, did you find anything?
=46rom looking at it, if we preemption at 0, migrate disable at 3 then a
substraction of one would underflow the preemption counter to f and
migrate disable to 2. But based on code inspection mg should be at 1.
And this does not explain where D & Z is coming from.

> -- Steve

Sebastian
