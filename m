Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191C723EA98
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764337988; cv=none; b=ZNodIQPX/uwlq+je4LSSav4F5BWSTO9vsxvReai/DAT3YpGbsV8Ppl3TdtxufPCiHEu5cP2kcyF6PyaGyM3hbGS0W+dWlREYxLXqo+LHQ48uA/bckeg8XvbS9DBA2XE3Nhf7KN2bSTZjGS6Kk3vKbZ6OroKduZmKTKUg/6qb4BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764337988; c=relaxed/simple;
	bh=pbBawiQmtNJdVZxeYvEt9G/XaBTVKaR9xIboieApa7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJvrq+ugQmoAOy9GHMwLFxSnkjryWvT5FILL4B1CGKfCDSKhGJnDp5yFDhJlVWsG375/m5n4eKoAc83UrQ0suRqLTuLcAlH5hrPD27Wv3yT2FFb4ZgoSXJAZT0dN32kT0pcwVnqPYIqHjdPkW8Bp1s/5/zBiCvrTRVK0fQso/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OKXHGwIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKXHGwIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764337985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbBawiQmtNJdVZxeYvEt9G/XaBTVKaR9xIboieApa7U=;
	b=OKXHGwIzTUmH5GB4g7tgQWH/LQ6tLcMS8zF6PR3Lx/iFuzWnViORSmnJ5R13mK+qpdLlFP
	oQG41RQ/PvlzpSP/bNRGPUt/qzHl4HL4/Dnek86rAy5zx4dLRHjaWKGAZCrdaLRJUM4Mpa
	0MzMj3nV+dOasZy1Y/B+gau7BreYjm0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642--4gXoDTDNUmdaCJ6850BKQ-1; Fri, 28 Nov 2025 08:53:02 -0500
X-MC-Unique: -4gXoDTDNUmdaCJ6850BKQ-1
X-Mimecast-MFC-AGG-ID: -4gXoDTDNUmdaCJ6850BKQ_1764337981
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-59580c95819so1394540e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Nov 2025 05:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764337981; x=1764942781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pbBawiQmtNJdVZxeYvEt9G/XaBTVKaR9xIboieApa7U=;
        b=LlZ03IOBCF7VYUufu1qaGpNf+rueRrUOOsh9ph7Q6awkl9irmlMfaDs0Ahk8s1N7Ti
         aZvOkXfPmm8HwjPIBMOW/r2CDitKCNf3SGpj2Q1NxCZiw073gfwNIoWtUK8TPJQ+NEdW
         1VWaMKt9e23zqcR7fAEJF/ow9Tsw/gztWRDq12piyCQsSYbDOQGX7beLrqZc9doVpDmR
         s3QDPo7/M3nK96RMM4MGZrnoFdEyATqZgoPCo5XEPFh+wRzJHejLIocbTaqzk83w39B9
         tvabJuyEdyb5EB5iCwqRuZ0leJpL0e5i08VmLPHeMEDM+yCwYaTn0WcLRIPwpFUCnFJZ
         dSFA==
X-Forwarded-Encrypted: i=1; AJvYcCXvEo8BSfPO02pgfBXg3jcA5aV+DNgjtIATmwBINgOqbVoUa6PyYIb2XDjd722pnxdXZDxWQBedeLd6xcrezgAGAVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKVoV+ChYgZ2vHj+R/b+ummuqHWEiB9IfZswUm0eZO2BBzIaR
	PYtypviaOoWhuTrAkPmzjfGALCklVYBlD9Qtvm6eIEZPLkJJmyoFsh71ZVVsm9Kfr7N34X7PXUO
	k8S4lmtOvixXUF21WrP0nDmVqLHfB/iWbkpMMe4Ljx/4IkTdEVJEjpvlu2G8NMWImhylSWb++ZH
	+PTgQRrMoNFdUx48UupAWNiTp3jwSJjNXGTDDGXXDXzQeBmkeg
X-Gm-Gg: ASbGncsp+ASV31+szG/6BqTskKEfhwcvuE0GVHkk+U+wYWqBG6G1BeAySFSmY17VXBN
	uG4GxwPU2IpvVVcGCB97aDXseSvuPuXZaotjuqe3jvclqv+l6eG0my8w+XV3/d1fZd1z46XbyVB
	9j8EpDnKF2Wz55Tt0WULuUbIMXU/Ocsup6EwwmpkhntXLsoGxr8Bk5FQQfEG/qHx/Q3Q==
X-Received: by 2002:a05:6512:110a:b0:594:2df2:84c8 with SMTP id 2adb3069b0e04-596a3ecf652mr8065926e87.33.1764337981166;
        Fri, 28 Nov 2025 05:53:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxr/p6KFwbxmBeYyfFkOgez8vD9eAT2uUP849jN8015e5rnJowKoYbVC9lcjOKCZyBvhu+4pGX0/eZBkRGR8U=
X-Received: by 2002:a05:6512:110a:b0:594:2df2:84c8 with SMTP id
 2adb3069b0e04-596a3ecf652mr8065918e87.33.1764337980757; Fri, 28 Nov 2025
 05:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-2-wander@redhat.com>
 <CADDUTFwK=TuhMcfr9C4NXOEQc89wBvdZtv+DtYFuHfc9wh5R=A@mail.gmail.com>
In-Reply-To: <CADDUTFwK=TuhMcfr9C4NXOEQc89wBvdZtv+DtYFuHfc9wh5R=A@mail.gmail.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Fri, 28 Nov 2025 10:52:49 -0300
X-Gm-Features: AWmQ_bkeS6Y54WrCji-DPm62oeGH0r4pGKqlqBcxo7rjyOZqWF3Uwi0VtVBxrd0
Message-ID: <CAAq0SUnYnopSwd2ir_J1roFU31SzK5SQkv1L+WhP=T=Xbq479A@mail.gmail.com>
Subject: Re: [rtla 01/13] rtla: Check for memory allocation failures
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: guSXvSMuY9mnrFgwfyYTfJPnvyOqVOBrOh-rKsGpJFE_1764337981
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 10:30=E2=80=AFAM Costa Shulyupin <costa.shul@redhat=
.com> wrote:
>
> On Mon, 17 Nov 2025 at 20:54, Wander Lairson Costa <wander@redhat.com> wr=
ote:
> > Add checks for the return value of memory allocation functions
> > and return an error in case of failure. Update the callers to
> > handle the error properly.
>
> Would you like to consider using fatal("Out of memory") instead of
> returning an error code?
> Anyway there is no work around for out of memory.
>

Good idea. I am going to update the patches.

> Costa
>

