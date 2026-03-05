Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F563299A8A;
	Thu,  5 Mar 2026 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734303; cv=none; b=Nu2N1nFxb8ekn8MCyeS5uubU7GX44GrfbZRWV+VDDXXOpt/kp0QdZ8irP8t53Md3y1TElZ7X1DFyC/WvcUZ68yb2am7NMIy1j1MZRvw1jQzhbEEoUan5RHyjlaQrFwm6gBSAvsqULXGum9ME/8Xa2rLyR7bEHg+tkabgLOgkUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734303; c=relaxed/simple;
	bh=T7m4BLh9QI5kPeCxs8Qel6Ve+zgcwEK/IwRIw8IjW4k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eC3gnjfDpoHB3bB7aU5TYBEyae1drWFyS8phCBKqHJs/TBo0tP7lpiYEuF52n4u21UL9iT0+kcFudWv9AmPBjaMHjEgasEe2u95OKk2H2u/xKcW20+zeWHFXW11MZ9Gk4awvwV8jlqHB2dRePAPUj5FVWMQAiYCLsgBmff04v28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 2DD1F16023A;
	Thu,  5 Mar 2026 18:11:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 51BCE18;
	Thu,  5 Mar 2026 18:11:38 +0000 (UTC)
Date: Thu, 5 Mar 2026 13:12:17 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: AnishMulay <anishm7030@gmail.com>
Cc: viro@zeniv.linux.org.uk, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracefs: Use dentry name snapshots instead of heap
 allocation
Message-ID: <20260305131217.392273b4@gandalf.local.home>
In-Reply-To: <20260227211505.226643-1-anishm7030@gmail.com>
References: <20260227154210.5bd19a45@gandalf.local.home>
	<20260227211505.226643-1-anishm7030@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9qgjmdm5hi9mibb5ygokz6feskzf16sn
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 51BCE18
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19aH4u9fjX9G4IRF6v049t/0puEwTrYTIQ=
X-HE-Tag: 1772734298-219169
X-HE-Meta: U2FsdGVkX19aGBn9iOtGsXkyjSJ0TMH7dKZ58zVarsBD1dJu2rdDgG2PWRpBA73dkEz8PsQpwJUfwqOx6sI42WrBsfEBNPJdaZEriOrAyull6lLAcox4U1XPC4DbWjTCO5CDfO8naHh2cHb21kQz5bG+cOPtxMogiYOptk4QlzVJTmqCAzg2rZ73EKLYpvoQQiqp6pPgblBaHDTH46ecHpeloOy0qOIYKgN21wzhX1mHCnNPWDYZ/Y6YsC74QVgEqvBuCGeRMy3uvVn01u4l98BUaw4R9AV1J+3COR+WOreiKO6KdtP1PKXNQNZrqI1gwfBIFXb2JODebUCVVxW4E/VqFWSdNDQKQo/vBtUk4bKi5hkw4edgcg==

On Fri, 27 Feb 2026 16:15:05 -0500
AnishMulay <anishm7030@gmail.com> wrote:

> In fs/tracefs/inode.c, tracefs_syscall_mkdir() and tracefs_syscall_rmdir()
> previously used a local helper, get_dname(), which allocated a temporary
> buffer on the heap via kmalloc() to hold the dentry name. This introduced
> unnecessary overhead, an ENOMEM failure path, and required manual memory
> cleanup via kfree().
> 
> As suggested by Al Viro, replace this heap allocation with the VFS dentry
> name snapshot API. By stack-allocating a `struct name_snapshot` and using
> take_dentry_name_snapshot() and release_dentry_name_snapshot(), we safely
> capture the dentry name locklessly, eliminate the heap allocation entirely,
> and remove the now-obsolete error handling paths. The get_dname() helper
> is completely removed.
> 
> Testing:
> Booted a custom kernel natively in virtme-ng (ARM64). Triggered tracefs
> inode and dentry allocation by creating and removing a custom directory
> under a temporary tracefs mount. Verified that the instance is created
> successfully and that no memory errors or warnings are emitted in dmesg.
> 
> Signed-off-by: AnishMulay <anishm7030@gmail.com>
> ---

It's nice to add version change history below the "---" with a link to the
previous patch:

  Changes since v1: https://lore.kernel.org/linux-trace-kernel/20260227194453.213095-1-anishm7030@gmail.com/

  - Use the helper functions take/release_dentry_name_snapshot() instead of
    allocating the name. (Al Viro)

As when I pull in a patch, my scripts add a link to the patch itself, and
having that patch have a link to the previous version is always helpful.

(This email serves that purpose for this patch)

-- Steve
