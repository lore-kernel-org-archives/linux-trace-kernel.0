Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB9305680
	for <linux-trace-kernel@vger.kernel.org>; Thu,  3 Sep 2026 01:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400627; cv=none; b=r8gH4G9t2SrpAAVG/drBqpyX17FcLgg8nb5qoe2I1+2Gm0JUh5xdKJLySV6mTPgLhFJyTck9ysTBPY/DQVK1nmAeRL2lfznRr8En8g6m+6Vpq1wMMbcsGt0d6OU89xz/ULsrHYJNveQMAol8hF8sHpLSIRRIH5PyW3mdPpI0/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400627; c=relaxed/simple;
	bh=mz30dBvtDT771JV451s8UVUULvK5bR+yMsulF6N92Sc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=uqD5GQSS694Siz69JasdNGEufGvcmwajfMooPAOUpmWXV4yzRzSZQFyc5Gv1uUVdWGmyNg1YT6bN1NMtKWg2exuIMWxo6etYJBPyt35pWVoOqaNlYqP3vmgCEL9OJEit1lg3vtSECsib6ILymdbQzb8iHrZ0CKsZjwJ9H8CxDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLODW4Nq; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLODW4Nq"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6b145a9623fso722816eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Sep 2026 18:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788400625; x=1789005425; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mz30dBvtDT771JV451s8UVUULvK5bR+yMsulF6N92Sc=;
        b=lLODW4NqgG0Qx+D8oN5I68rDbNsIbrcaz2G7Oi2yB4jvbwTngd8jNGS0kBtX8JVRhU
         cAe7wbi+tOAxtr5563sjrzh89LxLt0IWmCmZfaOTg9UYAbXDPFRbHScojyLeEku+Dc3M
         a326d7HXUI/5JsSZxSzu6ioWg7lBK8T2JOaOCe6FZ0GgQTjguldkTPPRVK7i99f9M+Xs
         kwmvvxmX0ciOhXhLPWGrOxiFvqpV1hfQeG5GiGZATWCZ7vIZuhTkR6BJbQr+iaEXmRMs
         wkKNKJsJ7nVGMpixBgYO0z2EwrN9yJmoGaT9rTP2HfIj2YNHoq2AynIIh8btyorSfnVb
         jRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788400625; x=1789005425;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mz30dBvtDT771JV451s8UVUULvK5bR+yMsulF6N92Sc=;
        b=OsfygEIH7U6woeNQ+kUIkttpyTQMmhX194dW7VG3W1H7syij6y1PY26o2Rv+3jA5ri
         f2Pf0G7vKCBsvQ5Qn+TtJBYS6VnEaer1cw3RsWlPHz2QZ4oJquXscncfdC8qQJtYZa8R
         eDvmfzws+ScG4eskh0G559q0Dr0qbp6T2QN/7aOIXFKDmU8OZqlR72mMM1QZ+yO6v8Zs
         jsCFJc2Xupa0bg6Dntn1IQXLjkz2Sk/Qa/bMbIyKRewCQTr/W6Bt07H8Qb1Pzn0gKC4R
         6ej0GhMDEAVOkpVK4miJVupJawlLXEuaJQ5wIsv7yzj/1q+iI+Vo67eC3gbduW1x4uFI
         0doA==
X-Forwarded-Encrypted: i=1; AKwUvBztHbWL75UHzeTI2IFihqedAAHmVzJ2McmSo1B2J4vCxuxDCqAh2E8StnTPJP4ul97NOcpBbF//3IGIgrxEufn073c=@vger.kernel.org
X-Gm-Message-State: AFuF++kwstLL5jPk3FPA2H4BMWUf7UzHk77hx3Dggq5LOtxqsG9GiN8H
	gAXsGYJoj5J8Fxnw75tWCbhtyhHwL0JXkBzRUeaejTErera+q3ZsEBum
