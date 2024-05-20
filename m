Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A071369AA;
	Mon, 20 May 2024 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716215476; cv=none; b=fbRhdz7I8D2Y2C0bQ81sitPBfniJiNUWiOJPrvK4CGwBotXTYGoVacOMl+cTTuOa8dhrb+v+aFICglSuj1CS9WXiuMjnqWu7ITy62VqHyNp4VQOebYmicxyLMeNA60onAN0eNhmTUPXXP3Hsh37MAp4wIemAut0K1VVcn64HR3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716215476; c=relaxed/simple;
	bh=4xJtd34PmhuOI+B1hMUkgdy+D/Ll2BKsRhEovxdIxUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvP9g5QJ4PZKQr/IgDay2XLaYam+QTxgp2GZUNUaM3pJ4tStlamUwRoYnelncemF5aWbViI/sW+gYJ3pkCS7JWCCP8LhGKCjDcmVbkKdIvTkwWUCUrrK4IxB4c5RKKh9iZAS53T+E+/ZHuiRG/Udv99hyAlHVusb8atEYRo6x1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D07BC2BD10;
	Mon, 20 May 2024 14:31:15 +0000 (UTC)
Date: Mon, 20 May 2024 10:31:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ubisectech Sirius" <bugreport@ubisectech.com>
Cc: "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>,
 "linux-kernel" <linux-kernel@vger.kernel.org>, "kent.overstreet"
 <kent.overstreet@linux.dev>
Subject: Re: UBSAN: shift-out-of-bounds in validate_sb_layout
Message-ID: <20240520103153.245b0c51@gandalf.local.home>
In-Reply-To: <e9ce22da-0caa-4815-9b3a-3e406aca6ffd.bugreport@ubisectech.com>
References: <e9ce22da-0caa-4815-9b3a-3e406aca6ffd.bugreport@ubisectech.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 15:02:26 +0800
"Ubisectech Sirius" <bugreport@ubisectech.com> wrote:

> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> 
> Stack dump:
> UBSAN: shift-out-of-bounds in fs/bcachefs/super-io.c:310:18
> shift exponent 127 is too large for 32-bit type 'int'
> CPU: 0 PID: 14408 Comm: syz-executor.3 Not tainted 6.7.0 #2
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>  ubsan_epilogue lib/ubsan.c:217 [inline]
>  __ubsan_handle_shift_out_of_bounds+0x24b/0x430 lib/ubsan.c:387
>  validate_sb_layout.cold+0x1a/0x51 fs/bcachefs/super-io.c:310
>  bch2_read_super+0x980/0x1000 fs/bcachefs/super-io.c:786
>  bch2_fs_open+0x471/0x3890 fs/bcachefs/super.c:1922
>  bch2_mount+0x538/0x13c0 fs/bcachefs/fs.c:1863
>  legacy_get_tree+0x109/0x220 fs/fs_context.c:662
>  vfs_get_tree+0x93/0x380 fs/super.c:1771
>  do_new_mount fs/namespace.c:3337 [inline]
>  path_mount+0x679/0x1e40 fs/namespace.c:3664
>  do_mount fs/namespace.c:3677 [inline]
>  __do_sys_mount fs/namespace.c:3886 [inline]
>  __se_sys_mount fs/namespace.c:3863 [inline]
>  __x64_sys_mount+0x287/0x310 fs/namespace.c:3863
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0x43/0x120 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x6f/0x77
> RIP: 0033:0x7f41e1091b3e
> Code: 48 c7 c0 ff ff ff ff eb aa e8 be 0d 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f41e1d22e38 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000005d82 RCX: 00007f41e1091b3e
> RDX: 0000000020005d80 RSI: 0000000020000100 RDI: 00007f41e1d22e90
> RBP: 00007f41e1d22ed0 R08: 00007f41e1d22ed0 R09: 0000000000000080
> R10: 0000000000000080 R11: 0000000000000202 R12: 0000000020005d80
> R13: 0000000020000100 R14: 00007f41e1d22e90 R15: 0000000020005e00
>  </TASK>
> 
> Thank you for taking the time to read this email and we look forward to working with you further.

I'm not sure why this is getting Cc'd to linux-trace-kernel. That's for
anything to do with the tracing code (trace events, tracepoints, kprobes,
uprobes, function tracer etc).

What part of tracing is this for?

-- Steve

