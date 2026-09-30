Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958AF4E2F33;
	Wed, 30 Sep 2026 15:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780688; cv=none; b=W1HnlmIQnAjDKER0wkQ70tItPYRFgU2qXnCNBfJ1oLab0OEjJ/nIqI85AAXQX11JDrWwiUqeHDryWZMnlYTmCaV8K87lUEiG9su5XE2R8H9QcB3w0fps87lc22+FFo4guac/nTTyBMkDwnXrHHhqmzkWKdY0sE4pFxtYTYXYbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780688; c=relaxed/simple;
	bh=r+nLw7Wd5AVHwY6nNiZC/bIHfgeeTqrTVuF3dvh6Ws0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RqRBNcW63p3qK0uMiwNJn5V0pXxw54UjBqXt0UUS0C4PnogcJfQ3wUxmwca4JNhUDLHPzrh19PCQNgGEnx5HatbLrS4/Fs2vr2LQWux+n0mNajp63Xm4q9yCJ/XPKM8gcwVY6FE1IzOjEvqvu5o+bcXweOXHPzNuRENHK3KkyvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmdDKH44; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmdDKH44"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D371F000FF;
	Wed, 30 Sep 2026 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780676;
	bh=gg4us66Hi6ASpn+YqC9GwbM/RclqWMZq9iwqtXVoaTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jmdDKH44VC+pFMFBRDILZlf56ykX0Cdx3BrgcWzL3nh/uzKQcAxR6gIK/KrFU0xXx
	 jHoH+ZZBmobex/0VR7B9iEduJFXc51bvrGvXAUweWDng2gk0mdQ5re7RCsGr2pWk5x
	 +T2493VzzDSy1QqrzCPEE11wxlC5u1dJ7F+C/9rYosneKb7+2cKpJCnpyuJxR9qMy4
	 x4faFRt0cAmpYfo9G8Hwzpl+/qrTgGC6bkvkwKFhSuXvgxZXHXmaVFBQRSRg7PWenu
	 6yw9+fWu1WDQrK0hx+n8XBCldD51LZw5OMR5jus1EC6kccw63lYXnFdnBVyxFj/+kQ
	 IWsFAqz4QJp2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] soc: qcom: qpace: Add Qualcomm Page Compression
 Engine driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Georgi Djakov" <georgi.djakov@oss.qualcomm.com>
Cc: robh@kernel.org, linux-trace-kernel@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
 <20260930145215.3380977-3-georgi.djakov@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 15:04:35 +0000
Message-Id: <20260930150435.C5D371F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] soc: qcom: qpace: concurrent MMIO access from CPU aliasing on >8 c=
ores
- [High] soc: qcom: qpace: UAF of global qpace_priv after driver unbind
- [High] soc: qcom: qpace: 100ms busy wait with preemption disabled causes =
latency spikes
- [High] soc: qcom: qpace: interrupt storm due to uncleared level-triggered=
 IRQ
- [High] soc: qcom: qpace: stray DMA writes on urgent command timeout
- [High] soc: qcom: qpace: hardware stuck in STOP mode after suspend/resume
- [Medium] soc: qcom: qpace: silent truncation of unaligned output_addr cau=
ses DMA corruption
- [Medium] soc: qcom: qpace: inline stp assembly breaks big-endian architec=
tures
--

commit 5edbc123f3ebd977977e7d874e4ecebc5ed95e6a
Author: Georgi Djakov <georgi.djakov@oss.qualcomm.com>

soc: qcom: qpace: Add Qualcomm Page Compression Engine driver

This commit adds a platform driver for the Qualcomm Page Compression Engine
(QPaCE). It provides the urgent command path for synchronous single-page
compression and decompression, supporting low-latency operations for
compressed-memory users like zram.

