Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963490;
	b=NK4DFKMLWKRAhkKtZBYkxjhgN3FWnnEJqu4pQsEgFQJa21cW4VO98BJQuXj11fV/bTJy
	 xKqpP31xbcDplLPiklWrCPbLFcvj/TKITJMwl38vlTcjMBTlJXgNw+YcUptn+MpC+W5/U
	 sxYkyEqCnybE9tWTSrHEqlOuUEUKQnjLKE3qbcYhGGo3So2+1tXGD2t6cZqzi2CVF/1wD
	 pK1KmjItgOZoS2gxJlr2TAhxEAcB96Slv6mJGZZjhedd5eR0ApGGjL9VRJdyqnEQHmpQo
	 QiFu9Hih3YzlcC3RT2/VJY7P2AbmUkW8SRU5osQF3NcteZZ2yAiQEDmIcGfjbF2+1Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963490;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R4Y0s9SFDf/JqEFtrNIMF3ef4jwxnuaiw44AhKSJbpU=;
	b=1gS9o+fSDPsg9rCa/PFOCJKxogzGe2u9o3EzwbXgKY+naM6GPtrmFjLu/fvcgMZR4krH
	 fo9c2NgopvvG5ndO9AuWs80WCADFD6BTAPwgoivBy73I78Sqe34UoWCEnElyQvezTxcLR
	 ISBgn1UwqmFZRD7ccmfcT/iSS/mL0LUBTBbFFYB9eW5N5YBtbzBl7vUJ9PLtIr7m3p1Ru
	 hd4cORWfVqXmLAN3ury00pmoYs41Xf6Up/sEOfYcIJQ63KOymNGX4tEHrdMSdzAsewn4t
	 5yNdmceC52C/TsiGbJgHMx7bH/mgiaD5lE5416ala/VsnbByPSbBg7E7NWVNGvAg8Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPaX1i1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3CB606A31C;
	Wed, 18 Nov 2026 00:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZlPaX1i1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420A61F000C4;
	Wed, 18 Nov 2026 00:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794963490;
	bh=R4Y0s9SFDf/JqEFtrNIMF3ef4jwxnuaiw44AhKSJbpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZlPaX1i1bm+82PSL6KXzU9Xp1zJ/yG0vscpHv83//mE+zFQ+pi8yz78LdzuvF3pH3
	 OHpcGp1c4lELgPGTiyaN2mcklD5dWf3uDHnW4MG29bZZt+0rbZ0GdP6dwwaNwaJeGz
	 LeOx2CJrlLsLBsczdbHorwtPKun41nI35GUJwvu9uEbPbWPTOXIEaRW7iyOR1X4cYw
	 CZhvlUjmXu1SBunm1SsrRpHhKkUIWU9j5EToqxOxR7B7qRFfRvyCQwLkyMASG+WIZ7
	 oJXZ41AfJGDrcL2oLbldXsgNiW2KTioydPpWs9MAG4n9eFWYz57knHKUSuts0mLzea
	 M2shOO/lEGOIQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Brian Norris <briannorris@chromium.org>, sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Date: Wed, 18 Nov 2026 09:58:07 +0900
Message-ID: <undine-1794963487554690675-818c80e274af2040@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261117142310.4f440b3f@gandalf.local.home>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid> <sashiko-outbox-217828@kernel.org> <20261117085552.0e4ef272@gandalf.local.home> <avybp3O2zxcLozKB@google.com> <20261117142203.72235895@gandalf.local.home> <20261117142310.4f440b3f@gandalf.local.home>
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

On Tue, 17 Nov 2026 14:23:10 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 17 Nov 2026 14:22:03 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> As it doesn't need to be visible let's still have:
> 
> 
> > config ENABLE_EVENTS
> > 	bool "Enable trace events"
> 	depends on !GENERIC_TRACER
> 	select TRACING

I don't like these changes. I think TRACING should be kept "depends on"
for this.

If a proper hierarchical structure of dependencies is in place,
visibility may seem unimportant. (especially, "!GENERIC_TRACER" may
just hide the option instead of indicating "Trace events are enabled")

FTRACE ("Tracing" menu)
 L_ FUNCTION_TRACER
 |   L_ FUNCTION_TRACER_SELFTESTS
 |   L_ FUNCTION_GRAPH_TRACER
 |   ...
 L_ TRACE_EVENTS (can be hidden)
 |   L_ SYSCALL_EVENTS
 |   L_ KPROBE_EVENTS
 |   L_ HIST_TRIGGERS
 |   ...
 L_ GENERIC_TRACER
 |   L_ IRQSOFF_TRACER
 |   L_ SYSCALL_TRACER (selects TRACE_EVENTS and SYSCALL_EVENTS)
 L_ TRACE_OPTIONS(can be hidden)
     L_ SNAPSHOT
     L_ ...
     L_ 

Maybe something like above?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
