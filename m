Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85491442FD;
	Thu, 18 Jul 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721317038; cv=none; b=ETyJShMIE4zEfE51fM3Befiw5wv7/200/9sXTnlJEmzkabpIFXD80ORIWN95LOWIxH98D1drHzIEFtQIWTUvOugy+Shm6FRtb4EadwjeJjbXkgnrOibYy0P81gtR+vylCSykd7DW7OLAfb2K6eFbYbjuYDIcdxe6XuLpuX/xqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721317038; c=relaxed/simple;
	bh=UxSMm25WvI6T12VAkReUDX4L63ptrBWgJixBihl4TUY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pL3OtFXJR0r0a/wG75WTWoz/im/bWqudspYmeThZ7ACw/eXxh70d3o/+l1rXPJjDO6CJVXcA4XQsEWr2hRcefWtfLp4MioJ99Ao5DrzvniIMIF5YlwvvS0KP2+gCLYFkFBwBPp2oS4mSG2ilQCLflVOiMpkL2m5UkOr/ZwF2VoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSfDdonQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSfDdonQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5182DC116B1;
	Thu, 18 Jul 2024 15:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721317037;
	bh=UxSMm25WvI6T12VAkReUDX4L63ptrBWgJixBihl4TUY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fSfDdonQ7MhyRZad7FV9U5ZQl+aQJhhbg2YCr0UxTZDXaiVUH3KQ9xH+d6bHGQ2Sh
	 SJr5ArmhGQmsG6KxCLVqLEGOGZYBHXYsPdxS573ZpWiY0T+k2dXL91VNyKVbpBsddm
	 kKbnd61xuXsmzZx9Rw0WiMoli9WRQfSQLHPQMwMFVUo2XTf+GJqWfJyscL4MA9bX46
	 Ci5OhtQN/4XxUXovnnlU0jsf0TA5GW0hqGl+/0dzxIUDYSOruWBQ/LCJu3KBk9fQyh
	 ZOoaYV4TLmVsAl/v0NwGcm6j3Lx3sD4RR5syfqDwZhG1hVZJwQxBYbIuXVz0HG8xQT
	 Hl7vYCvfrlhAA==
Date: Fri, 19 Jul 2024 00:37:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-trace-kernel@vger.kernel.org, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vgar.kernel.org
Subject: Re: [PATCH pre-6.7] kprobes: Fix double free of kretprobe_holder
Message-Id: <20240719003713.6c47efeb2741504996e1df15@kernel.org>
In-Reply-To: <92cff289-facb-4e42-b761-6fd2515d6018@suse.com>
References: <92cff289-facb-4e42-b761-6fd2515d6018@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jul 2024 14:52:43 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Hello,
> 
> Below is a patch for a kretprobe-related problem that was already fixed
> in v6.7 as a side-effect of the objpool optimization, in commit
> 4bbd93455659 ("kprobes: kretprobe scalability improvement").
> 
> I'm sending it to the list because it might be useful to pick the fix up
> for longterm or distribution kernels. Additionally, I would like to
> propose a small improvement to refcount_t and this gives me an actual
> problem to point to about its motivation.
> 
> Cheers,
> Petr
> 
> ---
> 
> From b0dde62cc5268a7d728cfdb360cb5170266a5e11 Mon Sep 17 00:00:00 2001
> From: Petr Pavlu <petr.pavlu@suse.com>
> Date: Thu, 4 Apr 2024 16:44:02 +0200
> Subject: [PATCH pre-6.7] kprobes: Fix double free of kretprobe_holder
> 
> When unregistering a kretprobe, the code in unregister_kretprobes() sets
> rp->rph->rp to NULL which forces all associated kretprobe_instances
> still in use to be later freed separately via free_rp_inst_rcu().
> 
> Function unregister_kretprobes() then calls free_rp_inst() which takes
> care of releasing all currently unused kretprobe_instances, the ones
> that are on the kretprobe's freelist. The code in free_rp_inst() counts
> a number of these released kretprobe_instances and invokes
> refcount_sub_and_test(count, &rp->rph->ref) to decrease the
> kretprobe_holder's refcount and subsequently calls kfree(rp->rph) if the
> function returns true, indicating the refcount reached zero.
> 
> It is possible that the number of released kretprobe_instances in
> free_rp_inst() is zero and therefore refcount_sub_and_test() is invoked
> with count=0.

Ah, good catch! Calling unregsiter_kretprobe() when all instances are
used, this happens. To avoid this, usually refcount starts from 1 as
initial reference, but it didn't.

> Additionally, depending on timing, it can happen
> that all previously used kretprobe_instances were already freed via
> free_rp_inst_rcu(). This means the refcount of kretprobe_holder already
> reached zero and was deallocated.
> 
> The resulting call of refcount_sub_and_test(0, &rp->rph->ref) in
> free_rp_inst() is then a use-after-free. If the memory previously
> occupied by the refcount is still set to zero then the call returns true
> and kretprobe_holder gets wrongly freed for the second time.

Right.

> 
> Fix the problem by adding a check for count>0 before calling
> refcount_sub_and_test() in free_rp_inst().

OK, this can avoid use-after-free.

> 
> Note that this code was reworked in v6.7 by commit 4bbd93455659
> ("kprobes: kretprobe scalability improvement") and the new objpool
> implementation doesn't have this problem.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This should go directly into stable because there is no applicable code
in the latest kernel.


> Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---
>  kernel/kprobes.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 0c6185aefaef..7ae5873545a1 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1942,10 +1942,9 @@ static inline void free_rp_inst(struct kretprobe *rp)
>  		count++;
>  	}
>  
> -	if (refcount_sub_and_test(count, &rp->rph->ref)) {
> +	if (count > 0 && refcount_sub_and_test(count, &rp->rph->ref))
>  		kfree(rp->rph);
> -		rp->rph = NULL;
> -	}
> +	rp->rph = NULL;
>  }
>  
>  /* This assumes the 'tsk' is the current task or the is not running. */
> 
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
