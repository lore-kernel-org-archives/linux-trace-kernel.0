Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A101632DD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 05:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364776; cv=none; b=OK7ORtYn7axUZb3DZak0dNtNDcp8jsHzlKePCJNn0b1uwnPMgQXgENCAx3pG0AqGviV0TCfIIv6TqiKKnmdHl/KuBkDeheYznICk9hEr4pxJjT86x1ZCQpIfYtSpL7sKJ9l2kXWiXt8fb3jR3DpjEXbLs7WEJ6cW1PjVkhTD+XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364776; c=relaxed/simple;
	bh=W+UV36HKCb5faRsvLH1128S9CvAdd8pNG6+QhvRhIb0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YTISQyfKp2KxfgmQxI1N6lcmNYbvuRWOm7X46Pc2ddrz/0/lhzLM38eYMmGfPGnNYRZX11LaKepR/8rG2BzoytOGfjc9KkpjaFCzWr5tROP/vRlcOVjRQ0bU3kXWUX0MebvY9NP2DeylwWrZ4rX+mHEmE+gs5XylVh+XntfNu5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfZye4vX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfZye4vX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A9B1F000FF;
	Mon, 14 Sep 2026 05:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789364774;
	bh=Cz+kCdnag2pxT5jrb2/Bn4m5inG+jzecuU/kuHuL1OE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LfZye4vXUfjI/vxusQ8FfGq53AmNv3f1708vO3W33eBLKkNkl2UQ327pmPHtE9KxZ
	 6U6DJz4F/xtio6DTgzNjwWuEnnr+7TfoIueManhqYF79u+KBxbQbBYA4oH63xmOyWw
	 ETigddnfjDVTIEHQuXtfamibRmIGz3jEf8Ti/Ax4EJ7Q3sTzm3DEupILaW33IYc5I5
	 ZR1xBurilqkOtuw9pXqS2OnhqubaNrpR1Ho0DEjCmd4z0Yofy6h7v8u1tawNHKfaYc
	 5JhnPkqhyGfaINpZcVQpsNw8wwvP00kL/WvtER5m5u4o/NzXhEt58cgu2/OasaEDJV
	 PRU5pp2pbtDuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] tracing: Print the bucket size as unsigned
Reply-To: sashiko-reviews@lists.linux.dev
To: "Donggeun Yoo" <donggeunyoo.kernel@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260914053443.981201-2-donggeunyoo.kernel@gmail.com>
References: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
 <20260914053443.981201-2-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 05:46:14 +0000
Message-Id: <20260914054614.82A9B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Data truncation and broken sign-extension of 64-bit trace fields o=
n 32-bit architectures.
- [High] Histogram buckets calculate the bucket multiplier using unsigned d=
ivision, mapping negative signed values to incorrectly shifted intervals.
--

commit 4cdcc152f0ffdbdcaf7893e1ce7822e2b783d217
Author: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

tracing: Print the bucket size as unsigned

This commit fixes how the bucket size is printed in hist_field_print().
It changes the format specifier from %ld to %lu to prevent negative output
when the size exceeds LONG_MAX.

> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 963e0d6b61fdf..ecfdc5ddc2c13 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
[ ... ]
> @@ -283,28 +283,28 @@ static u64 hist_field_log2(struct hist_field *hist_=
field,
>  			   struct tracing_map_elt *elt,
>  			   struct trace_buffer *buffer,
>  			   struct ring_buffer_event *rbe,
>  			   void *event)
>  {
>  	struct hist_field *operand =3D hist_field->operands[0];
> =20
>  	u64 val =3D hist_fn_call(operand, elt, buffer, rbe, event);
> =20
>  	return (u64) ilog2(roundup_pow_of_two(val));

[Severity: High]
This is a pre-existing issue, but does roundup_pow_of_two() in
hist_field_log2() truncate the 64-bit val on 32-bit architectures?

Since roundup_pow_of_two() takes an unsigned long, it appears this will
discard the upper 32 bits before computing the logarithm for any histogram
trigger operating on a 64-bit field on a 32-bit architecture.

>  }
> =20
>  static u64 hist_field_bucket(struct hist_field *hist_field,
>  			     struct tracing_map_elt *elt,
>  			     struct trace_buffer *buffer,
>  			     struct ring_buffer_event *rbe,
>  			     void *event)
>  {
>  	struct hist_field *operand =3D hist_field->operands[0];
>  	unsigned long buckets =3D hist_field->buckets;
> =20
>  	u64 val =3D hist_fn_call(operand, elt, buffer, rbe, event);
> =20
>  	if (WARN_ON_ONCE(!buckets))
>  		return val;
> =20
>  	if (val >=3D LONG_MAX)
>  		val =3D div64_ul(val, buckets);
>  	else
>  		val =3D (u64)((unsigned long)val / buckets);

[Severity: High]
This isn't a bug introduced by this patch, but does the unsigned division
in hist_field_bucket() break the bucketing logic for negative numbers?

If the field is signed and negative, its 2's complement representation is
large. Performing unsigned division via div64_ul() or an unsigned cast
without checking hist_field->is_signed seems like it would calculate the
remainder incorrectly. This would happen whenever a histogram is configured
with buckets over a signed field that takes negative values, mapping them
to the wrong bucket intervals.

>  	return val * buckets;
>  }
[ ... ]
> @@ -461,11 +461,11 @@ static u64 hist_field_timestamp(struct hist_field *=
hist_field,
>  #define DEFINE_HIST_FIELD_FN(type)					\
>  	static u64 hist_field_##type(struct hist_field *hist_field,	\
>  				     struct tracing_map_elt *elt,	\
>  				     struct trace_buffer *buffer,	\
>  				     struct ring_buffer_event *rbe,	\
>  				     void *event)			\
>  {									\
>  	type *addr =3D (type *)(event + hist_field->field->offset);	\
>  									\
>  	return (u64)(unsigned long)*addr;				\
>  }

[Severity: High]
This is a pre-existing issue, but will casting to unsigned long in the
DEFINE_HIST_FIELD_FN macro corrupt 64-bit and signed trace fields on 32-bit
platforms?

It looks like this cast truncates 64-bit trace values to 32 bits, silently
discarding the upper 32 bits. Additionally, for signed types (s32, s16, s8),
it appears to break sign extension, causing negative values to become large
positive 32-bit integers. This would corrupt values for any histogram
trigger operating on a 64-bit or signed field on a 32-bit architecture.

[ ... ]
> @@ -6203,7 +6203,7 @@ static void hist_field_print(struct seq_file *m, st=
ruct hist_field *hist_field)
>  		}
>  	}
>  	if (hist_field->buckets)
> -		seq_printf(m, "=3D%ld", hist_field->buckets);
> +		seq_printf(m, "=3D%lu", hist_field->buckets);
>  }
> =20
>  static int event_hist_trigger_print(struct seq_file *m,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914053443.9812=
01-1-donggeunyoo.kernel@gmail.com?part=3D1
