Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43532EEE80
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549839; cv=none; b=sSj9zAksVfPQeit4Ude4mC+pgNqt86c88DwvCRaJPz2OychG/Wk9QjPseFm/AYk15WyPbIEBH3xKegzSeoXV3ssPH827VsNlEXjpL1pYYPqocC99Stkxui41mQgPDYh982Bkuz+2yEtlX/k23W2W2JXiyQt0DZo+UALhHQVocKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549839; c=relaxed/simple;
	bh=CH9RfYmrzTDweBmCvwGXyCZ1Mr/x6oXi19Mwt4aTmpE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGEtVnjHcIelSGa4qzeez87aHhhjcfPNcCcjkIk/QOubeX1fE6qQw3GAeAclutExpMm1AGd4SlMY/uEMtxhvVrxvyBl+xLt24GZ34avSmuOPvU0zg8bbOgPohVD/xGcEX2d9FlC/R68WskqCxamjCv8pZENm5j/iuFENzzNryEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkwaHLlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkwaHLlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516A31F000E9;
	Wed, 12 Aug 2026 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549838;
	bh=7bLVmUiqleuI1Xhrohc7JlnyHfdl8p8kN+pQSc7XV/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JkwaHLlP7B6wq6yb3RCzRNREHb5trqTkmeZCkSL1DT9T1uFvIaRl2TscULSxa8X01
	 PRKluo/rhqFK0484MMBrhdFuNde5hCRZVTRF+MIhBwXXgExjrEqBvvQRmbujzXoB5U
	 m2WpoartCEN20Ottm+Ms35tfhtGdIooyEeYx6zOZHG3wc3RfOcvn2Qvczf8nunGJOG
	 HgkHSdVgyZZj02zyMeovWlxrVfFl7pnXIAQO4/U/066YyIg2ew6VP949PpLMthO7xp
	 tfJ59oJMapvAVU7ARwQFYvx1b50jccIcN0iAbBK6OHcSp6VXb4qD7I4+kgRbCIc/Bl
	 WhRnz31weBY8g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] ring-buffer: Free cpu_buffer->free_page with
 subbuf_order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-2-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:50:37 +0000
Message-Id: <20260812155038.516A31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Concurrent execution of sub-buffer order resizing (`ring_buffe=
r_subbuf_order_set`) and read operations (`ring_buffer_alloc_read_page`, `r=
ing_buffer_read_page`) can lead to out-of-bounds writes, use-after-free, an=
d page allocator corruption due to mismatched synchronization.
--

--- Patch [1]: [PATCH v4 1/9] ring-buffer: Free cpu_buffer->free_page with =
subbuf_order ---
commit 4100674474d6bd293fb872fecb17fc781ca58502
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Free cpu_buffer->free_page with subbuf_order
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
This isn't a bug introduced by this patch, but is it possible for a race
condition between resizing and reading to lead to memory corruption?

If thread A changes the sub-buffer size via
/sys/kernel/tracing/buffer_subbuf_size_kb, ring_buffer_subbuf_order_set()
updates buffer->subbuf_order locklessly globally before tearing down the CPU
buffers and clearing their free_page.

If thread B concurrently reads /sys/kernel/tracing/per_cpu/cpu0/trace_pipe_=
raw
via tracing_buffers_read(), it observes the new order and calls
ring_buffer_alloc_read_page().

Because ring_buffer_subbuf_order_set() hasn't yet cleared
cpu_buffer->free_page for this CPU (they use distinct locks), thread B pops
the old page from free_page but tags it with the new order:

kernel/trace/ring_buffer.c:ring_buffer_alloc_read_page() {
    ...
    bpage->order =3D buffer->subbuf_order;
    ...
    if (cpu_buffer->free_page) {
        bpage->data =3D cpu_buffer->free_page;
        cpu_buffer->free_page =3D NULL;
    }
    ...
}

Thread B then calls ring_buffer_read_page(). The lockless check passes
because both match the new order:

kernel/trace/ring_buffer.c:ring_buffer_read_page() {
    ...
    if (data_page->order !=3D buffer->subbuf_order)
        return -1;
    ...
    reader->page =3D data_page->data;
}

Could this allow the undersized old page to be swapped into the ring buffer
as the reader_page, leading to an out-of-bounds write when a writer attempts
to write large events?=20

It seems it could also cause page allocator corruption when a smaller page
is later passed to free_pages() with a larger order.

>  	kfree(cpu_buffer);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D1
