Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934483;
	b=sNtT3xhoM0MmiedfxuF7BkXHbOCcGOZ1fV/pFenX8YoNAg1p2xZxpi4D9a+cbYCGCumb
	 yE9vfM7F5AK20QQi2aWP3ofRKQOLIWfiHblrNIWOjmJQunWb8Y/+R/Qsdco6UW4mGEFm1
	 LS7I6V34se1jgcwv53Uj8xAzugGI+D0wEfJbLiqFuCfiZ2Sujnz7U/N+1XpSyAo2cuZBD
	 W53ycat//Yl1Vwo0R3YL8HUmIMm8aXsXP7GO+9CTJuEM35UupwifI3YE0saPRLTzdNNog
	 7JOY0SlsaIL2Dmj5j58ilSeDpNwn0gMwY9O8uaM7fTS/6SeoCswj9x4aypcIBkr+jow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934483;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
	bh=6i0giO9JC/Tn20VM9MLp6JL4dkTvjBKFn8ta8TGBzWs=;
	b=KPK72vWhs77hltg0vNZnvIk6nJYK+FHDpTk/QtVVXzXIKHsAqqcx27tdpLijbExkVn3N
	 dKmS2I7tsAdFu9LSE+pHivpYJBtTSJrhqFbY0NiTz2zZ4KUu5l6+W/1zvFAcfO3Tc/8lv
	 rGVmtJDcPRGxPkGNzCpOMg4ppPRpdLe1gZvC3c0hfT7oChW2ikuG/GUuDc19bBZci3PAt
	 RimKqkrXVNbpHAULHCmFaWzXXJSunWw5i+VIYvMpTnfoAxerZbr2TWcCm5UB4eEHOtyNR
	 csvk1VmqYHlRdqMObA9mF1WHKmibdUNPjtFCDwpLZwBirk1zbVZMeC5R01TVh4LFe2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OLHcz1g7;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DBC606A326;
	Fri,  6 Nov 2026 03:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42DBC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OLHcz1g7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793934482; x=1825470482;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sHSsITdw52eBg+7eK+akWWmzeFire5iQg00Atu2e4KQ=;
  b=OLHcz1g7ePmTwXiI2D1PYd68YXvvXFhJ8a3cEvcnsFWrimfYlx88iXbQ
   U7DotrZ1C9gradlyq0rm+C/StskvilDk4YQ0OBVKPontrNgogugPORSDe
   z82y2oYzKtt0JFSZYzdoz91SpMVXcq1GlcLK3P9R1R9Mzl/I0YPJF+02M
   j38DC4SnUKO0oG/E/ErXlMxfiPEEa8GcTmf/xexUEN1lLZ35lKDQEcdxY
   pTtWLuCpMxSPhZ3Iqi/ij4CxOn9C6EyDRxIzuVWJ5g7Gnno+uAL2ZPnT8
   C7jbkmBHJeQVdtLglmiZT3DGgmutEzX9rQmymagrPJFIL9FZuW+3MFrmi
   w==;
X-CSE-ConnectionGUID: 57bvP8uYSJqLQOPkc+Wa/Q==
X-CSE-MsgGUID: ipEf1IVkSxGza7g9XvwmpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2744334"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2744334"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:08:02 -0800
X-CSE-ConnectionGUID: XqXT3RTHTsKW0Tln1c9DNQ==
X-CSE-MsgGUID: ETiATnndQ/KqparOYXV0Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9047896"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 19:07:59 -0800
Date: Fri, 6 Nov 2026 11:07:56 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>, Vinod Koul <vkoul@kernel.org>,
	linux-trace-kernel@vger.kernel.org, yi1.lai@intel.com
Subject: [linus:master] [tracing]  b5cc230af5:
 WARNING:at_kernel/trace/trace_events.c:#test_double_dereference
Message-ID: <202611060303.c90f27a7-lkp@intel.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "WARNING:at_kernel/trace/trace_events.c:#test_double_dereference" on:

commit: b5cc230af5e536ff752f8bd5c30e23612936d5c3 ("tracing: Warn when an event dereferences a pointer in TP_printk()") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linux-next/master ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b]

in testcase: boot

config: x86_64-randconfig-r2309-20261012
compiler: gcc-14
test machine: qemu-system-x86_64 -enable-kvm -cpu Cascadelake-Server-noTSX,enforce -smp 4 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202611060303.c90f27a7-lkp@intel.com


