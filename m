Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314757;
	b=zVBFO1bEklw2gGZM88PPhmcqNagxoM3eTeBk6h+iRVAnttZCqO2qn87tIqpbU+pGwWcP
	 ObJ23KmsrSpM/Tc91o4d69dXdjUKXLkFR4DnlnjPnBRm7EK8JLiNcVLORelHw43BzOkI8
	 Hjs4ywFHrqQ9JDduO9vAqflx7SQyo57+W3+i5esqfQ0H95wVPZNykpPkaYSlMcMIOeqgk
	 aqWSnf8JpZVvX7bHphAZkgUcjel/EhUlAm9cfLl9j+teI1PS2svIo4aImD+q6LWfaofZm
	 +l4sioPmZgKkQeDE0R3ugcsk0g+GbSU1K48gnB4+wJrmybcEey7UitNJD9SztZ5Iukg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hirW6C3469OrMbRII0zqoqHpsRAarkqmX6lIehqNN6A=;
	b=3Z0baKwUis2FR7pPyKBo5eoXYJ7LG0xpcq50131wFfwTQinv7M0zhBY0DCN687rJ3m5S
	 mgDlY3XdaQDYtjefgZyd2RD2+BVxkhtE3OmuQtGOS+jQKXp7nAB94GqFu45Qv0U6g4VsZ
	 h7eJZJf5Z4QRsMAi7DDSOdSDO2ENJ/PRidgAzFvK4OOWMqPPv5aC3dS0JFz8yjYSux4+t
	 ++o6eMzG/Tbzj4oTZEQdJb2GKnCWHHT0vXeew2DW0pDIDf13ioIjwQqELB0sSRSXAEoaV
	 ClRY/hM+mdmqsljEgwX8QFwBZ3yX0uP2ThT7fahTIAeDVj0Un9qkc9Qc5SU2hcNwkiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXf0e8Ab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC4606A325
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 12:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kXf0e8Ab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F078C1F0089F;
	Tue, 10 Nov 2026 12:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314757;
	bh=hirW6C3469OrMbRII0zqoqHpsRAarkqmX6lIehqNN6A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXf0e8AbJz1KMaOR0GrrESU4GPS71ZAtnQ5XJqSWlzPzP4+0P9ReqzHeeaOcMfYcS
	 xX7oMfDTtYWAmR5gYIVV2vxvjWmnWkLsoxaji2F380qMu6mZ4PlfXl7eVje6AbofbS
	 AM3FAaVKlAxYzXOJnTxCRTbmSE332ui0GxXGCP1ypfet1WM2OVWWO7TgdY9sSPyfcS
	 BYCaciJDy5WHcxMpZg7zmVKseGcsMGrFb4juhnqiaodAGQiu85sNR3lDoJ3OpeaZRT
	 MF8AU6r631I/AcZy9awpRpxeuZEV8EXcR+eoGRTqaZ+9jE0wFbn7LcfVXGy3f8S38o
	 52vb/T7kquZbA==
Message-ID: <sashiko-outbox-207040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing: ring_buffer: serialize shrink with NMI
 readers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoli Zhang" <26031212468@stu.xidian.edu.cn>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261110122610.655756-1-26031212468@stu.xidian.edu.cn>
References: <20261110122610.655756-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:45:56 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] tracing: ring_buffer: infinite NMI loop when empty checks
  return false on skip
- [Medium] tracing: ring_buffer: stale event pointer in
  ring_buffer_consume() on skip
- [Low] tracing: ring_buffer: missing Fixes trailer on bug-fix commit
--

commit baa028f41be3b1534303fc3f33ecfebadca9debf
Author: Haoli Zhang <26031212468@stu.xidian.edu.cn>

> tracing: ring_buffer: serialize shrink with NMI readers
>
> The syzbot report shows a use-after-free in rb_is_reader_page(), reached
> from rb_move_tail(), with the freed page released by rb_remove_pages().
> Source inspection suggests that a detached reader page can retain a link
> into the range removed during a shrink. This patch addresses that possible
> stale-link path and coordinates NMI readers with page removal.
>
> When an NMI reader cannot acquire reader_lock, rb_reader_lock() falls back
> to reading the ring buffer without the lock. Gate lockless NMI readers
> while rb_remove_pages() removes pages. Track readers that entered before
> the gate and drain them before changing the page list; new NMI readers th=
at
> fail reader_lock while the gate is closed skip that CPU. The gate and
> reader-count protocol uses ordering barriers and release/acquire accesses.
> Readers that successfully acquire reader_lock remain serialized by it.
>
> The NMI fallback increment of record_disabled is intentionally retained.
> The pre-existing fallback comment says an unlocked NMI read may corrupt t=
he
> buffer and that recording must remain disabled afterward; the existing
> unlock path does not undo that disable. The new nmi_readers counter is
> separate: it tracks only the temporary lifetime of the lockless NMI read
> and is decremented when that read exits.
>
> During shrink, redirect reader_page->list.prev if it points to a page bei=
ng
> removed. Detect a stale reader_page->list.next as well, and after reconne=
cting
> the ring redirect it to the surviving successor link, including the
> transferred head flag. Treat skipped empty-buffer queries as non-empty, a=
nd
> clear the timestamp output when peek or consume skips the read.
>
> Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspotmail.com/bug?extid=3D37e1793bdb0061ea3a47
> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

[Severity: Low]
Since this fixes live page unlinking in rb_remove_pages(), should this
include:

  Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atom=
ic")

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e760d2fe386fb..e947ac629e67f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c

[ ... ]

