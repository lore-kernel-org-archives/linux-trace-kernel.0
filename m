Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEFD1FC4;
	Wed, 15 May 2024 21:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715808653; cv=none; b=aQtkn3YR9MyMbEJE38eP57v99tgU/o4w2fMFJ4bgt0C5YNw+Ci50y7xtS9gKdMnCmmPO5DZW2Cf8HRcDD80Rb5J48eAIgXQep9zVG59eWl1T6tjdjc5Bwz/61jahHzuyYSwcN8qKMQNZsQwvk9CCLNWAejKU5NrMwsNOa9PNtek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715808653; c=relaxed/simple;
	bh=cSegm8zca06bh3VxwG/1nohgKIpy1sLC+CwU8trRmDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmOHF6qg6Bm7gT9w4E8fm5moIEKYJqAuIqzogToT017XjSknp9/RUjTdH//7cOSOQCzVOkkJtjRbfDb+9oCLWXdiEpBwethzY+7LvY9S4vOL9pmTueQ7ENmRzIkG1uDPr57pRelP+vyd267W6SvEEHYahDsgsU6yAHuaYvVGmRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQZGNlvo; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQZGNlvo"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-350513d2c6aso4245784f8f.2;
        Wed, 15 May 2024 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715808650; x=1716413450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/Y5GE40yPs/wmhH+w0R59Hsxc6Sy/7klwSUObGVbGA=;
        b=YQZGNlvo/rqPfMziRaeIyqEpHjwsXni8BJYvRzkPBDqEzG4on+0pa2PsUiQp1V136F
         TpHWKTATmbF0bBRKAR/EHndSkJ/WNnMTrY1AdlGRGYju2qikej67c01yrDb6rR8ekdQc
         Ks1H2sQVHkXuNN4ItoFNrN61rgjgIcmJWhDLg4TsuU4+bNCGcQJCZuVRduGyZ8uiNdg3
         pm3CDyaNwTmLy0IQ7rh+E405OtTDQaL1ZDUDgBGgXlO0MsDMKdjZhCDWbxM1bVei3js8
         4UhQVWzEfr2Q+IZJX8zLyVf3azniENoHDWdUev4mVknSZtJEz5RaYiQZfPr2YaQz0frD
         tyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715808650; x=1716413450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/Y5GE40yPs/wmhH+w0R59Hsxc6Sy/7klwSUObGVbGA=;
        b=vnDoEVBCkthFGW5eXspcUvNHtJEoeE+32QMsUcJwl+FN/FkPZrHmmMAUK5BrE0YB9A
         18+zdoRW442NVZ3jk6ds/461va9r8+Z4jBOwgWhKfRd6P3MiMuxOIgPEuc3ZOjWqlCpJ
         17Wz2jDJSlRx2GHqjoeoHhJ+T9ndPme7UPz72Y1hqO2TK9aV2jpwv7MZfSle+c+Xa6n1
         UHuBSEn1580XfEAIOIGSEk2QmctFALKbiK505l81znKtRu+j8lXX7vZrHTVENAOZa4Fn
         sBtwhsa629M7LuxzkTiYvR10Rghk7aysaG81cHKIdjf6bboR5FSSvskjOppISU2wAIne
         Q/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCWv6IbD5rdY9MHilHF5D82mTvdrLKmWmjEV63bu54SDvKH13w6gV/Rypx6x61VtwnVlKG9K3ejrZW23bnXSmrW70sn6gVcAiYcANOMl
X-Gm-Message-State: AOJu0YwB7zuxIUjBz7VOQMxIjH5J2gjA9Qtg9V4BTZQJYKybKdwcJo41
	RApPS2yhIjQZvoSuAo+d4g/rojGIeIxmyZ9z8Tt7LQznaVm5re/JMON3KyK3TdvtptKUta2p88B
	m7pFUUBaFGLtJ+2Ir+hpkLRjqVXLf8w==
X-Google-Smtp-Source: AGHT+IE8VtGau0essx9ToUKZqi4zv6/Id5h0ygVvU2ANrazUnqgPIA5Kx9EcBwhH80J1JyJdj6WPRfZ43FoHRn9fPMU=
X-Received: by 2002:adf:e851:0:b0:34d:9fc2:4a81 with SMTP id
 ffacd0b85a97d-3504a61c5c6mr11922947f8f.5.1715808649395; Wed, 15 May 2024
 14:30:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da22ddaf-384f-4a38-8338-decbfdb929fc.bugreport@ubisectech.com>
In-Reply-To: <da22ddaf-384f-4a38-8338-decbfdb929fc.bugreport@ubisectech.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 May 2024 14:30:37 -0700
Message-ID: <CAADnVQJndMkNh4X-w0520B8PVN122h8XKQxE4g4LmDTKyWd=0Q@mail.gmail.com>
Subject: Re: WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
To: Ubisectech Sirius <bugreport@ubisectech.com>, Jiri Olsa <jolsa@kernel.org>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, ast <ast@kernel.org>, 
	daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 12:33=E2=80=AFAM Ubisectech Sirius
<bugreport@ubisectech.com> wrote:
>
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.=
 Recently, our team has discovered a issue in Linux kernel 6.7.  Attached t=
o the email were a PoC file of the issue.

Jiri,

please take a look.

> Stack dump:
>
> loop3: detected capacity change from 0 to 8
> MTD: Attempt to mount non-MTD device "/dev/loop3"
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 10075 at mm/util.c:632 kvmalloc_node+0x199/0x1b0 mm/=
util.c:632
> Modules linked in:
> CPU: 1 PID: 10075 Comm: syz-executor.3 Not tainted 6.7.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/0=
1/2014
> RIP: 0010:kvmalloc_node+0x199/0x1b0 mm/util.c:632
> Code: 02 1d 00 eb aa e8 a7 49 c6 ff 41 81 e5 00 20 00 00 31 ff 44 89 ee e=
8 36 45 c6 ff 45 85 ed 0f 85 1b ff ff ff e8 88 49 c6 ff 90 <0f> 0b 90 e9 dd=
 fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> RSP: 0018:ffffc90002007b60 EFLAGS: 00010212
> RAX: 00000000000023e4 RBX: 0000000000000400 RCX: ffffc90003aaa000
> RDX: 0000000000040000 RSI: ffffffff81c3acc8 RDI: 0000000000000005
> RBP: 00000037ffffcec8 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 00000000ffffffff R15: ffff88805ff6e1b8
> FS:  00007fc62205f640(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2e026000 CR3: 000000005f338000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  kvmalloc include/linux/slab.h:738 [inline]
>  kvmalloc_array include/linux/slab.h:756 [inline]
>  kvcalloc include/linux/slab.h:761 [inline]
>  bpf_uprobe_multi_link_attach+0x3fe/0xf60 kernel/trace/bpf_trace.c:3239
>  link_create kernel/bpf/syscall.c:5012 [inline]
>  __sys_bpf+0x2e85/0x4e00 kernel/bpf/syscall.c:5453
>  __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
>  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fc62128fd6d
> Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc62205f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 00007fc6213cbf80 RCX: 00007fc62128fd6d
> RDX: 0000000000000040 RSI: 00000000200001c0 RDI: 000000000000001c
> RBP: 00007fc6212f14cd R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007fc6213cbf80 R15: 00007fc62203f000
>  </TASK>
>
> Thank you for taking the time to read this email and we look forward to w=
orking with you further.
>
>
>
