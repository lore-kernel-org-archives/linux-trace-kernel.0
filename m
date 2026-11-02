Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631131;
	b=DDbQF/f2Sf8YnFopkSOhpYgCiNi0MBXu0vaPPFiS2NG8vkzrZaCbbevPodn7hfJlID2R
	 UGCgA7paQVjLsP/kINnpbuz4peogoReYwin6MIwfj42BzxVe4e6h+m3zZM4h9VWtl+r1e
	 d4OTXcvhiGB5zbITc6vG+SV/EzQYy2KMa2R0ygmauDecuykaB9T7gpHGYj040EEypkllo
	 aL2imK/pmibRa2X2wnNczWMp0WmD0YNnJLG6SCKTEj5NU8mweNUYvOZ9AtaHGJpwi30ao
	 xQC0x666EHxmGtsSUPmqS0/oTq12yk3QmazPSZx4CSmcYYa3N4UonSiICpMAbvwNkFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+HCttoGBkWTUHlmHnmibkOpVEkp8uKTJs3rKwln8Eg=;
	b=FtAlkgdAYZKDpmJLNIFV+SQ4x0GuVrOuGO7DR7SmeHHiEQ3WckyZiT+PuQoHBHlp6xjC
	 5txuQzsTl0p90WXvrgpDK9ifpKUB5mHfULMHoyReGIEUJ60OD3o3TrWUctVctXE+QIvO2
	 y8ywvaiHnIsYouyxz74l19FWrJtLLqY7/FE+dzmpBVYdEB/zd61s4ZCfIMlofcUZb1jF4
	 tseL7RLPivVw4tKrVscAZI9HqL+ae2etBj/myLejUdY9+ADvJ8YOTBPRwt+zeiDmY4Im9
	 l18vIChnTX/PG0KjvpRsZNLswOZMTb8bXB0Nee1AkyfZgYANzBvBd8DFl5sXtVzhrSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOrvWTVM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C722A606D808
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kOrvWTVM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857801F00A17;
	Mon,  2 Nov 2026 14:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793631130;
	bh=5+HCttoGBkWTUHlmHnmibkOpVEkp8uKTJs3rKwln8Eg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kOrvWTVMJJ/G40x+9Qg3oty/R3/aG+57H6y/+6s3MDWlTYQjbgIMYpXPAFzkQXdPl
	 9Ul/eFzQRT9yBreQ7mwA2/BGaNxtqtT2An+rMZ6WEvhXcxH6RvKHfzoC/9feJ4y/YM
	 BWJ3YEDbqR87dprdxfraaRzIRgcyEn4t/JiVVg1FmiF1dLXSnNprBZcAwNzdv93pmb
	 4+0kItiPbU9Sp5rEwPJFTF07bnfkXjLvj0m6EAkuu/espGHhIeA4pjXHZnFRXxs1pr
	 k3WSQnLMu3VoUA0Tl5dG25oClw7ox+mu/wAjIAhnDc3fs68oye6X3+mPmukoQZrlZC
	 5FFBhgHdMCMeQ==
Message-ID: <sashiko-outbox-193612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ring-buffer: Handle a reader taking the new head in
 rb_handle_head_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org>
References: <20261102-ring-buffer-head-moved-v1-1-165973790be4@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 14:52:10 +0000
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

commit 06572f261acc9f999487d8e50d79b22b59309351
Author: Breno Leitao <leitao@debian.org>

ring-buffer: Handle a reader taking the new head in rb_handle_head_page()

This patch handles RB_PAGE_MOVED returned from rb_head_page_set_head() in
rb_handle_head_page() when a nested interrupt writer advances the head page
and a concurrent reader swaps out new_head before the outer writer completes
its second cmpxchg.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee1..7a60fa175e2cc 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3789,6 +3789,15 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cp=
u_buffer,
>  	case RB_PAGE_NORMAL:
>  		/* OK */
>  		break;
> +	case RB_PAGE_MOVED:
> +		if (type =3D=3D RB_PAGE_HEAD) {
> +			ret =3D rb_head_page_set_normal(cpu_buffer, next_page,
> +						      tail_page,
> +						      RB_PAGE_UPDATE);
> +			if (RB_WARN_ON(cpu_buffer, ret !=3D RB_PAGE_UPDATE))
> +				return -1;
> +		}
> +		return 1;

