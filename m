Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B926CE0A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765907392; cv=none; b=JedPcnW6EyRiVibkPIwrYK+nV7Z2DGtPoYDwec4/KLa1Xya8m2fOeNXPVpWJDzWYMLdwthS1Fru9L0FbjzvhXClVIofhEioJr5PEDgRhXbadvwSsB1V4BWD98dc+vgehDN+fiDB3YRlECt5cONZ8WnfziBkF40sY0yeCLSqk5Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765907392; c=relaxed/simple;
	bh=PMPIzd9q+CYmsb1evjU8F7QFL1nhdvZvtpJRwhqCcGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UPKnboyKJ9p1WTigaQa4Ij11qb5mRLQcjDFDj4oNfPJXDevbHUkItd1L37T/6OvNhrVnzYbpUmpPG47DfQtyLIemVUTNdsvHDoKwPZm9ywGjDLuLHIqLtJc3v6ZbmA9QrYaMGjgUald2lX6dnfcuHhg0+CCgE2bvZ7eBN5/g/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vm70T+vH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vm70T+vH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74923C4CEF1;
	Tue, 16 Dec 2025 17:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765907391;
	bh=PMPIzd9q+CYmsb1evjU8F7QFL1nhdvZvtpJRwhqCcGM=;
	h=Date:From:To:Cc:Subject:From;
	b=Vm70T+vH0dGgjZkfNCFOWxKsUT4Vfl2jb5luELZNByZvfuRygvK53ejZ5beebJrKK
	 KKqJpGIkKQXPHrucaA8MEhgkyOT+v59XIytrIS/wkwmUT0CnN9T4ijvR1/e8sOnhzo
	 Rr0qZA9346SVertJinvgcMWPEHEricf34o0nItdsje3NRgSxRLrn38igTUJDZ9Itk9
	 b+aBYWGj1kykz7gxBSFKP5L/uLnTeY8HIoNsfDh3QYXBx+tF6MUYzw5qgi1mOMsRF4
	 trSwV+8+153opuVX5K4LXNR78IPG6DMI3H5ZnTvXi6qTViyDNzozQFpsTQtXDbyl+d
	 w0YHRCUMey3bg==
Date: Tue, 16 Dec 2025 09:49:50 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: rostedt@goodmis.org, mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] trace: fix UBSAN warning in __remove_instance
Message-ID: <20251216174950.GA7705@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Darrick J. Wong <djwong@kernel.org>

xfs/558 triggers the following UBSAN warning:

 ------------[ cut here ]------------
 UBSAN: shift-out-of-bounds in /storage/home/djwong/cdev/work/linux-xfs/kernel/trace/trace.c:10510:10
 shift exponent 32 is too large for 32-bit type 'int'
 CPU: 1 UID: 0 PID: 888674 Comm: rmdir Not tainted 6.19.0-rc1-xfsx #rc1 PREEMPT(lazy)  dbf607ef4c142c563f76d706e71af9731d7b9c90
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-4.module+el8.8.0+21164+ed375313 04/01/2014
 Call Trace:
  <TASK>
  dump_stack_lvl+0x4a/0x70
  ubsan_epilogue+0x5/0x2b
  __ubsan_handle_shift_out_of_bounds.cold+0x5e/0x113
  __remove_instance.part.0.constprop.0.cold+0x18/0x26f
  instance_rmdir+0xf3/0x110
  tracefs_syscall_rmdir+0x4d/0x90
  vfs_rmdir+0x139/0x230
  do_rmdir+0x143/0x230
  __x64_sys_rmdir+0x1d/0x20
  do_syscall_64+0x44/0x230
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
 RIP: 0033:0x7f7ae8e51f17
 Code: f0 ff ff 73 01 c3 48 8b 0d de 2e 0e 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 54 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 b1 2e 0e 00 f7 d8 64 89 02 b8
 RSP: 002b:00007ffd90743f08 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
 RAX: ffffffffffffffda RBX: 00007ffd907440f8 RCX: 00007f7ae8e51f17
 RDX: 00007f7ae8f3c5c0 RSI: 00007ffd90744a21 RDI: 00007ffd90744a21
 RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
 R10: 00007f7ae8f35ac0 R11: 0000000000000246 R12: 00007ffd90744a21
 R13: 0000000000000001 R14: 00007f7ae8f8b000 R15: 000055e5283e6a98
  </TASK>
 ---[ end trace ]---

whilst tearing down an ftrace instance.  TRACE_FLAGS_MAX_SIZE is now 64,
so the mask comparison expression must be typecast to a u64 value to
avoid an overflow.  AFAICT, ZEROED_TRACE_FLAGS is already cast to ULL
so this is ok.

Fixes: bbec8e28cac592 ("tracing: Allow tracer to add more than 32 options")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 kernel/trace/trace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e575956ef9b5a2..6f2148df14d966 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -10507,7 +10507,7 @@ static int __remove_instance(struct trace_array *tr)
 
 	/* Disable all the flags that were enabled coming in */
 	for (i = 0; i < TRACE_FLAGS_MAX_SIZE; i++) {
-		if ((1 << i) & ZEROED_TRACE_FLAGS)
+		if ((1ULL << i) & ZEROED_TRACE_FLAGS)
 			set_tracer_flag(tr, 1ULL << i, 0);
 	}
 
