Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559938;
	b=X0BAEUIHf5sLWEawPoNFfthkuqDG25jlL3pSieRUx4AX7rI7vUHGARz8vS7KPp9o5KIh
	 ckkLyhPQZIPsTQyBmZy7MVXCADb539qnwlAReQaS0lGEqtr/isyJcD1tK2d93mj3ZFaKe
	 TeahexUyWXB6ZNEuQzzow+cNWHvb6G5No0QO/ku4QvqwPOfkwRcHdv1YYXlWdNZTfPit1
	 AiHb7kb5Zz3tDZ6p0xr0iLHT2XJKwHolLvk8DuCrEDV8UXm3xGvDFnQoYrjvXkpfZc8zr
	 fVJtqLquo0uwR/B7sA3kFF1VIFllCnZI8Fp4BmmUWhDtqoPu9EuR7Db0xBo4xzvrupQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559938;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X0OPboTlKYBYDfOoS/lo7m1c6pePCwddRm4rdAWfTyg=;
	b=Trn3eE3/VK+GClNm+9FD5+xXeUqTYDEAe0LoD37MT7knWvF8+1aBHE/Cwx07wLHGcYO8
	 9KkYSstor3UjIMxeIW/mcZHUnkEfAIfs2aNz6YyAZpYsXGddSCDaKx4q5WzAuzFzWAnuO
	 80B4FEYsyhPwIxEou0djSkpoVIs+IxbEU2uDzdUZCXuvMnrCqHrB/3++YfKuV0tzdpOTc
	 S0K9qUqgfWqa2sg/HOZ+NvzyJvlfjRS1uTb4blJ3dbZSpegCpJUH4fEYke0yQHyT9ezIk
	 S6r32npRyycRyJWfXWiT3yfypLqxipMcCrHRrKriZ5Fb3AYlb2CVtz8OpLa+MMPe3EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oj33aV3S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B360A6F52
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oj33aV3S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA6B1F000C6;
	Fri, 13 Nov 2026 08:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559938;
	bh=X0OPboTlKYBYDfOoS/lo7m1c6pePCwddRm4rdAWfTyg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oj33aV3Slt3uNNzFU8g9Oj3nLL7Cmh8Im7Snrjp/A0McaEo93Sja2gdn77byB+WAC
	 NYt/P+k7V9BQJyNGIlAEoyjjwNJepooijTbOTuqZF0WJ1cG7VkCG6FboLPiI2GSnQE
	 iVK7eevcQKVxbgrP5i84QWHFL24XUqucxEaM3xBE3CFyaCmpkpqIEQUX4otky40+ud
	 az2jPQXwGCC/KMcvnxE5WvwzFgznqLb9MxBUGw50HInMS1R2VaeeWuMo4mo6PoRlyQ
	 ZAAGxwbOKBWtaPKImmT5pSUgfcbo5ktenG2AHQnK9afNJkBPaHUlTg0VAUbaqfsTe0
	 sJemyhO8jjYdA==
Message-ID: <sashiko-outbox-212472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ring-buffer: Annotate the speculative iterator event
 copy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhu Jun" <zhujun2@cmss.chinamobile.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113083446.177306-1-zhujun2@cmss.chinamobile.com>
References: <20261113083446.177306-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:52:17 +0000
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

commit b8f65c61949524a718551f053209be2d46d549d1
Author: Zhu Jun <zhujun2@cmss.chinamobile.com>

ring-buffer: Annotate the speculative iterator event copy

This commit wraps the speculative memcpy() in rb_iter_head_event() with
data_race() to suppress data race reports when a concurrent writer
overwrites the buffer page.

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
>  	/*
>  	 * If the page stamp is still the same after this rmb() then the
>  	 * event was safely copied without the writer entering the page.

[Severity: Low]
Does annotating only the memcpy() leave the preceding rb_event_length(event)
and following iter_head_page->page->time_stamp loads in the same speculative
read section subject to the same data race?

Just above the memcpy(), rb_iter_head_event() calls rb_event_length(event)
on the same shared event pointer while a concurrent writer can update
event->type_len, event->time_delta and event->array[0] in rb_update_event():

kernel/trace/ring_buffer.c:rb_iter_head_event() {
	...
	event =3D __rb_page_index(iter_head_page, iter->head);
	length =3D rb_event_length(event);
	...
}

Because rb_event_length() and its helpers read the event header with plain
loads, the race detector will still report the race there, and the compiler
can reload the event->type_len bitfield across the switch and length
calculation before the barrier().

Similarly, the plain loads of iter_head_page->page->time_stamp after the
memcpy() race with __rb_reserve_next() updating tail_page->page->time_stamp.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113083446.1773=
06-1-zhujun2@cmss.chinamobile.com?part=3D1
