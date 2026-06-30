Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A8270EC1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854211; cv=pass; b=okOxK9hCC/kr4l9VHVStvpBmD06gRHlFafxiYfP/Ue9BWXDIKcKh0BYsGMEBjzOrxg2N79kgLalbGQaiyKiLKqHtAJh7dO5PbDKoad+9muxhBFGUy52g1Q37CGmVMgUi4w3HkVnVYATNcZgnpSXRsszFJVi7hcT6U1qLKw6c72g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854211; c=relaxed/simple;
	bh=ruUT8WsbOkLIXJNusWz9ZA4yeHJpidmSIjp8q7dO1tg=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUqW3WiEVJ2zwWo9QNM16nlgvdELEdad/KsfmtQYswWYiG/m4pTjpZCV/KDajdFdtPMhtgYdthlnkdkYSiWGcAAe1ZALc7rufuyGBmt4AI6yVEK5+aZuRgaWaZrWyUtTGUvq48V/qdi0+A24+AHUTYIInxDOdYvfVG+qtITM4Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMpT5Q50; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMpT5Q50"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-664c6304683so3394446d50.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 14:16:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782854209; cv=none;
        d=google.com; s=arc-20260327;
        b=g1Go68aiqmCHpRgEcIi4ov8hrjjyJzzzYnPtkwfwoJC34vmPyIbpfnhFccF8s054gN
         hYlVsqqaH3F6Brm/HvxdOb6BP4AA9WwvStrCCvK38UkOXr3PUuY9Dxhh74hj7sUGGl4K
         jx4Jg5Yw9X9d7PMtTwmLIHa1H5TaI7oRpP4CggMIDEhU0uU7UE3f7nKvYq5nhrmuSJje
         JBZzO4jAMK6A4Y3Nid6yOKvnGSo/WYWkvKA1VB87C/1nHeqjyr9LErG873RJxKyf0ccf
         6Sw4SpHxmOEc1HBB3357doQ2dxpbzLKgaW0EEDPRFrFGjJ3nMLOxc1CVMbv/J2bQ5MPd
         zIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=ruUT8WsbOkLIXJNusWz9ZA4yeHJpidmSIjp8q7dO1tg=;
        fh=SamkXEKpR4DczL7OrFd8KymofpqFH/bavlp6Wa92SPs=;
        b=aPgA/HiLtzUB6mazzFSFNH3PggHkccul6BvMogpJpagvZ9JSOUxbzu7t400ccHLph/
         TPQ4kbx8I8CengbtarBX8pTHLgTXqWnT+4dOsN0IKXlyxm7gmBQiLsgwfWo1qfW0mnaD
         MO2i/l6ZCDwacOnazO5edRBNomNblXFs6T2Pse0Tfr3MdW7f6/s20XxPSJXq5SwEgYPy
         a0yBAIYKqWNv3eePxvUCisFpQFsiMWzUP9rjMpJGFOO2aUOHS13k8Xahsl7iOT5lbSp8
         K9Keq/u4iJveRT1EVXKZb76GoPkfLE11ttsodZ8P7UIUn88MLSII4YdthxmqECaNqtoQ
         oQGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782854209; x=1783459009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ruUT8WsbOkLIXJNusWz9ZA4yeHJpidmSIjp8q7dO1tg=;
        b=fMpT5Q50ZSbyWoQqPrMocTZ8+hhtQYkXEYABv8+DXYCeLw4p72ZyXcJsgujY3Sw0sl
         BM0rh539VbxECmgIJpn6j3TdOuRr1gHzg4pagSV7L5eYwBmoebZzAgWxaFjdvDP8treM
         jKTdfQJG5QFoXp0do6HmnU7i4I0/zLduHUTjF1T+zkHkyI0fRX64dLBq686Q6D0DvJSK
         14/dFziLRv6fDYNkmTGetVPqNhIywpyUUgI2SPI0nz3Qe+e/GHAlnnPe42P03E9xka8K
         dM8P0/1L/Nhxm62Wvd9dfeNzhVVNYTX2bcDGwy//Mtu5+kIjw+NBtzKeT/cXux1b1W+b
         zP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854209; x=1783459009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ruUT8WsbOkLIXJNusWz9ZA4yeHJpidmSIjp8q7dO1tg=;
        b=pBBwWxn5rZqONRAC4S4LxISjl0t0fqJUKzjpN19bI0eMc9B07wGY7YQh1VUm5sHNpB
         Uwe9i0DRdg8gHiQ69yAe+kKOj9ISDab2kkPgRDcCfZkLVmTRlpr3g/Btv0HXKRI+NbFr
         XfROjyc/DiyVcVYh2HAxpqpFdYHa2JQd96LVyXQ26PmZWHFAD3iPIIWxvVAisRMA8MXx
         Q4HWedPWrEW0dgywqalIH7ZIdjwmAaLoRSRf34NYxrNqxWBIfNyMVLmvVSJNVWW61b1X
         zx6W3oYxHneOteuGtemB51lQp5NBo2pD+/dOjKC5lwEv/NFwZCcKtbKwGc9OadWL/FTK
         3Hjw==
