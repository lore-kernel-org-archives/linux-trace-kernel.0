Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA881B86EF;
	Thu, 21 Nov 2024 08:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732176278; cv=none; b=Ug4yOa7qXJ0fEEeDXE6cl0DQuF1HPn+OC1Tr3YC9rECU6SZBR9upbpCXG8vIQ49H6Upfnr+dvV/FrtbkMJsMBL+pGF9LpWdzJ72sf6V/i7o+V/liEHgzmEPZIUb12EXM3ZQDLILPY4hyS0PNOIJzUxdTHxZ2slBX47RMFACQbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732176278; c=relaxed/simple;
	bh=USTqCWO3YIEQxhLLxJVkk4vT8yPUjZmhJHDUHgKS+kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+J029Q/BGZTdqRlIRd0RRxhY8rQCSFl9xFRY8jH0K0BmHWXQDFZpa0OR8VNf/YpBRH5jdJpVDQWogbS5S3QRjojWNkXOEJPNJ8rokZyAHQyb46sEviVv5FAuz8wWa5JvMuFX1ozDNSYEr7y/2QB+yoJdj13FctcXTJYuPXCQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NyG6Nk1o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=00SL+6PT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NyG6Nk1o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="00SL+6PT"
Date: Thu, 21 Nov 2024 09:04:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732176274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM0Cf5LQhpvPLhru80W8Ev3cAE7kvo8JvDnLy5hKLhA=;
	b=NyG6Nk1oyouXgy7nM6wGiy/pLQYU7Q4pVhnjhHRbQ3kgaWe7h0y/2sGYO4grLhBl/8FYjo
	6Xl7T+qPP3aWOSDHe7WseILPzOh3QEQNDgF96YXOfbZWVYcXCQXowOL7NCb+4ScBrbJGdB
	PWuGhMK662NDpuvjtGZQuFukced1cxOKOPMI5tsiDUH35osmqmUdy6ouroKZhOMByYrs5K
	GnYiidrvzUZ+qf9tx8n89KPkQLblPtctg1lJ2gjs440Uhv/H3dcrb+Df4Q2Z8bAVExxY2f
	Zc6qhvjJLgdVn9jQ3na1H3nGidjgvXiA0rzMydeEuY/EE0Dg5ty3wzuK9YjOeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732176274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AM0Cf5LQhpvPLhru80W8Ev3cAE7kvo8JvDnLy5hKLhA=;
	b=00SL+6PT7X4ghP00+uZcoC7LUHmHWg5XNG4o2UIF9p9egU6ul3km3TOrK00IVyYNlE9waa
	Lhb/blG/ofm+NiAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Naveen N Rao <naveen@kernel.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kprobes: Reduce preempt disable scope in
 check_kprobe_access_safe()
Message-ID: <20241121080432.ysLlZsSP@linutronix.de>
References: <20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de>

On 2024-11-21 08:38:08 [+0100], Thomas Wei=C3=9Fschuh wrote:
=E2=80=A6
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index da59c68df8412c4662d39d3e286d516e8cee9a69..369020170e832a34ea9c05eda=
6693bded02ec505 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -39,6 +39,7 @@
>  #include <linux/static_call.h>
>  #include <linux/perf_event.h>
>  #include <linux/execmem.h>
> +#include <linux/cleanup.h>

This hunk can be dropped. The definition for guard(preempt)() comes from
preempt.h.

>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>

Sebastian
