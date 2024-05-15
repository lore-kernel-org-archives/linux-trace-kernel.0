Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7635A155A57;
	Wed, 15 May 2024 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809665; cv=none; b=ObYAMIL8I+b2zP2K/lt8OwTbPI7U0Fhb1AIhRHpis0CxwqBCLmtzXJ70fzGjPHXu0c5BjEKhOSV2hcKLz9ZkxcMR0s8I/u7Qg3XapVkd7p5+/pRkXb13VkRqjD1KDdGNcfa+umv6DyGdkAZSMq0AfS5geB5UW7txSngZ6N14HKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809665; c=relaxed/simple;
	bh=LI9hUjH7t7Zwg5fteMpc579qcbztQeCkUGV2aMfslG4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hj9blkDOWyMmYlIUtXfXqlFfKK0ZwZvgkQMHMS45bN4Upba+0GylVmz90Zo79HtiYMw+LMG5IRZkktaxVumA2otwEQ1oGRSDqtgxenlNw1UyXv7+Ncmh4Cd89cwZkMubZ8fVQhDZBdeIpnURSAd7GeOS75sKGHHoXGqI43UdGMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc4aGt07; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc4aGt07"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1ee0132a6f3so58108465ad.0;
        Wed, 15 May 2024 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715809664; x=1716414464; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hHyY+0tQ9MhTq4Mfna+AwPPphiWbhqwRtp6sEgx3Jm4=;
        b=Mc4aGt07xojTOmZlLTz0vVXrf8tJipTgehaPJGZxSqR60KPF858CLNRv02dkobXsH+
         eKRUYiiRaK8IFKv8J+18oHwL3YHfc1EcXWqm27Tu1xRXqXqqvRJTBZJiDgVhODXa9Sya
         Oj/xKwBI0L1FKwXYUdUIi0KAvg1wJXylnGqlQiNjSdsQP7ZGcFKct49GnFckn1M1OYtZ
         dfw3FyjG54LM9MJtTSGm1LzIeyvKCz3pAQum0XHcqnB9NxCtwIJjEsDgRxPmLb3NkO+/
         k3FP2+lsKaiUF2cB22IbzgLxoUFU45uwlblvhniLNCEuw5+JUkYTDH27mDJzAIPSHB/y
         vm9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809664; x=1716414464;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHyY+0tQ9MhTq4Mfna+AwPPphiWbhqwRtp6sEgx3Jm4=;
        b=Hv2kbf2UO/mUQnlwztYlhIM0GqnnYLVNqf/Og350yt7d/JHLeCV+0hx6HTLVWSIawI
         1IbpwpIImxbi5GcdjHPO/B2nkd/LlBPMCdYYXiR9obWWjlVFVcjN6IyMDgai8dj4W0ck
         y3FmLZVixwAQn8+SOHQzEVNBOrabrnVCbwHD5tGv74h1QH1FMrGzD20HXYaCT5xvuYtb
         mU6dl/qjC4rKtevyr7udl0Z8pPbt0JdVe2R11CgYKZDTvCYVgpIvJ4EgJERpRj0rUtep
         STSHlRORmWDTOH3NUuJzYxYFyTqj/gQxaPWBcZTcieP537nMQeVaZd4zVBIr1VARw6p0
         MXmA==
X-Forwarded-Encrypted: i=1; AJvYcCV79GfBOh5W7Gjir3XYPAopRljYhE/LEzyIVZ1m25eKRq5R5SA2R3ElDsSTolz94il5jkqd4TY2S9Qm4rPE2G67Z8SWs4rAQfz6YyRcx5lQ5OPsSdZLY/hn49QF9nuqGC9c2mt+y/k5g3oyijFBTIpn
X-Gm-Message-State: AOJu0YwRAWmLU3aQC0JcppwIEWFFI0GT8zlc/o6WpVvxftW2vEqoqVWD
	foJufgmqCtChCnVFgqiJAr6EAnbrEWG3/DwAQlfSqlEPOS9NdEILuqd7TA==
X-Google-Smtp-Source: AGHT+IHjeD8CJAQCCw3yV5Si0QDfL1HUwUh69c0XMShDCcTHA3OtcBSrwulp8CfschFn1fvYHO7yPQ==
X-Received: by 2002:a17:903:32cc:b0:1f0:9395:7525 with SMTP id d9443c01a7336-1f0939576e5mr27236765ad.1.1715809663294;
        Wed, 15 May 2024 14:47:43 -0700 (PDT)
