Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAEA2E40E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948951; cv=none; b=lKMwuV1p30ZWcVR/hckMfUMzth3d97GqNCTHbqqDSbbApWbGInJDHFszFUgk84+rpKfnYcjBzUlblj4jQMK8GuYh4UTc5cZmG1wZD7TMkEEHjMxcCzU+QA9TPVlKQAksxmkhAOCVm55bqzYcD5WrPkbSoevE0L/2AD+jDCIoNcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948951; c=relaxed/simple;
	bh=LdicY+2ncQNT9KCrIYxZm9IcrU2l5w1pIT/SGT4TkQQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mxmr9CJUYXdlLhA4ZldPEJaM28izLNESwU47qISS4joKPrq3YrBVmjOfa1tr9OzAeYA0/wDm9stez2kcGmAoiWrxgOoAq0qOxEaCG15Mwwhj29Lf++ycXxidXH8g8lk0TK1UHg4jqsFtH1cAPPE1/5UqdJ0u5jJt0OdnQFr9SiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RGBhkMjl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RGBhkMjl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753948949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=HHZ9+ef1VJ3neo5CwDLUurfNI4xnlLHmxEsfHcd9QeQ=;
	b=RGBhkMjl/KVFG4nDABMONH1zRJOqmAuoucIBAVHh01nfQP5zOa8OngxB9xlJHya+H5/VnK
	R734JuBmKOBO6MgWDZ2soPse+oOc4chMOjUOx3/xLWEKOMIVkJRm0lXoe9A2tdUa/WVZh/
	dA7l9azA2Fy6HqIFJ/29bnkmBFP6mn4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-tnFmPD7tNxunD2APHHbaeQ-1; Thu, 31 Jul 2025 04:02:23 -0400
X-MC-Unique: tnFmPD7tNxunD2APHHbaeQ-1
X-Mimecast-MFC-AGG-ID: tnFmPD7tNxunD2APHHbaeQ_1753948942
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b793f76a46so531993f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 01:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753948942; x=1754553742;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgv6U/W/hpoRUHyZFqCrSaXyDup15bzLQFsiG+oYoJU=;
        b=A8TEza5ioe+4mllWplljef0vSdsiB0sQrAVpvZXYpcUi2vR7Cq5MeBwNRwqWFGJPxY
         AjHjDy0GROwgBfFcwf65RkNdfh/3UgBWSba8jSj+a6gsWBiXSA3dmE7tFLWMxEXxiF5H
         lxy1V7vrI3OgcyZZSmvltHIqfIJynYHljVmgs3I8ElAO6+udKtZUnRO98OZKNikHe5Mt
         PQD+V1NzZwRcgbrNuepIZZUouMCs+vQGfngNF1tNfPi392o3twJodKccxJteZb/Ts5OF
         gyVpCEx7C3I8y4id2Pm6tsECF5o9UNEy0KUSuoOBOiDYBda9UMyJ00e+NJ6PXYpSvB8P
         E2Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWv//JlH/Ii4AkDv7doqQm5HDxjj2PIjcOwMc4KehwSd8bF0/khANi68N5wMM/6pk24BGaeKK4GnTBqG7HyvIeDcMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx+I/kxzu/vDT8jDZm0wxCwgyH6P1ZuhdF47xm/dQJabq9FZF3
	dUrp/UpMzxLWkUKaYHpghyay2tsIfBqIKR0+Ui/75ZHydiiNrwF1uM/K1GzmusawlQEoBwwNEkb
	a9i2fcco/QV6+rM3rFAHYmtFpcoTVNwKmed/1qV0WedVIURJ1WHWBcV1zn6cIM0s94YMhUGTiHA
	==
