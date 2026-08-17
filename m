Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F83C81B9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975495; cv=none; b=em9r+rCfSeohaP/C+AmD/5aVhuf87NwUxvVfeCZI7I/zVP3+gnTxj+9ordKQ+X/T49tN8g3u4caPhLrY9/NPUbiLK47Yuy/yOri1dThLyU/dP/i6pCdHVXAi+lS1DeURw5mVswl2c7V+f3daqeXGS70KUvY8cs8n4rKcZSTmhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975495; c=relaxed/simple;
	bh=MIxOIXY8Y6QVmz+dsTSn1QQUxZTwE/WdHZL0Xd35QHc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FI8tDUetbdgS8M04HraOM6Aft36IxWEuVzBBOV09tZzwNW9TYjEX08sPVWrPKqt9tnVR/kCs3Gug3//p2Mo6zygkExx0nkDVxKHJkLpRbKiMAOJf5SK+l3MrzqucrdEzVXmDrsxhG6wPSZKti7RsftPaEa3wYQOAMKR/81WmhVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAygILA3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAygILA3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231C71F00A3A;
	Mon, 17 Aug 2026 14:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975494;
	bh=OSkmiC8uo9X2maTITCIDywaJJUTDQnG99gXaRBwhzgc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WAygILA3wfoxW4WjgNAAO/0sxKqT4mOmkxsbJyhdjGeaVOBwc860WrxQ5qh/oYU7R
	 i3/h71fAsYtrrTS4/jL0mEUA/SLyrwlS3yxJHwCNXc84nytNtQOKBn8nCjkFKmaubw
	 GqaqFp+ouAVkdyfSu8dFqYaZwcUXJNUruXBdu1jWefykVKShoM1s4UUpgIe9MB1+z2
	 4gzOyd8RXi6hcW3scpk5ixsJCrKbniWR9knrsqEtRE4rRjah1M9yiFgezrUipge1R6
	 N2Pz1hSy8AbApUPpsHY9bB7jmb1I3tGl+UqJzmw3PqQGbBXqEXJKYdw0Oyj+UmZCO4
	 p/FmQ1bJnYWbg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/18] ring-buffer: Use panic-friendly locking in
 ring_buffer_iter interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-11-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-11-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:04:53 +0000
Message-Id: <20260817140454.231C71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete panic-friendly locking leaves the system vulnerable to =
deadlocks during non-NMI panics.
--

--- Patch [10]: [PATCH v6 10/18] ring-buffer: Use panic-friendly locking in=
 ring_buffer_iter interface ---
commit ecd8a71adf986114125493b0d7821b40d48b7d2e
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Use panic-friendly locking in ring_buffer_iter interface

This commit replaces raw_spin_lock_irqsave with rb_reader_lock in the
ring_buffer_iter functions. This prepares the iterator interface for dumping
the buffer on panic without deadlocking on the reader_lock.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a7d9936b4c835..a6f2293f409b8 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -6302,11 +6308,14 @@ ring_buffer_iter_peek(struct ring_buffer_iter *it=
er, u64 *ts)
>  	struct ring_buffer_per_cpu *cpu_buffer =3D iter->cpu_buffer;
>  	struct ring_buffer_event *event;
>  	unsigned long flags;
> +	bool dolock;
> =20
>   again:
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	local_irq_save(flags);
> +	dolock =3D rb_reader_lock(cpu_buffer);

[Severity: High]
This is a pre-existing issue, but does rb_reader_lock() actually prevent
deadlocks during non-NMI panics?

Looking at rb_reader_lock(), it only falls back to raw_spin_trylock() when
in_nmi() is true:

static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
{
	if (likely(!in_nmi())) {
		raw_spin_lock(&cpu_buffer->reader_lock);
		return true;
	}
...

If a standard oops or sysrq-c triggers a panic in a normal process or softi=
rq
context where in_nmi() is false, won't this unconditionally call
raw_spin_lock()?

If smp_send_stop() halted another CPU that was currently holding the
reader_lock, or if the panicking CPU interrupted a context holding the lock,
this would spin forever and prevent kdump or panic_timeout from working.

Should rb_reader_lock() also check oops_in_progress to fully realize the
panic-friendly locking behavior intended by this patch?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D10
