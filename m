Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D41C93BC;
	Thu, 22 Aug 2024 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337092; cv=none; b=MvURu6fYrS75znrQgp4EaiZNohCNw/REboYi0kobBP/nPB7BgIFql56uNxyewpYP+Wh8yPRtZc+xpHy2JpWKyP37VDhCXo/jRCWX2b6u5LEQBnx0mqcjH3gV56OyJU4VZKynb31nIRINSM9HXfVNcWLLkhOcU43y8EpaE34xIGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337092; c=relaxed/simple;
	bh=c/Cj9RrvqJul5t8m3NiqMO38iRJFNFSyGlqIQpBEd94=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnB2xzXTj3PK0V7fHO3Dn8H6Y4OMrb2vBjBB1phUfPyLujofqLZZoF8rzZPhQWzr7R37BnT7TjIvTCrpZRPjNs2o5CDcAtGVGdSYeXt9g+UlVQP5YuXWL14926upcgb+k4LuLtnrUqTfPQazQgC7l4LkICxEf3Zs9bZtitqeYBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC80C32782;
	Thu, 22 Aug 2024 14:31:31 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:32:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in
 timerlat_fd_release
Message-ID: <20240822103202.130cf0df@gandalf.local.home>
In-Reply-To: <CAP4=nvRTH5VxSO3VSDCospWcZagawTMs0L9J_kcKdGSkn7xT_Q@mail.gmail.com>
References: <20240820130001.124768-1-tglozar@redhat.com>
	<20240821160316.02c03c44@gandalf.local.home>
	<CAP4=nvRTH5VxSO3VSDCospWcZagawTMs0L9J_kcKdGSkn7xT_Q@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Aug 2024 11:32:07 +0200
Tomas Glozar <tglozar@redhat.com> wrote:

> st 21. 8. 2024 v 22:02 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.or=
g> napsal:
> >
> > I'm able to reproduce this with the above. Unfortunately, I can still
> > reproduce it after applying this patch :-(
> > =20
>=20
> Thank you for looking at this. I was at first not too sure about
> whether this is the proper fix, but after some discussion with Luis
> (in CC), we have come to the conclusion that the double-close of the
> timerlat_fd might be a possible explanation, and this patch worked for
> both of us. Are you reproducing the same bug (NULL pointer dereference
> in hrtimer_active) with the patch? IIUC that should not happen anymore
> since the patch explicitly checks for zero in the hrtimer structure.

There isn't a double close. But there are two bugs and you did sorta fix
one of them.

>=20
> I have caught however a different panic in addition to the one
> reported above while testing "rtla: Support idle state disabling via
> libcpupower in timerlat" on an EL9 RT kernel:
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000014
> CPU: 6 PID: 1 Comm: systemd Kdump: loaded Tainted: G        W
> -------  ---  5.14.0-452.el9.x86_64+rt #1
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
> 04/01/2014
> RIP: 0010:task_dump_owner+0x3d/0x100
> RSP: 0018:ffffadd6c0013aa8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffffa00c864f4580 RCX: ffffa00c87453e10
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa00c864f4580
> RBP: ffffa00c87453e10 R08: ffffa00c87418e80 R09: ffffa00c87418e80
> R10: ffffa00c88236600 R11: ffffffffb73f1868 R12: ffffa00c87453e0c
> R13: 0000000000000000 R14: ffffa00cb5e430c0 R15: ffffa00cb5e430c8
> FS:  00007f9336b41b40(0000) GS:ffffa00cffd80000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000014 CR3: 00000000025ee002 CR4: 0000000000770ef0
> PKRU: 55555554
> Call Trace:
> <TASK>
> ? show_trace_log_lvl+0x1c4/0x2df
> ? show_trace_log_lvl+0x1c4/0x2df
> ? proc_pid_make_inode+0xa0/0x110
> ? __die_body.cold+0x8/0xd
> ? page_fault_oops+0x140/0x180
> ? do_user_addr_fault+0x61/0x690
> ? kvm_read_and_reset_apf_flags+0x45/0x60
> ? exc_page_fault+0x65/0x180
> ? asm_exc_page_fault+0x22/0x30
> ? task_dump_owner+0x3d/0x100
> ? task_dump_owner+0x36/0x100
> proc_pid_make_inode+0xa0/0x110
> proc_pid_instantiate+0x21/0xb0
> proc_pid_lookup+0x95/0x170
> proc_root_lookup+0x1d/0x50
> __lookup_slow+0x9c/0x150
> walk_component+0x158/0x1d0
> link_path_walk.part.0.constprop.0+0x24e/0x3c0
> ? path_init+0x326/0x4d0
> path_openat+0xb1/0x280
> do_filp_open+0xb2/0x160
> ? migrate_enable+0xd5/0x150
> ? rt_spin_unlock+0x13/0x40
> do_sys_openat2+0x96/0xd0
> __x64_sys_openat+0x53/0xa0
> ...


> Yeah, it seems there might be multiple bugs in the user workload
> handling, the other NULL pointer dereference and refcount warning
> above might be related (but I have yet to reproduce it on an upstream
> kernel). I'm also going to look at the code and will post any findings
> here.

Yes that is the second bug and it is related to the that this addresses.

-- Steve
