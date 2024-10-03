Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A1211CA0;
	Thu,  3 Oct 2024 02:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727921424; cv=none; b=eRXyQHTpK1YZKWdTJSNq8Vwv02BztGwn4HTRjYp7qLswJC2P+WVb16pNp8SdxMRoj/CRhMYnZz8kB50bj+o9hTnwEel57maLAuYHX/MYYtGhJCs+k34vjDELCTlrlOVmn3cvDFmfBlG50jG9pyz7UENsdLLNxP5cq3APcRS59pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727921424; c=relaxed/simple;
	bh=xfplKuyANPlerQeBTTfg6KbZDn0osN7IGvBaB6L7fhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2JyXHpgTq96pGRblAp3kVm1wIkhnQKkDBm/k6dbxwXAPwleYqXN0a5YLbaULyvuhyrN56TvymqVfZuN5PzqvTnWYsRQkdkCa8fyoxPN/RmzIVg5zYqYhT5Dx8/BS60DsZMJwU+lH1tLoEf8fQP30eJRovVzsgwc8RSlqo6Ickg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB464C4CEC2;
	Thu,  3 Oct 2024 02:10:22 +0000 (UTC)
Date: Wed, 2 Oct 2024 22:11:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
 linux-cxl@vger.kernel.org
Subject: Re: RIP: 0010:trace_check_vprintf 6.12-rc1 & CXL test
Message-ID: <20241002221114.74bf1b85@gandalf.local.home>
In-Reply-To: <Zv3z5UsG_jsO9_Tb@aschofie-mobl2.lan>
References: <Zv3z5UsG_jsO9_Tb@aschofie-mobl2.lan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Oct 2024 18:31:17 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Hi Steve,
> 
> Using 6.12-rc1 hitting this on every trace attempt.
> Is this a known issue?

No, but the backtrace looks funny.

> 
> --Alison
> 
> [  110.689666] BUG: kernel NULL pointer dereference, address: 0000000000000058
> [  110.691694] #PF: supervisor read access in kernel mode
> [  110.693058] #PF: error_code(0x0000) - not-present page
> [  110.694420] PGD 0 P4D 0 
> [  110.695347] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
> [  110.696613] CPU: 2 UID: 0 PID: 1518 Comm: bash Tainted: G           O     N 6.12.0-rc1 #304
> [  110.698454] Tainted: [O]=OOT_MODULE, [N]=TEST
> [  110.699665] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [  110.701447] RIP: 0010:trace_check_vprintf+0x3d/0x610

I think the above is:

	if (iter->fmt == static_fmt_buf)
		goto print;

That is at least what trace_check_vprintf+0x3d is on my kernel.

> [  110.702370] Code: 55 b0 48 8b 17 48 85 f6 0f 84 74 05 00 00 49 89 fc 0f 1f 44 00 00 0f b6 06 48 81 bf d8 00 00 00 00 24 de 83 0f 84 50 05 00 00 <48> 8b 7a 58 49 89 f1 48 89 7d b8 48 8b 7a 60 48 89 7d 98 84 c0 74
> [  110.705146] RSP: 0018:ffffc9000ec8ba00 EFLAGS: 00010007
> [  110.706110] RAX: 000000000000006d RBX: ffff888000180000 RCX: ffff888001bfe0b0
> [  110.707290] RDX: 0000000000000000 RSI: ffffffffa0c40750 RDI: ffff888000180000
> [  110.708465] RBP: ffffc9000ec8ba78 R08: 000000000000000a R09: ffff8880001801f4
> [  110.709640] R10: 0000000000000001 R11: 000000000000b6a5 R12: ffff888000180000
> [  110.710819] R13: ffff8880001801d8 R14: ffff8880001800e8 R15: ffff8880001800e8
> [  110.711791] FS:  00007f7353bc2740(0000) GS:ffff88807d900000(0000) knlGS:0000000000000000
> [  110.712674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  110.713386] CR2: 0000000000000058 CR3: 000000000b8b6000 CR4: 00000000000006f0
> [  110.714194] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  110.715002] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  110.715811] Call Trace:
> [  110.716263]  <TASK>
> [  110.716678]  ? show_regs+0x5f/0x70
> [  110.717201]  ? __die+0x1f/0x70
> [  110.717682]  ? page_fault_oops+0x14b/0x460
> [  110.718261]  ? trace_check_vprintf+0x3d/0x610
> [  110.718859]  ? search_exception_tables+0x5b/0x60
> [  110.719464]  ? fixup_exception+0x22/0x300
> [  110.720036]  ? kernelmode_fixup_or_oops.constprop.0+0x5a/0x70
> [  110.720710]  ? __bad_area_nosemaphore+0x17d/0x240
> [  110.723080]  ? bad_area_nosemaphore+0x11/0x20
> [  110.725055]  ? do_user_addr_fault+0x2b5/0x750
> [  110.726985]  ? __this_cpu_preempt_check+0x13/0x20
> [  110.729010]  ? exc_page_fault+0x6e/0x230
> [  110.730815]  ? asm_exc_page_fault+0x27/0x30
> [  110.732279]  ? trace_check_vprintf+0x3d/0x610
> [  110.733569]  ? vsnprintf+0x182/0x530
> [  110.734719]  trace_event_printf+0x4d/0x60
> [  110.735964]  trace_raw_output_cxl_generic_event+0x105/0x130 [cxl_core]