[Severity: High]
Can the same race with a nested writer and concurrent reader leave two pages
in the ring buffer with RB_PAGE_HEAD set simultaneously if the reader swap
happens before new_head is loaded, or when an interrupting writer sees
type =3D=3D RB_PAGE_UPDATE?

In kernel/trace/ring_buffer.c:rb_handle_head_page(), the outer writer sets
tail_page->list.next to RB_PAGE_UPDATE before computing new_head:

	type =3D rb_head_page_set_update(cpu_buffer, next_page, tail_page,
				       RB_PAGE_HEAD);

	switch (type) {
	case RB_PAGE_HEAD:
		local_add(entries, &cpu_buffer->overrun);
		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
		local_inc(&cpu_buffer->pages_lost);

		if (cpu_buffer->ring_meta)
			rb_update_meta_head(cpu_buffer, next_page);
		break;
	...
	}

	new_head =3D next_page;
	rb_inc_page(&new_head);

	ret =3D rb_head_page_set_head(cpu_buffer, new_head, next_page,
				    RB_PAGE_NORMAL);

Once rb_head_page_set_update() sets tail_page->list.next to RB_PAGE_UPDATE,
if the nested interrupt writer and concurrent reader swap happen before
rb_inc_page(&new_head) reads next_page->list.next:

1. The nested interrupt writer sees RB_PAGE_UPDATE, sets next_page->list.ne=
xt
   (pointing to the old new_head) to RB_PAGE_HEAD, and advances
   cpu_buffer->tail_page from tail_page to next_page in rb_move_tail() ->
   rb_tail_page_update().

2. The concurrent reader in rb_get_reader_page() -> __rb_get_reader_page()
   swaps the old new_head out for its empty reader_page, setting
   reader_page->list.next to the following page with RB_PAGE_HEAD and setti=
ng
   next_page->list.next to &reader_page->list with RB_PAGE_NORMAL.

3. The outer writer resumes and executes rb_inc_page(&new_head), which loads
   the newly spliced reader_page from next_page->list.next.

4. rb_head_page_set_head() then matches &reader_page->list | RB_PAGE_NORMAL,
   sets next_page->list.next to &reader_page->list | RB_PAGE_HEAD, and
   returns RB_PAGE_NORMAL instead of RB_PAGE_MOVED.

5. The subsequent tail check does not clear the extra RB_PAGE_HEAD flag
   because the single nested interrupt only moved cpu_buffer->tail_page to
   next_page:

	if (ret =3D=3D RB_PAGE_NORMAL) {
		struct buffer_page *buffer_tail_page;

		buffer_tail_page =3D READ_ONCE(cpu_buffer->tail_page);
		if (buffer_tail_page !=3D tail_page &&
		    buffer_tail_page !=3D next_page)
			rb_head_page_set_normal(cpu_buffer, new_head,
						next_page,
						RB_PAGE_HEAD);
	}

A similar sequence also appears possible when the outer writer sets
next_page->list.next to RB_PAGE_HEAD, the reader swaps that page out for
reader_page, and an interrupting writer arrives before the outer writer
updates cpu_buffer->tail_page. The interrupting writer enters
rb_handle_head_page() with type =3D=3D RB_PAGE_UPDATE (or hits the new
RB_PAGE_MOVED path and returns 1 without advancing cpu_buffer->tail_page,
immediately retrying on the same tail_page), loads new_head as the spliced
reader_page, and marks next_page->list.next as RB_PAGE_HEAD while
buffer_tail_page is still tail_page.

In both cases, wouldn't both next_page->list.next and reader_page->list.next
be left marked with RB_PAGE_HEAD, corrupting the ring buffer list state and
triggering RB_WARN_ON() in rb_set_head_page() or __rb_get_reader_page()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-ring-buffe=
r-head-moved-v1-1-165973790be4@debian.org?part=3D1
