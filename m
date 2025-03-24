Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042F84D08;
	Mon, 24 Mar 2025 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742843973; cv=none; b=MvXrzHp4KyL8Q+Rg5I3+KahuMFLlVBI1a5ccTuR8ZHghB1d4Sdw+HDXv7Du1LbRa5HJURuZpgtbfRV82JzJcS/mYpNEsBSqNKjIExZtTeX6iIr9KRKL2nkzuRNByn3aUnXy3HDrNU4mX1TuiZXSEKZIMGB/PfpJHlVkp8J/iAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742843973; c=relaxed/simple;
	bh=fqnEprHyp29eEzNNsQAHHHd77WVKBIYKI6z30Kl4dAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iut4RkIFEo4ge5CrdBzwnQ2K49K15O0zgWO843wSZgyGVTUT/koReelhmMwX6M3Hq1s59qIZ7vU1Rk96Fo7R9un2K6XrO0hx3N2XpOos9hjWQ9mokr4SH7Wp5jJQVHqYtu9yh4RvIzrgs6X4SVKJS0NL/KtpqtSyQ+wovALnbgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395E5C4CEDD;
	Mon, 24 Mar 2025 19:19:31 +0000 (UTC)
Date: Mon, 24 Mar 2025 15:20:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Kees Cook
 <kees@kernel.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 4/6] vsnprintf: Mark binary printing functions with
 __printf() attribute
Message-ID: <20250324152012.413380d8@gandalf.local.home>
In-Reply-To: <20250321144822.324050-5-andriy.shevchenko@linux.intel.com>
References: <20250321144822.324050-1-andriy.shevchenko@linux.intel.com>
	<20250321144822.324050-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Mar 2025 16:40:50 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Binary printf() functions are using printf() type of format, and compiler
> is not happy about them as is:
>=20
> lib/vsprintf.c:3130:47: error: function =E2=80=98vbin_printf=E2=80=99 mig=
ht be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Werro=
r=3Dsuggest-attribute=3Dformat]
> lib/vsprintf.c:3298:33: error: function =E2=80=98bstr_printf=E2=80=99 mig=
ht be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Werro=
r=3Dsuggest-attribute=3Dformat]

BTW, I find it disturbing that the compiler is set to "error" on a warning
that "might be a candidate". What happens if it is not? We have to play
games to quiet it.

Adding __printf() attributes to stubs seems to be a case of the compiler
causing more problems than its worth :-/

I honestly hate this error on warning because it causes real pain when
debugging. There's a lot of times I don't know if the value is long or long
long, and when I get it wrong, my printk() causes the build to fail. It's
especially annoying when both long and long long are the same size!

Fixing theses stupid errors takes a non trivial amount of time away from
actual debugging.

-- Steve


>=20
> Fix the compilation errors by adding __printf() attribute.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
