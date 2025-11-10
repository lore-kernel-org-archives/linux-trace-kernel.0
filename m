Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A46302CC7;
	Mon, 10 Nov 2025 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762772037; cv=none; b=iD8qjfa4nODGZM600XKSQCU1phuOVpeMDZ/fbWZnUinZwPagXoELbiY7flNsLypTCiD7aFK5QSVpkYdaEDrbgnTGeS//HbhXOZKJ1iDHI6XLG5Qa6n23/ySCj09HGzBEx3gwvEM/FJ36EKxUzOIWhth5R9uUnofmfHqC7f8OBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762772037; c=relaxed/simple;
	bh=Mgs4y/iHE6Ql6Ocxm3zOpdfKT6+R+xJkyATnM8dtOBU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y6580xobU7tiyuReFEv9VO6Fu3uifow+nz6qiyg7rd2ZxbeW8s60SJ83KnbE5dSSrpf2U5XVVjC+n6L8hxL09SyFudF1UDFUeStjxEUcLBixUscmQdOK4MGSr558rduwmwYOV7VbHBAQl57RA4gGysKeXWmAPXk6HP2a1BpvglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zlx7pCBP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xcB19Fsb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zlx7pCBP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xcB19Fsb"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762772033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgs4y/iHE6Ql6Ocxm3zOpdfKT6+R+xJkyATnM8dtOBU=;
	b=Zlx7pCBPF5yAtI20rQO/2/jlXFEsLGAms/Qat/J9kiM+Xc4ZVK/C9weK229x6K8Zx7LLLP
	1HVyCpuPi2q9Gm7pQA9eKaE3hh02QPEP9mo4VtWLt3aR7+h6jaTC4GBQjkd0Kg4PBFDtwZ
	5cQjud2X7GgWCGd+cBN/0Y7BjRsZ+XP4GtLpfl3s7QCkUl9SKYAvMf27Fr4ExcIlECC6Fr
	tuHZyK7WcLAaOv3R7k/Bo1b7j62boK8aiZZx3/oiwTRfNTRMQwMnInd/qdEw5lvJJOIGwe
	g25cw0pcDkXLs1Ll01fYwVvz9P9KBmp4Co+dOqAE2HPRF1wETm8ydipW+av97g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762772033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mgs4y/iHE6Ql6Ocxm3zOpdfKT6+R+xJkyATnM8dtOBU=;
	b=xcB19FsbUk3s9+oIEb9Sa82dmQVAZbVrWlxob/PiG7tUOtlOa+Gdev7hbofmwusBi9u0HM
	MrDpGG9dUWtuzHDA==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Gabriele Monaco
 <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
In-Reply-To: <20251015115714-e8e69ed8-a5e4-4139-8d6d-7f2487674e68@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
 <87qzv6szku.fsf@yellow.woof>
 <20251014094206-80eb5d6c-e4dd-4704-a40a-e2d0461c2185@linutronix.de>
 <4d0467cf03f4b818a40344b6ec8142582c26a876.camel@redhat.com>
 <20251014140813-692b312f-67d8-4f11-99f9-73d5d8d34c87@linutronix.de>
 <ef1503b097e6113cec24f2c20684635fe1337260.camel@redhat.com>
 <20251014160719-f5a075fa-7cdf-4367-8551-05cf7715a3e7@linutronix.de>
 <1014118845296ead20fc1f8ae64c4fa610d06bc0.camel@redhat.com>
 <20251015115714-e8e69ed8-a5e4-4139-8d6d-7f2487674e68@linutronix.de>
Date: Mon, 10 Nov 2025 11:53:53 +0100
Message-ID: <87a50ukvjy.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> On Tue, Oct 14, 2025 at 04:50:18PM +0200, Gabriele Monaco wrote:
>> I don't mean to really sacrifice accuracy, DA monitors are disabled afte=
r a
>> reaction. This comes from the assumption that the model becomes invalid,=
 so
>> whatever comes after might be meaningless. Monitors restart as soon as w=
e are
>> sure we reached the initial state.
>> In this case, it already doesn't make sense to monitor events triggered =
by
>> reactors.

I can get behind this idea. I would even suspend tracepoints entirely
during tracepoint handling. Currently there is nothing protecting LTL's
internal data if multiple CPUs touch it internally. It needs a (raw)
spin lock, but cannot use it because spin locks step on some
tracepoints.

Suspending tracepoints during tracepoint handling would make lots of
things accessible to RV.

>> LTL is a bit more complex, so it might make sense to continue monitoring=
 just
>> after a reaction, but I'm not sure how useful that is.
>
> Ack.
>
> It is still possible to manually re-enable all monitors through sysfs, co=
rrect?
> That is needed for the kind of testing I have in mind.
>
> Do we still consider these hypothetical tracepoint loops a blocker for th=
is
> patch series? In my opinion the usage of lockdep does not exacerbate the =
risk.

Gabriele, if you want to take these patches:

Acked-by: Nam Cao <namcao@linutronix.de>

as the lockdep's tracepoints are not used by RV at the moment, so it
should be fine. And the patch does help with RV development.

But we need to investigate further into suspending monitor or suspending
tracepoints. If that is not feasible, we can revert this patch in the
future.

Nam

