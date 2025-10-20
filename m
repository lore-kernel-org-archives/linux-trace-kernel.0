Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70431A072;
	Mon, 20 Oct 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967828; cv=none; b=AQC9a3KyGyYk0md7o3JeonBADwfvKzJFIBVxe6LLivNllTGTA2px0Ooy/YGyfKnFlAIZ+cbWtQDDhWebmfgT2v3hBragNpptiTR+wYPOFTTJyjBqgQo4f8F6wQU1ZUnJjC2kvsv3IbzO93V+UHQK4sOh50Nwy8hGHhtP05l50VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967828; c=relaxed/simple;
	bh=k3dK99KOu03+4EjLWh6Rrg7+isG10bnPNPUZppC4efU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bW7mvHDALuD5cGQu1shjVMm5xuBcttNWAbZu8tQrgYkFzJhdmZhhB6gvluScfYhifHhg95Mnd1rYPgzOG8VxB8h2zHqM/6QFj0tRXOkhwwxNnnxL/HBfsLWbpJvw35dqfJBqVayUivpmt+mgBkoVjTcsky2YOzUjhU+b/3uZnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SEOxPdyg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PVewv6Cl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SEOxPdyg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PVewv6Cl"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760967823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3dK99KOu03+4EjLWh6Rrg7+isG10bnPNPUZppC4efU=;
	b=SEOxPdyg1j0vuo9U1Ui86K9g+LpcRKKL73gm+EbmbSv5n4T/4OuLTWeXw2hYeH5DRC6x8F
	ZtMyVoehq+zzNtQnb6xYzWBRzq2rHSM7CP4pe5K7LT/bFKzgfuVYsAPS4nolvSGqWM0Qbq
	sXike2wPK1fmEyQlEAUOl0Ufw294x2HI4PWy1lyqGapSUFoD2sMpmuOLOj4Jq0yhoBGx3n
	1oRXpwFd2iOiEkkUa+KoD0VDT28x8OVLseImhLcksnuc0iH7S3ShUtG018Db4ptBff3yuT
	ke5uEnp8XrzUNIVMevvuJ8+MdH/CRIht4gRx74JMKDdn1lqu9p5ZxdC7joZDzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760967823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3dK99KOu03+4EjLWh6Rrg7+isG10bnPNPUZppC4efU=;
	b=PVewv6ClMsz1fEKbQHDqWFxigFF15FcMyP3HIaTTTPOcHd8708T+8TACzgXgvaIJByn4HC
	Fin35yFFitQLH+Bg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 10/20] rv: Add Hybrid Automata monitor type
In-Reply-To: <0c61c0bbbdc2002efb638dccda1f0a18c51d29df.camel@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-11-gmonaco@redhat.com> <87ldl9x6h7.fsf@yellow.woof>
 <4d27225b5a38210a40efcdb8eb778ca0ec3808f1.camel@redhat.com>
 <87frbhwudz.fsf@yellow.woof>
 <0c61c0bbbdc2002efb638dccda1f0a18c51d29df.camel@redhat.com>
Date: Mon, 20 Oct 2025 15:43:43 +0200
Message-ID: <87y0p5sn74.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Alright, that /should/ be possible, provided the value used to set invariants is
> constant or at least doesn't change until we leave the state.
> This seems a fair assumption to make but doesn't stand for the throttle monitor,
> in that case I read the remaining runtime from the dl entity, that one is
> updated frequently, for instance when a task is throttled, it's negative, but
> this doesn't mean the invariant should expect time to be negative.
>
> Runtime is consumed only when a task is running, so here I use an invariant set
> up on the /remaining/ runtime when reaching the running state, that's why also
> switch_in resets the clock (runtime is not replenished, but the runtime_left
> value doesn't need to be subtracted anything).
>
> An alternative would be to have some sort of pause/resume operations on clocks,
> and a task would just pause the clock when preempted, but those operations are
> not backed up by theory and wouldn't really simplify the implementation (use 2
> variables per clock or a single one and some hack to mark it as paused).
>
> Again, there may be better ways, but I found this one the "simplest".
>
> Does it makes sense or am I just crystallising to this implementation?

Ok, now it makes sense.

I have been thinking about this in the past days, and didn't come up
with anything better. Let's leave it be.

Nam
