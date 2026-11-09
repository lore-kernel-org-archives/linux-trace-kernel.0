Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213584;
	b=eCW3Bts3GEwaOiiSp8Cbg3WXmJH+hDfk3iJiLnKnxTqX4vD8we9lGDTZ5xazhgUvUi3w
	 41BASKdxDY7Hl/JGtzrJCKFYSMKSlGQoGsWeUnZZs8bAZ8KVG/jPyDpwvEddnNUvkwSYr
	 0GBo8a/+Jrp0kVl4r5zkTE96oAmI+1NyUZjGFRxDD9ljWpakGQpTE6EMOdBGtgHN0JbmH
	 cpADb94a0htP1Mq3/SnTy9Iex4OYHhaHij5th5yGpQT+cxukP59numC0vU8Ilo5NLlOox
	 SAVREyK6ZrpmCOssg5BcA8q+YLy8sDhStzGXmSaO9RRhkSlCs9SAN4GSWenD+nHJdHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213584;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=l9i4mwhB6QEe8gOgrlArZBvPzKd1sxtssMVQFk6jCc4=;
	b=VnzBvnG2QZGagQTBQz0oQuWbKV3UWe5jvB/RvYsfpV7/ZxZZzSPsJi3gmP/6etkR92qq
	 MPJNWI+XLKGrrNLpx/zzKU/gaJdikG9qAq1UPComHwImmANeoqVshKA5cZdGoQAYKqRva
	 6bdWCu+ATtTtFLQ8XV95j750Vn4ecwE8PgpMfFw3hFUTEwDq529RbXIDmj3CFpOSicc0J
	 1rP03coiOi6QWlDwUQuVp7gUwDkkxRY/etlGyvDhHxjIwlKKfUHplQ6iw6CcWBwbw8ydX
	 TzEU2PZWOjXwwyTkPiUYcpdV5aA1wQgto6t7kNd33GsJuJgmtYF0y8JaDNaQgnk1HaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrUOYbQ9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50114606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OrUOYbQ9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA441F0089F;
	Mon,  9 Nov 2026 08:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794213583;
	bh=l9i4mwhB6QEe8gOgrlArZBvPzKd1sxtssMVQFk6jCc4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=OrUOYbQ9ZZLAmNfuwrvrt1HzlwaYDRnsvq4G00Z6mIacdIgieB3BLDgHHpmLxWVE9
	 hMKDtb1vFLAbVuP96QEESf4fcNh0RugGT9PHlElQAhYNg31n/7J8yxzVf46n3nGvT+
	 qYOVuTAy9f9OUec7uDsK+iIjNuXQoKXPkL+0FR3qinMY2Q/zllnN9Z8x2OtP1MmXqu
	 Fjh2gyPmI8jj5GtW66SVL5X0rc/+aGx2cgGKHCnsgDWHxQVpYGQVI3+/+EzjfQgZVK
	 BUSJLbJZYCJ+zbxCP8l2AecbAWnULH0QDBFJtQ5o7h8Pqm/5yN3yy4hC3mUth0V8EK
	 IdzNF8FSsAlxg==
Message-ID: <sashiko-outbox-204599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Do not allow reader to see unfinished
 moved head
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux trace kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261109032241.55e57d26@fedora>
References: <20261109032241.55e57d26@fedora>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 08:39:43 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] ring-buffer: nested irq in rb_handle_head_page() moves
  head_page past UPDATE
- [Medium] ring-buffer: race on head_page between rb_handle_head_page()
  and reader
--

commit f326a3a8a8353c768b90c13ee6f1ad10ec362a2f
Author: Steven Rostedt <rostedt@goodmis.org>

ring-buffer: Do not allow reader to see unfinished moved head

This commit updates cpu_buffer->head_page in rb_handle_head_page() with
smp_store_release() and reads it in rb_set_head_page() with
smp_load_acquire() so a reader does not start scanning for the head page
between a sub-buffer being updated and the newly moved head sub-buffer.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e760d2fe386fb..cf9e0dc10c88f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -1494,7 +1494,13 @@ rb_set_head_page(struct ring_buffer_per_cpu *cpu_b=
uffer)
>  	if (RB_WARN_ON(cpu_buffer, rb_list_head(list->prev->next) !=3D list))
>  		return NULL;
> =20
> -	page =3D head =3D cpu_buffer->head_page;
> +	/*
> +	 * Make sure that the start of the search of the head_page does not
> +	 * start between the writer adding the UPDATE and the new HEAD that it
> +	 * moves forward.
> +	 */
> +	/* Sync with the writer moving the HEAD in rb_handle_head_page() */
> +	page =3D head =3D smp_load_acquire(&cpu_buffer->head_page);

[Severity: Medium]
Can the reader's non-atomic update of cpu_buffer->head_page in
__rb_get_reader_page() race with the writer's new store in
rb_handle_head_page() and advance cpu_buffer->head_page past the sub-buffer
marked for update?

