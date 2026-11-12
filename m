Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794493327;
	b=USoHtesxJAg2PJzLLdWUZoAVWkEV1Vs3YfQUTPmIV8q9HnTJ9bZslqdUtFNTkWRtuauT
	 7SL8/V0uIyAVcgrsuw/fNew+i1/EjbBBEpztvSyQSUQcTKYg7u0fH1YdQw5gNbuznTLCl
	 V52pep83lerBg3QHtLj0jkrE1Rxq6t2wZr0L4va58ucmbud4Gjt1E/S64J+S6mgqvlJ9J
	 64SGzeo1/dMSpNwTz4uSaJMEAGW/ckrykZdcyYR8QmY1K4Y2UWSIQMfjwUDTnOl03ahqG
	 OKdIciWy/hud/psuHGLfUhMno3qC3WOWteyiA1nfKONpjJ+HsfR4sbwwg0pLCtpyNTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794493327;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PIVTWE/VNxYGvZ0T63r4PexYkFdzwPboycCILQz/wKY=;
	b=iaGLcYKmJK6z6PJRDXg3u/YQCU8fvmzEUij5TwIwN/tto+jL9XjskL14GJ/LfoG7eT5/
	 9YdCJyZRtvhoGoeQg2w6Mg56XyPxVRNmSOpIOAlC19OMm9YFqOPiNkmtdtwm3o+AFVtH6
	 8QAmhPtxSr5aUfNlRPW/Cyjql0IqwdIuUVf4dqvGMAy0AYUlyJmo+mQj5gPU1q2kZ4mv/
	 R9h0Vma3hWSWVqgDgOxY8/dJNjhLwL0kZiR4hzQNGqfcac59T2kdcYKevILOJDCTk/ueO
	 E1cAJ14LFENjWH7qVK8109xsoyMJ9kplW+8sBKMa5kc5aPNQlFgfrF/5qu5SxJW7gCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6MS1acs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59189606D565
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S6MS1acs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E591F00A0B;
	Thu, 12 Nov 2026 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794493327;
	bh=PIVTWE/VNxYGvZ0T63r4PexYkFdzwPboycCILQz/wKY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S6MS1acsQ0b9I4FCYWZHA9mXsl58gYw+HzbQrIyAbk8huFxntC5jElMYzzRR7SBK7
	 3ZtQoy71bp4wi9AAC8BFDiEbadQZ9gRlHu49znMzNjoZXsvORMJ5Q2b+U5bmlcSYN4
	 8PkVdMKEJthOkfhm2kDGebwdFS/GGbtFim54B/WdvpaAj1D/ComophJCCd17FbPJQ/
	 9p3AuvS0U+gRmFbCkXAGrCR8yK7Hj4qNFVFCDMuJ6Nhxn3MGCaobB+pkjI7oIuM8GJ
	 VAK2HoPg/fm7N5lT6GSbIhp7FLTPvdX7ClWRky/TpvtCfbDZwbhQqrdCQLI2/7Z8T5
	 AgJbJ41XklhVw==
Message-ID: <sashiko-outbox-211307@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/9] ring-buffer: Always read buffer->buffers after
 testing the cpumask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261112141440.3050124-2-vdonnefort@google.com>
References: <20261112141440.3050124-1-vdonnefort@google.com>
 <20261112141440.3050124-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:22:06 +0000
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
- [High] ring-buffer: atomic counter underflow in ring_buffer_reset()
  [1]
--

commit fbf1784e6b7f3202f4d6898704fb8180140b6da5
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Always read buffer->buffers after testing the cpumask

This commit moves the load of buffer->buffers[cpu] after the
cpumask_test_cpu() check in ring_buffer_peek(), ring_buffer_reset_cpu(),
and ring_buffer_read_page() to avoid reading a stale per-CPU buffer
pointer when racing with trace_rb_cpu_prepare().

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 1fd28a72e6ee1..bd8126f6353b7 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6740,11 +6742,13 @@ static void reset_disabled_cpu_buffer(struct ring=
_buffer_per_cpu *cpu_buffer)
>   */
>  void ring_buffer_reset_cpu(struct trace_buffer *buffer, int cpu)
>  {
> -	struct ring_buffer_per_cpu *cpu_buffer =3D buffer->buffers[cpu];
> +	struct ring_buffer_per_cpu *cpu_buffer;
> =20
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
>  		return;
> =20
> +	cpu_buffer =3D buffer->buffers[cpu];
> +
>  	/* prevent another thread from changing buffer sizes */
>  	mutex_lock(&buffer->mutex);

[Severity: High]
This problem wasn't introduced by this patch, but can a concurrent
trace_rb_cpu_prepare() race with ring_buffer_reset() [1] and
underflow cpu_buffer->record_disabled and cpu_buffer->resize_disabled?

Unlike ring_buffer_reset_online_cpus(), which marks each disabled
cpu_buffer with RESET_BIT before sleeping in synchronize_rcu(),
ring_buffer_reset() iterates over buffer->cpumask twice without tracking
which CPUs were disabled in the first loop or holding cpus_read_lock():

CPU0                                  CPU1
ring_buffer_reset()
  for_each_buffer_cpu(buffer, cpu)
    atomic_inc(&cpu_buffer->resize_disabled);
    atomic_inc(&cpu_buffer->record_disabled);
  synchronize_rcu();
                                      trace_rb_cpu_prepare()
                                        rb_allocate_cpu_buffer()
                                        cpumask_set_cpu(cpu, buffer->cpumas=
k);
  for_each_buffer_cpu(buffer, cpu)
    reset_disabled_cpu_buffer(cpu_buffer);
    atomic_dec(&cpu_buffer->record_disabled);  <-- underflows to -1
    atomic_dec(&cpu_buffer->resize_disabled);  <-- underflows to -1

For the newly prepared CPU, reset_disabled_cpu_buffer() runs while
recording is still enabled and both atomic counters underflow from 0 to
-1, corrupting the per-CPU ring buffer state.

[1] https://sashiko.dev/#/bug/linux-2557ac4d-25af-4832-a2c9-c12af32c7a04

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112141440.3050=
124-1-vdonnefort@google.com?part=3D1
