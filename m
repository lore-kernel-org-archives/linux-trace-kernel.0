Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B429B8634F;
	Thu,  2 Oct 2025 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759416979; cv=none; b=T6IZVZunErBetFIAg74u7sdOSWOVfkmn0rm3dGAu5KWYgsrk5uWq4vj9rRbMgdfHEZ5wWB2g2QUdAxrJZY4kdDgXevi4CLcZ28oeNqcgBbs4GnXtG+iRp7eIlW65QT7MvsmsYG8XNBJPtXZ3GVccYvZBtfT80c3bCXNWKv9Rr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759416979; c=relaxed/simple;
	bh=JVBa0Hdha2soHLO1LtZQ3Bhv0Tp/23q2HRVgvFMM4eU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rX+E29SJ9Y76vcGuMHQP/GekeEyGhMPlfTFBpewxot3+9LuOYy/FNwMB8Ph0RAiqIvA4LIPiOEs3Wh/WZLp1g1uCNs9jdp/1ryvPHPbtBhziHNefM8kUQ4glozotlLP18JiPTJlbkHtSQie1a+/6Ct1BCJVA0Xp6u9zM3KLvgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ie3YCFrw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vuO9LZZe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ie3YCFrw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vuO9LZZe"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759416970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVBa0Hdha2soHLO1LtZQ3Bhv0Tp/23q2HRVgvFMM4eU=;
	b=Ie3YCFrwZmmncUHhOgPYLIK5UHH1f00sNRzJI+ntG58L12sqQVIw859uRViaGAkVBauKQJ
	Jb0lYBEcmAZ4aBTRxQfuOlLG7r0MoaEZIcOvnsx1PC2r4W8JkV11UpztSJxYq11kG/Ta72
	Dl3WHz3eDylCu5QgAz7YpmD+twlsQgm/XUYJoPwsDC699zk128iJ2ePel6VWo0FPPeSktK
	Y2qGctzbri+GzNVWkGxttya4USO8M3aZQ1QBUg8YLDj4pCdbCj6y+MANrzBiQwHtbzhx4l
	/UYGrLlBcZX9U1WFFafFY10gPfMAnDblwLl0PSHq/P1pHQ4/BDrrC3kJtnLo1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759416970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JVBa0Hdha2soHLO1LtZQ3Bhv0Tp/23q2HRVgvFMM4eU=;
	b=vuO9LZZeHclUp1uBDUiPj56XJOSWIPxlbhU14QYS+sI6HNA0EPqAw2PLAdC/A+odJkbTxH
	cpggEDjxCMU/6PBA==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Gabriele Monaco
 <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] rv: Add signal reactor
In-Reply-To: <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de>
 <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com>
 <20250922162900.eNwI7CS0@linutronix.de>
 <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
 <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
Date: Thu, 02 Oct 2025 16:56:09 +0200
Message-ID: <87ikgxqrna.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> I am wondering if it would make sense to add a new tracepoint that
> fires in addition of the reactors. That would allow multiple
> simultaneous consumers and also bespoke handlers in userspace.

We do have tracepoints for each monitor in: kernel/trace/rv/rv_trace.h

And yeah, I think it is a nice idea for all the consumers to use these
tracepoints intead (that includes rtapp testing, and also the existing
reactors). It would simplify things, as the monitors do not have to
worry about the reactors, they only need to invoke tracepoints.

But this also makes me think about the necessity of the existing
reactors. What do they offer that tracepoints do not? Myself I almost
never use the reactors, so I'm thinking about removing them. But maybe
@Gabriele has objections?

Nam
