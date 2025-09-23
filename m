Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F113BE5E;
	Tue, 23 Sep 2025 00:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586809; cv=none; b=iniv7KRyYiLAPwfTztxywLudkjTtxpf6zv73apXrufKum+JNLz8eJd3hfnB4F2fIVqS+1p0F3wn3Muhc0z4A7+97mSduHfe92UDxc+qHvdW8skNM5f11lyYcf8flzHJGxzeBuR3DioPmjG7EuL/JzCAPhRlBp5FusRVpLXPXdb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586809; c=relaxed/simple;
	bh=/YBR+R7LfGYnIdMOOdTLlGjgAGM0YwIAXCZB1PCXPHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2wDSbTiHs7kDMuyBe3l4rLOLozshajoK8OZdt831apsoJN012xuhvZGK5cTFSvMyZ4APO/We1/b7jWNd9NrtHbaJZIfKImvIcr8ztXNbGDyDuS94SjE/An7j0iU3X+9oe0oocSw2LXIvaRxWpYYK19JbzqyTcgVUcoeVaCSvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vII9/bnp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vII9/bnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AA2C4CEF0;
	Tue, 23 Sep 2025 00:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586809;
	bh=/YBR+R7LfGYnIdMOOdTLlGjgAGM0YwIAXCZB1PCXPHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vII9/bnpzWpioGSZ+2cDByaO4ZessAu6VxmjFltMYns07Rls7A8wbbyZHF1/bjJ02
	 koohXi76kRLB7IK4L+eOiZzzgwHa+ruWeK3xlwVSE42zavkujpxJjXfE6ryrtcnGhy
	 ZTvoRJaDo1aUiAtkOBaPgLZKjV5ywPjMnAMryNoPifDM2HgoaMkpjnMr6/vjmKeyVk
	 0UexqKVtoSDX77iQKgC8JyM71ePPxSN8YKnv5+BgbFuVcZAoktl8z2ATpeMujz0k2i
	 QQLbvr0X2A2IxAxzRKQzlhopS24Ku1Y/31bzbOzC4BS57ONvPDvjtZLHdUFj261K4H
	 8h5WETmOROLUQ==
Date: Mon, 22 Sep 2025 17:20:04 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
Message-ID: <20250923002004.GA2836051@ax162>
References: <20250806120911.989365-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806120911.989365-1-namcao@linutronix.de>

Hi Nam,

