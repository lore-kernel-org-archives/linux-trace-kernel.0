Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6401531E8;
	Mon,  1 Jun 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780299108; cv=none; b=ouW7hHBcG+sfddVAFZVnND9bwPdTW5qg5JW5mRwk8NjuRr8BttEzLT1YiVE4GyeLMEQxzY+ivHsMOvuxAJZs2FI5cNGnKZvHckPjJQllpvJgt7VdZxiCRGrz1LCAkACrQwS6F04rTUbOmT+sO10I47s8J6Zttt8sQOBDtAQVSJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780299108; c=relaxed/simple;
	bh=5gA0PfnsC7tuzMON/W6iIZ+OSNbB+oPaJSW+49neSMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sblfmO1Ny+9jhCrBmTeNo8hftLAOJ5fSYMP8oljw7ZxeQIgCBAJ7O+JVeOLqjeo6WYBXbwEAXjCZub6I1+xbImCxLh20/cdN/iFH20cEEZHymtbla40VhkRcU6VhzjYQEIR35MDVX9MLbsLxAky0KfZha9q5LVz5QlDTkabTU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uWAiPeLY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vlv4aDb8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uWAiPeLY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vlv4aDb8"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780299106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gA0PfnsC7tuzMON/W6iIZ+OSNbB+oPaJSW+49neSMg=;
	b=uWAiPeLYaQYdmUK9a4f5MWU1PZEv3kDwFV6K+IsRuucEZhv33RR4fW6FhgmfBcF1XZ3MTO
	VLfAAD/+IjquZx2pAM4OUqRGXpFv+9Pl8jiO3YDpNMv/J7cmmB55iRGrghKIgNDbk2SM/T
	eV8p6H3X4w9AnsPmX1QNPSu07SLRpPMEASWPnB34YP/WedpXRvnR8+meanLWkFlWqsSefn
	o/yhNBPfFvojQkDzCau9sK0ooM7wiFpPhPx6q3Ke/ugqyVtZDAoWCGyqh7T66kB4bhPLtI
	xTjymm25L4PperVAw2qi2iDHKd8Q9hX580KWNcFaEsXT8njihRdZG/dlPQj/1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780299106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5gA0PfnsC7tuzMON/W6iIZ+OSNbB+oPaJSW+49neSMg=;
	b=Vlv4aDb8LVtApA7MBD3HMvYgiLcEs7CmFN0PzJSZPDpSm/1riEEPGPmGcJ8VRjzThDe9hc
	glYblhFwS5ZNR2Cw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 06/13] rv: Do not rely on clean monitor when
 initialising HA
In-Reply-To: <87fr36yb7g.fsf@yellow.woof>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-7-gmonaco@redhat.com> <87fr36yb7g.fsf@yellow.woof>
Date: Mon, 01 Jun 2026 09:31:45 +0200
Message-ID: <87a4teyavy.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam Cao <namcao@linutronix.de> writes:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>> +static bool ha_mon_initializing;
>
> The global variable makes me a bit uncomfortable (a quick google will
> tell why this is not the best pattern).
>
> I am sure there are better ways to differentiate when we are
> initializing vs destroying. How about the incomplete sketch below? I
> doubt it even builds, just give an idea.

Or instead of function pointer, we can also pass a bool flag whether the
timer should be reset.
