Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158032AAA0;
	Mon,  3 Aug 2026 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785760813; cv=none; b=Br1P76t3nQeLoP7I2GkTVOU9cS4LDItvKGOlSa8xo82jisyefTYx9fYpFJetpiy8vVwY1x+yVCO3ZHaGwZdQqMBfoAIdL47fFZEox2K+Hb8sOvq0Z1gYUP/cYihJ2ugzkLNjTej22jFIAzAbP5s5VSmeiGwMLPM7XVtkKqVR5hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785760813; c=relaxed/simple;
	bh=Jbn3ZKdXWDHLbpEk6de2ZVp4+eqxT2RAkdibw6ECz9Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oXCNOogGOIAvO+syBv42PVZW2IXniDu4LqmDGRCVUNMhVcQX8cWMq8OVkNE/1J+0G/Va/9nGF+/BDrWrcGNSZgiBtPrMXjJ4Z+/8iFgW2ZMQIAeUxbS7tSdmsJX+VP05iGcQcabBoknezmACx+u1nAx8/hkY4R6pa71xIPIcCBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnXi1r5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnXi1r5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B80F1F000E9;
	Mon,  3 Aug 2026 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785760812;
	bh=w08UCbkWtU9TfXhclWa+F/QyElpPyUvaHz012wzyT/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dnXi1r5vWkuDOhzSCp2b+ev8osnacMTCyVJ53uwAR3oByxd4tQuEamsTfPnCa/Jzu
	 3Zl+cnX3oHU38DlcVRO/kSegMX6N7B+FyDRtso/shPwmatZKvrdAJTT8W4VVse5JQW
	 syrs+SlD7qd6aBPwH43bQ6NdQpXTsvctVJWsCec3R7xr7IZ+iBgPvWdG6RikGS7BUX
	 7ibz+YYIspHC/xYRSJ/eUijkuGsMEuUlmhguAAIxHVmD/b7x1IG30VXQmF2t1sUKw1
	 6l/dmsBjtEpDLUIUML1Ra2jW6JOkQl5Oo91npLaptq4YBr5UGiuVhnLPfUYGyt2GCK
	 mau8bCf4NUDew==
Date: Mon, 3 Aug 2026 21:40:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eugene Mavick <m@mavick.dev>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gary
 Guo <gary@garyguo.net>, Steven Rostedt <rostedt@goodmis.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v4 0/5] tracing: add ref_trace_final_put tracing
Message-Id: <20260803214006.d6e03e8fe220694709125157@kernel.org>
In-Reply-To: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
References: <20260801-refcount-final-put-trace-v4-0-2e58678f0ffd@mavick.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 01 Aug 2026 18:59:40 +0800
Eugene Mavick <m@mavick.dev> wrote:

> When debugging use-after-free(UAF) bugs, knowing when the object reaches
> 0 references and enters final release can significantly aid the
> debugging process.
> 
> There is currently no universal way to trace this information.
> 
> This patch series implements tracing of the final puts in the
> most widely used refcounting implementations,
> refcount_t(and thus kref which uses it), and percpu-ref.
> 

I have a question regarding the event group name. If this is related to
refcount, wouldn't it be more appropriate to call it `refcount_final_put`?
Even if it is currently used by `ref_trace`, it is fundamentally an event
belonging to the refcount subsystem.
I believe event names should be based on where the event occurs and what
actually happens, rather than on who is using it.

Thank you,

> The tracepoint records three fields:
> - caller: function that called the refcounting
>   function(refcount_sub_and_test, percpu_ref_put_many)
> - ip: return address of the trace wrapper macro call
> - obj: refcount object(struct percpu_ref, refcount_t)
> 
> Signed-off-by: Eugene Mavick <m@mavick.dev>
> ---
> Changes in v4:
> ref-trace:
> -remove fn
> -add ip variable
> -change trace wrapper macro respectively, _THIS_IP_ is used for ip variable
> -change relevant code respect to fn removal and ip addition
> -fix style issues in include/linux/ref_trace.h
> -add new macro do_trace_ref_final_put_cond that only calls tracepoint if cond is
>  true
> lib/refcount.c:
> -change from do_trace_ref_final_put to *_cond
> -remove if statement above since _cond already performs the check
> KUnit:
> -change relevant code respect to fn removal and ip addition
> -check if caller and ip are valid addresses
> -change timeout from 10 jiffies to 10 seconds
> -move didn't timeout assertion from before to after probe
>  unregistration, to prevent it from impacting next test
> 
> Changes in v3:
> include/trace/events/ref_trace.h kernel doc comments:
> -caller of refcount function -> return address of refcount function
> -ref_trace_final_put->do_ref_trace_final_put
> lib/ref_trace.c: add include trace/events/ref_trace.h
> kunit:
> -change Kconfig depends from FTRACE->TRACEPOINTS
> -EXPECT_FALSE->ASSERT_FALSE for calling percpu_ref_init
> -add tracepoint_synchronise_unregister to test_exit macro
> -added timeout to capture.count waiting
> -remove noinline and __always_inline from function attributes
>  (added for testing, but accidentally submitted)
> -add period to the end of Kconfig help text
> v2 link:
> https://lore.kernel.org/all/20260710-refcount-final-put-trace-v2-0-557cfce860a2@mavick.dev/
> 
> Changes in v2:
> -include/linux/ref_trace.h: change macro name, use direct tracepoint
>  call in macro to avoid double check
> -add tracepoint to refcount_dec_if_one
> -kunit: make significant improvements to design, fix critical bug, add test case for
>  refcount_dec_if_one()
> -Link to v1: https://lore.kernel.org/r/20260705-refcount-final-put-trace-v1-0-0ae936edb750@mavick.dev
> 
> ---
> Eugene Mavick (5):
>       tracing: add ref_trace_final_put tracepoint
>       refcount: add ref_trace_final_put tracepoint
>       percpu-refcount: add ref_trace_final_put trace
>       kunit: add test for ref_trace_final_put
>       MAINTAINERS: add entries for ref_trace_final_put
> 
>  MAINTAINERS                      |   3 +
>  include/linux/percpu-refcount.h  |   5 +-
>  include/linux/ref_trace.h        |  40 +++++++++++
>  include/linux/refcount.h         |   2 +
>  include/trace/events/ref_trace.h |  51 ++++++++++++++
>  lib/Kconfig                      |  10 +++
>  lib/Makefile                     |   2 +
>  lib/ref_trace.c                  |  13 ++++
>  lib/refcount.c                   |   6 +-
>  lib/tests/Makefile               |   1 +
>  lib/tests/ref_trace_kunit.c      | 141 +++++++++++++++++++++++++++++++++++++++
>  11 files changed, 272 insertions(+), 2 deletions(-)
> ---
> base-commit: df685633c3dbc67441cc86f1c3fee58de4652ba2
> change-id: 20260624-refcount-final-put-trace-49bd7c39bd5a
> 
> Best regards,
> -- 
> Eugene Mavick <m@mavick.dev>
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
