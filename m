Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE6348C7C;
	Mon, 27 Jul 2026 20:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184050; cv=none; b=Ss0I+IoqtK5Su51S8X2ervqEiTGuutTF3J7lRtADwc9n/rIEKdfoclImud+QIe4yOpH2YkECGYuZ1WPVJzTSLLXS57MmC/lKUoglbVnKECQSy1Of05IxV0VKutGtHm+hux3UVFpRY/KGuYwsHawzmVeTHKthpuTEOT0S79Efvs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184050; c=relaxed/simple;
	bh=JKFBUSxSL6/4yn2MONtnRvep+bV4wb3Ghi3SESDz1b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+bqhWBDqmyKGmCK5a0WNJX31j7IIrztzusKOQtZ00v/RTnJl942MMD1QIOLM4fJzG/EHAMKzPe8mlhXSErPe+GfuchL8Ncg76v4NbdRBFCKFMd3UdegrcwcF0EYaIqC+U3reaFUOKzp7uVJCE22Zy3QwSM4mDQb1l3OA4DJJkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 8A4E5401D5;
	Mon, 27 Jul 2026 20:27:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 7558A20029;
	Mon, 27 Jul 2026 20:27:16 +0000 (UTC)
Date: Mon, 27 Jul 2026 16:27:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eugene Mavick <m@mavick.dev>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gary
 Guo <gary@garyguo.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 2/5] refcount: add ref_trace_final_put tracepoint
Message-ID: <20260727162743.55ca2d14@gandalf.local.home>
In-Reply-To: <20260711-refcount-final-put-trace-v3-2-674c8f03d9f9@mavick.dev>
References: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
	<20260711-refcount-final-put-trace-v3-2-674c8f03d9f9@mavick.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 77f5hjgk3wcfxpc6ett3pueof6jrewsi
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7558A20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ZftNc9YOHVOuzN2od2wsTbU1P+xcBgB0=
X-HE-Tag: 1785184036-372918
X-HE-Meta: U2FsdGVkX1+NcYwiz6LsYobSPrRXvfmEsFQv7lCJ6wYiQ7Pw576BKNSNm8O3ULvb9YsMRNqhg+hr4tW7DcySZFQShCheBv7n4x4e94nBQ769pK8Mwcqn5gwkMRLZy2gxEtJjRXxgVjqn9UyvDwp1OvFskmjSxOQ6SuWhaySb/txyK//mMO2ipdnM2y6661+cgFSONAlzsn/FwOLv3EMhIxOwKnScb4TrOOqbcDLu1BuK6FWk4Q6sScV7nTgXtMp60OnVJbsXrNHH/UX8S9H/iQQTVlwS761IQwmLX54GhNg+d1Z7xJvKWNE0zi7GXNZh

On Sat, 11 Jul 2026 12:40:20 +0800
Eugene Mavick <m@mavick.dev> wrote:

> Add the ref_trace_final_put tracepoint to __refcount_sub_and_test() and
> refcount_dec_if_one()
> 
> This tracepoint fires when a refcount_t reaches zero, capturing the caller
> address, the function name, and the refcount_t address.
> 
> Signed-off-by: Eugene Mavick <m@mavick.dev>
> ---
>  include/linux/refcount.h | 2 ++
>  lib/refcount.c           | 8 +++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index ba7657ced281..70d07a462da1 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -107,6 +107,7 @@
>  #include <linux/limits.h>
>  #include <linux/refcount_types.h>
>  #include <linux/spinlock_types.h>
> +#include <linux/ref_trace.h>
>  
>  struct mutex;
>  
> @@ -393,6 +394,7 @@ bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
>  
>  	if (old > 0 && old == i) {
>  		smp_acquire__after_ctrl_dep();
> +		do_trace_ref_final_put(r);
>  		return true;
>  	}
>  
> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3c..cd7e32df3919 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
> @@ -7,6 +7,7 @@
>  #include <linux/refcount.h>
>  #include <linux/spinlock.h>
>  #include <linux/bug.h>
> +#include <linux/ref_trace.h>
>  
>  #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
>  
> @@ -56,7 +57,12 @@ bool refcount_dec_if_one(refcount_t *r)
>  {
>  	int val = 1;
>  
> -	return atomic_try_cmpxchg_release(&r->refs, &val, 0);
> +	bool ret = atomic_try_cmpxchg_release(&r->refs, &val, 0);
> +
> +	if (ret)
> +		do_trace_ref_final_put(r);
> +
> +	return ret;

Tracing should avoid adding any open conditionals. This is in the fast
path. No need to add an if statement that is only used when tracing is
enabled.

You can create another macro:

	do_trace_ref_final_put_cond(ret, r);

And have that defined as:

#define do_trace_ref_final_put_cond(cond, obj)					\
	do {									\
		if (tracepoint_enabled(ref_trace_final_put)) {			\
			if (cond)						\
				do_ref_trace_final_put(_RET_IP_, __func__, obj);\
		}								\
	} while (0)

That way the conditional is only checked if tracing is enabled.

-- Steve

>  }
>  EXPORT_SYMBOL(refcount_dec_if_one);
>  
> 

