Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC29317142
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 12:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476716; cv=none; b=gjHvHtoTUrDxhQhrBjPlpHVvSpjwxzxjT+YHW4SSq39QJb7fCQoo6d1nu/BXfM9wp4d3tfxvdzdH8E/dEIRZSaJbjHXwG29Owf8Pgq2LuOBhi8DzWWoVfTsS8zWOPngU2oO0MypX4a6J5ppjsIFPqqPx5raPr8xFCAI8bMIQW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476716; c=relaxed/simple;
	bh=Y674XKR7coUlBC/m7GkUrCEpw/Jzj1/8zEdUJbQB6JQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8Aer8X0viYABYP3+Rj1XO/UY9dn8RT3KKIh9fyBUPzGNYytRm0PNFzsaiO0L2Nr3us3bob7ALayPBANgB+EF2zHFtcTsZ0tZTilFxEqwPkAKR2OP8iXcEp1hkVkgGB2HDfF43isIwn7TDcsXZq9Y19K2CMopSRZLOKjYT9g9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dA7J6/E2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dA7J6/E2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782476714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y674XKR7coUlBC/m7GkUrCEpw/Jzj1/8zEdUJbQB6JQ=;
	b=dA7J6/E24SH88I6wkFdV1+3FReTfZFVmEZ6QPucQ3OYjc7NsnCHBeCWfo2QarK3Rfk4T6p
	csO6MaWIc/0UTSseBKGCPlL2fr/zfIaWgIf/40EkSBPh0dlj163XIggPZLwCKkG0uV8Ldk
	BTed3O3rZ6RMHqZ3rOfFnKKzRjRR98U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-ys5hoTe-P36bIS6srhswSA-1; Fri, 26 Jun 2026 08:25:13 -0400
X-MC-Unique: ys5hoTe-P36bIS6srhswSA-1
X-Mimecast-MFC-AGG-ID: ys5hoTe-P36bIS6srhswSA_1782476712
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4923d2f0dedso5090935e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 05:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476712; x=1783081512;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7mzVWJs3aKiLXCG8c+oTwzKTAB4KW8z019ld5bSjd5A=;
        b=VfgfiEjjCI/0i2Er9PV3TrdNBZ9UKkme62Dzxy/v5l9+zFUQxQctqKiCEVGJO36aoS
         HQX5biOykHMMDXYU5nkt6CCxlNs58dEEXW8DXEUrqC6ECyE6pQ7vXFycGwlpyMn5bZd3
         Cq/XllDKxEk6GAYzOmdUr1fiKN/TpTPmb9+6NLbv9ws4Apsg+yJVFbcF6ltqrp4ILry+
         5hydgImYOjb6ROuq5gKvKdA9Wdwg6iVEBuOH+Xa5SIxiwR13ogMSLxvZw2xtS01kNpsX
         0zQmESeMfRDibfWKCsgiCUcwHMugCtdwwrWo729PYooHbnJJaTODerDT1ky/mAP1Mfk6
         wdgQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TeBlPV8sxwxS+Crq2TK267i929hbIbtVXj+O9nQNZImEn71S+qiyzYXouRpjCwzpDvxLVecKJN8nqp0eFPpxJ32E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv4kCgfxujWTz8UrwmEpKK131E+4KlCqeZAWkS6jRK2zlo7OmB
	66bTRrQ/Fyl5GfqWdcJTpK5WWcstBYQG4O9DaPBjsNgSh+RSOt9IgMXlKrnXW7aSIxEW72Heyg3
	pvlCk8gPtox/2JJJbxdxVcjnphkWJ/Xu5QvECWDQxG7Do3c4OTJmUido8wcHceINecA7xKLrpqA
	==
X-Gm-Gg: AfdE7cmZn3D7eD1Cglb1Cp8T4ZZvyvvt64mSnBTkSq7sToXsyNjy2GbT+rXAP9FT9a7
	L4/JJ2+P8SwcqQfXzPn6bHZHiC06ZRy8uUYwWpXmr7UtPqcki0498ykbdlDTdybhFoToZkPFeMA
	l4r9cAX5QjR88/ub9VbMsMZTmr1N3/bPQ6NaF0Bp+c/ojNGanhtAAgx31qak0n9E7TzCKXdeTj6
	217JbB1AXpxByBT2i025SI8zskigjVnCThqgdtPIE4OraRgnQxa0d2n2MOEdlxtf5mrUNME9yCF
	w+zNhdgS419LAKsyrJxAM35fiw584TXVWStQzedlVoOmK3wMefRXPLpySDWxLEj92L/A8JdRDGu
	bKNHWIYD0p6bXLMdn5aeXDwISgfRSDOU0N1VT3wIxKQha9s2g/0Obo8lyxBiZd2uo9I6AxJEr
X-Received: by 2002:a05:600c:a410:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-49266862966mr92729475e9.4.1782476712407;
        Fri, 26 Jun 2026 05:25:12 -0700 (PDT)
X-Received: by 2002:a05:600c:a410:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-49266862966mr92729045e9.4.1782476711979;
        Fri, 26 Jun 2026 05:25:11 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d998esm23765146f8f.24.2026.06.26.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 05:25:11 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tomas Glozar <tglozar@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, John
 Kacur <jkacur@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC PATCH v2 0/4] tracing/osnoise: Track IPIs
In-Reply-To: <20260626062658.7f95bcad@fedora>
References: <20260617131803.2988989-1-vschneid@redhat.com>
 <20260626062658.7f95bcad@fedora>
Date: Fri, 26 Jun 2026 14:25:09 +0200
Message-ID: <xhsmhy0g1zdy2.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e33ShZuZSQoV7BYG8GUDxpo_s35eZwTTKthCafBPbFw_1782476712
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/06/26 06:26, Steven Rostedt wrote:
> On Wed, 17 Jun 2026 15:17:55 +0200
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> Hi folks,
>>
>> So I've seen a few times now reports of latency spikes caused by IPIs, u=
sually
>> because of isolation misconfiguration, but only detected at the tail of =
end
>> e.g. a 24h timerlat run.
>>
>> It's not because those IPIs are rare, but rather that they don't by them=
selves
>> cause a monitered CPU to reach the latency threshold, it's usually a com=
bined
>> interference that gets us there.
>>
>> I'd like to make it easier to detect such misconfigurations and thus IPI=
s
>> hitting supposedly-isolated CPUs. I initially kludged a timerlat option =
to stop
>> tracing as soon as an IPI was sent to a monitored CPU, regardless of the=
 latency
>> threshold. It sort of did the trick, but Tom=C3=A1=C5=A1 convinced me ti=
merlat wasn't
>> really the place for that.
>>
>> So here's IPI tracking added to osnoise. This time around fully in users=
pace, as
>> Tom=C3=A1=C5=A1 pointed out to me that this will make it a lot easier to=
 deploy to older
>> kernels.
>>
>> Based on top of linux/next at 'next-20260616' to have the latest libsubc=
md
>> changes.
>>
>
> Hi Valentin,
>
> My new job actually makes me very interested in IPI interference, and
> this patch set looks *very* interesting. I'm currently finishing up my
> orientation and hopefully next week I can start catching up on all my
> email.
>

Welcome back :-) If IPIs are your thing, you may also have a look at
[1]. I'm working on a v10 following some (surprisingly) useful feedback
from Sashiko.

[1]: https://lore.kernel.org/lkml/20260505082355.1982003-1-vschneid@redhat.=
com/

> I'll try to take a deeper look at this in the coming weeks.
>

Thanks!

> -- Steve