> @@ -6416,7 +6475,7 @@ ring_buffer_consume(struct trace_buffer *buffer, in=
t cpu, u64 *ts,
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	struct ring_buffer_event *event =3D NULL;
>  	unsigned long flags;
> -	bool dolock;
> +	enum rb_reader_lock_state state;
> =20
>   again:
>  	/* might be called in atomic */
> @@ -6427,15 +6486,18 @@ ring_buffer_consume(struct trace_buffer *buffer, =
int cpu, u64 *ts,
> =20
>  	cpu_buffer =3D buffer->buffers[cpu];
>  	local_irq_save(flags);
> -	dolock =3D rb_reader_lock(cpu_buffer);
> +	state =3D rb_reader_lock(cpu_buffer);
> =20
> -	event =3D rb_buffer_peek(cpu_buffer, ts, lost_events);
> +	if (state !=3D RB_READER_SKIP)
> +		event =3D rb_buffer_peek(cpu_buffer, ts, lost_events);
> +	else if (ts)
> +		*ts =3D 0;
>  	if (event) {
>  		cpu_buffer->lost_events =3D 0;
>  		rb_advance_reader(cpu_buffer);
>  	}
> =20
> -	rb_reader_unlock(cpu_buffer, dolock);
> +	rb_reader_unlock(cpu_buffer, state);
>  	local_irq_restore(flags);
> =20
>   out:

[Severity: Medium]
Can event retain a stale non-NULL pointer when ring_buffer_consume()
retries at again: and then hits RB_READER_SKIP?

event is initialized to NULL only before the again: label.  If the first
pass peeks a RINGBUF_TYPE_PADDING event and jumps back to again: at the
end of ring_buffer_consume(), and the retry sees state =3D=3D RB_READER_SKI=
P,
event is not cleared to NULL (unlike in ring_buffer_peek()).  if (event)
then calls rb_advance_reader(cpu_buffer) without reader_lock or an
nmi_readers reference while rb_remove_pages() is unlinking and freeing
pages, and the trailing RINGBUF_TYPE_PADDING check loops back to again:.

[ ... ]

> @@ -6848,7 +6910,7 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	unsigned long flags;
> -	bool dolock;
> +	enum rb_reader_lock_state state;
>  	bool ret;
>  	int cpu;
> =20
> @@ -6856,9 +6918,10 @@ bool ring_buffer_empty(struct trace_buffer *buffer)
>  	for_each_buffer_cpu(buffer, cpu) {
>  		cpu_buffer =3D buffer->buffers[cpu];
>  		local_irq_save(flags);
> -		dolock =3D rb_reader_lock(cpu_buffer);
> -		ret =3D rb_per_cpu_empty(cpu_buffer);
> -		rb_reader_unlock(cpu_buffer, dolock);
> +		state =3D rb_reader_lock(cpu_buffer);
> +		ret =3D state =3D=3D RB_READER_SKIP ? false :
> +			rb_per_cpu_empty(cpu_buffer);
> +		rb_reader_unlock(cpu_buffer, state);
>  		local_irq_restore(flags);
> =20
>  		if (!ret)
> @@ -6878,7 +6941,7 @@ bool ring_buffer_empty_cpu(struct trace_buffer *buf=
fer, int cpu)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
>  	unsigned long flags;
> -	bool dolock;
> +	enum rb_reader_lock_state state;
>  	bool ret;
> =20
>  	if (!cpumask_test_cpu(cpu, buffer->cpumask))
> @@ -6886,9 +6949,10 @@ bool ring_buffer_empty_cpu(struct trace_buffer *bu=
ffer, int cpu)
> =20
>  	cpu_buffer =3D buffer->buffers[cpu];
>  	local_irq_save(flags);
> -	dolock =3D rb_reader_lock(cpu_buffer);
> -	ret =3D rb_per_cpu_empty(cpu_buffer);
> -	rb_reader_unlock(cpu_buffer, dolock);
> +	state =3D rb_reader_lock(cpu_buffer);
> +	ret =3D state =3D=3D RB_READER_SKIP ? false :
> +		rb_per_cpu_empty(cpu_buffer);
> +	rb_reader_unlock(cpu_buffer, state);
>  	local_irq_restore(flags);
> =20
>  	return ret;

[Severity: High]
Does returning false from ring_buffer_empty() and ring_buffer_empty_cpu()
on RB_READER_SKIP cause ftrace_dump_one() to spin forever in NMI context?

rb_remove_pages()
  atomic_set_release(&cpu_buffer->resize_in_progress, 1)
  raw_spin_lock_irq(&cpu_buffer->reader_lock)
  <NMI>
    ftrace_dump_one()
      while (!trace_empty(&iter))
        ring_buffer_empty_cpu()  --> false (RB_READER_SKIP)
        trace_find_next_entry_inc(&iter)
          ...
            ring_buffer_peek()   --> NULL (RB_READER_SKIP)
        touch_nmi_watchdog()     <-- spins forever

rb_reader_lock() only returns RB_READER_SKIP in NMI context when
reader_lock is held and resize_in_progress is set.  If ftrace_dump_one()
interrupts rb_remove_pages() (or runs on another CPU during a panic after
stopping the resizing CPU), rb_remove_pages() cannot resume to release
reader_lock or clear resize_in_progress until the NMI dump finishes.
Because ring_buffer_empty_cpu() reports the skipped CPU buffer as
non-empty while ring_buffer_peek() returns NULL, trace_empty(&iter) stays
false and the while (!trace_empty(&iter)) loop in ftrace_dump_one() never
terminates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110122610.6557=
56-1-26031212468@stu.xidian.edu.cn?part=3D1
