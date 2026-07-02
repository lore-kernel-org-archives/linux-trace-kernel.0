Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02D5335564;
	Thu,  2 Jul 2026 20:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783025832; cv=none; b=iCycBm0wF5N5Y2Ii2NjGfaGqV71IQT/Xvj24+RdR8f7sGujcbB4IUA5j9bWVjFEHqeysmRQn8vxv6Ur3qbjc7dGMqBKGxjJQzknx63tqc5AFo1Ux1ovHXi+E7c/3aobsFYg2sY9XY86TZDkTrj8mP3h4xAE5sgsO+Bf6ULDb7Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783025832; c=relaxed/simple;
	bh=8Nmp3wHLYFKAXar638DK//coq/abiDbLyQase7ojOoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF9bad2hcyQmNFI4IOjYRyJxT/th3h32LTY1EfLRulm+gHdRqtjd4HU5UfXQpmpFYcWkjaEMiWj61vU0L5PyM1x62ecFrfEKkH1dQBMCoBabJ/owSlQMdwpExJNofAth8FT+KaFBRqU1X5IzxkPA85jOwekpeixZ7j5CRJkKR90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEZ40vJ2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEZ40vJ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DE11F000E9;
	Thu,  2 Jul 2026 20:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783025831;
	bh=GY/bHu8ysxbjFkB5NSHu/2S71hwF4DlYW+ddZeO6g8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LEZ40vJ28MRy8wo8OwdsdT/MvkdYqumJRkxDrL1CCkZmeUlFFlz26RDaDgYcBK0fz
	 zlvgsl+G0TsWoNxp95VhhZyVtl4PKx+fViKF01+RKKDPlVOcmb43fTWzxOwsqFIHlt
	 uefKMMoKu+lROGSRgGLHv4/1Rgv0wvkhpCF8neblat99MYike/WSxYx/g25rXE7m9C
	 c7V3f9yon9zB4YLOXtQnKHquFE2ujkyJUAQK88e1sYgsJkaSEWp/8mIhbawBNEDaNX
	 7QSTOwZ1ZDbuq5KLkSbTrhTnn/dSL3AkS85w40MB5pOk6m5NximFH2AJXJ0UZrAnYV
	 AeT+B3vOEP5Hw==
Date: Thu, 2 Jul 2026 16:57:13 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>,
 regressions@lists.linux.dev
Subject: Re: [PATCH v3 2/2] tracing: Remove trace_printk.h from kernel.h
Message-ID: <20260702165713.39580e1d@gandalf.local.home>
In-Reply-To: <akZpICZ0pGqspV2u@monoceros>
References: <20260624081806.120105649@kernel.org>
	<20260624081948.301578807@kernel.org>
	<akZpICZ0pGqspV2u@monoceros>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2 Jul 2026 15:43:14 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> This patch became commit 9cbc3d9806d3 ("tracing: Remove trace_printk.h
> from kernel.h") that currently is in next via
>=20
> 	https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git tr=
ace/fixes

Thanks for letting me know. I'll remove it and push it up.

I forgot I had it in there :-p

-- Steve
