Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275A030AD15
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Mar 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442013; cv=pass; b=n+KlAxYhmQgzlHHuD6xc+czu5XBwY7/aY5hUQogLCAAm+inhga00kUA3PLYudGcHA5W3G2hTO+3tnCpnF3rcI9JxIk2Fd6QKDCAxjzops6QANd2xqH8A2+vsRh+LhSU1DHmauyp0d6NOG/+Xoqh19XZEFOLBEHVRf7HnsCOCZBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442013; c=relaxed/simple;
	bh=Wqm4M8zpADdnGjbRnJfT5476S4B2fTnEXmWXq+lRGIo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=jKUp9kp0vZuZlojbEYekobG6FqLfISbzM/2RPtRtKwoAM9o0CbQyXQgObEHb14pQCBamnAVu/f32P0o9TJKKMsB15T8unNHJnfkKbRr0IqHU9vqr3j3oAKwGfNUMobGlWI3kaEntgq1tUDnAcpUvjnz7Q1fr6LFst504QXacnyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6XYigWh; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6XYigWh"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae3a2f6007so10879375ad.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Mar 2026 01:00:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772442011; cv=none;
        d=google.com; s=arc-20240605;
        b=TsCm8lpFfpTpMWAIifCfypcvQ93d8jNGwZWEj4bLkWa77FH9t331rYMoTyN3hhzTgA
         na85aUNlXhhXLRTZ7HR9uOXPK52j3ylD0RLybvbwYTzJCqN8esuuT47KfKNVoCe5R7cT
         d8wWehA1J9hrNKC/CvhH8xngnAN4GF+NhvNPYvXcEA72GtSMNUlJBIUmaivnStOoseyd
         WTxPHX2GoB0FxTNAacNUYuM0BgtoYGluI9cCxO1TIyB50ryQS/ULO7C9FU5FgtkuZV4o
         tkceGUtQQ9AG6bAaTFjN9oYuXeaWkHXR3xvhrr7N03BDK3W2u4qLZ2Z+Gpgv5UAj/KZM
         7Z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tyfQqvmOLhXYF1eqzHxusoyHZKTXWx+8q/n4jqqrR/Q=;
        fh=UMSQ7EQpj6/u6/IP+2I8CdW1AK/uHMDz2vgB4thAErg=;
        b=RnOG67BqwvdML+xoDnzx+kCJc9P5KpEnZQDlURx6JtzehoQIRAbIDSubarBo13ooy2
         7DhqEDvbV4/kc+gMa3wEJ8nWP0IdbICz5+HYTP7tezDGtoN/KZ65VFXWp7xOkm4r7Bwl
         RT9aIJBVupT1cglXm+0IaocVe+VG9knXKe1gZmkopKWZQPmO8qycDcRQw2x8AqW2wAg8
         6sezOvGuOCIlKB3uKGble/MhUpwfbHFJnNfeXsX8ZQGPK6nNMbUaF7mExPuq6CvNa9Dp
         0XXnsYhRAZ8ePX5IIyW/JDt/QvYfCR/H4Uk90QseTSb+nOgL9/mqSRihvrzHfjnQrPBv
         zGTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772442011; x=1773046811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tyfQqvmOLhXYF1eqzHxusoyHZKTXWx+8q/n4jqqrR/Q=;
        b=W6XYigWh1voewHfjO1R4gbkaltgzsnAopRsoCmvS/VyRWBDKnCntjSBSbWkzYAApMF
         ucGMeYiKcMuHIyA3gHzTBQKstDiatRdR/toLmeLR/M/j1AXh65MBltqHXqpQKe3k7bLB
         887apQcsidlkp8d7feT6mjVN17GBAREYnrM0nzyZTT5BQW8ngx1v7D9CwaD9XkGTuPLg
         zd1dVK6prl2taWy7x8EGY6WAIrv2p2GWmjDXJZDBUD6SQT3URJUjr/jvY30OtHjmBhYo
         EjE1vfssYciSqs7yBXAKMnXpCiCkQKDIdBYgm4gHcDeWwVfBnlizPjZ408ORDiwi5n/Y
         A5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772442011; x=1773046811;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tyfQqvmOLhXYF1eqzHxusoyHZKTXWx+8q/n4jqqrR/Q=;
        b=W9nH2t4uTviB3fVnTfw5cn7v0YtXEcVLUsIxVgjSDOxSfSprq08V8OmUENQ9af6hoj
         rrS913Ppx/UbxAq/3wkbQbzADe/DKT8zE2VZGOCQXO+K/vDNvr0bEK1DvwW+ApvnjNOQ
         DOtKK0BHuH8g0YorCrAq98uBmSi3+lv7+8HHOGp6P7eM8uZ2JC+cufiUKAL8Y1Nyzgiz
         W63iLK2bI6+IAC90YwEUNWhdBNN6WW2jxtQtkJoNsgNWXZNHCwzeq9NtJS7tsPfwePan
         dEf35GO0lQrT8bGDuJN+rAlBMJm6uzTRZDZHcDowhmYbtS1ATxklacJevAcZGGuXNcVC
         Hj3A==
