Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2EE453A2F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549615; cv=none; b=UH6iSLu04R+0+vpQYIWV1fEZq+9UEGhtJ0RX9D6EbAtDnSOVwpLoFPDL5OC67LnwI7VXLpF60F+k3nTd2OpEWP03k2Vsx+uJw/t52GDO98mc94nfVqhwGG4gk897CZwLeXROOFZIzybLqJDGw81tBwvYqIo4Wzz//EE3MVk4XxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549615; c=relaxed/simple;
	bh=jE6fdAmoyNVYryR5FQ29q9PuqK7fyQWERI0+PxvjnaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sebm0CEjYKTEBZRbKfzFcWitsQmYzKMqnwReTZF689+CMfC1eYTD3pPAGXxQhbz7kdPGdB6imo51WjegX96Luiwo3xKgN0/54jvU8L43QvPuXguWoTS2UiJkn7UGsuIXC7tpVS0HYu//keakxWonOW/JKoz1dTpfv1FYiCCknfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxFwpiTD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxFwpiTD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BD11F00A3D;
	Wed, 12 Aug 2026 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549613;
	bh=FLvxi43sS/jlFGwfnrN8oCmUbWal9PTDWjD3V1GTcW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WxFwpiTDh3DPc5UD3VbVaUMNKGtrv09A1BBTeyBHLTuLMR7+j4a8KRuURrYP7MoyM
	 LMmPUh1B+EpC4BMT/4J3pOcZsN981OP+WCPKaRlvoH7iRsTHYaG4Z0U0bFIGEGeos+
	 inkA2bVjt8w5fFf7dde06GtjcY75EmxO3VUd+kbEt5SJAloyV455TksEbOXv3bmRyk
	 Au4GSUxJlBYvn0E3IxPWoDpJSTuXVRHy4IZBjAFj/pzhXqgyU7bUy6xGnigIH2zQRD
	 fn1bI78IezN2MCQ1GGWQtexpUN1TjnbSgd2dhs43/Y6BeA/xbYih3RMefBJUPm2wJo
	 dAwEW/KUxD7Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/9] ring-buffer: Fix subbuf resize race in
 ring_buffer_alloc_read_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-5-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-5-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:46:53 +0000
Message-Id: <20260812154653.87BD11F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch is an incomplete fix for a race condition in `ring_buffe=
r_alloc_read_page()`. While it ensures newly allocated pages use `bpage->or=
der`, it entirely misses the branch where `cpu_buffer->free_page` is reused=
. This allows an undersized cached page to be paired with a newer, larger `=
bpage->order`, leading to heap buffer overflows during reads and out-of-bou=
nds frees when the page is released.
--

--- Patch [4]: [PATCH v4 4/9] ring-buffer: Fix subbuf resize race in ring_b=
uffer_alloc_read_page() ---
commit 28754c82212e5979b25cf6fac815748ff021a277
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Fix subbuf resize race in ring_buffer_alloc_read_page()

ring_buffer_alloc_read_page() is racy with ring_buffer_subbuf_order_set,
it can allocate a reader page with an outdated order. This isn't a big
issue, the user can still re-allocate a new reader page and try again.

However, what is more problematic is if the value of subbuf_order
changes in the middle of ring_buffer_alloc_read_page(). In that case,
bpage->order might not match the actual allocated memory.

Use bpage->order for the allocation to prevent this race.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 97449423d3a68..94552a433228d 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7018,7 +7018,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *bu=
ffer, int cpu)
>  	if (bpage->data) {
>  		rb_init_data_page(bpage->data);

[Severity: High]
This is a pre-existing issue, but does this path leave bpage->order
mismatched with the actual allocation size of cpu_buffer->free_page?

If ring_buffer_subbuf_order_set() updates buffer->subbuf_order to a larger
size before clearing cpu_buffer->free_page, ring_buffer_alloc_read_page()
might read the new larger order into bpage->order, but then claim an older,
smaller cpu_buffer->free_page:

kernel/trace/ring_buffer.c:ring_buffer_alloc_read_page() {
    ...
	bpage->order =3D order;
    ...
	if (cpu_buffer->free_page) {
		bpage->data =3D cpu_buffer->free_page;
		cpu_buffer->free_page =3D NULL;
	}
    ...
}

Could this lead to an overflow of dpage->data when reading events?

kernel/trace/ring_buffer.c:ring_buffer_read_page() {
    ...
			memcpy(dpage->data + pos, rpage->data + rpos, event_size);
    ...
}

It also appears this could cause an out-of-bounds free of bpage->data when
the page is released, since it frees using the mismatched bpage->order
instead of the page's actual allocation order.

Should we also verify the cached page's actual order matches bpage->order
before claiming it?

>  	} else {
> -		bpage->data =3D alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
> +		bpage->data =3D alloc_cpu_data(cpu, bpage->order);
>  		if (!bpage->data) {
>  			kfree(bpage);
>  			return ERR_PTR(-ENOMEM);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D4
