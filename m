Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671A4136986
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 May 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716216174; cv=none; b=gYfT7yGMWrtJ6jPMtZDQzpU/37Y8ka2UED0zZHPpHb+4fYJB3+BUTy91PbiR6SdAHhTWYVJlK3BUAK6nKXoNMUtvjyU3aN8v/KABLoNRZf6oDslCFvVxoeNv6MccyDTwSc/1GDxuArwbbiji38Wm02N1EzNLUPFZP+iQ2iIOVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716216174; c=relaxed/simple;
	bh=KUgBuEaVcI4ydQagLxbGYRK4MhcScQHsdwehLTvW9Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3/ZIahg0kXXz9s8b8NPDdV2By2rGzmuLrhtDyccDvEvYm40kz47b/CEfBtxOcvjShZvTGasboLX4b/qPSIgeo1Eq32BUGM5QHdZzEqrDRSYy3EihsjiClSYT49TC9gpVBDvwlXR2xjjhW5SHjLhBPkSGgkPUWBi/pQCao7h+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=H0w+Fr1t; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="H0w+Fr1t"
X-Envelope-To: rostedt@goodmis.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716216170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0KCk58wS70fFfp9wh3lG0S0zT2I32k7WzSL3uhS3b9w=;
	b=H0w+Fr1tyaK0dgotrLbIBNgrB1mOi3KV38cxZpo+6Yyt4k+fO/2vrDH+iGt3UjFRD8fn/H
	4uejzgWDY0WsHI9V3l3aWie7L631vo/dQ8HI4xdI0irJWkUB4r3afU3hIDSU5P51XHGC4d
	qup6Oab80OmddLIInLfZaL4n8I/oDYs=
X-Envelope-To: bugreport@ubisectech.com
X-Envelope-To: linux-trace-kernel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 20 May 2024 10:42:45 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ubisectech Sirius <bugreport@ubisectech.com>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in validate_sb_layout
Message-ID: <rcrruhodkxfno5645jrikjtc6i5p7dsaesajmqgsfboj5xur3q@zcwkow7kf4rt>
References: <e9ce22da-0caa-4815-9b3a-3e406aca6ffd.bugreport@ubisectech.com>
 <20240520103153.245b0c51@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520103153.245b0c51@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

On Mon, May 20, 2024 at 10:31:53AM -0400, Steven Rostedt wrote:
> On Mon, 20 May 2024 15:02:26 +0800
> "Ubisectech Sirius" <bugreport@ubisectech.com> wrote:
> 
> > Hello.
> > We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> > 
> > Stack dump:
> > UBSAN: shift-out-of-bounds in fs/bcachefs/super-io.c:310:18
> > shift exponent 127 is too large for 32-bit type 'int'
> > CPU: 0 PID: 14408 Comm: syz-executor.3 Not tainted 6.7.0 #2
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
> >  ubsan_epilogue lib/ubsan.c:217 [inline]
> >  __ubsan_handle_shift_out_of_bounds+0x24b/0x430 lib/ubsan.c:387
> >  validate_sb_layout.cold+0x1a/0x51 fs/bcachefs/super-io.c:310
> >  bch2_read_super+0x980/0x1000 fs/bcachefs/super-io.c:786
> >  bch2_fs_open+0x471/0x3890 fs/bcachefs/super.c:1922
> >  bch2_mount+0x538/0x13c0 fs/bcachefs/fs.c:1863
> >  legacy_get_tree+0x109/0x220 fs/fs_context.c:662
> >  vfs_get_tree+0x93/0x380 fs/super.c:1771
> >  do_new_mount fs/namespace.c:3337 [inline]
> >  path_mount+0x679/0x1e40 fs/namespace.c:3664
> >  do_mount fs/namespace.c:3677 [inline]
> >  __do_sys_mount fs/namespace.c:3886 [inline]
> >  __se_sys_mount fs/namespace.c:3863 [inline]
> >  __x64_sys_mount+0x287/0x310 fs/namespace.c:3863
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> > RIP: 0033:0x7f41e1091b3e
> > Code: 48 c7 c0 ff ff ff ff eb aa e8 be 0d 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007f41e1d22e38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> > RAX: ffffffffffffffda RBX: 0000000000005d82 RCX: 00007f41e1091b3e
> > RDX: 0000000020005d80 RSI: 0000000020000100 RDI: 00007f41e1d22e90
> > RBP: 00007f41e1d22ed0 R08: 00007f41e1d22ed0 R09: 0000000000000080
> > R10: 0000000000000080 R11: 0000000000000202 R12: 0000000020005d80
> > R13: 0000000020000100 R14: 00007f41e1d22e90 R15: 0000000020005e00
> >  </TASK>
> > 
> > Thank you for taking the time to read this email and we look forward to working with you further.
> 
> I'm not sure why this is getting Cc'd to linux-trace-kernel. That's for
> anything to do with the tracing code (trace events, tracepoints, kprobes,
> uprobes, function tracer etc).
> 
> What part of tracing is this for?

Everything I've seen from Ubisectech has been duplicates of stuff syzbot
found awhile ago and is already fixed.
