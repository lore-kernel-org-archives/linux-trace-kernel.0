Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32903ACF0F;
	Wed, 26 Aug 2026 19:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772163; cv=none; b=XG6q6E82e3aT+jl1MnWkgCULLu1ZSb6NGDZstyNbs8fQMx+y2fWN/5JBTL/akM14z21BAXl0NgtrL3IxoEJHVkbxbM40gEAzqEHzvG2N/s2oP/bD+MHeY0SmCW9kKmA55HlQ0kPQ4DHK72VCDgM9lxyrb3cNjEn5eVhqCY3EtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772163; c=relaxed/simple;
	bh=oSpQfwKhoSIgOkQ9OJik+kWr+ikQsWyrw4UzrbcnRGE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlcsmQcV/rvOCeG08DskQkyzaeQivKPaVCS3KDip8en98Wm6lApmYUBljW55hnkmoAaqUicq+ZeyLV+m+pKUVL95XaW/tk4DOVAcGLTiIgMzv5O7KTwXpL5+8yRz6IyzpwE5uD6/LkPjSJYG5+zmeojGRrCQhyxiYHpfCW3Mweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=CCncnxR6; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="CCncnxR6"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 1E44E1601FE;
	Wed, 26 Aug 2026 19:22:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 542F120031;
	Wed, 26 Aug 2026 19:22:27 +0000 (UTC)
Date: Wed, 26 Aug 2026 15:23:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: =?UTF-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, include@grrlz.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: Clear copied tracing state before
 fork duplication
Message-ID: <20260826152312.62d5802e@gandalf.local.home>
In-Reply-To: <20260824211036.3729669-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260824211036.3729669-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Stat-Signature: can967q4bytt1hw1h51dkjw6ujyjrdey
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 542F120031
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19h4uimY2J2hA37/3JFtVFukaq1XR0G7NA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=xhr3H1oSETvZ1QQ62lGcAt8zWUVienEqZAUbX1OVyEg=; b=CCncnxR6Jw/F7a4KqZMGsh3A4FogPy2Djhvo84dfFkkFfxDK1MdpLSFLQh8qtHLsWxr8FTXZxQLGLyQxUMOJfAWcBIeSbxMDeCxQAlNdKCGJyG7yqmXpeTMSIT64U3sTZsDL8PvUFu/vWcQuDFElQcIqbcJNlfo5wvcC+5vQj80=
X-HE-Tag: 1787772147-505586
X-HE-Meta: U2FsdGVkX19DU+jT0ZUm2vRFa0r0Le4ZB22SJ28hui2VIOq/tivZecDka+a5pWtjSIxqprOLhtw+nPg7Z7DKEfZ7tsmOS0KzDx118HqG7Z5Yo0CUIq4OU6jWUbwZG0nj/y/HIp4oTPiseAEoD+T638xPbBpvMtsS2RLLLYEe7NnXegB4IUV7CrH9LeoyzRQ4v3ceV/BS5hWMnLxgLAwgk3O3ik0FK+OXFo7o8C4o7BCxWX+4/xo4bvW9q4cYqL6LkBn1MjIICnOIR5fyYolMH1OdsFVJeLYpEJJ5kAaO9ghj7FoL/gJYU3e5BKt0viBO


[ Replying again, but against the one with the Cc to the mailing lists ]

On Mon, 24 Aug 2026 21:10:37 +0000
J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr> wrote:

> User events keep per-mm tracing state in task_struct::user_event_mm. It
> tracks the registrations and enablers created through the tracefs
> user_events_data interface.
>=20
> dup_task_struct() starts a fork by copying this pointer from the parent.
> user_events_fork() must then either share it for CLONE_VM, or create new
> state for a child with a separate address space.
>=20
> The second case can fail. If user_event_mm_dup() cannot allocate the new
> state or copy one of its enablers, it returns without replacing the
> pointer copied by dup_task_struct(). The child now points at the parent's
> tracing state, but did not take a task reference to it.
>=20
> When the child exits, user_event_mm_remove() can drop the parent's task
> count to zero and queue its tracing state for release. The next
> user-events registration in the parent calls current_user_event_mm() and
> writes to the freed object.

Please, do not cut and paste AI into your change log. Read it,
understand it, and summerize it!

The above is just mumbo jumble and is way too verbose for such a simple
change. Show me you understand what the bug is. And tell me what was
wrong. The above is totally not helpful for a change log. It's way too
verbose and makes it very difficult to know what the bug is.

>=20
> KASAN reports:
>=20
>     BUG: KASAN: slab-use-after-free in current_user_event_mm+0x51/0x1d0
>     Write of size 4 at addr ffff888005010d30 by task init/44
>=20
>     Call Trace:
>      <TASK>
>      kasan_report+0xce/0x100
>      kasan_check_range+0x10f/0x1e0
>      current_user_event_mm+0x51/0x1d0
>      user_events_ioctl+0x82e/0x15c0
>      __x64_sys_ioctl+0x139/0x1c0
>      do_syscall_64+0xce/0x450
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
>     Allocated by task 44:
>      __kasan_kmalloc+0x8f/0xa0
>      __kmalloc_cache_noprof+0x180/0x3a0
>      user_event_mm_alloc+0x3c/0x1f0
>      current_user_event_mm+0x88/0x1d0
>=20
>     Freed by task 42:
>      __kasan_slab_free+0x43/0x70
>      kfree+0x13a/0x390
>      process_one_work+0x696/0xf90
>      worker_thread+0x420/0xba0
>=20
> Clear the child's copied user_event_mm before starting the fallible
> duplication. If duplication fails, the child has no user-events tracing
> state to release. The CLONE_VM case remains unchanged because
> user_events_fork() explicitly installs the shared pointer and increments
> its task count.
>=20
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event en=
ablement")
> Assisted-by: Codex:gpt-daybreak-blue
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  include/linux/user_events.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/include/linux/user_events.h b/include/linux/user_events.h
> index 57d1ff0..2c9ac7b 100644
> --- a/include/linux/user_events.h
> +++ b/include/linux/user_events.h
> @@ -48,6 +48,7 @@ static inline void user_events_fork(struct task_struct =
*t,
>  		return;
>  	}
> =20
> +	t->user_event_mm =3D NULL;

Honestly, that line should be in user_event_mm_dup() and not here.

-- Steve

>  	user_event_mm_dup(t, old_mm);
>  }
> =20

