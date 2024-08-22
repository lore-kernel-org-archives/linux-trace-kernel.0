Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8117C230;
	Thu, 22 Aug 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724316095; cv=none; b=ka+DXiP4ywoOKl66JEMuTpvh2MlXB/wyiuFmFDrcMegZP0Ly9bgOFyy072D8zFzfDDoa1KKqqq4EGFTS8o36O4cmw0HO87+2GTm5obZFBYqY5apcXgCSKGR+qViRvaY5OmTEE9g8l5OhrPAbHzmh1KDAOTaxd/FhV5vugaCAT5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724316095; c=relaxed/simple;
	bh=dz62oINgz5SUIP1FotkdD2eDkg58OumWb21RFqKMRtI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiSVPbpyzOtvORBt1dVtzbVgNyIj4bZsIwUFxTKbvm5NpNSNz+rGL8qSGXEwwoHlSbCDFh4iG2I4XHHiqBfBiEmziIU+OoZI4OclhtvlXLBgp/cKFuqj+e6gTeElwL5acMTuFYYBx/B4TJNKFwIrlZHAI/l0XQ21ujVy+MDYz3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YivWu39x; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YivWu39x"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83597ce5beso84041966b.1;
        Thu, 22 Aug 2024 01:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724316092; x=1724920892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/fYnJU1OzD4PP6WOtje/AOdfdMauVTBLTL3pwqx6uWQ=;
        b=YivWu39xY00e6VaRu12bJhWJHtxDcyBlGHfJYSL6Lb/FJaU74U9ncCuSwhxortZGHO
         iuDJvw0JQs4Fs76aGwABwMIyJHkqJ+fbNzWzX6nsH90315VCiYjlzvMtp5pZPvQc2j/p
         6PokdavMNzuKNHe+n+CvHpWLo+2SwSCDGWN2G3A6A/IA+dpGFhditbstdjiN2xE30Gbr
         a0DphUxIXJAFzxMiyVd4UU+uN4t/vcpzNG8cjjp+9iDh/eQD/G+YjJ3k/1CnCqN23hKK
         cLUIN/XFKkVz37De9+1Ied2MXaiu/aZ+5lOOrlA93qFp5Sie0AOPcwczTUfqMJwClrRq
         ZLtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724316092; x=1724920892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fYnJU1OzD4PP6WOtje/AOdfdMauVTBLTL3pwqx6uWQ=;
        b=feI8Mam+3x19xstwRFF/Ie/emmKNURs43s5sd4kh9XA2BQLnhu8KrMVc6ASYFPm29z
         53lYzbWtZqx5VdXXyRGbbOvwqZw9G9RgGkJjVwGR3YJWqGRfnZQfXBNMra2x/9v5XWbw
         pnjuNH9SML+QYRlLq1rT6IdLtEpRn2NwVVYxsn5EC1KZzbgyWuUCtUa8mqEFtzA0ME7O
         FRhP7snGV+S3xPta92XRq1wEDKt0BFiruL24lkKNmJr/PJYT2R4hbOIQQXirGusaqa1q
         EjiVTCrHN+GWajWWDU2PyUvabSJT6INanyr8VRV2sBha1pmak0pYIp94IsD593+f33jB
         nMCw==
X-Forwarded-Encrypted: i=1; AJvYcCW1mqVicZpmGkIb9M+bAfQFTGLfrT0kP9+E3K2lI8HWGFHJO3piwoWGz+l+D7qPCAZSIdJtiuHimHoCRaYDsoH485Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NsIelXQkXhcVMYUHDy3pNSEYQgu4XmJh1XeUgrQG19bE0ICO
	VmLme1MzIVnQTxHudhQcgByNme6sQL3Kmus2ZH3hFdSk+hnyAlR2