On Wed, Aug 06, 2025 at 02:09:11PM +0200, Nam Cao wrote:
> Argument 'p' of enabled_monitors_next() is not a pointer to struct
> rv_monitor, it is actually a pointer to the list_head inside struct
> rv_monitor. Therefore it is wrong to cast 'p' to struct rv_monitor *.
> 
> This wrong type cast has been there since the beginning. But it still
> worked because the list_head was the first field in struct rv_monitor_def.
> This is no longer true since commit 24cbfe18d55a ("rv: Merge struct
> rv_monitor_def into struct rv_monitor") moved the list_head, and this wrong
> type cast became a functional problem.
> 
> Properly use container_of() instead.
> 
> Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>  kernel/trace/rv/rv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index bd7d56dbf6c2..6ce3495164d8 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -495,7 +495,7 @@ static void *available_monitors_next(struct seq_file *m, void *p, loff_t *pos)
>   */
>  static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
>  {
> -	struct rv_monitor *mon = p;
> +	struct rv_monitor *mon = container_of(p, struct rv_monitor, list);
>  
>  	(*pos)++;

I am seeing a crash when reading from /sys/kernel/tracing/rv/enabled_monitors
on a couple of my arm64 boxes running Fedora after this change, which
landed in mainline in 6.17-rc7. I can reproduce this in QEMU pretty
easily.

  $ cat kernel/configs/repro.config
  CONFIG_FTRACE=y
  CONFIG_RV=y
  CONFIG_RV_MON_WWNR=y
  CONFIG_RV_PER_TASK_MONITORS=2
  CONFIG_RV_REACTORS=y
  CONFIG_RV_REACT_PANIC=y
  CONFIG_RV_REACT_PRINTK=y

  $ git show -s --format='%h ("%s")'
  097a6c336d00 ("Merge tag 'trace-rv-v6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace")

  $ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- clean virtconfig repro.config Image.gz

  $ curl -LSs https://github.com/ClangBuiltLinux/boot-utils/releases/download/20241120-044434/arm64-rootfs.cpio.zst | zstd -d >rootfs.cpio

  $ qemu-system-aarch64 \
      -display none \
      -nodefaults \
      -cpu max,pauth-impdef=true \
      -machine virt,gic-version=max,virtualization=true \
      -append 'console=ttyAMA0 earlycon rdinit=/bin/sh'
      -kernel arch/arm64/boot/Image.gz \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
  ...
  [    0.000000] Linux version 6.17.0-rc6-00143-g097a6c336d00 (nathan@aadp) (aarch64-linux-gcc (GCC) 15.2.0, GNU ld (GNU Binutils) 2.45) #1 SMP PREEMPT Mon Sep 22 17:03:48 MST 2025
  ...
  ~ # mount -t sysfs sysfs /sys &&
  > mount -t tracefs tracing /sys/kernel/tracing &&
  > cat /sys/kernel/tracing/rv/enabled_monitors
  [  134.672494] Unable to handle kernel paging request at virtual address ffffffffffffffd0
  [  134.675919] Mem abort info:
  [  134.677233]   ESR = 0x0000000096000006
  [  134.679118]   EC = 0x25: DABT (current EL), IL = 32 bits
  [  134.680880]   SET = 0, FnV = 0
  [  134.682180]   EA = 0, S1PTW = 0
  [  134.683788]   FSC = 0x06: level 2 translation fault
  [  134.685435] Data abort info:
  [  134.687096]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
  [  134.688973]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  [  134.690889]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
  [  134.692687] swapper pgtable: 4k pages, 52-bit VAs, pgdp=00000000417a8000
  [  134.694969] [ffffffffffffffd0] pgd=1000000041c8d003, p4d=0000000041bf2403, pud=0000000041bf3403, pmd=0000000000000000
  [  134.700920] Internal error: Oops: 0000000096000006 [#1]  SMP
  [  134.702603] Modules linked in:
  [  134.703956] CPU: 0 UID: 0 PID: 53 Comm: cat Not tainted 6.17.0-rc6-00143-g097a6c336d00 #1 PREEMPT
  [  134.705506] Hardware name: linux,dummy-virt (DT)
  [  134.706481] pstate: a1402009 (NzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  [  134.707595] pc : enabled_monitors_start+0x6c/0xa0
  [  134.709324] lr : enabled_monitors_start+0x24/0xa0
  [  134.710047] sp : ffff80008043bbf0
  [  134.710557] x29: ffff80008043bbf0 x28: fff0000002e58000 x27: 0000000000000000
  [  134.711889] x26: ffff80008043bca0 x25: fff0000002b44038 x24: 0000000000000000
  [  134.712965] x23: 0000000000000001 x22: 0000000000000000 x21: ffff80008043bcc8
  [  134.714028] x20: ffffa8bf4243e000 x19: ffffa8bf4243ed00 x18: 0000000000000000
  [  134.714994] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
  [  134.716046] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
  [  134.717110] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
  [  134.718219] x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000000
  [  134.719246] x5 : 0000000000001000 x4 : fff000001fdea760 x3 : 0000000000000000
  [  134.720195] x2 : 0000000000000000 x1 : fff0000002b44028 x0 : ffffffffffffffc0
  [  134.721411] Call trace:
  [  134.722173]  enabled_monitors_start+0x6c/0xa0 (P)
  [  134.723088]  seq_read_iter+0xd4/0x47c
  [  134.723752]  seq_read+0xec/0x12c
  [  134.724200]  vfs_read+0xc4/0x33c
  [  134.724791]  ksys_read+0x64/0x100
  [  134.725255]  __arm64_sys_read+0x18/0x24
  [  134.725860]  invoke_syscall.constprop.0+0x40/0xf0
  [  134.726466]  el0_svc_common.constprop.0+0x38/0xd8
  [  134.727092]  do_el0_svc+0x1c/0x28
  [  134.727558]  el0_svc+0x34/0xe8
  [  134.728112]  el0t_64_sync_handler+0xa0/0xe4
  [  134.728763]  el0t_64_sync+0x198/0x19c
  [  134.729790] Code: f9402001 d1010020 eb01027f 540000c0 (39404001)
  [  134.731074] ---[ end trace 0000000000000000 ]---
  Segmentation fault

With this change reverted, there is no crash. As this change seems to
have proper justification, is there some other latent bug here?

If there is any other information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan
