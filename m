Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E0B1DA55
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757614609; cv=none; b=fH0FowJVJMUpNj/BgBbT4/wjbxQoJ5pTU0+IYkvXAgnygYYV655d8x4mIGAj9Mu16yeDvDXw564zKAWATJ1ZcY+8LaRKqLkm74t/+64vSXNMc9HyC0v64dWmbFTgR0aOAXSegh71oiGKUCStoIqsduYraURBG5Ai8UR0g3jNHmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757614609; c=relaxed/simple;
	bh=0r9KvZ5HHhRbwHtxTSHek7Pc6PRaSBOXkvjB8RvnfoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sj2+7lRmOcPIicvoIvXb9GjedfSGDNrKM3OY0zxFauYYHPMtRJ7gMDpbwVOGL7ahU23zkviZP7AfhhL6A2HTQu1FOJfnkWpR2/Bvq/Pi1+1REbOpDj5gyQX6XcR8emxOmZXJ+tHrTA2o4LsDz6rjsWP1OWT5X5rJJGOruRoBNBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWyuZRVt; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWyuZRVt"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso759247f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757614605; x=1758219405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceTMMFemAGLbYEYMZ/cDuhlhF3ZauocIubfLAclCvAY=;
        b=EWyuZRVtU2oiQ4gDrF6e3jnzrh6nJ4allnNKiCSc6rCMJovlcBMJLgmwUkia9J6ir+
         szOzm7SgKoI9QQJr5bR41MYmtX2x9aTsc3nGmFXdXAzoEYVadZGTjZjc3LEoVCbWjFdB
         7hX70FAAz8/fnQ/00qtDjOBtPpVfjsI0uKu5bJEQk97xXm0lNCYYaI+TbmG4kQgOpxM+
         ABA6Vo4HnoADThMhJGB/DBRWc9N11mkX+WNCso8qMqKNS6CYN59wTjLzjEMFWH9c/emJ
         AmSx0YEw+eHhr+TS6OPekefouUgl8rGMjS0di8JzUwkziFBU97PbYG3ogxjRG9YTpMAI
         M64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757614605; x=1758219405;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceTMMFemAGLbYEYMZ/cDuhlhF3ZauocIubfLAclCvAY=;
        b=ul45wWQ99xk7NZiOekevtLuWLMvecn0xwWFBC6YzyxVn1WNZoIJ9Z+QOZNvJiPTF8Z
         UIxFIB0mXDGhjL82m/z4s+O+MTQLbhikIgKLxTL0mmeJxwDOp3SGwpr789VFVMRrFiPk
         WhVQx0KWqmdtxL4m2eTjbfA/IKNUBlo/nqcaEJW3RAvQA32OFoOEgmD0rmJ+fO3gqx+/
         50ffLptQS164+mTDkMi9h/4xfz3moKVF54a4XsWSGkn+itqFw9R7dvhtvXJk2BX/z/un
         zI8FY2lPCfLAxvHTglWe3UMCuGoh0z63aOYn0pDiLY/veFbxeiM4IY+Qeb6zfT/C5ieH
         daDw==
X-Forwarded-Encrypted: i=1; AJvYcCWDD273uS5Pos7H1YPjhMHNG1NBE9b8K8qMu+C7f4MVZROOpj0N5t6ViIR41Z+W8tX0jG5yCACJ7Pm4Y516asBcF64=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGego6MbBtA3Hzu4OEEMuuZBx6JohxfbF7WYB06Er74AHXoWWX
	1kFzO+EW3mdHhUGjTHMXVvtBMuq6stj8yvuFnTT+YFZPJOsG4fz77Fk=
X-Gm-Gg: ASbGncup7n/ePq0Ekr8JdzWdynfyyvUrWt6e1ZdkCAj+4qbRXWbzz+WfpD8/QNh0SKt
	8dFtm2jAPZk1S2dhCiDXTQ538ngEWle3gdVWewYGYAiWgcd+SlCeEvwh3/GB80OgMBv9U1OhIPl
	xE1aNJW7A6rwfM5PJOSIeQnACQdjTybQ3Lah8WQq9qebykzGI+iGhYL866BCgvanYiHrBazovUZ
	EnIApD/aPePZ/WN3U7/RKmvnu7bnfeW5K3BUHNi03gERkXtZGz6NOj65Hx0RwbAgEdHiJj8QCLG
	COX8uKZhVpvQ6g4iXWp2NLPOKnyO1RB/zBCyw4SjK3tjq64yredUuQhjWHt4/+5i15DI2g8n5o2
	izXq37oQzQNGEVuA0uIr1QwZ+G3/nAKx/1NaFgFaiZd3Y
