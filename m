Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585817;
	b=3PwNNHV+we0peuxBB0HaiKzlzhArfmcMLbcnKFarEgY2kzzKANnmpP9OOrigJ0Qq38xv
	 Y1kK5AfIIBp0Ex95eQOUrpD9kq5RsG7n7DoBzbpvN6o+49ahrW2JrRGqRppOY8lvcA6Nf
	 yMaajhSL+1kO7TpSZoUl7hrt2NNwP1DDKpOOWeisXlDQnTuuh03Cqpw3FsKfF0sjrWCtj
	 KXR8fZX/EjrnHWrA6KL9aUqbV8q+qtd+GKPnzoZuS2YHEW0waTGDBvdcRA4pNjvSPhkIe
	 yBa1rsRQUu2n/XywahtcP+UAlhMdN2GoSkVToiAMcKjMDOpSxdprBNqbs9JkBy7d0SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XeENNbwPh9bLkMXZ7EhqeqDPUfhlLCVs65BML8PC5/Y=;
	b=kzvNPLec4CFNa88/M9dHN2v4uQtdnE4tgI98GZ4QlHNyKFg6EaUNvaSCuzWikbmO0KJk
	 OkrFzEArA/lVlCnjH+eXtC+9/2oqEPshU1V46jN6dNZimXrkJk+tL5rndeSZ/MvWZvyk3
	 xuCXrkcUA4zJ+v33PuotFcBSrQn8xwjmBvjZfVdR2tYPfMRmHkZJ4Z9GyQK7c4GpZypsK
	 /tjALlPWCr1dzb1D4ecbNN3/jMHfjTc0KjDUBealAJ5fUiYiXLW25RDTs7h7QgjeyPhg7
	 3eOzpQwYjOG6bWRckoV4qyNlG7+3SoO/RaSNn+yg90m8RK020YGkw+hVKpNoCtwSqQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHNfONeA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1632960A2616
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 16:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GHNfONeA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B63251F000C5;
	Fri, 13 Nov 2026 16:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585816;
	bh=XeENNbwPh9bLkMXZ7EhqeqDPUfhlLCVs65BML8PC5/Y=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=GHNfONeATYMtFKfLSVyi6Q51G0XW4nkrwYuq3m9Vdmee52/6wVUaiKHLfdFvLEBje
	 xj0j+hZW1VCizj/uQfVLc/z/LRv3/YcnEK85E+iAt/qlJxIlssPZFW2/MdE2VQhO18
	 LlAAzdfpBsKGMUKeNU1Rn1WdA9PMG7AhUNCQmayqF7RGO/3q1oJK9G9zYbabgPT83s
	 yBew12JlfCMMGaoXk7BFa/RFaqTNXMubvriRGWDohmAnNqZ+FO4SdlahBk2gYNNqgS
	 ixGoKSoV+Wt4Pu1Xa6ea16v5L6WoB0aHyfN8TcsAUe8McxUtEuh/i/YHHJHsy4uDSI
	 jz2tgVjn2POFQ==
Message-ID: <sashiko-outbox-213147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] ring-buffer: Check remote reader page commit
 before meta entries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113152729.837429-3-vdonnefort@google.com>
References: <20261113152729.837429-1-vdonnefort@google.com>
 <20261113152729.837429-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 16:03:36 +0000
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
- [Medium] ring-buffer: rb_num_of_entries() underflow when commit
  precedes meta entries
--

commit 1d2d0e6ae01d518c30dc9986893db113c38a4caf
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Check remote reader page commit before meta entries

This commit reorders the checks in __rb_get_reader_page_from_remote() to
inspect the current reader page commit offset before checking if
rb_num_of_entries() is zero, and adds memory barriers pairing page::commit
and meta::entries between simple_ring_buffer_commit() and the remote reader.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 3c7aa982d43e9..f70010e2ede77 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -5825,8 +5823,13 @@ __rb_get_reader_page_from_remote(struct ring_buffe=
r_per_cpu *cpu_buffer)
>  {
>  	struct buffer_page *new_reader, *prev_reader, *prev_head, *new_head, *l=
ast;
> =20
> -	if (!rb_read_remote_meta_page(cpu_buffer))
> -		return NULL;
> +	rb_read_remote_meta_page(cpu_buffer);
> +
> +	/*
> +	 * Order meta::entries read before page::commit, most likely paired with
> +	 * simple_ring_buffer_commit().
> +	 */
> +	smp_rmb();
> =20
>  	/* More to read on the reader page */
>  	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_pag=
e)) {
> @@ -5835,6 +5838,9 @@ __rb_get_reader_page_from_remote(struct ring_buffer=
_per_cpu *cpu_buffer)
>  		return cpu_buffer->reader_page;
>  	}
> =20
> +	if (!rb_num_of_entries(cpu_buffer))
> +		return NULL;

[Severity: Medium]
Can rb_num_of_entries() underflow to ULONG_MAX when an event is consumed in
the window between the page->commit update and the meta->entries increment?

CPU0 (writer)                       CPU1 (reader)
-------------                       -------------
simple_ring_buffer_commit()
  local_set(&page->commit, write);
                                    ring_buffer_consume()
                                      ...
                                      __rb_get_reader_page_from_remote()
                                        rb_read_remote_meta_page()
                                          /* caches entries =3D N */
                                        reader_page->read < rb_page_size()
                                          return reader_page;
                                      rb_advance_reader()
                                        cpu_buffer->read++; /* N + 1 */
  simple_rb_meta_inc(meta->entries, 1);

At this point cpu_buffer->read is N + 1 while cpu_buffer->entries is still =
N,
so rb_num_of_entries() evaluates N - (N + 1) =3D ULONG_MAX:

kernel/trace/ring_buffer.c:rb_num_of_entries() {
	return local_read(&cpu_buffer->entries) -
		(local_read(&cpu_buffer->overrun) + cpu_buffer->read);
}

Until rb_read_remote_meta_page() runs again, ring_buffer_entries() returns
ULONG_MAX and ring_buffer_empty() returns false on an empty buffer (which
also prevents trace_remote_try_unload() from unloading an idle buffer).  If
__rb_get_reader_page_from_remote() is called again before CPU0 increments
meta->entries, !rb_num_of_entries() evaluates to false and it proceeds to
swap_reader_page() on an empty buffer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113152729.8374=
29-1-vdonnefort@google.com?part=3D2
