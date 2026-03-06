Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965ED346FA0;
	Fri,  6 Mar 2026 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833314; cv=none; b=owtAGuV/4kk0ixgQ4X8r6wXilYUcPVZDBxvQHs1U2ZKD1IqI9kXiWa16Q+xjw1sNbNZxDW3x/v2+Bx95UmIvFrjCK2PbHIzl7W4XC2MapQW+Ymu5g2bcZo5to9Z6zbWeHh3e8jVEAneRsqzXYSkR6kF9bEY5yg4duFJqM+ZN35c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833314; c=relaxed/simple;
	bh=wTl87lZ344gP1skf/fw2sVAX+P5P5Ez3CPxEaVH4/eM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c68sOYh9wdorvW61UgslzMlxVPk4ejy+Ay1X3cQB6E3PB10br2SAAhei2kkmX77bmYBUQcU64kPw4GVE4N3Ke0axfhnr961qZ0nX9glQ7qGlrKXI+uqwnNZVTSt9UCb1VKlWSMqvHXxzaPo78b1J3nL4itoDSO5JaurJHkXgmPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 46EB61A0649;
	Fri,  6 Mar 2026 21:41:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 70DA61A;
	Fri,  6 Mar 2026 21:41:49 +0000 (UTC)
Date: Fri, 6 Mar 2026 16:41:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: AnishMulay <anishm7030@gmail.com>
Cc: viro@zeniv.linux.org.uk, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracefs: Use dentry name snapshots instead of heap
 allocation
Message-ID: <20260306164150.5a9e674f@gandalf.local.home>
In-Reply-To: <20260306200458.2264-1-anishm7030@gmail.com>
References: <20260305165231.67c2491d@gandalf.local.home>
	<20260306200458.2264-1-anishm7030@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: tmqwnebrue6f5n4o5snkh6zwwa5p1ita
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 70DA61A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/4oDov1WYDUav6/C0pcbE33hTvOzNSu3s=
X-HE-Tag: 1772833309-459212
X-HE-Meta: U2FsdGVkX1/rUx6YdJvcfO4TulfOx1A093mAyUd5CJhra/EhpDp1b5ca39MCXuQBiry3Gq1sxJocJtvD+Yrulo3PjepFI409R6c3R/ZM5Fp7PfDILLiGrcsbuTy0HYiMRxcwPVpEvatpCdN/6+gy4+HHWN0y8Yh2JLMnlqMPILiZlUOseDMJL7gvNv7acyoq81LrHGhefr3/KRFwAUtvKO0p0gC+wdOLKq8KtOzAkeqOrCPYXIPYz6nU9IuN1UQq5cFDf43MpMH6QZijhJhUsWcDaiUcwVnycB06imeKFFuHQawQX8tsakpUNSJzhnRe411qjRSzj8d9t5fT6LBm5iKETpKkthbVLXjbkUOpJKy8UXVg89L8Bg==

On Fri,  6 Mar 2026 15:04:58 -0500
AnishMulay <anishm7030@gmail.com> wrote:

Thanks for the update, but please do not have a new patch as a reply to the
old one. It makes it harder to find. As I'll only look at top level emails
for patches in my inbox which means all new versions should be their own
thread.

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
> Changes in v3:

The above should have been:

Changes since v2: https://lore.kernel.org/all/20260227211505.226643-1-anishm7030@gmail.com/

> - Rebased into a single clean commit against upstream.
> 


> Changes in v2:
> - Link to v1: https://lore.kernel.org/linux-trace-kernel/20260227194453.213095-1-anishm7030@gmail.com/
> - Use the helper functions take/release_dentry_name_snapshot() instead of allocating the name. (Al Viro)

The above isn't needed as the above link will give it to you.

No need to resend (unless I find something wrong with the code of the
patch).

-- Steve
