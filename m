Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE3EEBB;
	Thu, 28 Aug 2025 09:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756372190; cv=none; b=SyCzQ8XDlLFsn7KtskfO4O8HISSBAW2rA0lxISY87TASAn9LM8hFKKrNJblnOLvVVeMnLlgYhfRpValTZuybiHLeRROC0RdxpYmd3i57T5dJXQKVIgxZDD6btLkTttNrfl7lNDHHrbxaWR+Ajf/Al3187L37OcZ05Gsy0XWgHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756372190; c=relaxed/simple;
	bh=2iRtPdEXA98Pz3rM66s70MDkTRZ0lHEo6QmVIyn7zTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=su2+3Z0RFNFWWG2p0ERUNwhvU5Dyh9K3stO/J4YWtTYqdzlFI+ACTqI2MfMwnZkhs6FAg9CuG9xT/FoAXPXYd6m/3pUmvA4FNfcSWGlPrYh93vDgfKSB8/sMqMsCXofN13BuQdnGFnoSIUvclVJvj5WxMkKkO0HERNSkFfVajvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka+vbVLW; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka+vbVLW"
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e96e987fc92so544859276.2;
        Thu, 28 Aug 2025 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756372186; x=1756976986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s933IdTTL0HUGsnPirn8chwc2o3p5zqjIwMl0As4ASM=;
        b=Ka+vbVLWn4WQTRdOFcRGNMwDHhj7AgzIhQQC/fa69blPjdCTq9sAuNZ8jduzCY3cKw
         h3JlNTJKkQjGa8x2r6ojmic9FChQ5Cv0x3f2tQ/LIFoS40WDlB61GcAsMVxL0Y0uWvh7
         R4gi2kmSlLBJMBLEAgI9ksT58V9wH8YffXkc7udade/ymG+9IrQUphK7v2flNcl2o5g7
         GWG4171inatZNM+8zkC/5hZ1TaarrTYn2f+Ze/YiIzYo923ebp8hWGOpq45xBIx+jzyD
         /eO+pckCqiAHg9xlp4ygMl+fWTlDLB3EN+8lIwacN7X7+yaQNHGOxXuIv+lYkgh1jAjB
         wRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756372186; x=1756976986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s933IdTTL0HUGsnPirn8chwc2o3p5zqjIwMl0As4ASM=;
        b=P+zdx7Fr8hF62p+28siO+4Z28hEWmTeKAe3lEOtEI4pnXa1e9sy8nYht/MqN6qB0qF
         ScQI5AqzQqh4aSEV5IjyK3o1/X7gwFCGCtxYFjJxlYSZr1gncWISye779f+9czG7fHSw
         BJdeB+ezycmOO2nTEPLa7HxnY40st1PPSiIrvT0mKXMdNsbGw5DWLnPztFf6MRaNRKzF
         G9r649FZ7wkRGaINJga0QNzN9CXosLFsTQRqb5nlj2HkM6dWH8lDbvYT4QcAjKpOCO7Z
         b6NeQAF8Ev3AgxPRVY455pdVLxneYKpAl8ng2TrE9W80C5PR2DfQ4p/k0yPXivrWPjJS
         QobA==
X-Forwarded-Encrypted: i=1; AJvYcCUpjBxC4cEyl/NJ+cq1/9jqyc5Ny4Ou3qmbn8IVsj6RaD6oQQ3/KA010cDi2mYzWpli3SuJ0tisMXBIPLC1JYyF+n9B@vger.kernel.org, AJvYcCWNEKeE1b+nyjNmbku6n5bCgLcA7PzoNlupt8soWziEBgkgJcZq++H6Mg6sPv3Y5HWY7QZTgkMWAUmo/wA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2esII3rZgPFM6ZE8TcvtrM/4prSRKm7Z4xwKjnggCdk1hmhoI
	Ou8oBgqc8IzUcbhdmEg+uC1WcInU+JaTLj5Xfqno/9nt5dQ1R5sB15lesi9jDis/kYZUYXw3V9k
	4vm+vjvBztKm8o95EgG7z9KqCDIRmNKM=
