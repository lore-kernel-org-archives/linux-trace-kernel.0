Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584101;
	b=fABppmQm7W+OVcZP79kw9DHKug1VmdwIIwiAJzNWfQ55co783pvWCQla6+Mu5LF8DfIo
	 +wuNf+7Y2rNArXr+kEMz80WYxHX7x3PwvyaQzFNXKYqnW0zwHNx9pQazDuVU7RTSs76t/
	 xXu7bW6eQn0D5dwC7Q5axs/8KT7FBeqID5m36D29oBL/xaG8yr2OETTYWW+pNYkRoIxhG
	 G/hQiFN+0FmmYbAF9jBc20SVO5dfInSWpO2klA07KFXcZb7bmCBmcsRnltaWr+bmBvPe6
	 22fXUZgPQe5UeY+r2d+ltaBDt8Jn/vzpZ8eruNCGVpvcWXVflx3dvG0UZD88BMfaVXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ex9H280pJD2h2Gzs6IZptzHWpDjeu15cL1MfkhM3C4I=;
	b=iohuLKicgXIPsDSJSWgHl34yi+5bUNOsyYz926DOW54kkAZ+6l0vv/qj5QtW/dzPLtUf
	 t/UVNzLcbwvJ2vCYiTObYVCt3wC1wayq5TNWU+X4AV2JuC40xGVp4Lbvle7+g8tHJPGxC
	 uHhTDikJCHBUOdpmB3yGQF57mea/iGmo3LsKYb5KntGdDzUK/OhkDmuQKaitzq0h3Mzly
	 ffrbClPpYlpKDmSbIAHmIQKgMvuZ8ClZhbnE3BrLhF8stCjGLzKgfQIjK5T2Q6DnIDtqQ
	 hJ75kDPVhjkoTyjeRVotTMsAWf3whsm8Aa9dCLGZ9V5Dc2k+hskoRwGXbK/it5CBOJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnQLhKSX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023B606A32D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnQLhKSX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6556C1F000C4;
	Fri, 13 Nov 2026 15:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794584100;
	bh=ex9H280pJD2h2Gzs6IZptzHWpDjeu15cL1MfkhM3C4I=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KnQLhKSXMPDwx5MQ84MAaiGvmg7bCOMDXVuLNxjHsHEl+yQEMlMWlWx/UAxuEBdj8
	 3WRlsqGGn7CeM8IK0PbsoVM48ZF4O7iH6ISOlYtuklxVgcsp1vHDOglev0H+gZMcWC
	 vlkv5I0OYOoR05Y68WK7Uh2aEvxkvtYXZ0Wsz32Ipf/GN8JtOYBeQeNkJztpDEg6m6
	 QDhcF5JhQaaTHVApDWu0tg9NEJPmRidsAH8aICwmV4CmM0qmIBQtFtqO86+bP3zHUy
	 pUNsqsLudM8M7Gr/AN8X1RHMn+8OXN+2+X1bUbxhtxytkpLIXd57oNqG7wwrLaiEGc
	 bzU8LiGPjOrQQ==
Message-ID: <sashiko-outbox-213099@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/4] ring-buffer: Order remote page commit with data
 and timestamp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113152729.837429-4-vdonnefort@google.com>
References: <20261113152729.837429-1-vdonnefort@google.com>
 <20261113152729.837429-4-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:34:59 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] tracing: out-of-bounds write in simple_rb_reserve_next()
  [1]
--

commit b0c88540d75d93c7a85149df8d188a1bfaa9a89e
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Order remote page commit with data and timestamp

This commit adds memory barriers between page::commit, page::data, and
page::time_stamp for remote ring-buffers and defers updating read_stamp
until committed data is present on the reader page.

> diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring=
_buffer.c
> index 5f14ba152fba6..2dddaef638dc6 100644
> --- a/kernel/trace/simple_ring_buffer.c
> +++ b/kernel/trace/simple_ring_buffer.c
> @@ -307,6 +307,11 @@ EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
>   */
>  void simple_ring_buffer_commit(struct simple_rb_per_cpu *cpu_buffer)
>  {
> +	/*
> +	 * Order page::data and page::time_stamp before page::commit. Paired
> +	 * with __rb_get_reader_page_from_remote().
> +	 */
> +	smp_wmb();
>  	local_set(&cpu_buffer->tail_page->page->commit,
>  		  cpu_buffer->tail_page->write);

[Severity: Critical]
This problem wasn't introduced by this patch, but can
simple_ring_buffer_reserve() return a pointer whose reservation overflows
tail->page->data [1]?

In simple_rb_reserve_next(), when an event exceeds PAGE_SIZE -
BUF_PAGE_HDR_SIZE, simple_rb_move_tail() rotates to an empty page where
!tail->entries is true, and event_size is assigned to tail->write without
checking that it fits on a fresh page:

kernel/trace/simple_ring_buffer.c:simple_rb_reserve_next() {
	...
	if (unlikely(write > (PAGE_SIZE - BUF_PAGE_HDR_SIZE)))
		tail =3D simple_rb_move_tail(cpu_buffer);

	if (!tail->entries) {
		tail->page->time_stamp =3D timestamp;
		time_delta =3D 0;
		ts_ext_size =3D 0;
		write =3D event_size;
		prev_write =3D 0;
	}

	tail->write =3D write;
	...
}

Writing the caller's payload to the returned event pointer then writes past
the end of the page buffer and corrupts adjacent memory.

[1] https://sashiko.dev/#/bug/linux-b2128783-1787-4f13-b863-090db5378e74

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113152729.8374=
29-1-vdonnefort@google.com?part=3D3
