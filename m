Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFEA1DC720;
	Mon,  7 Oct 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320823; cv=none; b=ZIglRaxnHJcYcvu9gvzX7dmvWkXOEmhdcR1KFdVDVPmxV39glA+g/fFCwAp+SpkNfTgtUxQaKDLS1dngdQ/RaWd6fSe0TG0oDtlf/tHYbUmVipBkL1pyHXwt3ft4LWwbq9GohDD0QzRmnZZvvyEe0W+4t4rkm9Cn1x29nOa7bD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320823; c=relaxed/simple;
	bh=2c3ieTG9QS2OUk8GwGh7DTHOTO+IhBolPQMPCNmBpkE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g90ZQOGm+dDWmxigIHjKSii4Jzj2JvueIT1SU0ISkpr5FOBVhcsTugjFBJhJCxj3mvS0zle1tdkJafz69FI1NWTyIbhChbGNDQCu6NlUiHTzdI2jss8Q+03IqSjiNX9a/voz0p1NEF2aFkvRK0yEYXTq+imYdpTVfKr0+BRDuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BUp3O3tY; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BUp3O3tY"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E56A742C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728320821; bh=n8iff6OUFVvfuZmCb0NByRnTr0q4d9W+4KbZfQaxNp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BUp3O3tYLGJg6W1r9K8g+rxctorFmTa+SZG/eIAAJjlGs18mH+Lv/NrxJrl+iDYA4
	 spJkfxCJixlESU0oG0ROBeDs7IXNPOulq9+xgJummAr9GKNnGYmUt4biTTG1ETJhc6
	 ioHxPQVIzo0dH6leinrFXxDVW5nnB6321MclR3KulVlzWAAngVcqZWNeWoCc/uAQts
	 7Ljk2OoiOHTsNJb95aeKnrU4lHJpFqArzTlM3ScfYT4ZfvNZwqKRcaDXF2bZLdR9Bb
	 Rs1nKqmKxb6AZAHFdFnrWPtV6X9qU/+poV0c1P7woJsm9JmdtiPFsUbM08FxZ+n4tp
	 BDGCJkkhX0GYQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E56A742C0D;
	Mon,  7 Oct 2024 17:07:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gabriele Monaco <gmonaco@redhat.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH] tracing: doc: Fix typo in ftrace histogram
In-Reply-To: <20241003122334.44682-2-gmonaco@redhat.com>
References: <20241003122334.44682-2-gmonaco@redhat.com>
Date: Mon, 07 Oct 2024 11:07:00 -0600
Message-ID: <87r08rkfkb.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:

> The Tracing > Histogram page contains a typo in the field display
> modifiers table.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>  Documentation/trace/histogram.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/histogram.rst b/Documentation/trace/histogram.rst
> index 3c9b263de9c2..0aada18c38c6 100644
> --- a/Documentation/trace/histogram.rst
> +++ b/Documentation/trace/histogram.rst
> @@ -81,7 +81,7 @@ Documentation written by Tom Zanussi
>  	.usecs         display a common_timestamp in microseconds
>          .percent       display a number of percentage value
>          .graph         display a bar-graph of a value
> -	.stacktrace    display as a stacktrace (must by a long[] type)
> +	.stacktrace    display as a stacktrace (must be a long[] type)
>  	=============  =================================================

Applied, thanks.

jon
