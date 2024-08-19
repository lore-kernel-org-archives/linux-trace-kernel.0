Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A133913B5B9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Aug 2024 04:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724042405; cv=none; b=Vy+Pd/GJ2yukTJtRLLxOg+t3eljFCpb0QvZiF2ebaBKSunNslZqkmDFX1VWbx1h6Vy12z24o+CpfdG30A4ovy0a5tfQXdlUCbbx7q8/JSXSTUhoZbNLBG5dspqhddFQJQCCc3eGQMXOP6X+So/i1QbQE+mMoTc+dRC3j8Xf5O2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724042405; c=relaxed/simple;
	bh=ndPGcz+uTi/bIYAnyjXxTlLhFjz2KeP5UQ4eUxYbKxE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=V0Am6/64AWxDiIoVZV6IEyj+yzsilGNHxFxBWVCYsOEI1965LcCpmN9ywcvOxbIrlDUPw8ry8Q/VbftjF7Junfx7Kd8025YFpi0Pop/jyJTL8JQKcqQy5U7Pkhz4RW+MaB8W7LBB/SqTYXKojpTzuCA//9ZB5sgk+Rr2R/XAWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-81f8d1720ebso380470239f.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Aug 2024 21:40:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724042402; x=1724647202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QxjT7FBtIf+YOOl5Ydo57Y1HRHDgzWdhn/AVlpRKbU=;
        b=ZycrnJhKH6rsDjTucdv8hEIoOjy+UN22Rn+8aKOgbNXRdI8MZ+sv51XNqmI99scQDV
         F4UFsRMBH3TuFnaI4VprxozEFS/EA1EYHPwyZloR91MMAztJPDHuUaCUcr/JW18/G4Jw
         lt9FHIFvnA0T6l9pJTKuIys1E7CyJnoZ3XAKB0bXB64o9fvJ6fWtCSOiKD0bsPvANSQh
         AXNE3l1dzWWaKCGkwbrLpwNTjHBquH1P+pYhy/UisyMMV6etuW8eXzsSejlRUaVk2ODc
         v1i4vjzWUVpQF+d0WZ2DdZ0vz4mihb38yo2CdfppKK/UUd9f1a5Wa5DvjpujTOdLid6q
         tC1g==
X-Forwarded-Encrypted: i=1; AJvYcCVsLrgG0+RuCxaKtrh/G9kWalp1a2/2MA4C8pF2MGrp7edbLAkHI3Ih0uRTYq4Av5PNfEE/N7VBYE55QN85udfbKMGFdr3J+yWUypG5CJHO1AyV
X-Gm-Message-State: AOJu0Yzw4iC4Pko0ObmDAmnEsuj8IOrFUAMR8PQCfWptDDO/WwvbBrwa
	az3OubiexR06AG6I2xAIMvO4+mX3hwrvUvxmvVmpOBr012DK0sxySaRb99+dYVFLM9SNqLOIQBQ
	hFyDEHXgq/RcPxCGNdaSPCM22SZ7nMk450xzNjBxB7YrUEXzV156IHqw=
X-Google-Smtp-Source: AGHT+IH316qYQj7K/SEBVPvVeG35zflMK2F/Sc4nwXd5p9/IyQ5MeXxoQPgP4Q0j6l2BAJ0YCA/7X4FcoFqLlYh6md2L53cvBiuo
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:370f:b0:4b9:e5b4:67fd with SMTP id
 8926c6da1cb9f-4cce15cdbd5mr504210173.1.1724042401927; Sun, 18 Aug 2024
 21:40:01 -0700 (PDT)
Date: Sun, 18 Aug 2024 21:40:01 -0700
In-Reply-To: <0000000000002be09b061c483ea1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1e97e062001e6b2@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_released
From: syzbot <syzbot+16b6ab88e66b34d09014@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, netdev@vger.kernel.org, 
	nsaenz@amazon.com, nsaenzju@redhat.com, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Jun 21 01:08:41 2024 +0000

    mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d48893980000
start commit:   a12978712d90 selftests/bpf: Move ARRAY_SIZE to bpf_misc.h
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=736daf12bd72e034
dashboard link: https://syzkaller.appspot.com/bug?extid=16b6ab88e66b34d09014
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=125718be980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14528876980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
