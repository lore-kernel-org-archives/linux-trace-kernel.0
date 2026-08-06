Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8392F214813;
	Thu,  6 Aug 2026 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974566; cv=none; b=NTuiKyqACYnGCGWDS5mgIxXj43V6rbRcB3XbOcVc4/sadY4Mu6IKLc0u0tqzTK1wPI8xgU3tym8uOnRg/2rDyuzqy9+S/PziQmaa1AU3m+LKN+k8wVfAhHMnyIssjJ8W+ChguWY5BygHpMqRy3euxyWg7WC2gtwkkfX8VFi1KF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974566; c=relaxed/simple;
	bh=maLTdq9S0pOK5FWskgeV2YIL0eIKlKHfejHoTiyeeVs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Lguy/4ldB747uSAWVuJMhOu2aQLInX8FD7xKDGJweZ2S+LWKbgU6MvlFnpMKzPB+uVV3Eqm22v62ZtfXRe8sH8/xq1T7BfTnEi3TkLj0dJQdXm1MLMBQBk3LtfNSemxIUNPhLqF6v+s4dPpYQjC1k1QN67+cfRLuXM8c98nhZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvRADHmf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvRADHmf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8E61F000E9;
	Thu,  6 Aug 2026 00:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974560;
	bh=v14uNn/Psbc3r2oCTQLvFgoA/nZ54LrAncPHpTkAZ+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LvRADHmf5ITE06u5UT+i1rpzjfzWQ1dlrtuwoFDrJv8byyl2nt1wCtMNc9KjKu5hM
	 nlPW33FinuMg83VjKH20uFsjw6mr8lVCHdd9wGWM02GdI72QbIJdmE8t/nwCU7g096
	 938cM0ywaQNqHrhIvjb32h5sWt8oOZeUk3qP+xcFhwakvjMZ/UYyE5DBpKUvSdg77o
	 9bOiLio2ajBJhKKlAl+nSZs/AfUrwgjvHhN8mBzwd3r2+FcZQPOKXormECfTikZp0v
	 WEw6s2SwTjyhmYIXfVIID9V2KEMxJd+dmofvwaVrRZwGbYDyPXiVyxDYSEVOys98QN
	 udjp6OB/nMwDA==
Date: Thu, 6 Aug 2026 09:02:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Luigi Rizzo <lrizzo@google.com>
Cc: Naveen N Rao <naveen@kernel.org>, Luigi Rizzo <rizzo.unipi@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, JP Kobryn
 <inwardvessel@gmail.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kprobes: Fix NULL pointer dereference in
 unregister_kretprobes()
Message-Id: <20260806090235.e40c75f84f8a01b9a80fd570@kernel.org>
In-Reply-To: <20260805161221.2428623-1-lrizzo@google.com>
References: <20260805161221.2428623-1-lrizzo@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 16:12:21 +0000
Luigi Rizzo <lrizzo@google.com> wrote:

> In unregister_kretprobes(), rps[i]->rph can be NULL e.g. when called
> after kretprobe failed registration. Under !CONFIG_KRETPROBE_ON_RETHOOK,
> the unconditional access to rps[i]->rph->rp, causes a kernel panic due
> to NULL pointer dereference.

This is not a bug, since if register_kretprobe(rp) fails, rp must NOT be
passed to unregister_kretprobe(rp). Or, do you find any cases where
register_kretprobe() fails, preventing proper cleanup, and requiring
unregister_kretprobe()? If so, we have to fix that case.

> 
> Add a NULL check for rps[i]->rph before invoking rcu_assign_pointer().
> 

But this could be a kind of protective improvemet for someone
misunderstand that.

Thank you,

> Fixes: d839a656d0f3 ("kprobes: consistent rcu api usage for kretprobe holder")
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  kernel/kprobes.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index bfc89083daa93..5dd4786c455de 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2359,7 +2359,8 @@ void unregister_kretprobes(struct kretprobe **rps, int num)
>  #ifdef CONFIG_KRETPROBE_ON_RETHOOK
>  		rethook_free(rps[i]->rh);
>  #else
> -		rcu_assign_pointer(rps[i]->rph->rp, NULL);
> +		if (rps[i]->rph)
> +			rcu_assign_pointer(rps[i]->rph->rp, NULL);
>  #endif
>  	}
>  
> -- 
> 2.48.1.500.g5897711438-goog
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