X-Gm-Gg: ASbGncsvy7i4/OSwip4XpBi5yWCT5kyjPOOgr1rhIzet6r1cBQig9rfXysD3S5U5NP4
	WnQ15Aq0UL/cwu+OgdXysseHRQpJ+Q4YABO8K1kTLKUrtcbkpSlyIGIJPI30cRWSvufxNA7ESzL
	mfD15PmA+HtR5FUPw61Mgcrj3A1nhWk/jZq/AmQzBwdImRjEypJ57zMe7Av6ZLgUdzRTt1MQFJ4
	xNwUuLL3fV5YSeH64JDRQ==
X-Google-Smtp-Source: AGHT+IHE2w0EE1JIJM958VfAgZN7OV/RMiNe+9ltRgmpQC87DGYnFwu2gW2dVVVS7UO0SDahykgcf3fNZTQxgF2xevc=
X-Received: by 2002:a05:6902:488e:b0:e93:4ba6:a096 with SMTP id
 3f1490d57ef6-e951c2e97f7mr24235315276.19.1756372186288; Thu, 28 Aug 2025
 02:09:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508281655.54c87330-lkp@intel.com>
In-Reply-To: <202508281655.54c87330-lkp@intel.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 28 Aug 2025 17:09:35 +0800
X-Gm-Features: Ac12FXzSwLk_fTuh7odiLeyd6O9dEo3TINdjIP0TCM6oD2QReg8SaEaI_CxTG-Q
Message-ID: <CADxym3aHUDGahE1S2LzaDZA4vZP637txcMzQR3_r1U00GikEUA@mail.gmail.com>
Subject: Re: [linux-next:master] [tracing] dfe0d675df: WARNING:suspicious_RCU_usage
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>, lkp@intel.com, 
	Menglong Dong <dongml2@chinatelecom.cn>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:43=E2=80=AFPM kernel test robot <oliver.sang@inte=
l.com> wrote:
>
>
>
> Hello,
>
> kernel test robot noticed "WARNING:suspicious_RCU_usage" on:
>
> commit: dfe0d675df82fb9297ff98253b9c3042fdab5544 ("tracing: fprobe: use r=
hltable for fprobe_ip_table")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master d0630b758e593506126e8eda6c3d56097d1847c=
5]
>
> in testcase: kernel-selftests-bpf
> version:
> with following parameters:
>
>         group: ftrace
>
>
>
> config: x86_64-rhel-9.4-bpf
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake)=
 with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202508281655.54c87330-lkp@intel.=
com
>
>
> [  354.896751][ T4652] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  354.901528][ T4652] WARNING: suspicious RCU usage
> [  354.906255][ T4652] 6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S    =
    I
> [  354.913924][ T4652] -----------------------------
> [  354.918654][ T4652] include/linux/rhashtable.h:602 suspicious rcu_dere=
ference_check() usage!
> [  354.927114][ T4652]
> [  354.927114][ T4652] other info that might help us debug this:
> [  354.927114][ T4652]
> [  354.937180][ T4652]
> [  354.937180][ T4652] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [  354.945106][ T4652] no locks held by ftracetest/4652.
> [  354.950167][ T4652]
> [  354.950167][ T4652] stack backtrace:
> [  354.955924][ T4652] CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: =
G S        I         6.17.0-rc1-00001-gdfe0d675df82 #1 PREEMPT(voluntary)
> [  354.955948][ T4652] Tainted: [S]=3DCPU_OUT_OF_SPEC, [I]=3DFIRMWARE_WOR=
KAROUND
> [  354.955950][ T4652] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIO=
S 1.1.1 10/07/2015
> [  354.955966][ T4652] Call Trace:
> [  354.955968][ T4652]  <TASK>
> [  354.955971][ T4652]  dump_stack_lvl+0x7c/0x90
> [  354.955978][ T4652]  lockdep_rcu_suspicious+0x14f/0x1c0
> [  354.955987][ T4652]  __rhashtable_lookup+0x1e0/0x260

rcu_read_lock() is not needed in fprobe_entry, but
rcu_dereference_check() is used in rhltable_lookup(), which
causes this warning.

Adding rcu_read_lock() here is able to suppress this warning.
Maybe we need only rcu_lock_acquire(&rcu_lock_map) here,
but it's not a common usage. What do you think, Masami?

Thanks!
Menglong Dong

