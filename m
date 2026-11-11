Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794388203;
	b=Q+QV4K+vSD6346njP0NMHnqc3J/I4f2w2LTGioc2cgY+aqT06y/ut92EvIYrz5Xq3vjv
	 njzJljI/B13QbEl6cEw6MSJdk3k+jn9YByDk4S6O6HDvyy4df2Bxsj/pUIXpni2C1IzTK
	 kyssMGrQzN52kq/5lrk0RxwOJ+qjPGsrHlKqWmHVdyn9t9HRPIrvNKZZ/dFnI80E4353N
	 3l6T8YT1HTlgLNoNSvih3jKMnfKShZpjILalVWJRFY4bQ7GK8NWTSskcur4Q6/856tv+Q
	 h7eBo56nHkOoEGd2BGVdGOM9FnUhUAt3kuZmy+5aM/ZkWDYmkds+sHBlQB0TUxlfCyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1fU/3RUJzMH3qQmy+kIUd3ACnOcdNF6yRxLT+tx8+dY=;
	b=jobO8WOlrb5SzpX4NXvddKm/7mt/NdhOJG6jG1+Pdeo3iRxiSnHyKlKWKUdUgGdzyLDZ
	 pkSsKqcRBXu4yRHxOI5RYlrbWChUjFqAwt31lOsQROP9Phuzf8TdNOr5VaVT3j49K3pUp
	 RBomvRjH6aOI3tH8nV8lky3ASxiJguGWc1moe6cw0hGTdmQsxxsb0IAVW8GUy2LQ0wUsc
	 QtFcpZwuRlgfHXQ3Ko5Z/DTx/jBtEUdKWYI+VEB5FwgW2w7wIvTOdR+9DzuKPqhP1eQAc
	 PbNET+m/aprBFiTy1W/LAC9FI8qW255X4IzDeoPt1jfWlvfnG9YJo3H2W0WayB37SXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+GyvV8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFD660A2604
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R+GyvV8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B410C1F00A0A;
	Wed, 11 Nov 2026 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794388202;
	bh=1fU/3RUJzMH3qQmy+kIUd3ACnOcdNF6yRxLT+tx8+dY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R+GyvV8eC5Tjc63ryXLS4Wr4e6YxfVMOhX6pz4lCHldrLUpC8C2ZPlOBxwLYi6aEY
	 i8HRRYT/uqqd5CyublL/wzR/c1atcehVN0PCGe3XjLzhx5ZDOI1tQ9kYcqWbwE0y1S
	 UnErpkaeE78pNC/PV1G4kDXspLyutouZW7qGagDipzXP2EstyyvoZsHvKVNAFxfTxW
	 zHT5wm8g96YfYiddN4kOzubvn96jnXR/TCLMubvqNuSSZI1MQGJoYjsmpOnKG4qpYD
	 LqWvxnCyEe+6DEMMLQN+mhm2PgxYiMgB4KRXzuzwG8m8upiHE5KkbRc8TJcwlWhLos
	 OqDn8aTzE2Gvw==
Message-ID: <sashiko-outbox-208667@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Annotate the speculative iterator event
 copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111084201.80984-1-zhujun2@cmss.chinamobile.com>
References: <20261111084201.80984-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 09:10:02 +0000
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
- [Low] ring-buffer: unannotated speculative reads in
  rb_iter_head_event()
--

commit a821b9e5782f64ce12600813e637e78c35dbbee8
Author: Zhu Jun <zhujun2@cmss.chinamobile.com>

ring-buffer: Annotate the speculative iterator event copy

This commit wraps the speculative memcpy() in rb_iter_head_event() with
data_race() to silence KCSAN warnings when a concurrent writer overwrites
the page being read by a non-consuming iterator.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e760d2fe386fb..6e51a7a75d6b1 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3562,7 +3562,8 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
>  		/* Writer corrupted the read? */
>  		goto reset;
> =20
> -	memcpy(iter->event, event, length);
> +	/* The page stamp below detects a concurrent overwrite of this copy. */
> +	data_race(memcpy(iter->event, event, length));

[Severity: Low]
Can KCSAN still trigger on the adjacent speculative reads of event and
iter_head_page->page->time_stamp in rb_iter_head_event()?

kernel/trace/ring_buffer.c:rb_iter_head_event() {
    ...
	event =3D __rb_page_index(iter_head_page, iter->head);
	length =3D rb_event_length(event);
    ...
	data_race(memcpy(iter->event, event, length));
	smp_rmb();

	/* Make sure the page didn't change since we read this */
	if (iter->page_stamp !=3D iter_head_page->page->time_stamp ||
    ...
}

Before the annotated memcpy(), rb_event_length(event) reads
event->type_len, event->time_delta, and event->array[0] from the same
shared page while a concurrent writer updates the header in
rb_update_event(). Because rb_event_length() and rb_event_data_length()
read the event->type_len bitfield via plain loads across multiple checks,
the compiler can also reload inconsistent values if a writer modifies the
header mid-evaluation. Likewise, the plain loads of
iter_head_page->page->time_stamp in the validation check and reset path
race with the writer updating tail_page->page->time_stamp in
__rb_reserve_next().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111084201.8098=
4-1-zhujun2@cmss.chinamobile.com?part=3D1