X-Forwarded-Encrypted: i=1; AJvYcCXeL0hh9V2CEJFP5Al9tMR6ZKiqLS5rn78bwL/m2PJyEF+7ZqltBHM1N0OM8MJMdS8eOQB+xoAETAiQfcjo4sUw8ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKOD78hWTHKtR0ff9iH32eDhHooK3Wnwx+kkGaC+iVikVzO7IF
	zoHAtA1TAHSCPLm1wupiKnHuJHUvQZEWXj5xuE7+Rjjcu7GYF0ZrEeUX3yohEvpnFrEeO3BMqA1
	3rtpUFg1FCwsOOwT25p3v0G2m5nDUJG5ykoZy38EXDA==
X-Gm-Gg: ATEYQzxIOm/svg8//huKrFCeALmzgg8zxu0sL02s2zPJ3/u/PpUuOev1iLWUhN/lfLt
	Mjc213T79ULhyJV3XlLFZsxlvLTM++UcpLODkjGTZCm1XRCBUGk/KDefTCzUtiPCuMgrsJuZKLT
	RVbzZKS5cCSXZ2qNky9F17raOKuhSSZqMJFFma/0GuMzlivqVDqwUeUgvHQ0boDEDNwdbmQZxV4
	KPOVKF3HNjRgp1WM0RGmVHXBp3pOE2Fsy3o+XR9gVuv5Ks+045HOxp46dtRsh+4byPyxUnoaRA2
	CKTNnQw=
X-Received: by 2002:a17:903:2312:b0:2ad:ca65:a37b with SMTP id
 d9443c01a7336-2ae2e4d981bmr98832565ad.51.1772442011208; Mon, 02 Mar 2026
 01:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zw Tang <shicenci@gmail.com>
Date: Mon, 2 Mar 2026 17:00:00 +0800
X-Gm-Features: AaiRm52LxVr7Zn_98ChAawTy5LR0CBOsuRmpYtY5TgVAjctWqI6-OSX4Ywa369A
Message-ID: <CAPHJ_V+J6YDb_wX2nhXU6kh466Dt_nyDSas-1i_Y8s7tqY-Mzw@mail.gmail.com>
Subject: [BUG] kprobes: WARNING in __arm_kprobe_ftrace when kprobe-ftrace
 arming fails with -ENOMEM under fault injection
To: Naveen N Rao <naveen@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I am reporting a WARNING triggered by a syzkaller reproducer on Linux 7.0.0-rc1.

The kernel hits a WARN in kprobes while trying to arm a kprobe via ftrace:

Failed to arm kprobe-ftrace at __split_text_end+0x4/0x11 (error -12)
WARNING: kernel/kprobes.c:1147 at __arm_kprobe_ftrace()

This seems to be triggered through perf_event_open() -> trace_kprobe
-> kprobes. The reproducer enables systematic fault injection and
injects a failure (nth=7), and the arming path returns -ENOMEM (-12).
Instead of cleanly failing, kprobes emits a WARNING.

This is reproducible only with fault injection enabled.

Reproducer:
C reproducer: https://pastebin.com/raw/casZvuLe
console output: https://pastebin.com/raw/1xkwRUmc
kernel config: https://pastebin.com/raw/8Er8SZz0

Kernel:
git tree: torvalds/linux
commit: 4d349ee5c7782f8b27f6cb550f112c5e26fff38d
kernel version: 7.0.0-rc1-00301-g4d349ee5c778 #5 PREEMPT_RT (lazy)
hardware: QEMU Ubuntu 24.10