> [  354.955994][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  354.956000][ T4652]  fprobe_entry+0x9a/0x450
> [  354.956017][ T4652]  ? __lock_acquire+0x6b0/0xca0
> [  354.956022][ T4652]  ? find_held_lock+0x2b/0x80
> [  354.956041][ T4652]  ? __pfx_fprobe_entry+0x10/0x10
> [  354.956045][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  354.956049][ T4652]  ? lock_acquire+0x14c/0x2d0
> [  354.956053][ T4652]  ? __might_fault+0x74/0xc0
> [  354.956063][ T4652]  function_graph_enter_regs+0x2a0/0x550
> [  354.956067][ T4652]  ? __do_sys_clone+0xb5/0x100
> [  354.956076][ T4652]  ? __pfx_function_graph_enter_regs+0x10/0x10
> [  354.956080][ T4652]  ? _copy_to_user+0x58/0x70
> [  354.956084][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  354.956088][ T4652]  ? __x64_sys_rt_sigprocmask+0x114/0x180
> [  354.956093][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
> [  354.956099][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  354.956103][ T4652]  ftrace_graph_func+0x87/0xb0
> [  354.956110][ T4652]  0xffffffffc0547095
> [  354.956118][ T4652]  ? __pfx_handle_pte_fault+0x10/0x10
> [  354.956126][ T4652]  ? kernel_clone+0x5/0x560
> [  354.956132][ T4652]  kernel_clone+0x5/0x560
> [  354.956136][ T4652]  __do_sys_clone+0xb5/0x100
> [  354.956140][ T4652]  ? __pfx___do_sys_clone+0x10/0x10
> [  354.956154][ T4652]  ? __might_fault+0x74/0xc0
> [  354.956159][ T4652]  ? tracer_hardirqs_on+0x61/0x170
> [  354.956166][ T4652]  ? __x64_sys_clone+0x4d/0x70
> [  354.956172][ T4652]  do_syscall_64+0x8c/0x390
> [  354.956177][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
> [  354.956181][ T4652]  ? handle_mm_fault+0x198/0x540
> [  354.956186][ T4652]  ? exc_page_fault+0x57/0xb0
> [  354.956192][ T4652]  ? lock_release+0x6c/0x130
> [  354.956196][ T4652]  ? tracer_hardirqs_on+0x61/0x170
> [  354.956201][ T4652]  ? do_user_addr_fault+0x400/0x730
> [  354.956209][ T4652]  ? do_syscall_64+0x169/0x390
> [  354.956213][ T4652]  ? lockdep_hardirqs_on_prepare+0xd7/0x190
> [  354.956220][ T4652]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  354.956225][ T4652] RIP: 0033:0x7ff812c54353
> [  354.956229][ T4652] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00=
 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00=
 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> [  354.956233][ T4652] RSP: 002b:00007ffdebe44c98 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000038
> [  354.956237][ T4652] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0=
0007ff812c54353
> [  354.956240][ T4652] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000001200011
> [  354.956243][ T4652] RBP: 0000000000000000 R08: 0000000000000000 R09: 0=
00055a6ea2c1f90
> [  354.956245][ T4652] R10: 00007ff812b7ee50 R11: 0000000000000246 R12: 0=
000000000000001
> [  354.956248][ T4652] R13: 00007ffdebe44ed0 R14: 000055a6bd29eb08 R15: 0=
00055a6ea2c33e0
> [  354.956260][ T4652]  </TASK>
> [  354.956262][ T4652]
> [  355.255635][ T4652] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [  355.260334][ T4652] WARNING: suspicious RCU usage
> [  355.265034][ T4652] 6.17.0-rc1-00001-gdfe0d675df82 #1 Tainted: G S    =
    I
> [  355.272672][ T4652] -----------------------------
> [  355.277375][ T4652] include/linux/rhashtable.h:376 suspicious rcu_dere=
ference_check() usage!
> [  355.285767][ T4652]
> [  355.285767][ T4652] other info that might help us debug this:
> [  355.285767][ T4652]
> [  355.295845][ T4652]
> [  355.295845][ T4652] rcu_scheduler_active =3D 2, debug_locks =3D 1
> [  355.303744][ T4652] no locks held by ftracetest/4652.
> [  355.308785][ T4652]
> [  355.308785][ T4652] stack backtrace:
> [  355.314561][ T4652] CPU: 1 UID: 0 PID: 4652 Comm: ftracetest Tainted: =
G S        I         6.17.0-rc1-00001-gdfe0d675df82 #1 PREEMPT(voluntary)
> [  355.314569][ T4652] Tainted: [S]=3DCPU_OUT_OF_SPEC, [I]=3DFIRMWARE_WOR=
KAROUND
> [  355.314571][ T4652] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIO=
S 1.1.1 10/07/2015
> [  355.314573][ T4652] Call Trace:
> [  355.314575][ T4652]  <TASK>
> [  355.314578][ T4652]  dump_stack_lvl+0x7c/0x90
> [  355.314585][ T4652]  lockdep_rcu_suspicious+0x14f/0x1c0
> [  355.314594][ T4652]  __rhashtable_lookup+0x181/0x260
> [  355.314600][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  355.314606][ T4652]  fprobe_entry+0x9a/0x450
> [  355.314610][ T4652]  ? __lock_acquire+0x6b0/0xca0
> [  355.314615][ T4652]  ? find_held_lock+0x2b/0x80
> [  355.314621][ T4652]  ? __pfx_fprobe_entry+0x10/0x10
> [  355.314625][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  355.314629][ T4652]  ? lock_acquire+0x14c/0x2d0
> [  355.314646][ T4652]  ? __might_fault+0x74/0xc0
> [  355.314655][ T4652]  function_graph_enter_regs+0x2a0/0x550
> [  355.314659][ T4652]  ? __do_sys_clone+0xb5/0x100
> [  355.314667][ T4652]  ? __pfx_function_graph_enter_regs+0x10/0x10
> [  355.314671][ T4652]  ? _copy_to_user+0x58/0x70
> [  355.314675][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  355.314679][ T4652]  ? __x64_sys_rt_sigprocmask+0x114/0x180
> [  355.314684][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
> [  355.314689][ T4652]  ? __pfx_kernel_clone+0x10/0x10
> [  355.314694][ T4652]  ftrace_graph_func+0x87/0xb0
> [  355.314701][ T4652]  0xffffffffc0547095
> [  355.314708][ T4652]  ? __pfx_handle_pte_fault+0x10/0x10
> [  355.314716][ T4652]  ? kernel_clone+0x5/0x560
> [  355.314722][ T4652]  kernel_clone+0x5/0x560
> [  355.314725][ T4652]  __do_sys_clone+0xb5/0x100
> [  355.314730][ T4652]  ? __pfx___do_sys_clone+0x10/0x10
> [  355.314743][ T4652]  ? __might_fault+0x74/0xc0
> [  355.314748][ T4652]  ? tracer_hardirqs_on+0x61/0x170
> [  355.314755][ T4652]  ? __x64_sys_clone+0x4d/0x70
> [  355.314761][ T4652]  do_syscall_64+0x8c/0x390
> [  355.314766][ T4652]  ? __pfx___x64_sys_rt_sigprocmask+0x10/0x10
> [  355.314770][ T4652]  ? handle_mm_fault+0x198/0x540
> [  355.314775][ T4652]  ? exc_page_fault+0x57/0xb0
> [  355.314780][ T4652]  ? lock_release+0x6c/0x130
> [  355.314785][ T4652]  ? tracer_hardirqs_on+0x61/0x170
> [  355.314789][ T4652]  ? do_user_addr_fault+0x400/0x730
> [  355.314796][ T4652]  ? do_syscall_64+0x169/0x390
> [  355.314801][ T4652]  ? lockdep_hardirqs_on_prepare+0xd7/0x190
> [  355.314808][ T4652]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  355.314812][ T4652] RIP: 0033:0x7ff812c54353
> [  355.314816][ T4652] Code: 00 00 00 00 00 66 90 64 48 8b 04 25 10 00 00=
 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00=
 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
> [  355.314819][ T4652] RSP: 002b:00007ffdebe44c98 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000038
> [  355.314824][ T4652] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0=
0007ff812c54353
> [  355.314827][ T4652] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0=
000000001200011
> [  355.314829][ T4652] RBP: 0000000000000000 R08: 0000000000000000 R09: 0=
00055a6ea2c1f90
> [  355.314831][ T4652] R10: 00007ff812b7ee50 R11: 0000000000000246 R12: 0=
000000000000001
> [  355.314834][ T4652] R13: 00007ffdebe44ed0 R14: 000055a6bd29eb08 R15: 0=
00055a6ea2c33e0
> [  355.314846][ T4652]  </TASK>
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250828/202508281655.54c87330-lk=
p@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>
