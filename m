Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656905;
	b=x1fiiZGyMvIXS1xRSj3y+eadSuFvYRNJu6IM9j1Tx41zIGFSOZvFPJfbZSkt2KAcNk42
	 qtoApx8znYJh1SfF91SPN3hHWIcJ5sYNz4uaw6eZVGYwbWg6Rjhac+ADmpOVebDCQ/qhg
	 +1KCOG7B+ZwhaEMn0YvK/tlz8kbDGEvTMMkIGflJILDITuj2V+xmYkQvBpn9qCGl8pEZw
	 WNXXKkRFJsgJ2jsLh7zCfvxiV3XH2lRAueIf9k5/+i+PTYmhC7uqeV6WRPiOOsMnPiTWG
	 FyZ7Mwge7vD9FeVbSyE281J+dbdv/TqZeHqKZLSDVk3qfKwXbP3lEGM21UYaPMQZFYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656905;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=5YPyhUMNqUikP+Dpu8lwoaPm7i3mXLT4XpNezIXuTGw=;
	b=rE1Q9lGjtGj6sy57NHuKoI1LPn6ORw9KzbzoFj0y4fjyJTkJU4aXgyZ7ozrBz0nV7gg8
	 mYIlXYAfNTzUOXoosIxy72+k815Lyikp6bF8PD1jVp5vatgXPDk1xHjgV/XpgsXxDO9F9
	 DDcLoyGGjuCLaHBFWci2akjzJrLBlNYqEZDgGjW+fNGvwgeD5wBWUJM2nwKsoWjlaRu45
	 9jkawI0yydL1nGpO0imgJovuNMnwtbbiYQF/ege7h/NpSOJZTXoInok5/mtwW4vpE5hzF
	 /uXZPPXXTIhW8BKH2wPSJo83Biuapv11AI3Mm9OTMQEamvER//CvPj2ZYBBCpswVxzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kXs+EV63;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tuNQekcR;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEA606A324;
	Mon,  2 Nov 2026 22:01:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CADEA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=kXs+EV63;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tuNQekcR
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793656902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YPyhUMNqUikP+Dpu8lwoaPm7i3mXLT4XpNezIXuTGw=;
	b=kXs+EV63nmBQt9cForxgH2QSdn/hdKU48lfVQuWctlD2lgoayV/yzm9+RCi+MJg2aemVdc
	fPQawLkP48FE0V21ZcMl3p6nW+l+3HAEgXMODgynDjP0vm3HqeFabtHWBij10qpjSlnkcU
	TOOmAG4K5MT/XQXJGpJQRUHhN9HIXBx7LV56P2XRySB4B2cTW1dTbnWogekX9srcXss4Y9
	J049lsX+j4KKAsUghYX4KnA/7ydMvYubrNmtYdZSgkqjm7Fiu2hp2kTA3wltWuOyR39bzi
	3bdwM+KIm0+LWgsywf/UBQuNa98n4SpW5ceCuWrcscHdfFRHa78FME/q2VdlOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793656902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5YPyhUMNqUikP+Dpu8lwoaPm7i3mXLT4XpNezIXuTGw=;
	b=tuNQekcR9Vea9SW5HpyvYbzLk5ZCLFFhmkcnO1i7XKifh11f8Pq1jfGznh9n0ZxBB0HOKb
	9a0Pi6szvwXkpgBQ==
To: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Petr Mladek <pmladek@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
In-Reply-To: <20261102123408.0fb950bf@gandalf.local.home>
References: <179360345418.115681.193455787480210412.stgit@devnote2>
 <20261102123408.0fb950bf@gandalf.local.home>
Date: Mon, 02 Nov 2026 23:07:41 +0106
Message-ID: <871p9251ve.fsf@jogness.linutronix.de>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

[ Cc'ing Petr Mladek ]

On 2026-11-02, Steven Rostedt <rostedt@goodmis.org> wrote:
> [ Cc'ing John Ogness ]

Thanks.

>
> On Mon,  2 Nov 2026 16:10:54 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>> Here are patches to update the probe sample code to use trace_printk
>> instead of normal printk. Since the fprobe and kprobe/kretprobe handlers
>> can be called from somewhere where console is locked, using printk() is
>> basically unsafe. Only the unoptimized kprobe on x86 is safe because it
>> is ran with NMI context (in this case, the kernel uses printk_deferred()
>> automatically), but optimized kprobe/kretprobe/fprobe are not.
>
> I don't think printk() is unsafe in these situations anymore.

Since we still support legacy consoles, it is true that printk() is not
safe in these contexts when a legacy console is registered.

However, the printk_deferred() variant _is_ safe from any context. Once
we convert the legacy consoles (including boot consoles) to nbcon,
printk_deferred() can become printk() and still be safe from any
context.

It is misfortunate to add documentation saying printk() is not safe,
since the problem is converting the remaining legacy consoles. But we
can cleanup all such documentation later once the legacy consoles are
gone.

John

>> Thus, this series replaces those printk() (pr_*()) with trace_printk()
>> which should be safe to output the result into trace buffer, and use
>> trace_dump_stack() instead of stack_trace_print().
>> 
>> The similar issue had been reported by Tiezhu Yang [1] in 2023, but
>> it was pointed different reason, and not applicable to upstream.
>> I investigated it again.
>> 
>> [1] https://lore.kernel.org/all/d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn/
