Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795633286;
	b=T9nFvEd8eFyttY0VP8gi4iGFT3CTq9lQbXJaqOldPWYE4lrP149NEljW9vdMYU8iKvL9
	 bWJzQdkkr1kHttlGxxjfIDCg8qIP2OMDry+A3MY4MNgylRNiMXo0lkOFmYa/g/mVC4gOS
	 N3Y4dgx0GH91Wl5JIstCGy2JF8F07eSPPAC1Nw3Cb7APOprONL4XhVmQWr2Znlf58VEGu
	 xz1IGo6P0Abe0MJCapVERokbHKe0GK2dWOqKDmRGGS92GeglyXXp9ZAQ+vHTDyg1lMCzL
	 gYoxl5N9zm8QulUGQXkTERRZvxuzOQTji79iiZV6Xde+VO/xQQE8m5PqgWK5n4lpGXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633286;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yjeECiXppDQbE+eJdnY6wJHqcF82ARomOzpOBR3sbBI=;
	b=nGu8PAVzQTnSifEeYNdLp3VADNzPRODxgcGXWJ5Yf69RJxomrlUES2cez41u3+3EZdqe
	 E3En7m7YMkPLmr4IqKhF5my6w5DmoMKBl55Zz2Hxl3u5vxfgpugsFsi83mewCi0lvtXQG
	 mmklV2NGPvrQjHHgWMWkJvocpfEktIUCUMh3gJMpk4rDbruYatWpxhL2nE3ZglH0asfRF
	 nhR/WADFQXmKec4zmsW7VrG12Y4o5uKzG7M/+GN+J9U3HBWrgSvNPz2+Ap96IUVV9oGWL
	 Lwki9uVNeKdkUMA8CTL5pq0k9xb1Xl8SHL5uv9heBRvS6UgjBEL7RcmU61WQFAr+R1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTJj5nQ0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A2D606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTJj5nQ0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79F611F000C6;
	Wed, 25 Nov 2026 19:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633286;
	bh=yjeECiXppDQbE+eJdnY6wJHqcF82ARomOzpOBR3sbBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTJj5nQ0KzewPJzTwuyMTJqSs5PLNotvu2Ne/IYTZsCEwLPl/sVnG3/pL+c1cQiLj
	 JjM8h4B4DOaUZ27MLSo7KzDGDlIu9Buk2kEtpwFRleRpJ5W16lCvL1AhJY1MDwzHkZ
	 /cTynAmMKVzwMkNLN89l2T2vvWLYn9VtkxrggyjzQqdgU2gUiX+t4p1+jmYPPTa+BS
	 r4GxzXSg9Vz+7jDH32kSOm1RM4dkgkYwSPPZ9xBDCabHSaOWFo6dn19GBSpoe5NWX4
	 P2JLkyN1sgIGJEuGK/oTc7n75+tPvfIEvu0BIH8yZPFMT2+6VrS63M/fCHq1cSB2cV
	 sNbGz5MYGlyNQ==
Message-ID: <sashiko-outbox-234029@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] media: hantro: Add v4l2_hw run/done traces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Detlev Casanova" <detlev.casanova@collabora.com>
Cc: linux-trace-kernel@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261125-v4l2-add-ftrace-v3-9-1d1db48372ed@collabora.com>
References: <20261125-v4l2-add-ftrace-v3-0-1d1db48372ed@collabora.com>
 <20261125-v4l2-add-ftrace-v3-9-1d1db48372ed@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 19:01:26 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] media: hantro: NULL dereference and race on ctx in
  rk3588_vpu981_irq()
- [Medium] media: hantro: race and UAF in device_run() calling
  trace_v4l2_hw_run()
- [Medium] media: hantro: UAF race and duplicate trace in
  hantro_irq_done()
- [Low] media: hantro: stale ctx->hw_cycles reported in
  trace_v4l2_hw_done()
- [Low] media: hantro: missing kernel-doc entry for hw_cycles in
  hantro_ctx
--

commit e206fb95ea0a2df26a322693fa1382eb6fa7b49a
Author: Detlev Casanova <detlev.casanova@collabora.com>

media: hantro: Add v4l2_hw run/done traces

This commit adds trace_v4l2_hw_run() and trace_v4l2_hw_done() calls to
the hantro VPU driver and records the hardware cycle count from
AV1_CYCLE_COUNT on the Rockchip VPU981 core.

[Severity: Low]
In drivers/media/platform/verisilicon/hantro.h, struct hantro_ctx
(around line 256):
This isn't a bug, but struct hantro_ctx has a kernel-doc comment block
above it and the new hw_cycles field has no @hw_cycles: entry, which
triggers a W=3D1 kernel-doc warning.

