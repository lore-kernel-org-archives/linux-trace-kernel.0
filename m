Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893726;
	b=h5Vf4u1PNJXjNmb61bHBGVhl3UgCWTq3ngk8C3fA7IGUSubM6dObDsU389OnkBmKvC20
	 Yf6SERoDq++blHYHaOz18OLdqAux0urQVlEmKOx4dXjSMWoACCGJIrRXkubEKmO8KshTN
	 rUDTIpTT55HrX6cWqgAhriga+2OcIQ14QAmEPggfL/Lhj071nwrSsZbTebn4JW+sgxmWB
	 CSQbmtiF5IzSXjkjKIlQyCrxpDujnmZxvpP9wP19RpzXWo1JcJNtpmvR67zTaKu2uad99
	 Wi7awqiyNdrsAofeSQFBp7f1lT2/ksU/HZJ4AFR1k9KXiPQPbY9KRHVN9gELToncqMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VqTtOjLMc2SR5NEFeskRRTsJLuUm+FuqME1OO9ChNqY=;
	b=NRjTOdORA1dwjQBTIiH6BMMwqv2nHvHpo0I+I0ChadaUB5vvaMo5eDLM7r7QxeHkItsR
	 4+k4bxsMApMm5Qx1ujVLsD1We6HX1iLtcfjg/8a/Fd/GnLMAZRyrHqgFGx7JpD3YHVoJZ
	 5bVjF6vPMafUtIVJbAAuksB2YwBko4WXm0syd2JUc7Vau27a7XoQAaUXdjGR25svzzUR9
	 Jsx7fuhVlMmt82kD47MZ2CulbPgPqg805x+zvehXB+gv3V+k4pq0o49hFiMHVAeNuYTcn
	 B/2l0UVkfZcQ0P9tIOMFC9Lc4og1D61olChG8DcCWk8bRgrFAiiAj0u389QyC0wiiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTi+83WM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8A4606A332;
	Thu,  5 Nov 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTi+83WM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4A61F00919;
	Thu,  5 Nov 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893726;
	bh=VqTtOjLMc2SR5NEFeskRRTsJLuUm+FuqME1OO9ChNqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aTi+83WMLB+yIW2qIOKRwZcIoRrw5ldSZV26bVaVMGJrTZbGnkzAE1dLpoiusQF0s
	 X7fJhGryVcI7YxO6QoocLcJ2+HJ7nAX6BuTyko99nbPNMmbj0hB7bm+gnUNmEucLAi
	 vuVYrD0QVeHA8UZekChmGA/kEk+iIVAFviQT1hEIcqQwO25S6mV5IhKYpCA/IE8T0x
	 gTXS1mzWaBXHtkjQ3++Hzhk+XpSPk7yOo7MtLAe0iCv0YSkCBr/8n2XbpAm7ySLsiP
	 4Hj4RvpmAgUAd0i8hT9xc2WWYHlwX6EVrS199CrADbZRnRqsDiqu00RQRlrY2jnqj+
	 fsZ250CYyQQDA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Petr Mladek <pmladek@suse.com>
Cc: John Ogness <john.ogness@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, Naveen N Rao <naveen@kernel.org>, "David S . Miller" <davem@davemloft.net>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] probes: Use trace_printk() in probe handlers
Date: Fri, 06 Nov 2026 00:48:42 +0900
Message-ID: <undine-1793893722102543030-fbc455ddd7ed507e@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <aunBcxXXNhXDd-U5@pathway.suse.cz>
References: <179360345418.115681.193455787480210412.stgit@devnote2> <20261102123408.0fb950bf@gandalf.local.home> <871p9251ve.fsf@jogness.linutronix.de> <undine-1793671566795563056-fb7169cffcc7ac3c@undined.local> <aunBcxXXNhXDd-U5@pathway.suse.cz>
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

On Tue, 3 Nov 2026 12:11:47 +0100, Petr Mladek <pmladek@suse.com> wrote:
> On Tue 2026-11-03 11:06:06, Masami Hiramatsu (Google) wrote:
> > On Mon, 02 Nov 2026 23:07:41 +0106, John Ogness <john.ogness@linutronix.de> wrote:
> > > [ Cc'ing Petr Mladek ]
> > > 
> > > On 2026-11-02, Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > [ Cc'ing John Ogness ]
> > > 
> > > Thanks.
> > > 
> > > >
> > > > On Mon,  2 Nov 2026 16:10:54 +0900
> > > > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > > >> Here are patches to update the probe sample code to use trace_printk
> > > >> instead of normal printk. Since the fprobe and kprobe/kretprobe handlers
> > > >> can be called from somewhere where console is locked, using printk() is
> > > >> basically unsafe. Only the unoptimized kprobe on x86 is safe because it
> > > >> is ran with NMI context (in this case, the kernel uses printk_deferred()
> > > >> automatically), but optimized kprobe/kretprobe/fprobe are not.
> > > >
> > > > I don't think printk() is unsafe in these situations anymore.
> > > 
> > > Since we still support legacy consoles, it is true that printk() is not
> > > safe in these contexts when a legacy console is registered.
> > > 
> > > However, the printk_deferred() variant _is_ safe from any context. Once
> > > we convert the legacy consoles (including boot consoles) to nbcon,
> > > printk_deferred() can become printk() and still be safe from any
> > > context.
> > 
> > Got it. But since printk_deferred() is not exposed to modules,
> > these sample modules can not use it. (printk_deferred_enter/exit()
> > are also not exposed.)
> 
> We could export it if it would be useful for kprobes...

I also concern that exposing those means exposing internal implementation.
If so, I would like to avoid it, because if printk() becomes safe,
those simply become technical debt.

> 
> > > It is misfortunate to add documentation saying printk() is not safe,
> > > since the problem is converting the remaining legacy consoles. But we
> > > can cleanup all such documentation later once the legacy consoles are
> > > gone.
> > 
> > So, until it is done, this series is valid. Please let me know it.
> > After that version, I can revert these.
> 
> I do not have strong opinion here.
> 
> It just looks to me that using trace_printk() everywhere is an
> overkill. It is true that printk() is not safe when probing some
> locations, e.g. where a console is locked. But these are locations
> where you could not use printk() even in the probed code.

Ah, sorry if I caused a misunderstanding. What I meant was that for
callbacks — which might be invoked in critical contexts, such as those
used by kprobe or fprobe — we should use trace_printk() that include
recursion detection. This does not mean that trace_printk should be
used everywhere.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
