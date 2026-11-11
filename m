Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416155;
	b=gZOOKU04lLyp72PLGxn7q5+DfQ2owuuWFllKt+kSMC/tq2bseo3057P9gRyePIfHsTaN
	 UVR3XC1vEiXjGT2jJ2lXPsArF3Cl8INd+L7vXy1tWDSVBdDywHaodMhe5i43mt8AAMZnO
	 dWKE0swE2EnOG+ibcnWrhGM6CnoUOKDUtmDtYsjuq9x5wSAXVzoQo7RQxWk4WZYT1Lvzq
	 ETYzKpykSxWA+iYyeqPHPkdh/1VIVy24Wd78zqKR3jac1LroEmBubj8bq9eSAWbYB2BeJ
	 pURFZef9isUN1Kkg+AdpQUe1Zgmz9E94NvWtg+kBWEVHiCN9sNjijToWWRGgLDlecQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=COoFrKVjSGSQ3/0fRhMjTaGkJn0JhD3svPFFXROqO7k=;
	b=Tmvv/V6DsFX8w91M0ITq/fPZ29jou2tS/2imnCJhDyTWXOSLrbsu4FNsPisNNsN38nqR
	 4Z0abx8Ty7+/R3XIUWayVVvZ8J9/f6upz31ChK740o4aZazvZi3IRuBN2V+jh6UMI2XNp
	 O04Jeq9gGwhN9tNMszONF/i0F8ak/NjlU4DNsq6sPkydoA3LG5P2ts3OKOXhCud3NSrNc
	 rmMVaI7IfExB6YQGuxq0i1vj0aOic3NaReA8dMx1gyY803gTVJgamMuIv7s1QDXllkwD0
	 d8eXL2ll4vaP9vGUk98YipTWIDYFVaDv7q47w1XsO+vxAc5IRYCCkDAmZWus1hIvncA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTLcH7v0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FAD606A324
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTLcH7v0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 359691F00A05;
	Wed, 11 Nov 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416155;
	bh=COoFrKVjSGSQ3/0fRhMjTaGkJn0JhD3svPFFXROqO7k=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=QTLcH7v00+SmUDmF7Z0hbnZOOJpiJNE2IjGuq/QW3N0pxY6rUuPGptXf0L81Pk5FD
	 DnmVCRXDI8xqaKZ4vRVluox0CrtDa/YFxSiIktXk6vpihAvb9MX1Ju3mPNybjW8pND
	 Koik/gYbZyKDcB7n8EsZBOJBW2EmXnVC56JzqSgBQ6wHscElZJJxi9PD/GLTvyighO
	 vR3Sa3wUPqs3XAjorWtlkXBZO+EvPAoPU8I/tMxI6VuMORkCGjC0gGvrclnwE6QUl9
	 2x+pQPluvm7a/EfhdJy0WcYkEji4wtpI60D/uNUZJx8sFKHYAwhaWA4DUH2qQX0MPE
	 z3ECQxQYvdvMQ==
Message-ID: <sashiko-outbox-209343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Let the reader spin on head page update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111160624.1294946-1-vdonnefort@google.com>
References: <20261111160624.1294946-1-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 16:55:54 +0000
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
- [Medium] ring-buffer: stale list.prev dereference in
  rb_handle_head_page() writer loop
--

commit 42f758b28dc946f5aa06647c36c046a615ee80cf
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Let the reader spin on head page update

This commit introduces the RB_PAGE_HEAD_UPDATE flag to mark newly moved head
page links while a writer update is in progress, converting the final link
to RB_PAGE_HEAD only when the outer writer finishes rb_handle_head_page().

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee1..73f31e6719f98 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -3833,6 +3849,24 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cp=
u_buffer,
>  			return -1;
>  	}
> =20
> +	if (type =3D=3D RB_PAGE_HEAD) {
> +		struct buffer_page *prev_page;
> +
> +		do {
> +			/* Interrupts might have moved the head further  */
> +			while (!rb_is_head_page(new_head, new_head->list.prev))
> +				rb_inc_page(&new_head);
> +
> +			prev_page =3D new_head;
> +			rb_dec_page(&prev_page);
> +
> +			/* Try to release the reader */
> +			ret =3D rb_head_page_set_head(cpu_buffer, new_head, prev_page,
> +						    RB_PAGE_HEAD_UPDATE);
> +
> +		} while (ret !=3D (RB_PAGE_HEAD_UPDATE));
> +	}
> +
>  	return 0;
>  }

[Severity: Medium]
Can reading new_head->list.prev and rb_dec_page(&prev_page) here inspect a
stale predecessor page and spin in rb_handle_head_page()?

Lockless writers cannot rely on the head page's list.prev pointer because
__rb_get_reader_page() and rb_insert_pages() update the forward list.next
pointer via cmpxchg before updating the following page's list.prev pointer:

kernel/trace/ring_buffer.c:__rb_get_reader_page() {
	...
	ret =3D rb_head_page_replace(reader, cpu_buffer->reader_page);
	if (!ret)
		goto spin;
	...
	rb_list_head(reader->list.next)->prev =3D &cpu_buffer->reader_page->list;
	...
}

If a writer enters rb_handle_head_page() in the window after a reader swaps
the head page (or after rb_insert_pages() splices in new pages) but before
list.prev is updated, new_head->list.prev still points to the old predecess=
or:

CPU0 (reader)                     CPU1 (writer)
__rb_get_reader_page()
  rb_head_page_replace(reader,
    cpu_buffer->reader_page)
                                  rb_handle_head_page()
                                    /* tail_page is reader_page->prev,
                                     * next_page is reader_page,
                                     * new_head is reader->next
                                     */
                                    rb_head_page_set_head_update(...,
                                      new_head, next_page, ...)
                                    rb_head_page_set_normal(...,
                                      next_page, tail_page, ...)
                                    rb_is_head_page(new_head,
                                      new_head->list.prev)
                                      /* inspects reader->list.next
                                       * (RB_PAGE_NORMAL) instead of
                                       * reader_page->list.next
                                       * (RB_PAGE_HEAD_UPDATE)
                                       */
                                    rb_inc_page(&new_head)  <-- misses head
  rb_list_head(reader->list.next)->prev =3D
    &cpu_buffer->reader_page->list;

Because every other link in the ring has RB_PAGE_NORMAL, the inner while lo=
op
wraps around the ring buffer until CPU0 updates list.prev, or deadlocks if =
the
writer is an NMI that interrupted __rb_get_reader_page() or rb_insert_pages=
()
on the same CPU.

Since new_head starts as the page right after next_page, tracking prev_page
forward from next_page as new_head advances via rb_inc_page() would avoid
touching list.prev on the writer path.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111160624.1294=
946-1-vdonnefort@google.com?part=3D1
