Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AC249BD71
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 09:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400718; cv=none; b=V7X105HRG9BBVrOTWGxemJrv0bOVNiK9RLGK8W1bHP9JuYek/ALvJ+kF3HZaHfEBtphiYiYXL1o0nj8kWyymjiQMu4n+zXDMgx+8F0/icU4UA9K+Y+ZcyMdGgDmCtNVLg4MgELqE3Sa1JPk9qyGzQgC7uUmwd/MED8nI8EB7c2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400718; c=relaxed/simple;
	bh=gmnf5efQ2mINrLxGQXSf6UEgcGI1XJTCl1/2d7HLilM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFA+tZLD+zgXHyRsLBwyd2Au4mLmvmGMlX2vVNuSWLdLMo9/dgDlLnvxzwZEkWvnbFP0PPtzEc5DS5kAY9RNjDxAVQpptEiQZqcPtvwnRd+MIISqSWY5NFrzCGWmZ/KZuz9MEWLaZnAJuxRuHwFdER68lSgfY8CPqRK5j1B8b9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftwC1tnE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftwC1tnE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792400716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9io6NcVa485axIU0tMIo8oUR5zvQmfTZbiDmw/REe/0=;
	b=ftwC1tnEmaTflvLhcBBuQ/dB83a9H4exv9xxtyi/dCWCLHjpk0IUL46CsqXQpsJriFLnZr
	AEvxr60UYqEDp47Hy5cd9kMkOAPN/CLiuMWUEERboM0HM8JTMXMTyw3PhSbfIg05JhV6nt
	6kS4YYSPL2QROzAwm/hLkKf1gWgdkyQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-58qVH7pcPvOMzNBE04sfRQ-1; Mon, 19 Oct 2026 09:05:15 +0000
X-MC-Unique: 58qVH7pcPvOMzNBE04sfRQ-1
X-Mimecast-MFC-AGG-ID: 58qVH7pcPvOMzNBE04sfRQ_1792400714
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48e00f3929bso1416693f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 02:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792400714; x=1793005514;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9io6NcVa485axIU0tMIo8oUR5zvQmfTZbiDmw/REe/0=;
        b=1BL0aVU1Vq+jUjm+UxmhZaDd5FUdTS6zBWv76DvL8mMDET9qGO2jaixt0t1XtKEKeG
         2kqGobbjWJn8QLjIFheYIKGiJx11tntQXdWtSuVChfC1Vy2o1ak5Lt7ZKK8zDXZ1+FEl
         IIn31EgW2EhADQQDFKy/js+t5igecxN7Wp+d5BVA5iLYNEjo1/UE/YCW3M6Qc+lCtObG
         uhp9H7YDeUgQVIxetTFnrlK2XthQAi4r6y2wqwcFn4JOgWfHf/pRtv+6lE6yq3XwsliJ
         DvZ3pJTvoq9uNGtWTpFWTBETN/Gg0OkbLV2y99qohDqApz76rFhUX+/Yt6bJvlh5ni5K
         ql3A==
X-Forwarded-Encrypted: i=1; AKwUvByYe7h8i96cXQmrdMHu8WjCcIc9p0ETIaMV+KR4Y4HqMuUjbw0aqNulPaR/IWB/9LCXqd2Dx397SALkVAJn3iC/9zs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEjGVUPtfGWjqALc+7ooMgB6RRzRgSTFp7axYP6+sq4hPiHo8G
	9+AaO9Pf5JBGnhHzvePn0IQP/Xz/EUTPYpvz0itqic96uLRtQjfJusVFoOwLs7eSWsRq6MUnW2c
	T/tbqXeeJIYECHNY/kxRcUKRiDQhNPhhR9ATerb4x5JxqetoCg2i9qhXcrAqwcgMtnDlo7/kGr+
	j7Yirr6Q==
X-Gm-Gg: AYBFou3edEXQwXwy/rsVk7dRLBBEDrDC6iK2pOu2HLiB2bkDEjsSKLvgviX7YFLzJ/z
	jnPlqET7Oc7mYqRyGYK1aCMnqACsBi7Wtv2ZOtBf8D47psGCZguFtxZoYPw6i5q1ibSH1eFlLs7
	wvuxdkBsJOyJRv1Op2g6KDQRP+2dC/y1Evd+lR3oxL9d9ewwvGtVsOTiOkyznLhAe1FBl4Shafa
	GH8/c+6si2npxiJiCG6yRfpO117AsI3CZsldBvRBude2U8puFl2LtYi9x5tfng68vcS+3O59wk9
	/r4WKcYuqqwGsTBT60d3rqDcTReBVOQeOXprVk0pc4yZVQ5YbAeODKFurHUX+DHNQAS8RBVBBSH
	hCl4SJ+JftdzhH72YsDR/eZytgA==
X-Received: by 2002:adf:ec91:0:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48dfae65b2dmr19629110f8f.13.1792400713451;
        Mon, 19 Oct 2026 02:05:13 -0700 (PDT)
X-Received: by 2002:adf:ec91:0:b0:48c:54ec:ea3 with SMTP id ffacd0b85a97d-48dfae65b2dmr19629060f8f.13.1792400712928;
        Mon, 19 Oct 2026 02:05:12 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f576asm23527360f8f.32.2026.10.19.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 02:05:12 -0700 (PDT)
Message-ID: <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Nam Cao <namcao@linutronix.de>, Wen Yang <wen.yang@linux.dev>, Tobias
 Schaffner <tobias.schaffner@siemens.com>, Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 11:05:10 +0200
In-Reply-To: <87ik2zryzo.fsf@jogness.linutronix.de>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KcMMGE-4j0wlMc4VKuH9bWLMuCY1y34q1yUhiygOEYE_1792400714
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2026-10-18 at 14:16 +0206, John Ogness wrote:
> My issue with the /dev/kmsg design is bogus timestamps. But let's just
> drop my suggestion to allow eBPF programs to call printk(). Since the RV
> move to eBPF will require new user workflows anyway, the users will need
> to learn these new packages, tools, and output sources. The important
> thing (for me) is RV violations can still be used effectively with
> ftrace/perf, which they can (using globs in bpf_trace:bpf_trace_printk
> filters).

Alright, I'll focus on trace_printk for now. As I said, it's rather trivial=
 to
add another reactor later.

> @gmonaco: There should be clean glob-friendly RV bpf_trace_printk
> strings so that filters can be easily and reliably set up.

If I leave the LTL header unmodified, you'd get something like:

  rv: sleep: <comm>[<pid>] violation detected

It should be glob-friendly enough, but I'll try it out.

I wonder if string matching brings additional overhead (trace_printk itself
does, if I recall correctly), but that's probably rather minor.

Gabriele

