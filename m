Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE827385535;
	Mon,  1 Jun 2026 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300905; cv=none; b=pUUHVSuv1LPbJzpmmI/FKOEULYbxpSVXVEeD2kJEP1QGoUPdB4lASA0FDq2be1ZiZJ+p/RNZ9SFxd4ayPo5h75XMDSutu3jIAeUd9HAPemMMz/g1uSSai6sMIh8JfiNFX3F2fBGh8hx2i96d+pRQmx61rrNB8UwaH7u6XcYlO3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300905; c=relaxed/simple;
	bh=3TIH+yBMWiuFXSHsRK+km8PrYBvMf4O34W9ra7yng8Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ds+sVWlMj0+MchuWZApDyD+ygiKmrH8kXbERbQMzJDXSAbYln3rHICEvueBIAnd+7MIIz5pAn0qzDHZlCF5Y7GQ5l/mkivEQrTSptYp8PNxqbk7+gvManGI9N28Xwk1G5gztkdUmDW7BvY79R2s8AN31plzDMsVFUNbh28LnPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WcpzPgEl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ga04wote; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WcpzPgEl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ga04wote"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780300902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TIH+yBMWiuFXSHsRK+km8PrYBvMf4O34W9ra7yng8Y=;
	b=WcpzPgElG9qETSxYe311jJZGBMQPbT4eKDbV+xz7JHt1eB+m7gRUm9v7fkr+lJMoWdYEAE
	Muk6KfJFNzCHhpF7HJoAAb/4/xxb33IPwxXQdNzSR/hcqduHRSW3gjffX1FMEb0KAT+Yfx
	5qpHmbhtwgmmQ1E7mtTMRbIJnN20ug3eDCkbavUyG31ZhwN8+Ihk6U1QrYRu5D6FnTboKQ
	2VWnjJWe2et3/GEFiB3gmla7IYLut2h3WOj+lP8cHhf87PIeZLIi94iokjVygcp9c3oSJR
	LjrZrmYexNaIIdcWphxxTPvqGK76WmIvzv3Oo1slcIRLoRxUkUx34Ih9YdehoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780300902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3TIH+yBMWiuFXSHsRK+km8PrYBvMf4O34W9ra7yng8Y=;
	b=Ga04wote1QXn1BtX8F4lshqJSIJ67SmT1v0F7G0TdYmydHvYwk6cn7LeuHmldZRYbk3b/O
	6FLlW08n1VGQC0Dw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 13/13] verification/rvgen: Generate cleanup hook for
 per-obj monitor
In-Reply-To: <20260530141652.58084-14-gmonaco@redhat.com>
References: <20260530141652.58084-1-gmonaco@redhat.com>
 <20260530141652.58084-14-gmonaco@redhat.com>
Date: Mon, 01 Jun 2026 10:01:42 +0200
Message-ID: <87se76wuxl.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> Per-object monitors can allocate memory dynamically and such memory is
> required for the lifetime of the object, then it should be freed with
> the appropriate call.
>
> Force the generation scripts to add a cleanup function the user will
> need to wire to the appropriate event (e.g. sched_process_exit for
> tasks). This can be safely removed if the object will never cease to
> exist before disabling the monitor (e.g. if following only static
> variables).
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
