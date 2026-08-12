Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071C3911AA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552963; cv=none; b=bFPu318FuxYTWgIFxzcjXSTNvHmG7e5ueS0JgBNacbF6Xa6CVFItrCP2S7hocLWKgN4ZmN9whoaJQL/bepaMh3HVwPOybY8z6s7kIU+wIFC7Mc4UUTrA3svjLtATKnLecxZmtTM5yDKVK6obD0L/PwcIK84aANvFahxbo3Hxonc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552963; c=relaxed/simple;
	bh=d/QFHB+be7iSxNzwfhF6wJ7+3Sq9opM7JHpbQTol1Lo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dPRfjM2Is1msR0UFAUx0uKWV+F/5Gvw2wPZ5wMyN+QgzZC9IHo5s+rVEIRwrWH0n6/QnndPMTh2PC/+OdNh0qBbewxaycrKoJlbG5E9ASkF8Z1Ms1lN5JN7mu2RL8wiFHNgKpZgnui5VojEvFHAB+pjw5Jru1c2X5xo+VHuiqrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiueVTbY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiueVTbY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085961F000E9;
	Wed, 12 Aug 2026 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552962;
	bh=0o0pCiiWHp+U9ZcaajXWRQ+/9imFsRG4w0bwdD7zS4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JiueVTbYMa8ySlsZXsoEcK3AUOyUZbW423CdUR7hdglUTiP5KwusM15mI9sxPn5fo
	 CTf8NrH+uilHnp+kwK0cB8adZulmXaV6MUQ6TjkB7FsdKLyn/spZBP4Ea/GlSyYxe+
	 SgrucMx7s9p/KRP5doADGwz8tLkfk4FVcUO5x6QOys6HQFzIZrPAR0EVPKdGelbJUE
	 lSD4dHFf5WUTrwR+zFrzLgjUaUuhKFSul8WTtZvwtgISwB6erxE/KRlT1lTjkhZvm9
	 4xjn1HqnEmkNVHRC4hGhQ4fw6g/b+Hw2RFdZcF8jDt9+o9zl7xch76GXLmXGoHkFRb
	 yVGGppT+MrBIg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/18] tracing/simple_ring_buffer: Add support for
 compressed length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-6-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-6-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:42:41 +0000
Message-Id: <20260812164242.085961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch unconditionally introduces `type_len` compression for sm=
all events and hardcodes 4-byte alignment, ignoring `RB_FORCE_8BYTE_ALIGNME=
NT` and `RB_ARCH_ALIGNMENT`. This causes payload truncation and unaligned a=
ccesses on architectures requiring 8-byte alignment.

Pre-existing issues:
- [High] `simple_ring_buffer_reserve` lacks a bounds check to prevent `even=
t_size` from exceeding the maximum page capacity (`PAGE_SIZE - BUF_PAGE_HDR=
_SIZE`).
--

--- Patch [5]: [PATCH v5 05/18] tracing/simple_ring_buffer: Add support for=
 compressed length ---
commit 661f4dfe638155c632fb481b814114210260a54c
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/simple_ring_buffer: Add support for compressed length

This patch adds support for compressing the event length into the event
header type for small events in the simple ring buffer, saving 32 bits
per event. It enforces a 4-byte alignment for the compressed length.

> diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring=
_buffer.c
> index f4642f5adda33..1a97d17cca246 100644
> --- a/kernel/trace/simple_ring_buffer.c
> +++ b/kernel/trace/simple_ring_buffer.c
> @@ -207,7 +207,15 @@ static unsigned long rb_event_size(unsigned long len=
gth)
>  {
>  	struct ring_buffer_event *event;
> =20
> -	return length + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
> +	if (!length)
> +		length++;
> +
> +	length =3D ALIGN(length, RB_ALIGNMENT);

[Severity: High]
Does this hardcoded 4-byte alignment cause unaligned access exceptions on
architectures that require 8-byte alignment (where RB_FORCE_8BYTE_ALIGNMENT
is 1)?

It looks like using RB_ARCH_ALIGNMENT instead of RB_ALIGNMENT would prevent
these exceptions.

> +
> +	if (length > RB_MAX_SMALL_DATA)
> +		length +=3D sizeof(event->array[0]);
> +
> +	return length + RB_EVNT_HDR_SIZE;
>  }

[ ... ]

> @@ -259,9 +270,13 @@ simple_rb_reserve_next(struct simple_rb_per_cpu *cpu=
_buffer, unsigned long lengt
>  		time_delta =3D 0;
>  	}
> =20
> -	event->type_len =3D 0;
> +	if (length > RB_MAX_SMALL_DATA) {
> +		event->type_len =3D 0;
> +		event->array[0] =3D array_size;
> +	} else {
> +		event->type_len =3D DIV_ROUND_UP(array_size, RB_ALIGNMENT);
> +	}

[Severity: High]
Can this unconditional compression cause payload truncation on architectures
requiring 8-byte alignment?

If RB_FORCE_8BYTE_ALIGNMENT is set, it seems the core ring buffer reader
(ring_buffer_event_length) might subsequently subtract 4 bytes erroneously,
leading to data loss and potential out-of-bounds reads when parsing the eve=
nt.

>  	event->time_delta =3D time_delta;
> -	event->array[0] =3D event_size - RB_EVNT_HDR_SIZE;
> =20
>  	return event;
>  }
> @@ -284,7 +299,7 @@ void *simple_ring_buffer_reserve(struct simple_rb_per=
_cpu *cpu_buffer, unsigned
> =20
>  	rb_event =3D simple_rb_reserve_next(cpu_buffer, length, timestamp);
> =20
> -	return &rb_event->array[1];
> +	return rb_event->type_len ? &rb_event->array[0] : &rb_event->array[1];

[Severity: High]
This is a pre-existing issue, but does simple_ring_buffer_reserve() lack a
bounds check for events larger than the maximum page capacity?

If a caller attempts to reserve an event with a length exceeding
PAGE_SIZE - BUF_PAGE_HDR_SIZE, simple_rb_reserve_next() will move to a new
page and set the write index beyond the page boundary. This would return a
pointer that allows the caller to write out of bounds.

Would it be safer to validate that length is smaller than the maximum buffer
page data size before proceeding with the reservation?

>  }
>  EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D5