X-Gm-Gg: ASbGnctFMpcWs9umvc8H+KadrGAJDw8KoOG/txyLZpz0W1xrwrpGRXgfcr7rqkHDlUF
	YXBiXbIA/myFRx+N5eqvAcuwVHtqbg3aPVFVzhhHnQvsE09lrJT9aswCXVjdTNhkkbT9DNH7GGG
	3LxT0xMDm2YsK5WwdW6Ug78ZCDdkC3zb/YFoaDV6BZthmZ+CpoOPNJ7v/iMyy63xjhRMfIHtg6W
	BZ5oRX+MEgBbM/WADC+7kJQukeCEM0cQhMzk1hrKgjPcZGh1S7yeo5HsrtuxQ0sqEav6sstr1+s
	3EEnsPxpvKdQwAIEcG+u4YrffuRhPolw03YFxAv9Pjql9jdFZUFZb0xhRJ4Q8UdZ/w==
X-Received: by 2002:a05:6000:4287:b0:3b7:7633:4e71 with SMTP id ffacd0b85a97d-3b794fecc7cmr5082557f8f.13.1753948941969;
        Thu, 31 Jul 2025 01:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4pG6nXG2ua5v/+0ufLTKW+zE77EAA3F4z8dCGzhgrLwSHi6vxpr0yH0anYvSH+8Di5uZR8g==
X-Received: by 2002:a05:6000:4287:b0:3b7:7633:4e71 with SMTP id ffacd0b85a97d-3b794fecc7cmr5082530f8f.13.1753948941555;
        Thu, 31 Jul 2025 01:02:21 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c80sm1482291f8f.43.2025.07.31.01.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 01:02:21 -0700 (PDT)
Message-ID: <0fb442dc58bd36345b60f4bb8f6be73db74900ac.camel@redhat.com>
Subject: Re: [PATCH 2/5] rv/ltl: Support per-cpu monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 10:02:19 +0200
In-Reply-To: <da946aaf40a8d1a320dc62673013ceceef1c93b3.1753879295.git.namcao@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <da946aaf40a8d1a320dc62673013ceceef1c93b3.1753879295.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vQzvZKnFjRHH5Pit2Atg-twyZHIaNSZqgEdHVoFp5Hw_1753948942
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-30 at 14:45 +0200, Nam Cao wrote:
> Add support for per-cpu run-time verification linear temporal logic
> monitors. This is analogous to deterministic automaton per-cpu
> monitors.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>=20
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 4a6faddac614..f9e5fd044c45 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -177,6 +177,53 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
> =C2=A0#include <monitors/pagefault/pagefault_trace.h>
> =C2=A0#include <monitors/sleep/sleep_trace.h>
> =C2=A0// Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
> +
> +#ifdef CONFIG_LTL_MON_EVENTS_IMPLICIT
> +DECLARE_EVENT_CLASS(event_ltl_monitor,
> +
> +=09TP_PROTO(unsigned int cpu, char *states, char *atoms, char
> *next),
> +

You don't really need to follow to the ID/IMPLICIT convention here.

These LTL per-cpu monitors are, in fact, not implicit since they do
have an id (the CPU), implicit makes sense with the current
implementation of da_get_monitor that uses the current CPU (doesn't
have to stay that way, but there was no need to change so far).

If you don't want to get rid of the task's comm in the tracepoint (and
unify both with an integer id, like with DA), I'd suggest you use
different names like CONFIG_LTL_MON_EVENTS_TASK (in fact that doesn't
just have an ID) and CONFIG_LTL_MON_EVENTS_CPU (or even
CONFIG_LTL_MON_EVENTS_ID, for this it actually makes sense).

I'd prefer it as general as possible to ease new monitor types, but to
be real picky the LTLs per-task are not ID and the per-cpu are not
IMPLICIT.

The id field is what the rv userspace tool uses to differentiate
monitor types, by the way.


> +#endif /* CONFIG_LTL_MON_EVENTS_IMPLICIT */
> +
>  #endif /* CONFIG_LTL_MON_EVENTS_ID */

Also, I'm not sure if that was intended, but
CONFIG_LTL_MON_EVENTS_IMPLICIT gets compiled only with
CONFIG_LTL_MON_EVENTS_ID.

Thanks,
Gabriele