[    0.808840][    T0] ------------[ cut here ]------------
[    0.810236][    T0] Event hfi1_txq_complete has double dereference in TP_printk: REC->sde ? REC->sde->this_idx : 0
[    0.812882][    T0] WARNING: kernel/trace/trace_events.c:417 at test_double_dereference+0x95/0x100, CPU#0: swapper/0/0
[    0.815697][    T0] Modules linked in:
[    0.816602][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.2.0-rc5+ #1 PREEMPT
[    0.818731][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.821353][    T0] RIP: 0010:test_double_dereference (trace/trace_events.c:417 (discriminator 3))
[    0.822786][    T0] Code: 30 e8 c9 27 fb ff 80 7b 01 3e 75 25 e8 be 27 fb ff 48 8b 7d d0 e8 75 fa ff ff 48 89 c6 48 8d 3d 8b 30 8f 06 4c 89 e1 44 89 f2 <67> 48 0f b9 3a eb 3b e8 99 27 fb ff 41 0f b6 c7 f6 80 00 a1 fd 85
All code
========
   0:	30 e8                	xor    %ch,%al
   2:	c9                   	leave
   3:	27                   	(bad)
   4:	fb                   	sti
   5:	ff 80 7b 01 3e 75    	incl   0x753e017b(%rax)
   b:	25 e8 be 27 fb       	and    $0xfb27bee8,%eax
  10:	ff 48 8b             	decl   -0x75(%rax)
  13:	7d d0                	jge    0xffffffffffffffe5
  15:	e8 75 fa ff ff       	call   0xfffffffffffffa8f
  1a:	48 89 c6             	mov    %rax,%rsi
  1d:	48 8d 3d 8b 30 8f 06 	lea    0x68f308b(%rip),%rdi        # 0x68f30af
  24:	4c 89 e1             	mov    %r12,%rcx
  27:	44 89 f2             	mov    %r14d,%edx
  2a:*	67 48 0f b9 3a       	ud1    (%edx),%rdi		<-- trapping instruction
  2f:	eb 3b                	jmp    0x6c
  31:	e8 99 27 fb ff       	call   0xfffffffffffb27cf
  36:	41 0f b6 c7          	movzbl %r15b,%eax
  3a:	f6                   	.byte 0xf6
  3b:	80 00 a1             	addb   $0xa1,(%rax)
  3e:	fd                   	std
  3f:	85                   	.byte 0x85

Code starting with the faulting instruction ===========================================
   0:	67 48 0f b9 3a       	ud1    (%edx),%rdi
   5:	eb 3b                	jmp    0x42
   7:	e8 99 27 fb ff       	call   0xfffffffffffb27a5
   c:	41 0f b6 c7          	movzbl %r15b,%eax
  10:	f6                   	.byte 0xf6
  11:	80 00 a1             	addb   $0xa1,(%rax)
  14:	fd                   	std
  15:	85                   	.byte 0x85
[    0.827992][    T0] RSP: 0000:ffffffff87403d48 EFLAGS: 00010046
[    0.829610][    T0] RAX: ffffffff87183110 RBX: ffffffff87dcba95 RCX: ffffffff87dcba82
[    0.831687][    T0] RDX: 0000000000000021 RSI: ffffffff87183110 RDI: ffffffff87fe7ae0
[    0.833687][    T0] RBP: ffffffff87403d78 R08: 0000000000000000 R09: 0000000000000000
[    0.835822][    T0] R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff87dcba82
[    0.837895][    T0] R13: ffffffff87dcbaa3 R14: 0000000000000021 R15: ffffffff87dcb92d
[    0.839689][    T0] FS:  0000000000000000(0000) GS:ffff8884a6e38000(0000) knlGS:0000000000000000
[    0.841148][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.842182][    T0] CR2: ffff88843ffff000 CR3: 0000000007497001 CR4: 00000000000300b0
[    0.843452][    T0] Call Trace:
[    0.843961][    T0]  <TASK>
[    0.844424][    T0]  test_event_printk (trace/trace_events.c:599)
[    0.845211][    T0]  ? __pfx_trace_event_raw_init (trace/trace_events.c:640)
[    0.846111][    T0]  trace_event_raw_init (trace/trace_events.c:650)
[    0.846904][    T0]  event_init (trace/trace_events.c:3384)
[    0.847591][    T0]  trace_event_init (trace/trace_events.c:4857 trace/trace_events.c:4950)
[    0.848366][    T0]  trace_init (trace/trace.c:9957)
[    0.849014][    T0]  start_kernel (main.c:1071)
[    0.849736][    T0]  x86_64_start_reservations (x86/kernel/head64.c:310)
[    0.850600][    T0]  x86_64_start_kernel (x86/kernel/head64.c:291)
[    0.851419][    T0]  common_startup_64 (x86/kernel/head_64.S:418)
[    0.852218][    T0]  </TASK>
[    0.852686][    T0] irq event stamp: 0
[    0.853291][    T0] hardirqs last  enabled at (0): 0x0
[    0.854409][    T0] hardirqs last disabled at (0): 0x0
[    0.855533][    T0] softirqs last  enabled at (0): 0x0
[    0.856645][    T0] softirqs last disabled at (0): 0x0
[    0.857758][    T0] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261106/202611060303.c90f27a7-lkp@intel.com


--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