[Severity: Medium]
In drivers/media/platform/verisilicon/hantro_drv.c, hantro_irq_done()
(around line 105):
Can calling trace_v4l2_hw_done() before cancel_delayed_work() emit a
duplicate trace event or read a freed ctx?

cancel_delayed_work(&vpu->watchdog_work) is what synchronizes
hantro_irq_done() against hantro_watchdog().  If the watchdog is already
running on another CPU when the IRQ fires, both paths emit
trace_v4l2_hw_done() for the same job.  Worse, if hantro_watchdog()
finishes the job right after v4l2_m2m_get_curr_priv() returns ctx, a
concurrent close() can free ctx before hantro_irq_done() reads ctx->fh
and ctx->hw_cycles:

CPU0 (<hardirq>)                  CPU1 (watchdog / close)
hantro_irq_done()                 hantro_watchdog()
  ctx =3D v4l2_m2m_get_curr_priv()
                                    hantro_job_finish(ctx, ...)
                                      ...
                                      /* clears TRANS_RUNNING */
                                  hantro_release()
                                    v4l2_m2m_ctx_release()
                                    kfree(ctx)
  trace_v4l2_hw_done(ctx->fh.tgid,
                     ctx->fh.fd,
                     ctx->hw_cycles)  <-- use-after-free

Moving trace_v4l2_hw_done() inside the
if (cancel_delayed_work(&vpu->watchdog_work)) block avoids both the
race and the duplicate trace event.

[Severity: Low]
In drivers/media/platform/verisilicon/hantro_drv.c, hantro_watchdog()
(around line 131):
Can trace_v4l2_hw_done() in hantro_watchdog() report a stale
ctx->hw_cycles value from an earlier frame?

ctx->hw_cycles is only written in rk3588_vpu981_irq() and is never reset
before a new job starts or when a job times out.  If frame N succeeds on
VPU981 and frame N+1 times out (or fails at the prepare_error path in
rockchip_vpu981_av1_dec_run()), trace_v4l2_hw_done() reports frame N's
cycle count instead of 0.

[Severity: Medium]
In drivers/media/platform/verisilicon/hantro_drv.c, device_run()
(around line 199):
Can the completion interrupt fire inside ctx->codec_ops->run(ctx) before
device_run() calls trace_v4l2_hw_run()?

The .run() callbacks start the hardware before returning, while
device_run() runs with interrupts and preemption enabled.  If the job
completes immediately (or device_run() is preempted right after writing
the start register), hantro_irq_done() emits trace_v4l2_hw_done() before
trace_v4l2_hw_run() runs, and also clears TRANS_RUNNING so a concurrent
hantro_release() can kfree(ctx) before trace_v4l2_hw_run() reads
ctx->fh.tgid and ctx->fh.fd:

CPU0                              CPU1
device_run()
  ctx->codec_ops->run(ctx)
    /* starts HW */
                                  <hardirq>
                                  hantro_irq_done()
                                    trace_v4l2_hw_done(...)
                                    hantro_job_finish(ctx, ...)
                                  hantro_release()
                                    v4l2_m2m_ctx_release()
                                    kfree(ctx)
  trace_v4l2_hw_run(ctx->fh.tgid,
                    ctx->fh.fd)   <-- use-after-free

[Severity: High]
In drivers/media/platform/verisilicon/rockchip_vpu_hw.c,
rk3588_vpu981_irq() (around lines 427-438):
Can ctx be NULL or freed when rk3588_vpu981_irq() writes ctx->hw_cycles?

If hantro_watchdog() expires before the interrupt runs,
hantro_job_finish() clears m2m_dev->curr_ctx to NULL.  Because
rk3588_vpu981_codec_ops has no .reset callback, the VPU981 hardware keeps
running and can still raise its interrupt afterward.  Although
hantro_irq_done() checks if (ctx), rk3588_vpu981_irq() unconditionally
dereferences ctx->hw_cycles right before calling hantro_irq_done(),
causing a NULL pointer dereference in hard IRQ context.

Even when v4l2_m2m_get_curr_priv() returns a non-NULL ctx,
v4l2_m2m_get_curr_priv() drops job_spinlock before returning and
cancel_delayed_work() has not run yet, so a concurrent hantro_watchdog()
and hantro_release() can finish the job and kfree(ctx) before
ctx->hw_cycles is written.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-v4l2-add-f=
trace-v3-0-1d1db48372ed@collabora.com?part=3D9