X-Forwarded-Encrypted: i=1; AHgh+RpDq1oqJqq1MrR0tdvq/4bq7hSsZv1Y6adItwkagF7nLkslJ3E77lDwWgoidlmEyLYCN75LACEJ6rqAVbDQDhw3+1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxosEUFnelxaPGiNqjd8ghJExyHEvmk/wZVbqgaWpMbdkh/t012
	ObllethippGfLTOwjrZ8177227qGz4hPIA+wxW5kMTdP0cjxBEQ42pJGuBusL9OE4Q3sw92ziza
	hn3JtMs/GhM+rgaMn4m3KSj6BYfgET+c=
X-Gm-Gg: AfdE7cmL3y/hFGcSTN3RmF/ZxDUSZjibnSNtGnnSc5+smOYjB2wLbs0alreC5dflP7N
	Cuzf2oHjEC7rQ0dORxImcp4kz+58IdCjIFtEwGPGNtzEud4O1OYVn7g4icdbQjSpm3Jz6cwWwBW
	29jEPgnj+bUcz35Xa+M47FgzDNNaz84Bc1up4Qq/QXD9j4kYIQg3HehmkqqokaW7xMSnQQJNygZ
	GGMDNdoHBPIJNdx/PDFxdXr/b/F3uI/z4BZT1huMKEzUTWh0Xb2nX72clgKmVkt1KYMwoPI
X-Received: by 2002:a05:690c:2503:b0:80c:85e5:873c with SMTP id
 00721157ae682-810da811c43mr63224367b3.58.1782854208952; Tue, 30 Jun 2026
 14:16:48 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 14:16:48 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 30 Jun 2026 14:16:48 -0700
In-Reply-To: <20260630171603.26530150@gandalf.local.home>
References: <20260628004653.28065-1-alhouseenyousef@gmail.com>
 <20260630101425.2f7cfbea@robin> <CAMuQ4bV-HJWbS7NHPGtoyKz-_+LR335phbXeOi83EbV6kn+3gg@mail.gmail.com>
 <20260630171603.26530150@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
Date: Tue, 30 Jun 2026 14:16:48 -0700
X-Gm-Features: AVVi8CeI2NH_sVcqCH3X4e1JHXJ7nlLwk3iiDtgaDWzXsrOpT7oM3wiirYMrcCM
Message-ID: <CAMuQ4bUNbCM7oxnrXaT_oAoX+Guoo4_Bu0eO5dLR3OZ62Eu0Xg@mail.gmail.com>
Subject: Re: [PATCH] ring-buffer: serialize read-page order with subbuffer resize
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, petr.pavlu@suse.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Agreed. I=E2=80=99ll add an explicit resize-in-progress flag, set it around
the order transition, and make the external read-page
allocation/free/read paths reject work while it is set. I=E2=80=99ll check =
the
flag under the locks that serialize each path so it cannot race the
transition, then compile and test the resulting v2.

On Tue, 30 Jun 2026 17:16:03 -0400, Steven Rostedt <rostedt@goodmis.org> wr=
ote:
> On Tue, 30 Jun 2026 13:45:05 -0700
> Yousef Alhouseen <alhouseenyousef@gmail.com> wrote:
>
> > One issue turned up while checking the suggested locking:
> > ring_buffer_subbuf_order_set() writes buffer->subbuf_order before
> > taking reader_lock and never takes cpu_buffer->lock. An allocator can
> > therefore take cpu_buffer->lock after the new order is published but
> > before resize clears the old-order free_page, tag that old page with
> > the new order, and return it.
> >
> > I can keep the allocations outside buffer->mutex and hold the mutex
> > only while snapshotting subbuf_order and taking or returning
> > free_page. That removes allocation from the critical section and
> > serializes the order/free-page pair with resize. Would you prefer
> > that, or should free_page and the order transition be synchronized
> > another way?
>
> Nothing should be reading when the subbuf_order is being updated. Let's a=
dd
> a flag to state that it's being updated, and make all reads simply fail
> during that time.
>
> -- Steve
