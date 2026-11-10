Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289496;
	b=p8fXqwPj9Q/seQHn+WkQq8nkNFdX9gUzgnqErOEcTdIIDJ/0QY09pSYVoVSmyuLVx7O2
	 jvxOPabe8BrYM5AJf+qogGs12HdNCg9TcidmnhC37yzTXHuqITRbHIEBWYL9K1oSaOJR5
	 zjrZfXGAj8bYTqIohGUpoE/Iu507IMfH4bjrNc/NKfUmk7ZwUqElBTSwOqWeRkZLTG066
	 MQtAYZhmKGtWxK3qlN8CQDfQwLTp+ZCePAVOeKFie4akUufUdZAmsobPWWURVqkl25i2w
	 lm9BVUwgHMsvKTAgRu1ah5WHDNT2XnH+hxD6dk4l0Lj/0GlMDyp2vm4JAhgFAe0i9zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289496;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DNcjMlK21koA6XyHdj8/oF7BiXxFM+Jtloux+v/pOZM=;
	b=tUUGO02pu/KY/KHCykf5Ki8blQ4rZoglBVW/e02BjrlJScHPrWoB1B8dJWEljVRNLY7e
	 NcurQhginUh7wfZ+eiQTXtoeJ3wXeiqiU5kjn1OrnlJI3OxuxRdjZ7LgY0ehfxFKRHD1v
	 HhQfM7iLmesGv67XOz52yKK2vpkpgeEr8b2zqLSlaokIZoaRPJ2uCW5vSPkpg9hk/FXWu
	 9Kw/ZnYw7YPCvtAzsFDIy0T5NO/11jNrdK2512BhZ1pizZrFJSE2oAUo+wKPhxDxtHenn
	 ugAGBK9+9dsXmt0nlcR58bAQYs8ynqQmJcetmcIGHrHUYX5C12hq6ozU2KkwaZBun3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xl2oZDkG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE3C606A330
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Nov 2026 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xl2oZDkG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777901F0089F;
	Tue, 10 Nov 2026 05:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289495;
	bh=DNcjMlK21koA6XyHdj8/oF7BiXxFM+Jtloux+v/pOZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xl2oZDkGyai2WGFLC5deBwkv7sjAsSi4U5zxSPfQC/eNQwKps+AdS355QoRgT4N9D
	 iH5yKknAUmBq7lPKNYmL2qscIITaEhzEe+TxsOlxmUsvfACcaxGKSK4QV32Yqy/SQS
	 wrPjQxLGN452r81K4E4aM1ywF482eWq7cog4bQybBoZ+m2cIpd2kowo3RFI6Bp6z37
	 /RaMTa4vxIVAYwVQ+y+z6y5V8eqekqwyRGRQT/CHNJBmL7IPN8ssKVJjjXBHf3J1oK
	 Vw1iLpuFAXd6TtcGdpPdsBAGVf6XutU5Oj+YAjqlASqAJfz6pBjjc0ZNPD1pTvgXO0
	 tCjvlrjrKrE7A==
Message-ID: <sashiko-outbox-206337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] tracing: ring_buffer: wait for writers before removing
 pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoli Zhang" <26031212468@stu.xidian.edu.cn>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261110045850.2786-1-26031212468@stu.xidian.edu.cn>
References: <20261110045850.2786-1-26031212468@stu.xidian.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:44:54 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tracing: ring_buffer: ineffective synchronize_rcu() in
  rb_remove_pages()
- [Low] tracing: ring_buffer: missing Fixes trailer for
  rb_remove_pages() fix
--

commit 47d13d1f3cd83bf8e86c2d2c4091f144764c4470
Author: Haoli Zhang <26031212468@stu.xidian.edu.cn>

> tracing: ring_buffer: wait for writers before removing pages
>
> A writer can still be using the ring buffer page list when a concurrent
> resize removes and frees pages. Disabling recording prevents new writers
> from entering, but it does not wait for writers that are already in the
> reserve/commit path. The reader lock protects reader-side page operations
> and does not provide that writer-side synchronization.
>
> Disable recording before waiting for a grace period, then wait for
> pre-existing writers to finish before taking the reader lock and changing
> the page list. Keep recording disabled until after the page list has been
> updated and the reader lock has been released. The removed pages are
> unlinked and subsequently freed.
>
> This adds a grace-period wait to the resize path; it does not add
> synchronization to the normal ring-buffer write path.
>
> Reported-by: syzbot+37e1793bdb0061ea3a47@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D37e1793bdb0061ea3a47
> Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

[Severity: Low]
This is a bug fix for rb_remove_pages().  Should it include:

  Fixes: 83f40318dab0 ("ring-buffer: Make removal of ring buffer pages atom=
ic")

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index e760d2fe386fb..7ec0e12493f52 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -3080,8 +3080,11 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_bu=
ffer, unsigned long nr_pages)
> =20
>  	head_bit =3D 0;
> =20
> -	raw_spin_lock_irq(&cpu_buffer->reader_lock);
>  	atomic_inc(&cpu_buffer->record_disabled);
> +	/* Wait for in-flight writers to finish before unlinking pages. */
> +	synchronize_rcu();
> +
> +	raw_spin_lock_irq(&cpu_buffer->reader_lock);

[Severity: Medium]
Can any writer on cpu_buffer actually be in flight when rb_remove_pages()
reaches synchronize_rcu()?

ring_buffer_lock_reserve() and ring_buffer_write() disable preemption with
preempt_disable_notrace() across the entire reserve/commit path and only
write to the local CPU's cpu_buffer.  Meanwhile, ring_buffer_resize() only
runs rb_update_pages() -> rb_remove_pages() in task context on the target
CPU itself (via schedule_work_on() or directly under migrate_disable()) or
while the CPU is offline under cpus_read_lock():

kernel/trace/ring_buffer.c:ring_buffer_resize() {
    ...
			if (!cpu_online(cpu)) {
				rb_update_pages(cpu_buffer);
				cpu_buffer->nr_pages_to_update =3D 0;
			} else {
				/* Run directly if possible. */
				migrate_disable();
				if (cpu !=3D smp_processor_id()) {
					migrate_enable();
					schedule_work_on(cpu,
							 &cpu_buffer->update_pages_work);
				} else {
					update_pages_handler(&cpu_buffer->update_pages_work);
					migrate_enable();
				}
			}
    ...
}

Because rb_remove_pages() runs in task context on cpu_buffer->cpu, no
task-context writer on that CPU can be inside its preempt-disabled
reserve/commit section, and any interrupting softirq, hardirq, or NMI
writer that started before atomic_inc(&cpu_buffer->record_disabled) has
already finished before returning to task context.

Calling synchronize_rcu() here therefore does not wait for any writer.
Instead, it stalls recording on cpu_buffer for an entire RCU grace period,
blocks ring_buffer_resize() under migrate_disable() before scheduling work
on remaining CPUs, and leaves the use-after-free unfixed when
__rb_get_reader_page() leaves cpu_buffer->reader_page->list.prev pointing
to a buffer_page that rb_remove_pages() subsequently unlinks and frees
before a writer checks rb_is_reader_page() in rb_move_tail() or
rb_set_commit_to_write().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110045850.2786=
-1-26031212468@stu.xidian.edu.cn?part=3D1
