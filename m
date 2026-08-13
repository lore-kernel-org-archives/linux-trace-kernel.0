Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2336E473
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593761; cv=none; b=Is1DzMk/f79BUGmgCBgKGy8G3gvsmZbFbR8Q4yUk/ueyU0dKatyS1Ni33ib91K072dAb69jKr7BArvSmjCQYH4EvV4l0ucwe+DkwRGsMQiOXFh5IL5cqqQmsYk8c2xW2JZdBnLFDPKPXsGCY1GixNRbfMb42Mw/k0jWj3l8Jc4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593761; c=relaxed/simple;
	bh=uUZJfCMXEd7j8ZoSeu8PRZmP2SZ9wmJwshgzaua+IPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sQ6U5kMm27CPBNp7OZRTdFa+kNKZti5X/ugDVfXabmtMnq7mKVkjosJ6NA76XOjAjN8l7V1n/TawViM5K4owJSQtPtaTm3j2RcpVe0P613GwWKs59MYZ0i2xVmUX+dz6dIPol9gXwUMootpca6IDKsPtsQmsObvBFDNv7Nebbkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEzVZ3GF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEzVZ3GF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0418F1F000E9;
	Thu, 13 Aug 2026 04:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593760;
	bh=IgfcWqJrLxfYwJ5FW3v+uKz4kCGxReqIJ3ELXc0RA3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IEzVZ3GF3qXE5m66N9vchlpC4x5eizsMgTT4g3UgQ8MIBHwaAbq+M/RoxHxou8Ps3
	 hugzd+dKptbdqJEH5q4S1KdTgkc+kSb90Yh52Me7nkw/WJCAwHzlZWddT/C5tTne2A
	 /O7OJzy29hAxSZYBXzOGMICA6N38o1is0Mbt4Re8KjvPFF3QyjcUnPghmyU1Efasj5
	 +OFgUf1AXFykXmdJtVybEPMZhmFG94qTW/KVyE6V0fA8Q5G/LLB1Br/ep7XamnTVuc
	 Shq7jShP2bIET/+56gYjxYbVC2Eb/nHLbgXwveW3fCRYDgG5I+VKVq9/mx4fU9aEdR
	 WSXHYeRbDhH3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/5] percpu-refcount: add refcount_final_put
 tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugene Mavick" <m@mavick.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-refcount-final-put-trace-v5-3-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
 <20260813-refcount-final-put-trace-v5-3-6e8bf8a38b31@mavick.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:02:39 +0000
Message-Id: <20260813040240.0418F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The tracepoint incorrectly uses `_RET_IP_` in a `static inline` =
function, causing it to report the caller's caller instead of the actual ca=
ller depending on compiler inlining.
--

--- Patch [3]: [PATCH v5 3/5] percpu-refcount: add refcount_final_put trace=
point ---
commit 9f895c01ce2cdf26a289904e12ffb409aa7dc2a0
Author: Eugene Mavick <m@mavick.dev>

percpu-refcount: add refcount_final_put tracepoint

This commit adds the refcount_final_put tracepoint to the atomic fallback
path in percpu_ref_put_many(). It fires when the atomic counter reaches
zero, recording the caller function, the instruction pointer, and the
refcount object.

> diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refco=
unt.h
> index d73a1c08c3e3c..244992b2f746e 100644
> --- a/include/linux/percpu-refcount.h
> +++ b/include/linux/percpu-refcount.h

[ ... ]

> @@ -331,8 +332,10 @@ static inline void percpu_ref_put_many(struct percpu=
_ref *ref, unsigned long nr)
> =20
>  	if (__ref_is_percpu(ref, &percpu_count))
>  		this_cpu_sub(*percpu_count, nr);
> -	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
> +	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count))) {
> +		do_trace_refcount_final_put(ref);

[Severity: Medium]
Since percpu_ref_put_many() is a static inline function, won't using _RET_I=
P_
inside the trace macro evaluate to the caller's caller when inlined?

When inlined by the compiler, _RET_IP_ (which expands to
__builtin_return_address(0)) will yield the instruction pointer of the
enclosing function rather than the caller of percpu_ref_put_many().

Could the instruction pointer be passed as an explicit argument from the ca=
ll
site instead?

>  		ref->data->release(ref);
> +	}
> =20
>  	rcu_read_unlock();
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-refcount-f=
inal-put-trace-v5-0-6e8bf8a38b31@mavick.dev?part=3D3
