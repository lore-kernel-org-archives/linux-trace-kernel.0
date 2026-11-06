Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989256;
	b=Y/P/rI/ikFFzhapD7Mq4RUSuDO5DL7qxH5v32d3sgrFr9oJi9lNO65UQV8o0haFRVJVL
	 8LstrDEtXaLaOwEDfJKebIrYADBkv85zcf1Nh8OgccWjEYgIZjzToUIMiKx+OWQqslAJw
	 Apzo+1Q6moPab3gB/CxL+hbKbdGD0H/pcQ4+Mi2WuOzT9aYGguq/tmYi19oscfJH9qJKF
	 xd2FsDOJ96AIyl/OMCTF0oXcoKscUm5tFlrBzh2Bv3wb0zyF0K6zqd4k1XRZqUVSng7sZ
	 GMuYCNbaGhe2ll/buyDCPHGWwzBy8GgcC6us5hk9aMVqJcOz6YtVieeDdsE2OcEgLYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989256;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9x/m+k1X9GxPQ0t8VEHlIEFREx1SNS6SbJFSV3ne3cM=;
	b=zXxb3W6ZrKSQ0C5dEhCFs5qKmhMt/P04OzgFCoZ1zfvn3If4y22ObwAcohiyiD0Y9DeX
	 4M+mDwIte7U5+Oimokwu+QFiq9WD+zrY3SNb4aLl3KWGtqgpSUgdmqlWInNJ9aflx1B8c
	 R9e1h7E62dklk1Q00ZBP4gPbvQxGUVZHTmb2wVgy7FPm/HVcFYkSequ58GXuSKIMwmWmj
	 7DGz8FdDrVVXAf0iUElhTt+7XxFXciWgYbypHuM8GOd1f4mr5KhcxlS0eA1eIp/37PeOc
	 mLNza+cGYlqsHZz8Ep33mVLYs100J6KqeC0jj+0B2pV2p7/skYsA/2r1ACbYCHOM1fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrsEteAX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C2606A32D
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XrsEteAX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5411F008BD;
	Fri,  6 Nov 2026 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989256;
	bh=9x/m+k1X9GxPQ0t8VEHlIEFREx1SNS6SbJFSV3ne3cM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=XrsEteAXH/SAFho5OWvuAqXFEh1Ic2KDcbeR0Y7AqXjrRl37z8pMNC9WXXPPzssD8
	 KlRgfvwTtnthVq9kE6nHdR/jlCQpJVdaO0MLbeXHnlCSPb3yUxDNPDAvzWSB2AFDba
	 w+fwA00IvnbEyjLgtN/WMOcxoA8O1nL/THNeSk2zQkrxEDrlF4jo6j9zByl2pg2C81
	 2qvSA0dPtM6qrgtwNfQBobbAGe9MNKmGmejRD/TonbROybt4U8F8eRMWT930nCi7zo
	 XwYSVuJi6Bhk6V7yaYeS+SZDkVttNqzZ+Z0GjTWUqzVcYW/K8Fibpkkfm1bqsX649x
	 z1BiAQHTQYWcA==
Message-ID: <sashiko-outbox-202012@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 07/21] tracing/simple_ring_buffer: Add support for
 compressed length
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106180657.2460376-8-vdonnefort@google.com>
References: <20261106180657.2460376-1-vdonnefort@google.com>
 <20261106180657.2460376-8-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:20:55 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] tracing: shared-memory TOCTOU in simple_ring_buffer_reserve()
--

commit 9257cd3bebb215fd4b1122136bcc3bcfeab103ba
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/simple_ring_buffer: Add support for compressed length

This commit compresses small event lengths into the ring buffer event header
type_len field and enforces ring-buffer alignment to save 4 bytes per small
event.

> diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring=
_buffer.c
> index abfaf9bee12e1..a305331d29ba9 100644
> --- a/kernel/trace/simple_ring_buffer.c
> +++ b/kernel/trace/simple_ring_buffer.c
> @@ -207,7 +207,13 @@ static unsigned long rb_event_size(unsigned long len=
gth)
>  {
>  	struct ring_buffer_event *event;
> =20
> -	return length + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
> +	if (!length)
> +		length++;
> +
> +	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
> +		length +=3D sizeof(event->array[0]);
> +
> +	return ALIGN(length + RB_EVNT_HDR_SIZE, RB_ARCH_ALIGNMENT);
>  }
> =20
>  static struct ring_buffer_event *
> @@ -223,12 +229,15 @@ rb_event_add_ts_extend(struct ring_buffer_event *ev=
ent, u64 delta)
>  static struct ring_buffer_event *
>  simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned lo=
ng length, u64 timestamp)
>  {
> -	unsigned long ts_ext_size =3D 0, event_size =3D rb_event_size(length);
>  	struct simple_buffer_page *tail =3D cpu_buffer->tail_page;
> +	unsigned long event_size, array_size, ts_ext_size =3D 0;
>  	struct ring_buffer_event *event;
>  	u32 write, prev_write;
>  	u64 time_delta;
> =20
> +	event_size =3D rb_event_size(length);
> +	array_size =3D event_size - RB_EVNT_HDR_SIZE;
> +
>  	time_delta =3D timestamp - cpu_buffer->write_stamp;
> =20
>  	if (test_time_stamp(time_delta))
> @@ -259,9 +268,13 @@ simple_rb_reserve_next(struct simple_rb_per_cpu *cpu=
_buffer, unsigned long lengt
>  		time_delta =3D 0;
>  	}
> =20
> -	event->type_len =3D 0;
> +	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
> +		event->type_len =3D 0;
> +		event->array[0] =3D array_size;
> +	} else {
> +		event->type_len =3D DIV_ROUND_UP(array_size, RB_ALIGNMENT);
> +	}
>  	event->time_delta =3D time_delta;
> -	event->array[0] =3D event_size - RB_EVNT_HDR_SIZE;
> =20
>  	return event;
>  }
> @@ -284,7 +297,7 @@ void *simple_ring_buffer_reserve(struct simple_rb_per=
_cpu *cpu_buffer, unsigned
> =20
>  	rb_event =3D simple_rb_reserve_next(cpu_buffer, length, timestamp);
> =20
> -	return &rb_event->array[1];
> +	return rb_event->type_len ? &rb_event->array[0] : &rb_event->array[1];

[Severity: High]
Can reading rb_event->type_len back from the shared buffer page cause a
4-byte out-of-bounds write at EL2?

When compiled into the arm64 pKVM hypervisor (arch/arm64/kvm/hyp/nvhe/trace=
.c),
tail->page is shared with the untrusted host kernel via hyp_pin_shared_mem(=
),
and RB_FORCE_8BYTE_ALIGNMENT is 0. For length <=3D RB_MAX_SMALL_DATA,
rb_event_size() does not reserve space for event->array[0], but
simple_ring_buffer_reserve() re-reads rb_event->type_len from shared memory
to choose between &rb_event->array[0] and &rb_event->array[1]:

CPU0 (EL2 hypervisor)             CPU1 (EL1 host)
simple_ring_buffer_reserve()
  simple_rb_reserve_next()
    event->type_len =3D ...
    event->time_delta =3D ...
                                  rb_event->type_len =3D 0;
  if (rb_event->type_len)
    ...
  return &rb_event->array[1];  <-- 4 bytes past reserved space

If an event is reserved at the end of a page (write =3D=3D PAGE_SIZE -
BUF_PAGE_HDR_SIZE), the caller writes 4 bytes past the end of tail->page in
EL2 memory. Checking (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMEN=
T)
instead of rb_event->type_len avoids reading back from shared memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106180657.2460=
376-1-vdonnefort@google.com?part=3D7
