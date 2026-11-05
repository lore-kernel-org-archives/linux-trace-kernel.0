Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878314;
	b=uwGZxNxfKyIgTsLvHLrsxWK2yuROiNsixUvZBFauXWF9aBoJklrO2o9S9FYcXiS+O9hm
	 Y9WdHkJMXPnghymsG5bnlSzf6adOyGPDOVmjr+nbuJL77oAAoGTWHQmI5bO8k1NqcFPBw
	 2U7/wClFA839O3KFzEjURbcnwWnIbInZgvV15/EMbNan8OqXdpMrHitZogHQWx84dmtLS
	 46HGXLlZsTTNLUWjsQfNZsZiPIPB2XcZmDbwZLCk4MdvGYFRHdsARUNUlDoy1sYY13DFO
	 b8+96ukKex6qswRyPh3I1nR+1/MuTWv9bOz8kc2cZnp9eUNGI1SLpGdVxPtvsPZOqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878314;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OUcy9yxtLssZ6ZUmVYzGdoNzYLDLYmwTK/IrAFKR8bY=;
	b=WWTmS+y8rh+7rRLVa4iNEvrnjwzijhP14SxylZIPipJciUmi2dIyFaA7yfkEMZ5w40vW
	 jT3GoeDQbXwMzuBiVvoSvi7rM21IUnoLjsNdZWTR1SI5trWyPjYnQQ8xr7fCa1JfzCLQn
	 KCPrfMPs/a7g5lUOxooCLp19ao4lGUqnlhPtuc+w/t/MmyU6Y5aYQMowoMLq/Qm6dBMmU
	 Vi2/g5eQzSDHVkHi0RCiPibOe1AGJDDiF99eS5Ho7U+y552CWEZxVmCbFP5iwxyeUSLoG
	 cT80GMuTNsuweSHuCxgYOTIQ+Emsa8PxbVFrhFFgH5tXSPghBoJ5T73YZ/pl6wzDkdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsI7fH+i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0654606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 11:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsI7fH+i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F7F1F000C1;
	Thu,  5 Nov 2026 11:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878313;
	bh=OUcy9yxtLssZ6ZUmVYzGdoNzYLDLYmwTK/IrAFKR8bY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bsI7fH+iJ4mLU92c/kTaXY8ZCcMnWL9dhEo+ZGlOE/Tcx+p8GqT5jra+ZyJ1r+rLu
	 Zk8ov70mMG+M3/tlXZUY243w3XIMFVnO72jR+b6pLszrzfJlbywjbLfUiLdS4ZShEs
	 2ooKQfy85nOXuEtwJN7yTKudY0aBEZVWAGAQA2CPSC9jy0rIF3o3ku1SrG5LZOAV28
	 xMvIxpPigJRxlGRUBjin7anSpLWU0ycAl8YXfde2rwpZwMhh1O8pUPL2fT34eqFc5z
	 PQZ5dNo3eJGLgGDcmFHMYd/f8R+uRLhcbWXhSGyCQtXjBKPep0Q5XUa22eYwy5zM+I
	 TgiSjmJ3WudCQ==
Message-ID: <sashiko-outbox-198957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
References: <20261105-ring-buffer-head-moved-v2-1-05da40cebccc@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:31:52 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] ring-buffer: duplicate RB_PAGE_HEAD race in rb_handle_head_page()
--

commit 0a0249d6b3f6922c5b67d590d4639ec1b62531b2
Author: Breno Leitao <leitao@debian.org>

ring-buffer: Handle a reader taking the new head in rb_handle_head_page()

This commit updates rb_handle_head_page() to treat RB_PAGE_MOVED returned
by rb_head_page_set_head() the same as RB_PAGE_HEAD and RB_PAGE_NORMAL
when a concurrent reader swaps out new_head after a nested writer already
marked it as the head page.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee1..44782b7166472 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3783,10 +3783,13 @@ rb_handle_head_page(struct ring_buffer_per_cpu *c=
pu_buffer,
>  	 *            1) We really set it.
>  	 *            2) A bunch of interrupts came in and moved
>  	 *               the page forward again.
> +	 *  MOVED  - another writer set it, then a reader on
> +	 *           another CPU swapped it for its reader page.
>  	 */
>  	switch (ret) {
>  	case RB_PAGE_HEAD:
>  	case RB_PAGE_NORMAL:
> +	case RB_PAGE_MOVED:
>  		/* OK */
>  		break;
>  	default:

[Severity: High]
As reported by Sashiko on v1 [1], does handling RB_PAGE_MOVED here cover
the case where the reader swaps out the new head page before the writer
loads new_head via rb_inc_page(&new_head)?

In rb_handle_head_page(), new_head is loaded right before calling
rb_head_page_set_head():

	new_head =3D next_page;
	rb_inc_page(&new_head);

	ret =3D rb_head_page_set_head(cpu_buffer, new_head, next_page,
				    RB_PAGE_NORMAL);

rb_head_page_set_head() only returns RB_PAGE_MOVED if the reader swaps
new_head out in the narrow window between rb_inc_page(&new_head) and the
cmpxchg in rb_head_page_set_head().

If the reader swaps the page out in __rb_get_reader_page() before
rb_inc_page(&new_head) executes (either while the outer writer is
interrupted after rb_head_page_set_update(), or before a nested interrupt
writer reaches rb_inc_page(&new_head)), __rb_get_reader_page() sets
RB_PAGE_HEAD on reader_page->list.next and replaces next_page->list.next
with &reader_page->list | RB_PAGE_NORMAL:

	rb_set_list_to_head(&cpu_buffer->reader_page->list);
	...
	ret =3D rb_head_page_replace(reader, cpu_buffer->reader_page);

When the writer then executes rb_inc_page(&new_head), it loads the newly
spliced reader_page as new_head.  rb_head_page_set_head() then matches
&reader_page->list | RB_PAGE_NORMAL, sets next_page->list.next to
RB_PAGE_HEAD, and returns RB_PAGE_NORMAL instead of RB_PAGE_MOVED.

In the recovery check that follows:

	if (ret =3D=3D RB_PAGE_NORMAL) {
		struct buffer_page *buffer_tail_page;

		buffer_tail_page =3D READ_ONCE(cpu_buffer->tail_page);
		/*
		 * If the tail had moved passed next, then we need
		 * to reset the pointer.
		 */
		if (buffer_tail_page !=3D tail_page &&
		    buffer_tail_page !=3D next_page)
			rb_head_page_set_normal(cpu_buffer, new_head,
						next_page,
						RB_PAGE_HEAD);
	}

cpu_buffer->tail_page is still either next_page (if the nested writer
moved the tail) or tail_page (if the nested writer interrupted after the
outer writer's second cmpxchg), so rb_head_page_set_normal() is not
called.  Wouldn't that leave RB_PAGE_HEAD set on both next_page->list.next
and reader_page->list.next simultaneously?

[1] https://lore.kernel.org/r/20261102-ring-buffer-head-moved-v1-1-16597379=
0be4@debian.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-ring-buffe=
r-head-moved-v2-1-05da40cebccc@debian.org?part=3D1