> diff --git a/drivers/soc/qcom/qpace.c b/drivers/soc/qcom/qpace.c
> index 0000000000000..69aa14b7c4772
> --- /dev/null
> +++ b/drivers/soc/qcom/qpace.c
[ ... ]
> +static inline int qpace_urgent_command_trigger(dma_addr_t input_addr,
> +					       dma_addr_t output_addr,
> +					       int urg_reg_num,
> +					       enum urg_reg_cxts command)
> +{
> +	void __iomem *td_dst_src_reg =3D qpace_priv->urg_regs +
> +				       (urg_reg_num * QPACE_REG_PAGE_SIZE) +
> +					QPACE_URG_CMD_0_TD_DST_ADDR_L_CFG_CNTXT_OFFSET;
> +	u64 urg_addr_field_lower, urg_addr_field_upper;
> +	u32 stat_reg;
> +	unsigned long ret;
> +
> +	urg_addr_field_lower =3D FIELD_PREP(URG_CMD_0_TD_DST_ADDR_L__CMD_CFG_CN=
TXT,
> +					  command);
> +	urg_addr_field_lower |=3D GENMASK(63, 8) & output_addr;

[Severity: Medium]
Will this silently truncate the output_addr if the caller passes an address
that is not 256-byte aligned? In qpace_urgent_command_trigger(), this drops
the lowest 8 bits, meaning the hardware will write to the incorrectly
truncated address and overwrite up to 255 bytes of memory before the
intended buffer.

> +
> +	urg_addr_field_upper =3D input_addr;
> +
> +	/* Clear a stale request-on-active error before ringing the doorbell. */
> +	qpace_write_urg_cmd(qpace_priv, urg_reg_num, QPACE_URG_CMD_0_STAT_CLR_O=
FFSET,
> +			    URG_CMD_0_STAT_CLR_REQ_ON_ACTIVE_ERR);
> +
> +	/* Ensure that preceding stores that QPaCE will depend on are done exec=
uting */
> +	dma_wmb();
> +
> +	/*
> +	 * Ring the doorbell with a single 128-bit atomic store. QPaCE
> +	 * triggers processing when it observes the (dst_addr, src_addr)
> +	 * pair land together.
> +	 */
> +	asm volatile("stp %0, %1, [%2]\n" :
> +		     : "r" (urg_addr_field_lower), "r" (urg_addr_field_upper), "r" (td=
_dst_src_reg)
> +		     : "memory");

[Severity: Medium]
Does this inline assembly break big-endian architectures? By bypassing the
standard writeq() accessors, this stp instruction skips implicit cpu_to_le64
conversions, causing the hardware to receive byte-swapped, garbage memory
addresses and context configurations if the kernel is compiled with
CONFIG_CPU_BIG_ENDIAN.

> +
> +	ret =3D readl_poll_timeout_atomic(qpace_priv->urg_regs +
> +					urg_reg_num * QPACE_REG_PAGE_SIZE +
> +					QPACE_URG_CMD_0_ED_STAT_OFFSET,
> +					stat_reg,
> +					FIELD_GET(URG_CMD_0_ED_STAT_COMP_CODE,
> +						  stat_reg) !=3D OP_URG_ONGOING,
> +					1, 100 * USEC_PER_MSEC);

[Severity: High]
Does this cause severe scheduling latency spikes or RCU stalls? The caller,
such as qpace_urgent_compress(), disables preemption via get_cpu() before
initiating this hardware poll. Executing a 100ms busy-wait loop in
qpace_urgent_command_trigger() while preemption is completely disabled
can freeze CPU cores for unacceptable durations under load.

> +	if (ret) {
> +		dev_err(qpace_priv->dev, "QPaCE urgent command timed out\n");
> +		return -ETIMEDOUT;
> +	}

[Severity: High]
Are we returning a timeout error here without stopping the hardware from
continuing the DMA operation? If the hardware takes longer than 100ms in
qpace_urgent_command_trigger(), this returns -ETIMEDOUT while the device
continues. If the caller (like zram) frees the output page, the hardware
could later finish and cause delayed asynchronous memory corruption.

> +
> +	return stat_reg;
> +}
> +
> +int qpace_urgent_compress(dma_addr_t input_addr,
> +			  dma_addr_t output_addr,
> +			  struct qpace_algorithm *algo)
> +{
> +	int urg_reg_num;
> +	int stat_reg;
> +	u32 stat_reg_val;
> +	int ret;
> +
> +	ret =3D qpace_get();
> +	if (ret)
> +		return ret;
> +
> +	urg_reg_num =3D get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
> +	stat_reg =3D qpace_urgent_command_trigger(input_addr, output_addr, urg_=
reg_num,
> +						algo->urg_comp_cntxt);

[Severity: High]
Can this assign identical hardware registers to different CPUs running
concurrently when NR_CPUS is greater than 8 without cross-CPU mutual
exclusion? In qpace_urgent_compress(), get_cpu() disables preemption but
provides no mutual exclusion across different cores. If two threads initiate
compression on CPU 0 and CPU 8 simultaneously, they will both be assigned
urg_reg_num =3D 0 and race on the same MMIO block, leading to data corrupti=
on
and hardware timeouts.

> +	put_cpu();
> +
> +	qpace_put();
[ ... ]
> +int qpace_urgent_decompress(dma_addr_t input_addr,
> +			    dma_addr_t output_addr,
> +			    size_t input_size,
> +			    struct qpace_algorithm *algo)
> +{
> +	int urg_reg_num;
> +	int stat_reg;
> +	u32 stat_reg_val;
> +	int ret;
> +
> +	ret =3D qpace_get();
> +	if (ret)
> +		goto out;
> +
> +	urg_reg_num =3D get_cpu() % NUM_TRS_ERS_URG_CMD_REGS;
> +	qpace_write_urg_cmd_ctx(qpace_priv, QPACE_URG_CMD_0_CFG_CNTXT_SIZE_n_OF=
FSET,
> +				urg_reg_num, algo->urg_decomp_cntxt,
> +				FIELD_PREP(URG_CMD_0_CFG_CNTXT_SIZE_SIZE, input_size));

[Severity: High]
Does this dynamically overwrite the shared hardware context size register
concurrently across aliasing CPUs? In qpace_urgent_decompress(), with
more than 8 cores, aliasing CPUs will race on this MMIO block leading to
data corruption.

> +	stat_reg =3D qpace_urgent_command_trigger(input_addr, output_addr, urg_=
reg_num,
> +						algo->urg_decomp_cntxt);
> +	put_cpu();
[ ... ]
> +int qpace_get(void)
> +{
> +	int ret =3D 0;
> +
> +	mutex_lock(&qpace_ref_lock);
> +	if (qpace_priv->suspended || READ_ONCE(qpace_priv->broken))
> +		ret =3D -EBUSY;

[Severity: High]
Can this exported API blindly dereference the global pointer after the driv=
er
has been unbound? If the device is unbound via sysfs, qpace_priv is freed,
but the global pointer remains set. A subsequent call from a client like zr=
am
will call qpace_get() which dereferences qpace_priv->suspended, resulting in
a use-after-free.

> +	else
> +		_get_qpace();
> +	mutex_unlock(&qpace_ref_lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(qpace_get);
[ ... ]
> +static irqreturn_t urgent_interrupt_handler(int irq, void *unused)
> +{
> +	pr_debug("Urgent interrupt handled\n");
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Will this cause a catastrophic interrupt storm? The
urgent_interrupt_handler() fails to acknowledge or clear the interrupt at
the device level. Because the GIC interrupt is level-triggered, returning
IRQ_HANDLED without clearing it on the hardware will cause it to
immediately re-fire forever, resulting in a hard CPU lockup if the
hardware ever asserts this line.

[ ... ]
> +static void qpace_remove(struct platform_device *pdev)
> +{
> +	mutex_lock(&qpace_ref_lock);
> +	qpace_priv->suspended =3D true;
> +	mutex_unlock(&qpace_ref_lock);
> +
> +	static_branch_disable(&qpace_drv_probed);
> +
> +	wait_for_completion(&qpace_priv->no_active_refs);
> +
> +	/* No callers remain; tear down the hardware. */
> +	cancel_work_sync(&qpace_priv->disable_work);
> +	qpace_power_off(&pdev->dev);
> +}

[Severity: High]
Does this leave the global qpace_priv pointer set? In qpace_remove(), the
device is torn down and devres will free the memory backing qpace_priv, but
the global pointer is never cleared, enabling the use-after-free mentioned
above.

[ ... ]
> +static int qpace_resume(struct device *dev)
> +{
> +	int ret;
> +
> +	mutex_lock(&qpace_ref_lock);
> +
> +	if (qpace_priv->active_rings)
> +		dev_err(dev, "active_rings not 0, unexpected case\n");
> +
> +	ret =3D icc_set_bw(qpace_priv->interconnect, 0, 1);
> +	if (ret)
> +		goto out_unlock;
> +
> +	program_urg_command_contexts_v2();
> +	program_decomp_core_cfg();
> +
> +	qpace_priv->suspended =3D false;

[Severity: High]
Will the hardware be stuck in STOP mode after suspend/resume? In
qpace_resume(), we restore contexts but fail to wake the hardware engine
up to RUN mode (omitting the QPACE_RUN write) and fail to reprogram
essential bulk mode and cache index settings from qpace_hw_init(). This
means all hardware operations will indefinitely time out after the system
resumes.

> +
> +out_unlock:
> +	if (ret)
> +		dev_err(dev, "failed to resume QPaCE: %d\n", ret);
> +	mutex_unlock(&qpace_ref_lock);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930145215.3380=
977-1-georgi.djakov@oss.qualcomm.com?part=3D2
