Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC21F8AE6;
	Tue, 17 Dec 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479718; cv=none; b=nu20bhESk94AXOu2QsJghz6D675QiCIroD+B7ODSHFgUWCEng7BXua0HJANljNXfHrLPIZ77pLKigOLXpAUKvtbFKHQzyQevHX9/XuEhfN/WC6eQ0okaetwdFsiuyc8wp0jh2CO90Pr7wsFgU4RdjA1iZcPwwpPN2qTozvX2gNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479718; c=relaxed/simple;
	bh=JZi0lXHH71pplPBzLHxkjKKqNjDovCutW8ah8i70QKQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KnaQgn+xsPO+K47suU4TS8rHFluvSQ3mSt9k9+lKTMLL9hX57PAAcV7ijoUY0qLq6t80OjTkOnjfMmLs6zd5CFfxvLzHS0uXoXm64+nxgzJczbAKHLiO7gquhmyUgFLqYxPIbp/9kZXcfVqAX/QRnIUEI04jBZ3J2eDFqIX6lW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K4l6jUG1; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K4l6jUG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1734479409; bh=gxbNWNi8Fzzn3gs986CDR4lB07xEV86uZdr1Rqf+YKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K4l6jUG11d80PfmnkBq+t48gbgi+k5R3uehH7FKHnU9aJ3L4j2zGS0QEV16DspD/2
	 HNam1pr92YOv6n7QeJ8TZ/i+XL9URaF7vsVptF6GE7fDiQUYAWbG9vj2p/WolUg6cg
	 tC2tO23wzAMQTnnnD7lM9wQQyy8nvxovTXICdeIs=
Received: from pek-lxu-l1.wrs.com ([114.244.57.34])
	by newxmesmtplogicsvrszgpua5-0.qq.com (NewEsmtp) with SMTP
	id AEF1FA80; Wed, 18 Dec 2024 07:43:47 +0800
