Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BEA13C3F2;
	Mon, 24 Mar 2025 16:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832230; cv=none; b=hEcUgEj/dFy3EIZqYEW2ObYkXfXcgdBrN2x6ZAI++tbtfJw7RkiUOLM7sofXHplCrE60NyQMzFIT4qNW69AJ51tZOf+PJjofBw8tb+1UpvFKdOMpoVikTzK8ZszdQsGpv89Hd9K4f4qZoysNNhgskVC/thKdrdNQ8K6yfggJH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832230; c=relaxed/simple;
	bh=bgW7j/f9u8ZPFIkNNhLyPNhridLH3DGTgEjDIguYZ8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hw21PInKzxOBYbHYko0yMmgd6Vexy5Eipqu+zK6kaEIFgksLHH58vYyUU22r13wAHFlG2v22TMtFtJZLxPo4Sx5dnBh/2rUvQC75QMUifZn0Q0WvIAUF4MlvTe3tHKkQUHV8PRbiXeSGx/Lw5g2+CzPpCf4RZRicPh0vzI5WogI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C94C4CEDD;
	Mon, 24 Mar 2025 16:03:48 +0000 (UTC)
Date: Mon, 24 Mar 2025 12:04:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petr Mladek <pmladek@suse.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Kees Cook <kees@kernel.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org, John
 Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Andy Shevchenko <andy@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/6] seq_buf: Mark binary printing functions with
 __printf() attribute
Message-ID: <20250324120430.0620a8f6@gandalf.local.home>
In-Reply-To: <20250320180926.4002817-2-andriy.shevchenko@linux.intel.com>
References: <20250320180926.4002817-1-andriy.shevchenko@linux.intel.com>
	<20250320180926.4002817-2-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 20 Mar 2025 20:04:22 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Binary printing functions are using printf() type of format, and compiler
> is not happy about them as is:
>=20
> lib/seq_buf.c:162:17: error: function =E2=80=98seq_buf_bprintf=E2=80=99 m=
ight be a candidate for =E2=80=98gnu_printf=E2=80=99 format attribute [-Wer=
ror=3Dsuggest-attribute=3Dformat]
>=20
> Fix the compilation errors by adding __printf() attribute.
>=20

Should also note the removal of "extern"

-- Steve

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/seq_buf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/seq_buf.h b/include/linux/seq_buf.h
> index fe41da005970..52791e070506 100644
> --- a/include/linux/seq_buf.h
> +++ b/include/linux/seq_buf.h
> @@ -167,8 +167,8 @@ extern int seq_buf_hex_dump(struct seq_buf *s, const =
char *prefix_str,
>  			    const void *buf, size_t len, bool ascii);
> =20
>  #ifdef CONFIG_BINARY_PRINTF
> -extern int
> -seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary);
> +__printf(2, 0)
> +int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binar=
y);
>  #endif
> =20
>  void seq_buf_do_printk(struct seq_buf *s, const char *lvl);

