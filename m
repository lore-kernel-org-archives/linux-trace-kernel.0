Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF95453A2F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549621; cv=none; b=OAUi8jRnKZTaUlK9T78i0BIxdGB79SJglJOxchk3/TmJClf9VcUIQT0Cu/DWPg5x0gDyLxz3uqI0n0Fbxrfc5wgvJPjkpLp7EdT/qV45+8X4fBAirF8gUPqnmZadDE8xT719RopKAEUFmDt1tXJS+1xqZ6SY9FXE+9Ep4Y1QAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549621; c=relaxed/simple;
	bh=YXpGHBRzju+EFLrNueJ4YK+WqWGwIFpEVlA8gngs3C4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LG2+EcjTY28xfAzmEPccpmdwmU/i3qfgFH1+9zFBlulgaFGJAhMwNk1YC1stDy+ztb4io9Yi6kdN0s5zpXXznwRgJFTPoiGmY6ZA5zYeQ1ub/MXuv3eJ4AGh+0r0aZDXi+712A2YOnqv1OWTl79XuZWZbINq3nN7bO5ksOuPmK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efxP2kC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efxP2kC3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3081F00A3F;
	Wed, 12 Aug 2026 15:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549619;
	bh=SeK0xRgUvUsAD2+oi00QfsTwipZHZBmUyw5W/PVUFP8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=efxP2kC3spSW42L3WOxaoON61+zGNwKaHkNR/DQJ9UG7gK5V9SOLcphCIEW9izGAk
	 DhIzqWPXwUtvvgFLri75+wTdECMB2G8LpfhkBvigTayEMVp2kPKdk3hifLLniZWraX
	 K3D+P8GTvoOuY9HuoapRZXhVGaun73XzJovEIymHkixz6qBhHDnHuom0+ABARzdRTu
	 XtU10iCJuK5w4kbzWDseYC360BPdGt7nUovvjCKis5c+0BvWVcr3RMaVVY0zc7uYB1
	 M9jhmuhFqiMcjpBzXtTn4rw3Jvxc9t4yWcQ6FaI8uDy5MFPk6cugkQvLFFpmn6PFXM
	 saEHMvpbVADGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/9] ring-buffer: Hold cpu_buffer::lock when resizing
 a subbuf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812153311.2328812-3-vdonnefort@google.com>
References: <20260812153311.2328812-1-vdonnefort@google.com>
 <20260812153311.2328812-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:46:58 +0000
Message-Id: <20260812154659.3E3081F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch attempts to fix a race with `cpu_buffer->free_page` =
by adding an `arch_spin_lock(&cpu_buffer->lock)`, but it leaves a severe Ti=
me-Of-Check to Time-Of-Use (TOCTOU) race unaddressed. `buffer->subbuf_order=
` and `buffer->subbuf_size` are updated globally outside of any per-CPU loc=
k. If a reader (like `tracing_buffers_splice_read`) calls `ring_buffer_allo=
c_read_page()` concurrently, it locklessly reads the NEW `buffer->subbuf_or=
der` but then retrieves the OLD, incorrectly-sized `free_page` from the loc=
ked cache. When `ring_buffer_read_page()` uses this page, it copies data up=
 to the NEW `buffer->subbuf_size`, leading to a heap buffer overflow if the=
 new order is larger. Similarly, `ring_buffer_free_read_page()` validates `=
data_page->order` locklessly; if the global order changes just after the ch=
eck, it inserts a new-order page into `free_page`, which `ring_buffer_subbu=
f_order_set()` will later free using the `old_order`, corrupting the page a=
llocator.
- [High] The patch adds an unconditional `arch_spin_lock(&cpu_buffer->lock)=
` to `ring_buffer_subbuf_order_set()`. This creates an NMI deadlock window.=
 If an NMI (e.g., from a watchdog or an Oops triggering `ftrace_dump_on_oop=
s`) fires on the same CPU while this lock is held, the NMI handler may atte=
mpt to read the ring buffer. The read path (via `ring_buffer_peek()` -> `rb=
_buffer_peek()` -> `__rb_get_reader_page()`) unconditionally acquires the s=
ame `cpu_buffer->lock` using `arch_spin_lock()` without an NMI-safe trylock=
 fallback. Because the interrupted context holds the lock, the NMI handler =
will spin forever, causing a hard lockup.
--

--- Patch [2]: [PATCH v4 2/9] ring-buffer: Hold cpu_buffer::lock when resiz=
ing a subbuf ---
commit 1db68f92346fd21f55d54529fb97b920f02a0136
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Hold cpu_buffer::lock when resizing a subbuf

This commit adds an arch_spin_lock() around the clearing of
cpu_buffer->free_page in ring_buffer_subbuf_order_set(). This aims to
prevent races with ring_buffer_alloc_read_page() and
ring_buffer_free_read_page() during sub-buffer resizing.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a3d28b2e2c94a..ec4f5a0c93e85 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7431,8 +7431,10 @@ int ring_buffer_subbuf_order_set(struct trace_buff=
er *buffer, int order)
>  		cpu_buffer->nr_pages =3D cpu_buffer->nr_pages_to_update;
>  		cpu_buffer->nr_pages_to_update =3D 0;
> =20
> +		arch_spin_lock(&cpu_buffer->lock);

[Severity: Critical]
This is a pre-existing issue, but is there a Time-Of-Check to Time-Of-Use
(TOCTOU) race between the global order updates and this per-CPU lock?

Earlier in ring_buffer_subbuf_order_set(), buffer->subbuf_order and
buffer->subbuf_size are updated globally outside of any per-CPU lock.

If a reader like tracing_buffers_splice_read() calls
ring_buffer_alloc_read_page() concurrently, can it locklessly read the new
buffer->subbuf_order, but then retrieve the old, incorrectly-sized
free_page from the locked cache?

When ring_buffer_read_page() uses this page, wouldn't it copy data up to
the new buffer->subbuf_size, leading to a heap buffer overflow if the new
order is larger?

Similarly, ring_buffer_free_read_page() validates data_page->order against
buffer->subbuf_order locklessly. If the global order changes right after
the check, could it insert a new-order page into free_page, which
ring_buffer_subbuf_order_set() will later free using the old order,
corrupting the page allocator?

[Severity: High]
This is also a pre-existing issue, but does adding this unconditional
arch_spin_lock() widen an NMI deadlock window?

If an NMI (such as a watchdog or an Oops triggering ftrace_dump_on_oops)
fires on the same CPU while this lock is held, the NMI handler may attempt
to read the ring buffer.

The read path via __rb_get_reader_page() unconditionally acquires the same
cpu_buffer->lock using arch_spin_lock() without an NMI-safe trylock
fallback.

Because the interrupted context holds the lock, will the NMI handler spin
forever, causing a hard lockup?

>  		old_free_data_page =3D cpu_buffer->free_page;
>  		cpu_buffer->free_page =3D NULL;
> +		arch_spin_unlock(&cpu_buffer->lock);
> =20
>  		rb_head_page_activate(cpu_buffer);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153311.2328=
812-1-vdonnefort@google.com?part=3D2