[   92.516728] WARNING: kernel/kprobes.c:1147 at
arm_kprobe+0x563/0x620, CPU#0: syz.1.94/783
[   92.516766] Modules linked in:
[   92.516809] CPU: 0 UID: 0 PID: 783 Comm: syz.1.94 Not tainted
7.0.0-rc1-00301-g4d349ee5c778 #5 PREEMPT_{RT,(lazy)}
0b4dbcd6f14740930e77a74387d10aec6dbca841
[   92.516842] Hardware name: QEMU Ubuntu 24.10 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   92.516855] RIP: 0010:arm_kprobe+0x56a/0x620
[   92.516885] Code: ff 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1
ea 03 80 3c 02 00 0f 85 a8 00 00 00 48 8d 3d cd d3 8d 06 48 8b 75 28
44 89 e2 <67> 48 0f b9 3a e9 81 fc ff ff e8 87 8c ff ff 48 8d 3d c0 d3
8d 06
[   92.516905] RSP: 0018:ffff88800faf7a48 EFLAGS: 00010246
[   92.516924] RAX: dffffc0000000000 RBX: ffffffff89f46b40 RCX: 0000000000000000
[   92.516939] RDX: 00000000fffffff4 RSI: ffffffff81200004 RDI: ffffffff88481300
[   92.516955] RBP: ffff88800c566a18 R08: 0000000000000000 R09: fffffbfff108bacb
[   92.516969] R10: fffffbfff108baca R11: ffffffff8845d657 R12: 00000000fffffff4
[   92.516984] R13: ffffffff8845dc20 R14: ffff88800c566a90 R15: ffff88800c566a40
[   92.517002] FS:  00007f42ed38f6c0(0000) GS:ffff8880e224e000(0000)
knlGS:0000000000000000
[   92.517023] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   92.517041] CR2: 00007fe44aa68710 CR3: 000000000e340000 CR4: 0000000000350ef0
[   92.517057] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   92.517073] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
[   92.517090] Call Trace:
[   92.517099]  <TASK>
[   92.517126]  enable_kprobe+0x1fc/0x2c0
[   92.517173]  enable_trace_kprobe+0x227/0x4b0
[   92.517240]  kprobe_register+0x84/0xc0
[   92.517279]  perf_trace_event_init+0x527/0xa20
[   92.517329]  perf_kprobe_init+0x156/0x200
[   92.517367]  perf_kprobe_event_init+0x101/0x1c0
[   92.517406]  perf_try_init_event+0x145/0xa10
[   92.517458]  perf_event_alloc+0x1f91/0x5390
[   92.517509]  ? perf_event_alloc+0x1e4d/0x5390
[   92.517586]  ? perf_event_mmap_output+0xf00/0xf00
[   92.517709]  __do_sys_perf_event_open+0x557/0x2d50
[   92.517762]  ? write_comp_data+0x29/0x80
[   92.517788]  ? irqentry_exit+0x157/0xb20
[   92.517822]  ? perf_release+0x50/0x50
[   92.517848]  ? irqentry_exit+0x157/0xb20
[   92.517897]  ? __split_text_end+0x4/0x11
[   92.517956]  ? tracer_hardirqs_on+0x80/0x3b0
[   92.517986]  ? do_syscall_64+0x94/0x1160
[   92.518022]  ? __sanitizer_cov_trace_pc+0x20/0x50
[   92.518072]  do_syscall_64+0x129/0x1160
[   92.518118]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   92.518142] RIP: 0033:0x7f42ee92ebe9
[   92.518164] Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89
01 48
[   92.518184] RSP: 002b:00007f42ed38f038 EFLAGS: 00000246 ORIG_RAX:
000000000000012a
[   92.518207] RAX: ffffffffffffffda RBX: 00007f42eeb65fa0 RCX: 00007f42ee92ebe9
[   92.518222] RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000200000000140
[   92.518248] RBP: 00007f42ed38f090 R08: 0000000000000008 R09: 0000000000000000
[   92.518262] R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
[   92.518277] R13: 00007f42eeb66038 R14: 00007f42eeb65fa0 R15: 00007fff172e7218
[   92.518358]  </TASK>



Notes:

The reproducer sets up fault injection (/proc/thread-self/fail-nth,
failslab/fail_page_alloc knobs) and injects nth=7 before calling
perf_event_open().

The failure is reported as -ENOMEM when arming kprobe-ftrace, and the
WARN is triggered in __arm_kprobe_ftrace().


Thanks,
Zw Tang
