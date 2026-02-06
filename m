Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2058329E7D;
	Fri,  6 Feb 2026 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.103.80.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770365407; cv=none; b=A8uFuG3BUv4xtI1VWB9QgMHf2+NlU0WiyTM7DgSYPFWNcuab/Tv3vEAtLjkM1gvNo8HOEFmIZiPHlfuRPdSdReOT+Fe7l+lH3cRu17lHKbWWLfaTpTC/6r6Se8UPBcZPtRlH+suBp/6tGezTIU2meDuxIgOzKXwWTy1fGr4H+eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770365407; c=relaxed/simple;
	bh=Vr1k5ZKtRvRXCRphTDX7Rlz/Z9dNVEm5co+uHiOQcFM=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=VX8i3cdjKkWnWgWSQWQvP2kt31T8JqnRGH4bdyb41VNCKq2oFHjdqwmd3i9Cw+ntsbFqFy1kASsWWFnS6Z17i5OxZd/N0vUDKFnibJqfgSeSky9mWDiMbu8Cz4WjdAvUgRq2UfDerg/CehF84p7Af3CsDZJJVf7YWe3qnkY8Zac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com; spf=pass smtp.mailfrom=mykolab.com; dkim=pass (2048-bit key) header.d=mykolab.com header.i=@mykolab.com header.b=KZzbtTUf; arc=none smtp.client-ip=212.103.80.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mykolab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mykolab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mykolab.com header.i=@mykolab.com header.b="KZzbtTUf"
Received: from localhost (unknown [127.0.0.1])
	by mx.kolabnow.com (Postfix) with ESMTP id 7B22320A9E9C;
	Fri,  6 Feb 2026 09:09:54 +0100 (CET)
Authentication-Results: ext-mx-out011.mykolab.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=mykolab.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mykolab.com; h=
	in-reply-to:references:from:from:subject:subject:message-id:date
	:date:content-type:content-type:content-transfer-encoding
	:mime-version:received:received:received; s=dkim2; t=1770365394;
	 x=1772179795; bh=BEL3z6cZ5fUyoW2ed6AuenQqUUIZ10uxHuhSYkPasbM=; b=
	KZzbtTUfJ6ocUkNYgS3gsXH3rIzzjAY6WOkBbdfrfvtWPkV1ES92wYgA+34IbZfa
	v16S3LIDj/K+yp76s8M91UBb4wc1yCFGWok3lkciiyeZfTSmyxUx26HcPfrFcgJ6
	4IdOQZbYDMdBHkEk8ezMbj0j7TuSZHfWgNm47lN60F5VT1kEvkaiVwpdskTKJU//
	541m6GQYIf6ePYF6fhoHSwfDO6M3FXluEJAzlmoUQimBOlMzKRSR6Rhoe+FRkaot
	09hrBybrAu+n2KTFbYYdpsW7iYuXs9wT3MQkJaOO3G22oIqwd/ogZ72md/ZKTgh7
	mvjqGTdWRY1z7jntl2a0kQ==
X-Virus-Scanned: amavis at mykolab.com
X-Spam-Flag: NO
X-Spam-Score: 0
X-Spam-Level:
Received: from mx.kolabnow.com ([127.0.0.1])
 by localhost (ext-mx-out011.mykolab.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id DfZ4jvE6wBGd; Fri,  6 Feb 2026 09:09:54 +0100 (CET)
Received: from int-mx009.mykolab.com (unknown [10.9.13.9])
	by mx.kolabnow.com (Postfix) with ESMTPS id F205020B2751;
	Fri,  6 Feb 2026 09:09:52 +0100 (CET)
Received: from ext-subm010.mykolab.com (unknown [10.9.6.10])
	by int-mx009.mykolab.com (Postfix) with ESMTPS id 94D8D20C284A;
	Fri,  6 Feb 2026 09:09:52 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 00:09:49 -0800
Message-Id: <DG7Q5K72T7AZ.2TGDSMRADSUD9@mykolab.com>
To: "Steven Rostedt" <rostedt@goodmis.org>, "Colin Lord" <clord@mykolab.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] trace/hwlat: prevent false sharing in get_sample()
From: "Colin Lord" <clord@mykolab.com>
References: <20260202025838.32057-1-clord@mykolab.com>
 <20260205094722.6d21d8b0@gandalf.local.home>
In-Reply-To: <20260205094722.6d21d8b0@gandalf.local.home>

On Thu Feb 5, 2026 at 6:47 AM PST, Steven Rostedt wrote:
> On Sun,  1 Feb 2026 18:58:38 -0800
> Colin Lord <clord@mykolab.com> wrote:
>
> I was about to send this as part of my fixes, but taking a closer look at
> it, I have more questions.
>
>> The get_sample() function in the hwlat tracer assumes the caller holds
>> hwlat_data.lock, but this is not actually happening. The result is
>> unprotected data access to hwlat_data, and in per-cpu mode can result in
>> false sharing. The false sharing can cause false positive latency
>
> BTW, what exactly  do you mean by "false sharing"?
>

>> events, since the sample_width member is involved and gets read as part
>> of the main latency detection loop.
>
> I'm trying to figure out why the change in sample_width would cause any
> issue.
>

You described it below, but yes, by false sharing I am referring to
cache latencies that occur when reading sample_width. In this case, it's
primarily due to hwlat_data.count getting modified. Since count and
sample_width are just 8B apart from each other, they'll often share a
cache line, so one thread incrementing count due to a latency event
causes all other running threads to fetch the updated cache line when
reading sample_width.

