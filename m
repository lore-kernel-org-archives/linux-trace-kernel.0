Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD8236A74;
	Tue,  8 Apr 2025 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744140773; cv=none; b=gsD7ZU5sqzBfvijBi3wr+PMIhMPEJIEMdJjGTk7vXYspJCZLuAJuehL5sqwixZFaUCK9z93fyn7Fiw6/n8//pWahT8OWEwt59QF4ara5i3kGdjTZA7wQGTq7IP2rekMenJ2Y74DRxwkq6FEupO44aokDhkfHai1MGwwUshL4i7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744140773; c=relaxed/simple;
	bh=eFUoPQZAF9kjGlKSW+yRETCKsJBenqQcn6dMKTZqABU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TJx/yuhW/C28z1CdXmOkXkOVLDqVb6nYkN0ABUBH/hyYILu39jNPCQRTkukXye4ME5zvn8uG2BIZ9Hj9BioyyhWQjh5pvbstLybl7DAH4s11lwnmPaxV5wtXam604fMkQiYl2dohN13eER+luYt+ectgOXLYm+7DdhUkS3cft2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/+1m9vh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/+1m9vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B86CC4CEE8;
	Tue,  8 Apr 2025 19:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744140772;
	bh=eFUoPQZAF9kjGlKSW+yRETCKsJBenqQcn6dMKTZqABU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=a/+1m9vhFOflvIeKGwsqxQYasKl1KuUFz48SZMFOP5w1CJRyVQTvqn65ldOGGscSA
	 AbKMyZMymLjcUCuVztzSkXwA+G7b1SMPEpgjUHGVZamI/m6uc8eDweX+gB0JU7Gr9o
	 ZGWBOaf5hbIa2b1FluhROWvDgDLaxC8MJPJlo+9IFINX8IivDrlt/URXqmqyaTPhxA
	 1HSEshR2av2iUHsBBomdpaXWN7gdUzMER4ILRwTRnagyqKRcI7ZRFYHXzkbeBON4vS
	 JCgqX/sirEXXEJ/HiM9lSluZ0xYQBCRfnFfcbgYRpyo9U5V6VVcYewUGdP8ppniNLE
	 2COVDSnz5YY0w==
Message-ID: <d37227b12b2fa46dfe4d50f11c428040ed79a076.camel@kernel.org>
Subject: Re: [PATCH] tracing: Always use memcpy() in histogram add_to_key()
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, Kees Cook <keescook@chromium.org>, 
	linux-hardening@vger.kernel.org
Date: Tue, 08 Apr 2025 14:32:50 -0500
In-Reply-To: <20250403210637.1c477d4a@gandalf.local.home>
References: <20250403210637.1c477d4a@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Thu, 2025-04-03 at 21:06 -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> The add_to_key() function tests if the key is a string or some data. If
> it's a string it does some further calculations of the string size (still
> truncating it to the max size it can be), and calls strncpy().
>=20
> If the key isn't as string it calls memcpy(). The interesting point is
> that both use the exact same parameters:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 strncpy(compound_key + key_field->offset, (char *)key, s=
ize);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 memcpy(compound_key + key_field->offset, key, size);
>=20
> As strncpy() is being used simply as a memcpy() for a string, and since
> strncpy() is deprecated, just call memcpy() for both memory and string
> keys.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good, thanks.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
> =C2=A0kernel/trace/trace_events_hist.c | 6 ++----
> =C2=A01 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index c1ea6aaac182..4258324219ca 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -5224,10 +5224,8 @@ static inline void add_to_key(char *compound_key, =
void *key,
> =C2=A0		/* ensure NULL-termination */
> =C2=A0		if (size > key_field->size - 1)
> =C2=A0			size =3D key_field->size - 1;
> -
> -		strncpy(compound_key + key_field->offset, (char *)key, size);
> -	} else
> -		memcpy(compound_key + key_field->offset, key, size);
> +	}
> +	memcpy(compound_key + key_field->offset, key, size);
> =C2=A0}
> =C2=A0
> =C2=A0static void