X-Google-Smtp-Source: AGHT+IF0bIgvMEyCBSuguFMBY7F8Jgc1IxuYHmONlPBo0nSx1k2h196ST0jBDnQxNXC09dnJWC+LeA==
X-Received: by 2002:a05:6000:2005:b0:3e1:9b75:f0b8 with SMTP id ffacd0b85a97d-3e765a00860mr207428f8f.47.1757614604604;
        Thu, 11 Sep 2025 11:16:44 -0700 (PDT)
Received: from vova-pc ([85.94.110.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786ceasm3470173f8f.16.2025.09.11.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:16:44 -0700 (PDT)
Date: Thu, 11 Sep 2025 20:16:41 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: ferr.lambarginio@gmail.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
	mhiramat@kernel.org
Subject: Re: [PATCH] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <aMMSCQAINWfiDA4L@vova-pc>
Reply-To: 20250911104138.2830f60b@gandalf.local.home
References: <aMLPm__QGrQCwz1t@vova-pc>
 <20250911104138.2830f60b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911104138.2830f60b@gandalf.local.home>

On Thu, Sep 11, 2025 at 10:41:38AM -0400, Steven Rostedt wrote:
> On Thu, 11 Sep 2025 15:33:15 +0200
> Vladimir Riabchun <ferr.lambarginio@gmail.com> wrote:
> 
> > A soft lockup was observed when loading amdgpu module,
> 
> I'd like to see more about that soft lockup.
Sure, here is a call trace:
[  361.918605] [   T2076] [drm] amdgpu kernel modesetting enabled.
[  361.921884] [   T2076] amdgpu: Virtual CRAT table created for CPU
[  361.923327] [   T2076] amdgpu: Topology: Add CPU node
[  397.857556] [      C1] watchdog: BUG: soft lockup - CPU#1 stuck for 16s! [modprobe:2096]
[  397.857707] [      C1] Modules linked in: amdgpu(+) amdxcp drm_exec gpu_sched drm_buddy drm_suballoc_helper drm_ttm_helper ttm drm_display_helper cec rc_core i2c_algo_bit video wmi cfg80211 isofs binfmt_misc nls_iso8859_1 i2c_piix4 input_leds joydev serio_raw mac_hid sch_fq_codel dm_multipath efi_pstore nfnetlink dmi_sysfs qemu_fw_cfg ip_tables x_tables autofs4 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c raid1 raid0 psmouse pata_acpi cirrus floppy crypto_simd cryptd [last unloaded: amdgpu]
[  397.858531] [      C1] irq event stamp: 191866
[  397.858587] [      C1] hardirqs last  enabled at (191865): [<ffffffff82d0e47a>] irqentry_exit+0x3a/0xb0
[  397.858727] [      C1] hardirqs last disabled at (191866): [<ffffffff82d0c41f>] sysvec_apic_timer_interrupt+0xf/0xd0
[  397.858863] [      C1] softirqs last  enabled at (191816): [<ffffffff82d37d6c>] __do_softirq+0x44c/0x5e1
[  397.858986] [      C1] softirqs last disabled at (191811): [<ffffffff8117b95e>] __irq_exit_rcu+0x13e/0x160
[  397.859111] [      C1] CPU: 1 PID: 2096 Comm: modprobe Kdump: loaded Not tainted 6.8.0-31-generic #31
[  397.859229] [      C1] Hardware name: Red Hat KVM, BIOS 1.16.0-3.module_el8.7.0+3346+68867adb 04/01/2014
[  397.859349] [      C1] RIP: 0010:__asan_load4+0x35/0xd0
[  397.859419] [      C1] Code: fc 73 71 eb 0f cc cc cc 48 b8 00 00 00 00 00 00 00 ff eb 0a 48 b8 00 00 00 00 00 80 ff ff 48 39 c7 72 51 48 8d 47 03 48 89 c2 <83> e2 07 48 83 fa 02 76 29 48 b9 00 00 00 00 00 fc ff df 48 c1 e8
[  397.859681] [      C1] RSP: 0018:ffffc9000008f4c8 EFLAGS: 00000206
[  397.859762] [      C1] RAX: ffffffffa2bb5ddb RBX: ffffffffa2bb5de0 RCX: 0000000000000000
[  397.859865] [      C1] RDX: ffffffffa2bb5ddb RSI: ffffffff8130fed5 RDI: ffffffffa2bb5dd8
[  397.859967] [      C1] RBP: ffffc9000008f4c8 R08: 0000000000000000 R09: ffffc9000008f628
[  397.860070] [      C1] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffffa2c3bf50
[  397.860171] [      C1] R13: 0000000000006b99 R14: ffffffffa22382d8 R15: ffffffffa2cf49a8
[  397.860276] [      C1] FS:  00007fd742dea080(0000) GS:ffff888094080000(0000) knlGS:0000000000000000
[  397.860391] [      C1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  397.860475] [      C1] CR2: 00005d011eb97dc0 CR3: 00000000127b8000 CR4: 00000000000006f0
[  397.860597] [      C1] Call Trace:
[  397.860639] [      C1]  <IRQ>
[  397.860678] [      C1]  ? show_regs+0x6d/0x80
[  397.860740] [      C1]  ? watchdog_timer_fn+0x29d/0x360
[  397.860811] [      C1]  ? __pfx_watchdog_timer_fn+0x10/0x10
[  397.860887] [      C1]  ? __hrtimer_run_queues+0x3b3/0x650
[  397.860975] [      C1]  ? __pfx___hrtimer_run_queues+0x10/0x10
[  397.861056] [      C1]  ? kvm_clock_get_cycles+0x18/0x40
[  397.861129] [      C1]  ? ktime_get_update_offsets_now+0xb5/0x180
[  397.861218] [      C1]  ? hrtimer_interrupt+0x1a1/0x360
[  397.861306] [      C1]  ? __sysvec_apic_timer_interrupt+0x91/0x250
[  397.861393] [      C1]  ? sysvec_apic_timer_interrupt+0x8a/0xd0
[  397.861471] [      C1]  </IRQ>
[  397.861521] [      C1]  <TASK>
[  397.861562] [      C1]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  397.861663] [      C1]  ? find_kallsyms_symbol+0x1c5/0x350
[  397.861739] [      C1]  ? __asan_load4+0x35/0xd0
[  397.861806] [      C1]  find_kallsyms_symbol+0x1c5/0x350
[  397.861879] [      C1]  ? mod_hdcp_hdcp2_dp_transition+0x1140/0x1140 [amdgpu]
[  397.864007] [      C1]  ? __pfx_CalculatePrefetchSchedule.isra.0+0x10/0x10 [amdgpu]
[  397.868240] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
[  397.872439] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
[  397.876605] [      C1]  module_address_lookup+0x7f/0xd0
[  397.878686] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
[  397.882809] [      C1]  kallsyms_lookup_buildid+0xf8/0x190
[  397.884811] [      C1]  kallsyms_lookup+0x14/0x30
[  397.886734] [      C1]  test_for_valid_rec+0xcf/0x160
[  397.888597] [      C1]  ? __pfx_test_for_valid_rec+0x10/0x10
[  397.890523] [      C1]  ? debug_lockdep_rcu_enabled+0x23/0x30
[  397.892330] [      C1]  ? ops_references_ip+0xfe/0x1b0
[  397.894117] [      C1]  ? __pfx_dc_edid_parser_recv_cea_ack+0x10/0x10 [amdgpu]
[  397.897959] [      C1]  ftrace_module_enable+0x2f5/0x540
[  397.899745] [      C1]  ? 0xffffffffa0c1a000
[  397.901579] [      C1]  load_module+0xdd6/0x1220
[  397.903325] [      C1]  ? __pfx_load_module+0x10/0x10
[  397.903325] [      C1]  ? __pfx_load_module+0x10/0x10
[  397.905037] [      C1]  ? __kasan_slab_free+0x121/0x1c0
[  397.906719] [      C1]  ? vfree.part.0+0x210/0x680
[  397.908326] [      C1]  ? kfree+0x11a/0x360
[  397.909866] [      C1]  ? vfree.part.0+0x210/0x680
[  397.911365] [      C1]  ? vfree.part.0+0x65/0x680
[  397.912843] [      C1]  init_module_from_file+0xf6/0x180
[  397.914303] [      C1]  ? init_module_from_file+0xf6/0x180
[  397.915772] [      C1]  ? __pfx_init_module_from_file+0x10/0x10
[  397.917231] [      C1]  ? find_held_lock+0x8c/0xb0
[  397.918723] [      C1]  ? do_raw_spin_unlock+0xa0/0x110
[  397.920154] [      C1]  idempotent_init_module+0x206/0x470
[  397.921569] [      C1]  ? __pfx_idempotent_init_module+0x10/0x10
[  397.922961] [      C1]  ? ksys_read+0xf7/0x190
[  397.924336] [      C1]  ? __kasan_check_read+0x11/0x20
[  397.925735] [      C1]  ? __fget_light+0xa0/0xf0
[  397.927118] [      C1]  __x64_sys_finit_module+0x82/0xe0
[  397.928523] [      C1]  x64_sys_call+0x1d6e/0x25c0
[  397.929901] [      C1]  do_syscall_64+0x92/0x190
[  397.931280] [      C1]  ? syscall_exit_to_user_mode+0xcf/0x2c0
[  397.932692] [      C1]  ? do_syscall_64+0x9f/0x190
[  397.934073] [      C1]  ? do_syscall_64+0x9f/0x190
[  397.935431] [      C1]  ? do_syscall_64+0x9f/0x190
[  397.936780] [      C1]  entry_SYSCALL_64_after_hwframe+0x73/0x7b
[  397.938130] [      C1] RIP: 0033:0x7fd74252725d
[  397.939473] [      C1] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b bb 0d 00 f7 d8 64 89 01 48
[  397.942486] [      C1] RSP: 002b:00007ffc1de6bf18 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[  397.944045] [      C1] RAX: ffffffffffffffda RBX: 00005d53cf14fc50 RCX: 00007fd74252725d
[  397.945617] [      C1] RDX: 0000000000000004 RSI: 00005d53cec28e52 RDI: 0000000000000003
[  397.947206] [      C1] RBP: 00007ffc1de6bfd0 R08: 0000000000000040 R09: 00007ffc1de6bf60
[  397.948794] [      C1] R10: 00007fd742603b20 R11: 0000000000000246 R12: 00005d53cec28e52
[  397.950372] [      C1] R13: 0000000000040000 R14: 00005d53cf14fd80 R15: 0000000000000000
[  397.951975] [      C1]  </TASK>
[  397.953493] [      C1] Kernel panic - not syncing: softlockup: hung tasks
[  397.955095] [      C1] CPU: 1 PID: 2096 Comm: modprobe Kdump: loaded Tainted: G             L     6.8.0-31-generic #31
[  397.956772] [      C1] Hardware name: Red Hat KVM, BIOS 1.16.0-3.module_el8.7.0+3346+68867adb 04/01/2014
> 
> > this is the same issue that was fixed in
> > commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
> > kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
> > ftrace_graph_set_hash()").
> 
> The above cond_resched() is in the loop of all records that actually look
> at all records! And that can be pretty big. On my server, it shows on boot:
> 
> 
> [    1.934175] ftrace: allocating 45706 entries in 180 pages
> [    1.934177] ftrace: allocated 180 pages with 4 groups
> 
> That means the loop will go through 45,706 entries. That's quite a lot and
> a cond_resched() makes perfect sense.
> 
> > 
> > Fix it the same way by adding cond_resched() in ftrace_module_enable.
> > 
> > Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
> > ---
> >  kernel/trace/ftrace.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index a69067367c29..23c4d37c7bcd 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -7526,6 +7526,9 @@ void ftrace_module_enable(struct module *mod)
> >  
> >  	do_for_each_ftrace_rec(pg, rec) {
> >  		int cnt;
> > +
> > +		cond_resched();
> > +
> >  		/*
> >  		 * do_for_each_ftrace_rec() is a double loop.
> >  		 * module text shares the pg. If a record is
> 
> This loop is different. Let me show a bit more context:
> 
> 	do_for_each_ftrace_rec(pg, rec) {
> 		int cnt;
> 		/*
> 		 * do_for_each_ftrace_rec() is a double loop.
> 		 * module text shares the pg. If a record is
> 		 * not part of this module, then skip this pg,
> 		 * which the "break" will do.
> 		 */
> 		if (!within_module(rec->ip, mod))
> 			break;
> 
> See this "if (!within_module(rec->ip, mod))" break?
> 
> Look at the dmesg output again, and you'll see "groups" mentioned.
> 
> [    1.934177] ftrace: allocated 180 pages with 4 groups
> 
> That "4 groups" means there are 4 "page groups". That's the "pg" in the
> do_for_each_ftrace_recr() function.
> 
> This means in my scenario, it loops 4 times. And then it will loop through
> each module.
> 
> How big is the amdgpu driver? How many functions does it have?
> 
>  # grep amdgpu /sys/kernel/tracing/available_filter_functions | wc -l
14334 functions, hefty one.
> 
> And I'm guessing that this is only an issue when ftrace is enabled:
> 
> 		if (ftrace_start_up && cnt) {
> 			int failed = __ftrace_replace_code(rec, 1);
> 			if (failed) {
> 				ftrace_bug(failed, rec);
> 				goto out_loop;
> 			}
> 		}
> 
> As that could slow things down.
Call trace shows that kernel got stuck in test_for_valid_rec. It calls
kallsyms_lookup, which then calls module_address_lookup,
bpf_address_lookup and ftrace_mod_address_lookup. All of these guys hold
RCU read lock or disable preemption and may consume some time (mostly
because of debug kernel checks, but still there shouldn't be a panic).

Probably it may worth moving cond_resched under within_module check, but
before test_for_valid_rec call.
> 
> If this is all the case, then the cond_resched() should be with the
> ftrace_start_up code and not in the open like you have it.
> 
> 		if (ftrace_start_up && cnt) {
> 			int failed = __ftrace_replace_code(rec, 1);
> 			if (failed) {
> 				ftrace_bug(failed, rec);
> 				goto out_loop;
> 			}
> +			cond_resched();
> 		}
> 
> 
> -- Steve
Thanks for the detailed explanation, I appreciate it!

Best regards,
Riabchun Vladimir