On most systems I tested, this doesn't cause high enough latency to show
up, but I guess the system mentioned in the commit message has a slow
interconnect between the two sockets. Combined with large numbers of
threads, a single latency event would cause a cascade of cache related
latencies.

Another test I did to verify this is what was happening on that system
was setting tracing_cpumask to only contain CPUs on the same socket. If
I ran 32 threads on the same socket, there were far fewer latency events
compared to running 16 on one socket + 16 on the other (same number of
total threads just different distribution).

>>=20
>> Convert hwlat_data.count to atomic64_t so it can be safely accessed
>> without locking, and prevent false sharing by pulling sample_width into
>> a local variable.
>
> The above still makes sense, but this only effects the seqnum, which may
> show either duplicate or skipped numbers. But shouldn't affect any of the
> other data.
>

Yes, the modifications made in this commit to hwlat_data.count do not
affect the latency. The change is related to the rest of the commit in
the sense that it is addressing the incorrect assumption that
hwlat_data.lock is held during get_sample(), but it would also make
sense to put the hwlat_data.count changes in a separate commit. I could
split it up if you'd prefer that.

For what it's worth, I did also see many cases of duplicate/skipped
sequence numbers on the machine that was affected by this latency issue,
but I wasn't sure how detailed I should make my commit message.

>>=20
>> One system this was tested on was a dual socket server with 32 CPUs on
>> each numa node. With settings of 1us threshold, 1000us width, and
>> 2000us window, this change reduced the number of latency events from
>> 500 per second down to approximately 1 event per minute. Some machines
>> tested did not exhibit measurable latency from the false sharing.
>
> Is this because the read of hwlat_data.sample_width is a global variable
> and could possibly be causing a cache hit latency that shows up on large
> machines?
>
> Is that what you mean by "false sharing"?
>
> Oh, and subjects for the tracing subsystem should start with a capital, a=
nd
> should be something like:
>
>   tracing: Fix get_sample() in hwlat from ...

Got it, I can make that adjustment and resend. Would you also like me to
modify the commit message with any of the above clarifications?

thanks,
Colin

> -- Steve
>
>
>>=20
>> Signed-off-by: Colin Lord <clord@mykolab.com>
>> ---
>> Changes in v2:
>> - convert hwlat_data.count to atomic64_t
>> - leave irqs_disabled block where it originally was, outside of
>>   get_sample()
>>=20
>> Thanks for the v1 review Steve, have updated and retested.
>>=20
>> cheers,
>> Colin
>>=20
>>  kernel/trace/trace_hwlat.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
>> index 2f7b94e98317..3fe274b84f1c 100644
>> --- a/kernel/trace/trace_hwlat.c
>> +++ b/kernel/trace/trace_hwlat.c
>> @@ -102,9 +102,9 @@ struct hwlat_sample {
>>  /* keep the global state somewhere. */
>>  static struct hwlat_data {
>> =20
>> -	struct mutex lock;		/* protect changes */
>> +	struct mutex	lock;		/* protect changes */
>> =20
>> -	u64	count;			/* total since reset */
>> +	atomic64_t	count;		/* total since reset */
>> =20
>>  	u64	sample_window;		/* total sampling window (on+off) */
>>  	u64	sample_width;		/* active sampling portion of window */
>> @@ -193,8 +193,7 @@ void trace_hwlat_callback(bool enter)
>>   * get_sample - sample the CPU TSC and look for likely hardware latenci=
es
>>   *
>>   * Used to repeatedly capture the CPU TSC (or similar), looking for pot=
ential
>> - * hardware-induced latency. Called with interrupts disabled and with
>> - * hwlat_data.lock held.
>> + * hardware-induced latency. Called with interrupts disabled.
>>   */
>>  static int get_sample(void)
>>  {
>> @@ -204,6 +203,7 @@ static int get_sample(void)
>>  	time_type start, t1, t2, last_t2;
>>  	s64 diff, outer_diff, total, last_total =3D 0;
>>  	u64 sample =3D 0;
>> +	u64 sample_width =3D READ_ONCE(hwlat_data.sample_width);
>>  	u64 thresh =3D tracing_thresh;
>>  	u64 outer_sample =3D 0;
>>  	int ret =3D -1;
>> @@ -267,7 +267,7 @@ static int get_sample(void)
>>  		if (diff > sample)
>>  			sample =3D diff; /* only want highest value */
>> =20
>> -	} while (total <=3D hwlat_data.sample_width);
>> +	} while (total <=3D sample_width);
>> =20
>>  	barrier(); /* finish the above in the view for NMIs */
>>  	trace_hwlat_callback_enabled =3D false;
>> @@ -285,8 +285,7 @@ static int get_sample(void)
>>  		if (kdata->nmi_total_ts)
>>  			do_div(kdata->nmi_total_ts, NSEC_PER_USEC);
>> =20
>> -		hwlat_data.count++;
>> -		s.seqnum =3D hwlat_data.count;
>> +		s.seqnum =3D atomic64_inc_return(&hwlat_data.count);
>>  		s.duration =3D sample;
>>  		s.outer_duration =3D outer_sample;
>>  		s.nmi_total_ts =3D kdata->nmi_total_ts;
>> @@ -832,7 +831,7 @@ static int hwlat_tracer_init(struct trace_array *tr)
>> =20
>>  	hwlat_trace =3D tr;
>> =20
>> -	hwlat_data.count =3D 0;
>> +	atomic64_set(&hwlat_data.count, 0);
>>  	tr->max_latency =3D 0;
>>  	save_tracing_thresh =3D tracing_thresh;
>> =20
>>=20
>> base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7

