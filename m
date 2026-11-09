Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241297;
	b=h0IWhEnaUIxJ+BQ6vr7bN/pJPKiKX3K+wN9VA3aNuoSAH2rBFm7ih3aMc6rNOevFxSt+
	 votU2zJRGXgC/Qi2dwOZmW4/0Fqepw4J3qww2P6LlSxR4njT8XSsG8vTQIEHEQ5zdrhdU
	 FZy7LR67Te2Luwar+zTq8NjKC/hdMs7RoCW9aJ0te9Tb6N3k1VIn0Syw0sb9fo5v+op+9
	 ACj+39TciCQRlOhuGn/C8oYwiQXrfI+taNFjc2z/GOuqdGKc+UMKe5w6qDz0iAg0qKaSr
	 kDUb4NowwQQKNR8xv6eKeh8KwaDqY/h7jnan8Tudn3057zkbrfrnlkUixAGRh5VZC3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GBnfYrS+jdIGXi8vDz34wJBQH3iwSSZ8fmePbZRwvag=;
	b=hFuFefzVuzN+GHhpVWzyyzjwHIvdxgllNz4ezcRtQ72Mbr2NI4emS0cyraEaKUTv18ti
	 sPJHDb5wcmtnblRFixJGiKDQg2DntZsmSaUCw2E9mGv/cPO9S5lrIu0VHYq6rgbUDtIxh
	 WdUtyYLxF7QI9g872v9kmsK3N8DUsbHeYoE52dBFy2of3fxooX4SmZCgdF4EflnGHz5UL
	 MDkUb/5M90qWy4xsGKu9Vph2J7rRKvqn6zvgQ/4dCIF/ywQvsahFardYfgCY62hUB7nXj
	 ziI589KZCsaH0EmWe49TV0PSNS3hxTZC108rVYsN3UxmWqEJwIq02oYohkll44njuRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEaI7O+x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52F606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEaI7O+x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920101F008A1;
	Mon,  9 Nov 2026 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241296;
	bh=GBnfYrS+jdIGXi8vDz34wJBQH3iwSSZ8fmePbZRwvag=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kEaI7O+xzprgImauUIEjVqR3z9PYjlcyYi0mv6jQsP4q07vWGLwg2POkoxg1rqQYn
	 wTCLAMPfSWJvWnH3YBgdjUquY5AG8Nhvur5uABnWqnC/PTtfIqA9h3cScXO+PITxrk
	 JFLs7/nCCyeT3mru4c2+ayt9CuyUKt+WXhJZDfSMreVwOc3uUrLDEkoeQ7z5Ejmjsx
	 KMBU1a9l9/3qVYz6myghgWgDMuMYngmrr7GwdXhbfA1Eo+Qy2bUCwJwF4NcGtVjfa+
	 WYE2IC9s+Q2z46CwuDAXjRLRyw1vJJDqnhPrh/AQGEDl4Oee+7WvPGWzPnvKLoa0kL
	 lN8YrNu3MVdlg==
Message-ID: <sashiko-outbox-205226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND] tracing/synthetic: Handle dynamic string read faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261109155758.3330810-1-lee@kernel.org>
References: <20261109155758.3330810-1-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 16:21:36 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] tracing: TOCTOU ring buffer overflow in trace_string() [1]
--

commit f7b85a2fa215ca47a63174ad2034f4bca609b931
Author: Lee Jones <lee@kernel.org>

tracing/synthetic: Handle dynamic string read faults

This commit updates synthetic event dynamic string handling to skip
non-positive lengths in get_field_size(), record a 0-length dynamic field
in trace_string() when fetching a string fails, and print FAULT_STRING in
print_synth_event() when the dynamic string length is zero.

> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_event=
s_synth.c
> index e2870212e58d4..8492a5f285c4e 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
[ ... ]
> @@ -438,11 +440,20 @@ static unsigned int trace_string(struct synth_trace=
_event *entry,
>  	if (is_dynamic) {
>  		union trace_synth_field *data =3D &entry->fields[*n_u64];
> =20
> -		len =3D fetch_store_strlen((unsigned long)str_val);
>  		data->as_dynamic.offset =3D struct_size(entry, fields, event->n_u64) +=
 data_size;
> -		data->as_dynamic.len =3D len;
> +
> +		ret =3D fetch_store_strlen((unsigned long)str_val);
> +		if (ret <=3D 0) {
> +			data->as_dynamic.len =3D 0;
> +			(*n_u64)++;
> +			return 0;
> +		}
> +
> +		data->as_dynamic.len =3D ret;
> =20
>  		ret =3D fetch_store_string((unsigned long)str_val, &entry->fields[*n_u=
64], entry);
> +		if (ret > 0)
> +			len =3D ret;
> =20
>  		(*n_u64)++;
>  	} else {
> @@ -522,6 +533,8 @@ static __always_inline int get_field_size(struct synt=
h_event *event,
>  			len *=3D sizeof(unsigned long);
>  		} else {
>  			len =3D fetch_store_strlen((unsigned long)str_val);
> +			if (len <=3D 0)
> +				continue;
>  		}
> =20
>  		fields_size +=3D len;

[Severity: Critical]
This problem wasn't introduced by this patch, but can recalculating the
string length in trace_string() overflow the reserved ring buffer entry
[1]?

trace_event_raw_event_synth() calls get_field_size() to measure each
dynamic string with fetch_store_strlen() and reserves a ring buffer entry
of that size.  write_synth_entry() -> trace_string() then calls
fetch_store_strlen() a second time on str_val and sets
data->as_dynamic.len to the new return value before calling
fetch_store_string():

CPU0                                    CPU1
trace_event_raw_event_synth()
  get_field_size()
    fetch_store_strlen(str_val) -> 4
  trace_event_buffer_reserve(...,
    sizeof(*entry) + fields_size)
                                        event_hist_trigger()
                                          /* updates shared hist elt
                                             str_val to a longer string */
  write_synth_entry()
    trace_string()
      ret =3D fetch_store_strlen(str_val) -> 32
      data->as_dynamic.len =3D ret
      fetch_store_string(str_val, ...)  <-- writes 32 bytes past
                                            4-byte reservation

Because fetch_store_string() reads its maximum copy length from
data->as_dynamic.len rather than the length reserved in get_field_size(),
concurrent growth of the source string writes past the end of the reserved
ring buffer entry and corrupts the ring buffer.

[1] https://sashiko.dev/#/bug/linux-99ac32b2-e9bc-4529-bfdc-62d0b5345672

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109155758.3330=
810-1-lee@kernel.org?part=3D1