The above is for calling output from the ring buffer.

> [  110.737704]  trace_event_buffer_commit+0x13b/0x280

Hmm, do you have "tp_printk" on the kernel command line?

-- Steve

> [  110.739102]  trace_event_raw_event_cxl_generic_event+0x1f9/0x290 [cxl_core]
> [  110.740877]  cxl_event_trace_record+0x1f2/0x370 [cxl_core]
> [  110.742595]  __cxl_event_trace_record+0x95/0xf0 [cxl_core]
> [  110.744738]  cxl_mem_get_records_log+0xf9/0x270 [cxl_core]
> [  110.746833]  cxl_mem_get_event_records+0x55/0xa0 [cxl_core]
> [  110.748920]  event_trigger_store+0x82/0x90 [cxl_mock_mem]
> [  110.750945]  dev_attr_store+0x12/0x30
> [  110.752222]  sysfs_kf_write+0x47/0x60
> [  110.753292]  kernfs_fop_write_iter+0x13d/0x1f0
> [  110.754490]  vfs_write+0x25d/0x500
> [  110.755518]  ksys_write+0x5d/0xe0
> [  110.756530]  __x64_sys_write+0x14/0x20
> [  110.757609]  x64_sys_call+0x1d2a/0x1f30
> [  110.758690]  do_syscall_64+0x64/0x140
> [  110.759740]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  110.760992] RIP: 0033:0x7f7353ccdee4
> [  110.762029] Code: c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 80 3d 85 74 0d 00 00 74 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 55 48 89 e5 48 83 ec 20 48 89
> [  110.764713] RSP: 002b:00007ffd83c599d8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
> [  110.765837] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7353ccdee4
> [  110.766912] RDX: 0000000000000002 RSI: 0000561932b72bd0 RDI: 0000000000000001
> [  110.767993] RBP: 00007ffd83c59a00 R08: 0000000000001428 R09: 0000000100000000
> [  110.769058] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000002
> [  110.770118] R13: 0000561932b72bd0 R14: 00007f7353d9e5c0 R15: 00007f7353d9bf20
> [  110.771180]  </TASK>
> [  110.771738] Modules linked in: cxl_test(ON) cxl_mem(ON) cxl_port(ON) cxl_pmem(ON) cxl_acpi(ON) nd_pmem(ON) dax_pmem(ON) nd_btt(ON) device_dax(ON) kmem dax_cxl nd_e820(ON) nfit(ON) cxl_mock_mem(ON) cxl_mock(ON) libnvdimm(ON) nfit_test_iomap(ON) cxl_core(ON) [last unloaded: cxl_port(ON)]
> [  110.774348] CR2: 0000000000000058
> [  110.774885] ---[ end trace 0000000000000000 ]---
> [  110.775519] RIP: 0010:trace_check_vprintf+0x3d/0x610
> [  110.776166] Code: 55 b0 48 8b 17 48 85 f6 0f 84 74 05 00 00 49 89 fc 0f 1f 44 00 00 0f b6 06 48 81 bf d8 00 00 00 00 24 de 83 0f 84 50 05 00 00 <48> 8b 7a 58 49 89 f1 48 89 7d b8 48 8b 7a 60 48 89 7d 98 84 c0 74
> [  110.778140] RSP: 0018:ffffc9000ec8ba00 EFLAGS: 00010007
> [  110.778846] RAX: 000000000000006d RBX: ffff888000180000 RCX: ffff888001bfe0b0
> [  110.779678] RDX: 0000000000000000 RSI: ffffffffa0c40750 RDI: ffff888000180000
> [  110.780521] RBP: ffffc9000ec8ba78 R08: 000000000000000a R09: ffff8880001801f4
> [  110.781364] R10: 0000000000000001 R11: 000000000000b6a5 R12: ffff888000180000
> [  110.782204] R13: ffff8880001801d8 R14: ffff8880001800e8 R15: ffff8880001800e8
> [  110.783049] FS:  00007f7353bc2740(0000) GS:ffff88807d900000(0000) knlGS:0000000000000000
> [  110.783966] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  110.784705] CR2: 0000000000000058 CR3: 000000000b8b6000 CR4: 00000000000006f0
> [  110.785558] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  110.786393] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  110.787225] note: bash[1518] exited with irqs disabled
> [  110.787936] note: bash[1518] exited with preempt_count 3

