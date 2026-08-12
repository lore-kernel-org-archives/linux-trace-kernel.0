Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5705638F941
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786553653; cv=none; b=A02XV8R7ioQZbP3ewSvGwBjB3YT5CHrzQ11QrJlBEMUuhH69KHKqvfDKzkkXUE0PzKvXqFtg3N8hqUVPVOuNoSSCCd9xAJK+OjtLWSRFKkbHPlVpeHrtb28tEVeFyydEQQ1zwRKAKPPScc/cG3r3mY4cE7EOxO820snBY6P/3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786553653; c=relaxed/simple;
	bh=BuUnVi7gMzzbev3Dfn0ZHnfIROeUkg94pwtWQgnHkhs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZBFtYpK02eVW5iJnsIh/Tf1shfLLFFbWx4V7ldP28vrlXrj3T6Gok3e0R00sEZ9LNSr7nIQoxlv0WuKIRRybswYceD6Dz3xotD9upB0o5Efha9b8z8RJz3OLchorP9FKlPxRjYuMsU39bjdVokbZxJHBrAD4sbdX1L8KsoHwkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HySspO7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HySspO7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67B81F000E9;
	Wed, 12 Aug 2026 16:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786553651;
	bh=+4BzEwvpr9ss5uVaCgC+R9yJJcjth+jfTi6VzUQLBfw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HySspO7g7VSFEbGvsT7nHxjzFQBgoj72PbEsd4bzAEzazTCwgUQL0PSesU4vH/q0G
	 4XO0mPWpYtqq6rVEFmJ6xHnuqHll9jjAaLEQrKwZ9YGyyN7tWARM8eOtHewfFDvv6C
	 +pyiCiTYivjo9uBnUuqZp1Blfw7naWkQ6goxhk0lSD5dr48D5xA9JhYIFr/ilAHPig
	 4hLxWmabPJvTCsL5NhCA8h7tZ2Zk7K8oa/HjKPcBPxZEGkcHechSPdhueveaxfTlPY
	 cidwt9BFrrOIdwX/1TgcHUnxK7MzM36MvIe/1QaiFZ5XmjhnDIQvq13M//OetTsjK0
	 16z03FytkQOeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/18] ring-buffer: Use panic-friendly locking in
 ring_buffer_iter interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-11-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-11-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:54:11 +0000
Message-Id: <20260812165411.B67B81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] rb_reader_lock() lacks an oops_in_progress check, leading to deadl=
ocks during non-NMI panic dumps.
--

--- Patch [10]: [PATCH v5 10/18] ring-buffer: Use panic-friendly locking in=
 ring_buffer_iter interface ---
commit 15fbd37892d8549b59334542a9c228e531aa61b5
Author: Vincent Donnefort <vdonnefort@google.com>

ring-buffer: Use panic-friendly locking in ring_buffer_iter interface

This patch replaces raw_spin_lock_irqsave() with rb_reader_lock() in the
iterator functions. The goal is to make the iterators panic-friendly so
trace_remote can dump the buffer on panic without deadlocking.

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index a7d9936b4c835..a6f2293f409b8 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
[ ... ]
> @@ -5616,15 +5619,18 @@ void ring_buffer_iter_reset(struct ring_buffer_it=
er *iter)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	unsigned long flags;
> +	bool dolock;
> =20
>  	if (!iter)
>  		return;
> =20
>  	cpu_buffer =3D iter->cpu_buffer;
> =20
> -	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> +	local_irq_save(flags);
> +	dolock =3D rb_reader_lock(cpu_buffer);

[Severity: High]
This is a pre-existing issue, but does rb_reader_lock() lack an
oops_in_progress check?

If a panic occurs in a normal (non-NMI) context, in_nmi() evaluates to false
in rb_reader_lock():

static inline bool rb_reader_lock(struct ring_buffer_per_cpu *cpu_buffer)
{
	if (likely(!in_nmi())) {
		raw_spin_lock(&cpu_buffer->reader_lock);
		return true;
	}

During a panic, smp_send_stop() will forcefully halt other CPUs. If one of
those stopped CPUs was holding cpu_buffer->reader_lock, the panicking CPU
will spin forever in raw_spin_lock().

Since the goal here is to make these iterators panic-friendly, does
rb_reader_lock() also need to bypass the lock (e.g. check oops_in_progress)=
=20
to avoid deadlocks during non-NMI panics?

>  	rb_iter_reset(iter);
> -	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
> +	rb_reader_unlock(cpu_buffer, dolock);
> +	local_irq_restore(flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D10