Before this patch, only the reader modified cpu_buffer->head_page.  In
__rb_get_reader_page(), after rb_head_page_replace() splices reader_page in=
to
the ring buffer, the reader advances cpu_buffer->head_page assuming it still
points to the replaced reader sub-buffer:

kernel/trace/ring_buffer.c:__rb_get_reader_page() {
    ...
	ret =3D rb_head_page_replace(reader, cpu_buffer->reader_page);
	if (!ret)
		goto spin;
    ...
	rb_list_head(reader->list.next)->prev =3D &cpu_buffer->reader_page->list;
	rb_inc_page(&cpu_buffer->head_page);
    ...
	goto again;
}

If the writer on the traced CPU moves onto the newly spliced reader_page (R=
),
fills it, and enters rb_handle_head_page() to overwrite the next sub-buffer
(P2) before the reader runs rb_inc_page(), both sides update
cpu_buffer->head_page without synchronization:

CPU0 (reader)                     CPU1 (writer)
__rb_get_reader_page()
  rb_set_head_page()
    head_page =3D P1
  rb_head_page_replace(P1, R)
  P2->list.prev =3D &R->list
                                  rb_handle_head_page(..., R, P2)
                                    rb_head_page_set_update(..., P2, R, ...)
                                    smp_store_release(&head_page, P2)
                                    rb_head_page_set_head(..., P3, P2, ...)
  rb_inc_page(&head_page)
    head_page =3D P3
  goto again
  rb_set_head_page()
    page =3D head_page (P3)  <-- skips P2 update, swaps P3

When __rb_get_reader_page() loops back to "again", rb_set_head_page() starts
its scan at P3 instead of P2, misses the in-progress update on P2, and swaps
out P3 while the writer is still moving the head page, corrupting the ring
buffer.

> @@ -3719,6 +3725,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cp=
u_buffer,
>  		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
>  		local_inc(&cpu_buffer->pages_lost);
> =20
> +		/*
> +		 * To prevent a stale head_page from being between
> +		 * the UPDATE and new HEAD pages, set it here to have
> +		 * the reader check always find the update before
> +		 * finding the HEAD page.
> +		 */
> +		/* Sync with the reader setting the head page */
> +		smp_store_release(&cpu_buffer->head_page, next_page);

[Severity: Medium]
Can a nested interrupt that moves the head page across multiple sub-buffers
overwrite cpu_buffer->head_page and still place it past the outer writer's
sub-buffer under update?

When an outer writer in rb_handle_head_page() changes P0->list.next (P1) to
the update state, it gets type =3D=3D RB_PAGE_HEAD and sets cpu_buffer->hea=
d_page
to P1.  If an interrupt then preempts the writer before it restores
P0->list.next to normal and writes enough events to wrap across two
sub-buffers (P1 and P2):

1. On the interrupt's first call to rb_handle_head_page(tail=3DP0, next=3DP=
1),
   rb_head_page_set_update() sees the outer update on P0->list.next and
   returns RB_PAGE_UPDATE.  The interrupt sets P1->list.next (P2) as the new
   head page and advances tail_page to P1, leaving P0->list.next in the
   update state.

2. When the interrupt fills P1 and calls rb_handle_head_page(tail=3DP1,
   next=3DP2), P1->list.next has the head flag set, so
   rb_head_page_set_update() succeeds and returns RB_PAGE_HEAD to the
   interrupt:

rb_handle_head_page(..., P0, P1)
  rb_head_page_set_update(..., P1, P0, ...)
  smp_store_release(&head_page, P1)
  <hardirq>
    rb_handle_head_page(..., P0, P1)
      rb_head_page_set_update() -> RB_PAGE_UPDATE
      rb_head_page_set_head(..., P2, P1, ...)
    ...
    rb_handle_head_page(..., P1, P2)
      rb_head_page_set_update() -> RB_PAGE_HEAD
      smp_store_release(&head_page, P2)  <-- moves head_page past P1
      rb_head_page_set_head(..., P3, P2, ...)
      rb_head_page_set_normal(..., P2, P1, ...)

At that point P1 is still in the update state from the outer writer, P3 is
the new head page, and cpu_buffer->head_page has been advanced to P2 (betwe=
en
P1 and P3).  Furthermore, when the outer writer resumes at
rb_head_page_set_head(..., P2, P1, ...), it transiently sets the head flag =
on
P2 before resetting it to normal.  A concurrent reader on another CPU calli=
ng
rb_set_head_page() starts its scan at P2, never sees P1's update flag, and
can swap out P2 (which is cpu_buffer->tail_page) or P3 while the outer writ=
er
is still in progress.

Also, if the interrupt arrives between rb_head_page_set_update() and
smp_store_release(&cpu_buffer->head_page, next_page), the interrupt sees
RB_PAGE_UPDATE and sets the new head page before cpu_buffer->head_page has
been updated from its stale value.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109032241.55e5=
7d26@fedora?part=3D1
