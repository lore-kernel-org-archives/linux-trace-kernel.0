Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671571;
	b=f+cYOi1Liuk7bPXl3QkGVdIQWDRBgc6Rs0GNPzfzqwBJ5M6tjtX86gh4j7Za64KxFHfn
	 u6whzEyEsZ7YRJ1zOIshYEw76DPh2j04NbYqhbGdCkwBW1nscmm1RRNLbsmPCvEphu5qc
	 Dm89LBiLbFWtrwsPym9xQLXw286lXk5/VGddbGL4iIeffs3gH4G6dB/DJ7sDqev1TYh8h
	 MxlVYhxRVY4cmoWz4qp1Go0vnOgCoL0JakM+P4KJBnknQEEMVpeQd4x22SEVdUAmvjZv1
	 ZA5b0VY0V/5Jr4nq+TxvdFftC9ZBOO2S/MS7xhXg+m76rfTwTnU0Vx8obQcNVgxRY+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671571;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=tE/ZWm4PTQlsdcp5fqBMw+DjYzztKuw6GLRHOslzIIE=;
	b=ppCpFNmBJGHfgHynGa/RzV3ab7yj+dv2xXIKzP2WAyq3mfKJCelkvJC8EcCsmTbIHB1+
	 dpOHTCJbPRKt8/8ILg2qIunQQzm/IEAY1mSvC5YeEFU0WlWZBpcokGDyhPi1tb7cv1Hvh
	 xv9+oUiqoeKmC6Xge6Mr/pNSklgY+EV8QMsFDaiWzL40fqUGJTsvdFTJa5gt4dn0zw1sf
	 tz86ayGaV9PIa9B5Rhegb8JuyQV/TQrnmR20n0kTtXvJ+0VHjJn70Cqd9SGe/hUX/PFaW
	 dP80BV3crZdYjukQrbBDPDfVPq1vogho+vBBvwgejgIC69W8/HpdA93yKFdh8heIwNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZbYg1On;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81C606A32E;
	Tue,  3 Nov 2026 02:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZbYg1On
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EA11F0093A;
	Tue,  3 Nov 2026 02:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793671571;
	bh=tE/ZWm4PTQlsdcp5fqBMw+DjYzztKuw6GLRHOslzIIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RZbYg1OnYjxw0deJrg19zk2hVbyFk/i0slyVb7mvnHNPQeEfUggLO1TrLd59Pa/Lg
	 wWj2DhTeX67T96I3VfneSgun6G4v8fHhTgVFc3Zh8GglpXAjCg78GGmO0T3qGtZn/z
	 EjJ19hLmOAh5NBnxJD37UfYsjJ0699WKk45YdMHnTzSTHene+FaFVGxVmoAJJ31Zhz
	 XcdM25gVzffaOsiUVIlBGZTTdwZbGLUIfNBwpTD5jlOt3pdL/N/gOmz2alTT9kSZ1c
	 WUn18mnUbnIVhvuT22p+S1rnv2mR81FZ+5vkKY6vulhN7RkDmc1rnwaNJ4rVFa/Jdj
	 n3Z21Uo0Yf+vg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: John Ogness <john.ogness@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Petr Mladek <pmladek@suse.com>, Jonathan Corbet <corbet@lwn.net>, Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Date: Tue, 03 Nov 2026 11:06:06 +0900
Message-ID: <undine-1793671566795563056-fb7169cffcc7ac3c@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <871p9251ve.fsf@jogness.linutronix.de>
References: <179360345418.115681.193455787480210412.stgit@devnote2> <20261102123408.0fb950bf@gandalf.local.home> <871p9251ve.fsf@jogness.linutronix.de>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 02 Nov 2026 23:07:41 +0106, John Ogness <john.ogness@linutronix.de> wrote:
> [ Cc'ing Petr Mladek ]
> 
> On 2026-11-02, Steven Rostedt <rostedt@goodmis.org> wrote:
> > [ Cc'ing John Ogness ]
> 
> Thanks.
> 
> >
> > On Mon,  2 Nov 2026 16:10:54 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >> Here are patches to update the probe sample code to use trace_printk
> >> instead of normal printk. Since the fprobe and kprobe/kretprobe handlers
> >> can be called from somewhere where console is locked, using printk() is
> >> basically unsafe. Only the unoptimized kprobe on x86 is safe because it
> >> is ran with NMI context (in this case, the kernel uses printk_deferred()
> >> automatically), but optimized kprobe/kretprobe/fprobe are not.
> >
> > I don't think printk() is unsafe in these situations anymore.
> 
> Since we still support legacy consoles, it is true that printk() is not
> safe in these contexts when a legacy console is registered.
> 
> However, the printk_deferred() variant _is_ safe from any context. Once
> we convert the legacy consoles (including boot consoles) to nbcon,
> printk_deferred() can become printk() and still be safe from any
> context.

Got it. But since printk_deferred() is not exposed to modules,
these sample modules can not use it. (printk_deferred_enter/exit()
are also not exposed.)

> 
> It is misfortunate to add documentation saying printk() is not safe,
> since the problem is converting the remaining legacy consoles. But we
> can cleanup all such documentation later once the legacy consoles are
> gone.

So, until it is done, this series is valid. Please let me know it.
After that version, I can revert these.

Thanks,

> 
> John
> 
> >> Thus, this series replaces those printk() (pr_*()) with trace_printk()
> >> which should be safe to output the result into trace buffer, and use
> >> trace_dump_stack() instead of stack_trace_print().
> >> 
> >> The similar issue had been reported by Tiezhu Yang [1] in 2023, but
> >> it was pointed different reason, and not applicable to upstream.
> >> I investigated it again.
> >> 
> >> [1] https://lore.kernel.org/all/d179086d-78d8-d0e3-e113-9072cffa55f4@loongson.cn/
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
