Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609734750F;
	Tue, 25 Aug 2026 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787669036; cv=none; b=Lk0BT2drCTv3iCH6/gfaOi941llA8TZxWx2ozRqVSncQMqqLRRtkYcUaRmXVe+4XKspkAGZOpLjqw54bIBaKpeVNhU13ASBtUvemOoa5AW+dHZ7rKQM4IXuukk50lhYePw8TVWiQbXRzyJIdTx44D/Zq7uyT/wnqm9331my+5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787669036; c=relaxed/simple;
	bh=fjYNriNlzTQVk1dKlHFxaJgo51SeFEGb1Z6CGoIBs0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pknt/+w3N/rT3xbQ/1ta4fjdqZPaSQH7IQgvDyMA87PO+q+i1/zHaf/0Ol4isLiRwQpxJSX4Wk0jysrHKASI4Ma7Hzi/WIxc9y4Q3g6D10kDNKmXJ2Bhxf3RU5tTXGD+NvInS2qqc/VwER9UYyPfO7gehKF/fqXNlrRdeAO8HiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=WuuHKIiI; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="WuuHKIiI"
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 9A0D6A0406;
	Tue, 25 Aug 2026 14:43:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id A8F9E1F;
	Tue, 25 Aug 2026 14:43:50 +0000 (UTC)
Date: Tue, 25 Aug 2026 10:44:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, include@grrlz.net,
 LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing/user_events: Clear copied tracing state before
 fork duplication
Message-ID: <20260825104433.2f08ba46@gandalf.local.home>
In-Reply-To: <20260824215040.0509ff1b@fedora>
References: <20260824210814.3726486-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<20260824215040.0509ff1b@fedora>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A8F9E1F
X-Stat-Signature: um8ugb6za475w4zzqo9u1hk7dasus9tk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+11MbRnefjEJJwwgPIre7S3N/+Rx/Pusg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=xmMT9UHYmH3zmLYq5ELDI+ozek682f9BJ6lAzODIcnQ=; b=WuuHKIiIjnOGfRFSqFbzyUK8W7baCUhm3JgqsuaQYnNSBoYe4/xVxHt+PYywO4/DHhkz9Z/YthBXe27EjKYBxTFpPonjETxVNU2kIUofZtC39dMhn3pBKg5GjjRUQhoWtOUKG3OFGz56t14R8+bwWjS3aqdJXiNQAybsMnCNwso=
X-HE-Tag: 1787669030-519297
X-HE-Meta: U2FsdGVkX1+dwuxu0+LpeWNi7Feydry9DICqAWCh0WBxdTqV92gpdp7bV6ByQr0EoJ2VnZKPB+P3DQAy3LAbQ6I8X9/I3m3fTOLxMmubDxAmdzrGRc5RS0HgDrXkopvE+LPiq/HTw8qGQGWMjRVb+0Qd4Kmc9h78uJFcY5ECpPIftzqmUC8sJLr5RmwUOpRJDFisghQ8gO/nB5muIlXCtoewZhRrFXuw3qaPKFUFfdU6YnYR465D5DKWtaCXEt7CJEuPrJF8C1wxdmPnNQiDNF+LS9+1hfhi0QdhARxBFtXsvGJ8njf3QUx5HOm+Xx72Ngrrct4n1ta0oEpCtMi1OQq3dJ1m+VtjDELKcLWy1oSiL9iTdtY8YsWVCBaP4jB0Wm9BvBGb1R/EpxQ1mow/RlR3jZFpZ5KL


Oh, and you forgot to Cc any mailing list. You need to Cc linux-kernel and
linux-trace-kernel to have this include, otherwise it will never appear in
patchwork, which means it will never appear in the kernel.

-- Steve


On Mon, 24 Aug 2026 21:50:40 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 24 Aug 2026 21:08:15 +0000
> J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>=20
> > User events keep per-mm tracing state in task_struct::user_event_mm. It
> > tracks the registrations and enablers created through the tracefs
> > user_events_data interface.
> >=20
> > dup_task_struct() starts a fork by copying this pointer from the parent.
> > user_events_fork() must then either share it for CLONE_VM, or create new
> > state for a child with a separate address space.
> >=20
> > The second case can fail. If user_event_mm_dup() cannot allocate the new
> > state or copy one of its enablers, it returns without replacing the
> > pointer copied by dup_task_struct(). The child now points at the parent=
's
> > tracing state, but did not take a task reference to it.
> >=20
> > When the child exits, user_event_mm_remove() can drop the parent's task
> > count to zero and queue its tracing state for release. The next
> > user-events registration in the parent calls current_user_event_mm() and
> > writes to the freed object. =20
>=20
> Please, do not cut and paste AI into your change log. Read it,
> understand it, and summerize it!
>=20
> The above is just mumbo jumble and is way too verbose for such a simple
> change. Show me you understand what the bug is. And tell me what was
> wrong. The above is totally not helpful for a change log. It's way too
> verbose and makes it very difficult to know what the bug is.
>=20
> >=20
> > KASAN reports:
> >=20
> >     BUG: KASAN: slab-use-after-free in current_user_event_mm+0x51/0x1d0
> >     Write of size 4 at addr ffff888005010d30 by task init/44
> >=20
> >     Call Trace:
> >      <TASK>
> >      kasan_report+0xce/0x100
> >      kasan_check_range+0x10f/0x1e0
> >      current_user_event_mm+0x51/0x1d0
> >      user_events_ioctl+0x82e/0x15c0
> >      __x64_sys_ioctl+0x139/0x1c0
> >      do_syscall_64+0xce/0x450
> >      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >=20
> >     Allocated by task 44:
> >      __kasan_kmalloc+0x8f/0xa0
> >      __kmalloc_cache_noprof+0x180/0x3a0
> >      user_event_mm_alloc+0x3c/0x1f0
> >      current_user_event_mm+0x88/0x1d0
> >=20
> >     Freed by task 42:
> >      __kasan_slab_free+0x43/0x70
> >      kfree+0x13a/0x390
> >      process_one_work+0x696/0xf90
> >      worker_thread+0x420/0xba0
> >=20
> > Clear the child's copied user_event_mm before starting the fallible
> > duplication. If duplication fails, the child has no user-events tracing
> > state to release. The CLONE_VM case remains unchanged because
> > user_events_fork() explicitly installs the shared pointer and increments
> > its task count.
> >=20
> > Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event =
enablement")
> > Assisted-by: Codex:gpt-daybreak-blue
> > Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> > ---
> >  include/linux/user_events.h | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> > index 57d1ff0..2c9ac7b 100644
> > --- a/include/linux/user_events.h
> > +++ b/include/linux/user_events.h
> > @@ -48,6 +48,7 @@ static inline void user_events_fork(struct task_struc=
t *t,
> >  		return;
> >  	}
> > =20
> > +	t->user_event_mm =3D NULL;
> >  	user_event_mm_dup(t, old_mm); =20
>=20
> Honestly, that line should be in user_event_mm_dup() and not here.
>=20
> -- Steve
>=20
>=20
> >  }
> >   =20
>=20