Received: from krava ([50.204.89.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c136d13sm123766515ad.242.2024.05.15.14.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:47:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 May 2024 15:47:40 -0600
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Ubisectech Sirius <bugreport@ubisectech.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, ast <ast@kernel.org>,
	daniel <daniel@iogearbox.net>, andrii <andrii@kernel.org>
Subject: Re: WARNING: kmalloc bug in bpf_uprobe_multi_link_attach
Message-ID: <ZkUtfIROG6-FBI7-@krava>
References: <da22ddaf-384f-4a38-8338-decbfdb929fc.bugreport@ubisectech.com>
 <CAADnVQJndMkNh4X-w0520B8PVN122h8XKQxE4g4LmDTKyWd=0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJndMkNh4X-w0520B8PVN122h8XKQxE4g4LmDTKyWd=0Q@mail.gmail.com>

On Wed, May 15, 2024 at 02:30:37PM -0700, Alexei Starovoitov wrote:
> On Tue, May 14, 2024 at 12:33 AM Ubisectech Sirius
> <bugreport@ubisectech.com> wrote:
> >
> > Hello.
> > We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7.  Attached to the email were a PoC file of the issue.
> 
> Jiri,
> 
> please take a look.
> 
> > Stack dump:
> >
> > loop3: detected capacity change from 0 to 8
> > MTD: Attempt to mount non-MTD device "/dev/loop3"
> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 10075 at mm/util.c:632 kvmalloc_node+0x199/0x1b0 mm/util.c:632

hi,
this should be already fixed via:
  https://lore.kernel.org/bpf/20231215100708.2265609-2-houtao@huaweicloud.com/

original report was in here:
  https://lore.kernel.org/bpf/CABOYnLwwJY=yFAGie59LFsUsBAgHfroVqbzZ5edAXbFE3YiNVA@mail.gmail.com/

the fix should be in v6.7, can you check if your kernel has:
  8b2efe51ba85 bpf: Limit the number of uprobes when attaching program to multiple uprobes

thanks,
jirka


> > Modules linked in:
> > CPU: 1 PID: 10075 Comm: syz-executor.3 Not tainted 6.7.0 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > RIP: 0010:kvmalloc_node+0x199/0x1b0 mm/util.c:632
> > Code: 02 1d 00 eb aa e8 a7 49 c6 ff 41 81 e5 00 20 00 00 31 ff 44 89 ee e8 36 45 c6 ff 45 85 ed 0f 85 1b ff ff ff e8 88 49 c6 ff 90 <0f> 0b 90 e9 dd fe ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40
> > RSP: 0018:ffffc90002007b60 EFLAGS: 00010212
> > RAX: 00000000000023e4 RBX: 0000000000000400 RCX: ffffc90003aaa000
> > RDX: 0000000000040000 RSI: ffffffff81c3acc8 RDI: 0000000000000005
> > RBP: 00000037ffffcec8 R08: 0000000000000005 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> > R13: 0000000000000000 R14: 00000000ffffffff R15: ffff88805ff6e1b8
> > FS:  00007fc62205f640(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2e026000 CR3: 000000005f338000 CR4: 0000000000750ef0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > PKRU: 55555554
> > Call Trace:
> >  <TASK>
> >  kvmalloc include/linux/slab.h:738 [inline]
> >  kvmalloc_array include/linux/slab.h:756 [inline]
> >  kvcalloc include/linux/slab.h:761 [inline]
> >  bpf_uprobe_multi_link_attach+0x3fe/0xf60 kernel/trace/bpf_trace.c:3239
> >  link_create kernel/bpf/syscall.c:5012 [inline]
> >  __sys_bpf+0x2e85/0x4e00 kernel/bpf/syscall.c:5453
> >  __do_sys_bpf kernel/bpf/syscall.c:5487 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5485 [inline]
> >  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5485
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > RIP: 0033:0x7fc62128fd6d
> > Code: c3 e8 97 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc62205f028 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 00007fc6213cbf80 RCX: 00007fc62128fd6d
> > RDX: 0000000000000040 RSI: 00000000200001c0 RDI: 000000000000001c
> > RBP: 00007fc6212f14cd R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000000b R14: 00007fc6213cbf80 R15: 00007fc62203f000
> >  </TASK>
> >
> > Thank you for taking the time to read this email and we look forward to working with you further.
> >
> >
> >