X-QQ-mid: xmsmtpt1734479027tmcd9ys5y
Message-ID: <tencent_4F9EBF1BA54B1A1B74257CBA08BB49334F08@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCt24nDxpEgLXe7G1pXxSNp2PKXxKaCd+z+2bhFFbRCTam2zKAyEv
	 7tOGLF1vLsZLkB/JwW1UQc711G/mX4VhRWXa0dY+G7AubEpSSaPveGeo4KVeUbNNu2kePL+206gQ
	 JG4xUVAjfuagebKIQo9v5YQuhg4j0u0ykFI7gPuQOxng2YujLXOfU+PngnZKbmAkbF/rEXo0rqgf
	 PQtGK38Udsouuw6X3kmmcauqmlPQRAPWEs0COzdFTchCnJlKl7zgAVHKzmuRQDeJlN454tWB24uo
	 tREMIiFYrrZg9QR+876gJqgz+UR+PMRHuG4Yl4BSHrdbj2ySi29F7bXlOzrn0gIhj9la/SGwZQEI
	 fmjbNh0VfgIUqHiQZ0W61RRHMtj6IvFTNKnSTYaJ4u/YN3hvfyl8lFaScAy8pTXo3fD22ovvXuZe
	 pKpRH5smHPX4tcO0kfPY3kYa/YXsI5GF4qpjHyiTLjP65AKgveZjDVOg3Ms8ZzW/k0ko0i/DmYoS
	 sM4IFd/jinMHIOd52SmvqjVXE8KU+Xd71WRNq3wBv+sKqXB8TElINCkkURtetv7kdshxQaAwa2xk
	 51U1GTlhEBoXme4f68qsmDC9o8TExXPNrJu4jsnFX4HaqgRc7MvpPrSGgl4gDDH68g6HxmnT5SFg
	 /0IRW9bPK6QObA02E00idTTPw31mtbFlGJwhip1x4LNjt7fFQzzPyyBGA4QOgEpOLIcGWhoWUYQ8
	 galL1BHlxkB2Gx5nWctPZypQ1n8OnZHHbSJG68Q3b6mJ2BsIxpTqSvA0mWl4cFUkv4tg5dr5AeU+
	 4vqrosCuit7POLmVXtFW6R06bEnR9KH+n25XJP02ZU3WVnOMnmdeexXhscpinK1qO/NulqggNbVg
	 uM2N+x890o+KMzS10QiI3yZtAfKuoyHRhBqEgawxPV
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: rostedt@goodmis.org
Cc: eadavis@qq.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	syzbot+345e4443a21200874b18@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ring-buffer: Fix a oob in __rb_map_vma
Date: Wed, 18 Dec 2024 07:43:46 +0800
X-OQ-MSGID: <20241217234345.3254530-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217124602.2d498c3f@gandalf.local.home>
References: <20241217124602.2d498c3f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 17 Dec 2024 12:46:02 -0500, Steven Rostedt wrote:
> On Mon, 16 Dec 2024 22:07:57 +0800
> Edward Adam Davis <eadavis@qq.com> wrote:
> 
> > syzbot report a slab-out-of-bounds in __rb_map_vma. [1]
> > 
> > Overflow occurred when performing the following calculation:
> > nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff;
> > 
> > Add a check before the calculation to avoid this problem.
> > 
> > [1]
> > BUG: KASAN: slab-out-of-bounds in __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
> > Read of size 8 at addr ffff8880767dd2b8 by task syz-executor187/5836
> > 
> > CPU: 0 UID: 0 PID: 5836 Comm: syz-executor187 Not tainted 6.13.0-rc2-syzkaller-00159-gf932fb9b4074 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
> >  print_address_description mm/kasan/report.c:378 [inline]
> >  print_report+0xc3/0x620 mm/kasan/report.c:489
> >  kasan_report+0xd9/0x110 mm/kasan/report.c:602
> >  __rb_map_vma+0x9ab/0xae0 kernel/trace/ring_buffer.c:7058
> >  ring_buffer_map+0x56e/0x9b0 kernel/trace/ring_buffer.c:7138
> >  tracing_buffers_mmap+0xa6/0x120 kernel/trace/trace.c:8482
> >  call_mmap include/linux/fs.h:2183 [inline]
> >  mmap_file mm/internal.h:124 [inline]
> >  __mmap_new_file_vma mm/vma.c:2291 [inline]
> >  __mmap_new_vma mm/vma.c:2355 [inline]
> >  __mmap_region+0x1786/0x2670 mm/vma.c:2456
> >  mmap_region+0x127/0x320 mm/mmap.c:1348
> >  do_mmap+0xc00/0xfc0 mm/mmap.c:496
> >  vm_mmap_pgoff+0x1ba/0x360 mm/util.c:580
> >  ksys_mmap_pgoff+0x32c/0x5c0 mm/mmap.c:542
> >  __do_sys_mmap arch/x86/kernel/sys_x86_64.c:89 [inline]
> >  __se_sys_mmap arch/x86/kernel/sys_x86_64.c:82 [inline]
> >  __x64_sys_mmap+0x125/0x190 arch/x86/kernel/sys_x86_64.c:82
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > Reported-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=345e4443a21200874b18
> > Tested-by: syzbot+345e4443a21200874b18@syzkaller.appspotmail.com
> > Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> > ---
> >  kernel/trace/ring_buffer.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 7e257e855dd1..15c43d7415d5 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -7019,6 +7019,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
> >  	lockdep_assert_held(&cpu_buffer->mapping_lock);
> >  
> >  	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
> > +	if (((nr_subbufs + 1) << subbuf_order) < pgoff)
> > +		return -EINVAL;
> > +
> 
> A proper fix is being discussed here:
First, my fix is the first one.
Second, the root cause of the problem is an overflow when calculating nr_pages.
> 
> https://lore.kernel.org/linux-trace-kernel/20241216164931.57323-1-aha310510@gmail.com/
> 
> Thank you,
> 
> -- Steve
> 
The calculation of nr_pages below overflows because the pgoff value is 8,
the nr_subbufs value is 3, and the subbuf_order value is 0.
> >  	nr_pages = ((nr_subbufs + 1) << subbuf_order) - pgoff; /* + meta-page */
> >  
> >  	nr_vma_pages = vma_pages(vma);
BR,
Edward

