Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693642472B6
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629281; cv=none; b=cNbr/qbfjbWnd/0p5T3CzwYuzKWTj0weu9il5Scsyf2sgYXCwxqDm/+HpGhmNgLZws8fUrk6TAAIcIYqWtov599z1U6QpWHEzaZqzF3B8abclYto8SBh760BlK8wpVEANkWnLnAOSFlR96fy769jxkWutGMLR/BEW9c4/lfuPn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629281; c=relaxed/simple;
	bh=oYYh+xtw+Ni/0G6WphOQdA01oQWf85+mQbiqn17MyMc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LIx6WMEr6AeQou/YKtVTWyMS6L7+3Wl1pXnxyfMDi+DC3fo4vOOl+KbrkVd5xSmy7z7A3EQBdNlxyQuVlVT09MQ48cdLqNdetTvLgVMVOovOvYNe+PvdmaA2SUgJlszUFlu8bRj3utKLuzKGKYmvcsYWF6E8oNw1GT1WMQFAdJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohgukKlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohgukKlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42E01F000E9;
	Thu, 13 Aug 2026 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629280;
	bh=i10DBpY8TblJA+ajP/lsy2Y/qXgecUeKczQjnCejPWM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohgukKlDOaV0Wo5Ym/1Kk75robnBpViNmgT8b9F2ms0W85U1hWOdN60kdL57kJRGJ
	 TRghYktt34CslGLQUuDll7+JGMIaBMYbSkaPeoLZ/9X0eQrUVEE3Vj0KYtSXkvGAnz
	 jERBCOsMlHrJrRprpl7xWU7Wb+aJfI7+HIFXzqs+M7ZWYMPwfpOQLoe33uM4saMP+Q
	 DfKofeMIMFto8W1HcosncWZKiLecirwXWqmlxQMpGgNi9V4FW6iY/IMpHCJG8PuUXL
	 qeFrWjz0mJ5hOYxVET8EajnBo6jlRuoLHaHY6B+ZcKrxhUoP7soJycLjlMHufWTeCd
	 USEZjhCRulYLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page with
 subbuf_order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813131152.3589632-2-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 13:54:39 +0000
Message-Id: <20260813135439.E42E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] A data race and locking mismatch between `ring_buffer_subbuf_o=
rder_set()`, `ring_buffer_alloc_read_page()`, and `ring_buffer_free_read_pa=
ge()` allows `cpu_buffer->free_page` to cache a page of an old order while =
`buffer->subbuf_order` reflects a new larger order. This leads to heap buff=
er overflow and buddy allocator corruption.
--

--- Patch [1]: [PATCH v5 01/10] ring-buffer: Free cpu_buffer::free_page wit=
h subbuf_order ---
commit f550c0bfeadcc22eca47316e1820b4d91f6ef261
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Free cpu_buffer::free_page with subbuf_order
   =20
When sub-buffers use an order greater than 0, cpu_buffer->free_page is
allocated with subbuf_order. Use the correct order for
cpu_buffer->free_page.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 2667992f0aa29..a3d28b2e2c94a 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_p=
er_cpu *cpu_buffer)
>  		free_buffer_page(bpage);
>  	}
> =20
> -	free_page((unsigned long)cpu_buffer->free_page);
> +	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->su=
bbuf_order);

[Severity: Critical]
This is a pre-existing issue, but does this change expose a buddy allocator
corruption if cpu_buffer->free_page contains a page of a smaller order than
buffer->subbuf_order?

A race condition between ring_buffer_subbuf_order_set() and=20
ring_buffer_free_read_page() can cause a smaller order page to be stashed in
cpu_buffer->free_page while buffer->subbuf_order reflects a new larger
order.

If a trace reader calls ring_buffer_free_read_page(), it performs a lockless
check of buffer->subbuf_order:

kernel/trace/ring_buffer.c:ring_buffer_free_read_page() {
    ...
	if (page_ref_count(page) > 1 || data_page->order !=3D buffer->subbuf_order)
		goto out;
    ...
}

If a concurrent write to buffer_subbuf_size_kb calls
ring_buffer_subbuf_order_set(), it updates buffer->subbuf_order without
holding cpu_buffer->lock, and clears cpu_buffer->free_page under
reader_lock.

The trace reader then acquires cpu_buffer->lock and stashes the old smaller
page into cpu_buffer->free_page, missing the clearance because of the lock
mismatch (reader_lock vs cpu_buffer->lock):

kernel/trace/ring_buffer.c:ring_buffer_free_read_page() {
    ...
	raw_spin_lock_irqsave(&cpu_buffer->lock, flags);
	if (!cpu_buffer->free_page) {
		cpu_buffer->free_page =3D dpage;
    ...
}

During teardown, free_pages() here would free the undersized page using the
new larger order, causing buddy allocator corruption. Additionally, if a re=
ader
allocates this stashed page via ring_buffer_read_page(), it is swapped into
the active ring buffer where writers will overflow its bounds.

Can the locking be synchronized to prevent caching an old-order page?

> =20
>  	kfree(cpu_buffer);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813131152.3589=
632-1-vdonnefort@google.com?part=3D1