X-Gm-Gg: AYBFou1EV5FWsOq7HG1DOhnsyZypkoij+HTjArUKbT9L4/uZR5Bej+L3Sljr2Wy0IvM
	7Wg5I8WX7m1H1hMGYqmFrHQM+g6XBfX0u5bPzX14eN+qwdsFExr1majZoa4O1E0lwIizc1bj2fx
	jZrQMXkxVwTbJhx9YybSEskoIGn+L1Fmd0JbaqYDD4MT9dD0bJSGqTP08TGY7c6ZjxaB71a9m3n
	ri/KYh/064G8XCWR+tcR8yJ1bO6KyNDw+YQmRUOXk1VoNRoPCTzST5vSkT6VV2vCNZM+cVaicVk
	PposN9mohWMEEW0Ykzv/ZYGcE4FVl0d1hHwQbKfmlVRurjwQFbPWs9YX+8+GcK3ajmdU4fFkBI5
	aXEAS36EBBp7i1wUNtWQuCSF/eqy2JIGnksDdOtDap3sZqziWQqNY90Y6X4X2cQL9s+kel2n3Hz
	AkdH9e87s1dXLCc+pigmldKumd4rZw2hpo+Xo9Ac6hX0GULJ5W3vbKftKLQ5D/hTvkLGa6Q12mW
	dDJYR7k7FuH2pMJCrM8DOkay+XkZDH0PKAizmKKE9O3AZ+Nf3u+bxyJvEnq4KfH+w==
X-Received: by 2002:a05:6820:221d:b0:6b3:7d96:94c0 with SMTP id 006d021491bc7-6b47f81bf57mr6984688eaf.10.1788400624569;
        Wed, 02 Sep 2026 18:57:04 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:55::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ec2e6a8sm4061932eaf.9.2026.09.02.18.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 18:57:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 02 Sep 2026 18:57:03 -0700
Message-Id: <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com>
Cc: "Steven Rostedt" <rostedt@goodmis.org>, "Wen Yang" <wen.yang@linux.dev>,
 "Tobias Schaffner" <tobias.schaffner@siemens.com>, "Viktor Malik"
 <vmalik@redhat.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Gabriele Monaco" <gmonaco@redhat.com>, "Nam Cao"
 <namcao@linutronix.de>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260831090524.106845-1-gmonaco@redhat.com>
 <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
In-Reply-To: <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>

On Tue Sep 1, 2026 at 11:52 PM PDT, Gabriele Monaco wrote:
> On Tue, 2026-09-01 at 20:35 +0200, Nam Cao wrote:
>> Gabriele Monaco <gmonaco@redhat.com> writes:
>> > Extend the rv userspace tool to load BPF monitors, those can be found =
in
>> > specific locations (e.g. /usr/share/rv/bpf_monitors/) and are plain
>> > object files including BTF data.
>> >=20
>> > This type of BPF monitors can be generated from rvgen using the -b fla=
g
>> > just like in-kernel monitors and, after manual adaptation, can be buil=
t
>> > and run transparently by the rv userspace tool.
>>=20
>> I am not familiar with BPF. What is the benefit of BPF monitors,
>> compared to the existing DA monitors?
>
> I should definitely have included it in the cover letter.. I'm writing it
> everywhere (will present at LPC) but forgot it here.
>
> Essentially BPF monitors can be pluggable, folks writing their own monito=
rs
> won't need to submit a patch or maintain a separate tree, which is useful=
 for
> domain-specific models.
> By being pluggable you also don't need to reboot to use a new/updated mon=
itor.
>
> Think of being able to distribute a more granular set of rules for RTapp,=
 I
> remember we had conversation along those lines, not all rules apply to al=
l
> contexts and what you send upstream has to be general, what you keep for
> yourself doesn't.
>
> Having monitors in BPF brings also other perks over kernel modules: a who=
le
> bunch of readily available probe types (uprobes, fprobes, all unexported
> tracepoints that are cumbersome for modules), the map infrastructure for
> allocation is arguably easier and the code is verified when loaded agains=
t
> common issues (NULL pointer access, unbound loops, etc.).
>
> That said, I try to mimic as much as possible the in-kernel functionality=
, but
> some things are not the same (event/error tracepoints).
>
> These support DA only because BPF loading needs a userspace component and=
 the RV
> tool doesn't support LTL and HA yet, there shouldn't be any technical rea=
son not
> to extend to those in the future.

I don't think bpf fits here. I haven't seen active use of RV and even less
so of any request from people who want this kind of programmability.

So Nack for now. Sorry.