X-Google-Smtp-Source: AGHT+IFlHTfcDQCkQoKtFkm5vZI/ldGEn8qxYUCVNZnbZEXd0vHyv24WwdSxTJM9TE1sylhmkZqJ4g==
X-Received: by 2002:a17:907:6ea6:b0:a86:935c:4c49 with SMTP id a640c23a62f3a-a86935c5972mr102511366b.14.1724316091953;
        Thu, 22 Aug 2024 01:41:31 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43790bsm84796466b.126.2024.08.22.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 01:41:31 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Aug 2024 10:41:29 +0200
To: Ubisectech Sirius <bugreport@valiantsec.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
	andrii <andrii@kernel.org>
Subject: Re: WARNING in uprobe_unregister
Message-ID: <Zsb5uY6vvf3gEnAL@krava>
References: <ae7a5402-c364-47fb-bffb-46b65cecd442.bugreport@valiantsec.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae7a5402-c364-47fb-bffb-46b65cecd442.bugreport@valiantsec.com>

On Mon, Aug 05, 2024 at 09:50:45AM +0800, Ubisectech Sirius wrote:
> 
> 
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.8. Attached to the email were a PoC file of the issue.
> 
> Stack dump:
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 14015 at kernel/events/uprobes.c:1107 uprobe_unregister+0x66/0x80 kernel/events/uprobes.c:1107
> Modules linked in:
> CPU: 1 PID: 14015 Comm: syz.0.291 Not tainted 6.8.0 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> RIP: 0010:uprobe_unregister+0x66/0x80 kernel/events/uprobes.c:1107
> Code: 89 ee 48 89 ef e8 3a fd ff ff 4c 89 e7 e8 72 8b b1 ff 48 89 ef e8 ca aa ff ff 5d 41 5c 41 5d e9 f0 29 d3 ff e8 eb 29 d3 ff 90 <0f> 0b 90 5d 41 5c 41 5d e9 dd 29 d3 ff 66 66 2e 0f 1f 84 00 00 00
> RSP: 0018:ffffc90001e27d18 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffff888064695ac8 RCX: 0000000000000000
> RDX: ffff888043b8c980 RSI: ffffffff81b782c5 RDI: 0000000000000001
> RBP: ffff88805e3f5040 R08: 0000000000000000 R09: fffffbfff1a95cf8
> R10: ffffffff8d4ae7c3 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff888064695aa0 R14: 0000000000000000 R15: ffff888064695aa0
> FS:  000055555744b500(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000110c394aab CR3: 0000000064b02000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  bpf_uprobe_unregister+0xf7/0x1c0 kernel/trace/bpf_trace.c:3134
>  bpf_link_free+0xe8/0x1b0 kernel/bpf/syscall.c:2904
>  bpf_link_put_direct kernel/bpf/syscall.c:2935 [inline]
>  bpf_link_release+0x62/0x80 kernel/bpf/syscall.c:2942
>  __fput+0x282/0xbc0 fs/file_table.c:376
>  task_work_run+0x16a/0x260 kernel/task_work.c:180
>  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:108 [inline]
>  exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:201 [inline]
>  syscall_exit_to_user_mode+0x278/0x2a0 kernel/entry/common.c:212
>  do_syscall_64+0xe5/0x270 arch/x86/entry/common.c:89
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7fbb25596e2d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe3696a318 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
> RAX: 0000000000000000 RBX: 00007fbb25737a80 RCX: 00007fbb25596e2d
> RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> RBP: 00007fbb25737a80 R08: 0000001b33420214 R09: 0000000000000000
> R10: 0000001b33420210 R11: 0000000000000246 R12: 000000000004ba6b
> R13: 00007ffe3696a3f0 R14: 00007fbb25736064 R15: 00007fbb25737a80
>  </TASK>
> 
> Thank you for taking the time to read this email and we look forward to working with you further.

hi,
thanks for the report

so far I can't hit it with the reproducer, could share your .config?

do you see it on latest bpf-next/master?

thanks,
jirka
