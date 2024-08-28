Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AED13C670
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Aug 2024 03:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815864; cv=none; b=q/njIDLRP2SpyXUzr8Zbx6QuyC0R9C1yTeqxzx1EwJRSK+O9rS9EZwiizPkwJjMkaLSQmR36b4l3stlfFSbUK5zRSmdDxNcJ29bH3CLLKVkUIJ0HgOq/53QtWDVrkwvPKHzqKrpQHXP7xWOgAJ3cRQABEWqvobmwQDN4IpaI5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815864; c=relaxed/simple;
	bh=rGfTbjB/IrseFEx3IwAHyLUhBJHgnuEKuPFplJBEDm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D3fHZPA4WYaTLRpfPcGg1f0x0Zwp84p/rOB/o/iav3E/ik3GcSM4kLK1EcmXMoCwUFg9NmHVh6hbQwXxxVWSmwpNLPHhO+4Wwdun5DS1cgaPMQUzjRySkZuMgkZYND/DrrvZkEHvPrCbtbPnIHaWZc51jdnmOTsfoGtWQS2sgaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824d69be8f7so689025939f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Aug 2024 20:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724815862; x=1725420662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vu5uJIf/8g8dj3Yf1bX3ohQRMUDAmS7B1nSWGrngtyA=;
        b=h+U9UuI5r66kS6AJwJgdb/c8+QFui5mc1oH2htjLJVVHhHFsj+ilM3FSDOOIJysmGW
         oIm2q/xFNLHXogHj+gUiLpOpfyWPcJDqwquR760vl7XPiCDMAIB0rJKcdjlQkO35fMMl
         Mp/IE1Od2S4hkgljah/kgNs659V4dfEbE6KhjQwP3kN6kzR7Z9PgHjCwQAhAej6lCcQj
         XBUHKISqhYv4BciRV8BGvSjGgRc66kyunoJn9FcWXRPgN4jdVheW3w1VVbO4uxD0WmAf
         NpYEVY1AGm7XdJSuPTxw/D1ymsmc1/p0t3AUCKpG70EdKoVPsz/Zo+UhQONsWGdql9yu
         0+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCV7DdQeDT0sSNdFa9aZXqIgAl/HQcdFrtAGG28+7WnTWXqRAWYKVhrlOcNU5dgV8bADlys4KS7X/qUGRCGa+qJapqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXdceHz6XugZcLs6r8Uwv0VB4QZWoKLLrz/dyqOHefYwNKb45N
	plri0P/K5sgfZYVCZ+K63xiVg0MxdG8O0OAfKPTkdYpZZZYgHYCez4y6yuzXd+mGnfr7+FuyRjd
	vcfelGy1vgnon+8JcopqLlwIaoAjSkG6EML/zu+rEou3ld/Cily5S5MM=
X-Google-Smtp-Source: AGHT+IEq8u5/q/T/KHaia+Jqn7A0HsIJt8R9RZERwYw9F9VvKOGMfK5bKs62RG9i16fQQ3jpz+ESgjyw7fdzdoTzuweYCtivkz/x
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:7306:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4cec4f922cbmr24918173.4.1724815862301; Tue, 27 Aug 2024
 20:31:02 -0700 (PDT)
Date: Tue, 27 Aug 2024 20:31:02 -0700
In-Reply-To: <00000000000041df050616f6ba4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c69eb60620b5fc4b@google.com>
Subject: Re: [syzbot] [mm?] possible deadlock in __mmap_lock_do_trace_start_locking
From: syzbot <syzbot+6ff90931779bcdfc840c@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, axelrasmussen@google.com, 
	cgroups@vger.kernel.org, hannes@cmpxchg.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, lizefan.x@bytedance.com, 
	longman@redhat.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netdev@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp, 
	penguin-kernel@i-love.sakura.ne.jp, rostedt@goodmis.org, 
	syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 7d6be67cfdd4a53cea7147313ca13c531e3a470f
Author: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Date:   Fri Jun 21 01:08:41 2024 +0000

    mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1412f697980000
start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
git tree:       bpf
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=6ff90931779bcdfc840c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585acfa980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17bdb7ee980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: mm: mmap_lock: replace get_memcg_path_buf() with on-stack buffer

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
