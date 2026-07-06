Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C426F345CAA
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 10:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332439; cv=none; b=F5vsA0VZsWWeljtk9wuCJiUEfCVeTFP50wbT/1PUzpxUmGXpgWhHElt6MVBL9KCS+rbTQ3jmDXjgdv6BXDyRchvHdb1lCxAs90rLaEmBoSifF4E0CajBUNeaoVHPSvoRbPc3ssdSHiHXcT2h6wpdbci2t5cL87aJx7C/WOgcwgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332439; c=relaxed/simple;
	bh=BMBSFJW577smW+YmxyyWUZMC3pCoGF4PpZl29bcysIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgKEiFTPbKmKz4hwwz+6+hkY91WXSwGnFmC8ZYYZgWOLI2uRNiIrqF+4ft8YDLKJancuYFUmLx02g8dSxpGRR7nIoVSTtewauPS/5i3bVEwpdKZS0MHsIn72CknLVzYm8HKwV5avHxHuF5jQ5DUN5JP0hbTLxgsL20SP8P3MDUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uRaPeAW0; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uRaPeAW0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783332435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2qDm5qCn56ojOGZCWOAPiLnSVNmd57w1YlcEyEv3Zo=;
	b=uRaPeAW0527K2sZaauy6ZQlf9rRFKHn2Z4O2AFHWcAe2bDmpICq+Szd/Sj3qJQ+6L8KIW6
	yYhwwWumAMl5sdBzV1aq64mEQRP59pZ0l8CExNPaCPgCOqJwE6hZ+ZzQUefFXgSw12v8TX
	J4AcsYJzgoZz47mqAKxBm5RBeGFLvEA=
From: Usama Arif <usama.arif@linux.dev>
To: Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Gary Guo <gary@garyguo.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Eugene Mavick <m@mavick.dev>
Subject: Re: [PATCH 2/4] refcount: add ref_trace_final_put tracepoint
Date: Mon,  6 Jul 2026 03:07:07 -0700
Message-ID: <20260706100709.1519907-1-usama.arif@linux.dev>
In-Reply-To: <20260705-refcount-final-put-trace-v1-2-0ae936edb750@mavick.dev>
References: 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Sun, 05 Jul 2026 09:20:52 +0800 Eugene Mavick via B4 Relay <devnull+m.mavick.dev@kernel.org> wrote:

> From: Eugene Mavick <m@mavick.dev>
> 
> Add the ref_trace_final_put tracepoint to __refcount_sub_and_test().
> This fires when a refcount_t reaches zero, capturing the caller
> address, the function name, and the refcount_t address.
> 
> Signed-off-by: Eugene Mavick <m@mavick.dev>
> ---
>  include/linux/refcount.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index ba7657ced281..7b1fbf326a21 100644
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
> +		trace_ref_final_put(r);

Should refcount_dec_if_one() also fire the tracepoint?

>  		return true;
>  	}
>  
> 
> -- 
> 2.51.2
> 
> 
> 
