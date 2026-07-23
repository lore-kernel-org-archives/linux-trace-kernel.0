Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43BE470443
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806339; cv=none; b=NccfsuhcfkmZ3yA5HcmPwrUOuRCqvGqmvFG8cisCh8yIHmYHd+xxQICPzoLb71wdmcqhsDaHEt0pAqmVWA4kmtXQhYu6LxMkW4oxlIefwQJbp8yWz8qi5lNoQp82AkXgqDpZivxwBm223XaRyX+f5arocDzKYQZznyb5R5Gteps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806339; c=relaxed/simple;
	bh=sJXlTZvstAW1479buWcLoZGwe/+RfOs/HTWSTm4W9Gg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlIASHxDOBHal2JF4d4yrZtMMuG7YvkQasykMln2WWiS/HVLrIUW7T/jfbgglirUBDepVqLGt7g0ey8qPkHtJrcVIt4+kwqSFtzGVf6R8eqHhk3p7ReyDxAOPa2xzy7ZC1v9LAS6ACA8DjvC0/QaNqK043w5HhHBHSz1y7JWtqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOlRqVIe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOlRqVIe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784806336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EMbR4DpbySItxfobMDkhC4TUtP0c34aNYffE3EcNSgo=;
	b=VOlRqVIeHQb80utcAz2Rx+Xoy1hYf5T6rWSgq/93+yFCvIbnRzaEWlOuWe+fmP5WJIy7Vv
	Po1Lhl3bLt5oMIHugXFIBPqcXXAli6/J3EzD4K1nJInNkm6owAfLoRw3uNtTnGNzh+DEip
	duxP0TfiW8NBbNY1N56E3lniPh8uklQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-gAovBtdUNs2DutYWrL4z5A-1; Thu, 23 Jul 2026 07:32:15 -0400
X-MC-Unique: gAovBtdUNs2DutYWrL4z5A-1
X-Mimecast-MFC-AGG-ID: gAovBtdUNs2DutYWrL4z5A_1784806335
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c15eb4015e7so68805166b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 04:32:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784806334; x=1785411134;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EMbR4DpbySItxfobMDkhC4TUtP0c34aNYffE3EcNSgo=;
        b=b9tMGr7LCHjwaTPZPUez/RcT4EKSQMxxru1MLbih1ae4MTgq/i7HKvqu1bJuBsRGhe
         A4ikSIuSyqKszzOszlhD8u1OYAMCKslXahqHyUZIg1skPRIYDUoEPcoYem6O/CGCqfC+
         ERff0r1hdxxTqOs8buaVT/1VIklLMExEwtOi11gmbOPTU0LTubG+A8ak1Dbm/1Wg2NCj
         cyyv+MlUZDMgmBa5OW60ivI0KyAyOW5Nr9BV1UaY4jo9AjGGV+C0L2k/DS0ioY6du0Yk
         ElU4/svqhZC9b6Kf1iEfQCMbP0FaMI6t1/LfWVStk6I5WGq1nKE1nHgvz1OkJTmMCvTt
         pQ+g==
X-Forwarded-Encrypted: i=1; AHgh+RqoNpiAH2LBAu0D/i1uiI2QJWXPu+XtFxuutJpnl6lQtYLk4OlEaGJ/F/yxjhPIIUPV6SRtjhKSZ47n+8qMgaZyX6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACyo+Jc22FuPRdUPPDeqdmd9sOJkUHIMy4cJZIB+ESqDv8unE
	TsEkM9Xb9ZAuW03ytSsompjQcBQ0D4ce682B+5BxyXRXzMEDC/+eEzH2Pn6YjW67K/jRfKGHPb9
	73ozIlZzpP79DbqA8I72FpD4XNFgPDVjG1mb10L8/kQNe24RCqoEpMNlphmFGfwTA5mrzn8B1I0
	ebBVqWpBU8Jvtc+yBRP+zcMYCzE4kkI5X/jHxrhyS3f3dnv5u0
X-Gm-Gg: AR+sD11QRTPaQX1+IKwFyZUVW2avtHWuMNbKc03qaleLA+q4h7BLCUsKYqnUW+9xiNJ
	RCrEGh9Yz2IwsC40pDUWGEGZg8ozN4tVdI9tChn3EgGhfMzu2jTzSRNHdjEAWFSCkXv7Euo7Ozr
	shGfdfFcQkrGWkVMXL0J6Qf11/41OlTp3/mfp5UKCCEGGBAREuJMgn3AX+
X-Received: by 2002:a05:6938:a087:10b0:c16:5e73:b3e3 with SMTP id a640c23a62f3a-c1c508d2345mr78003766b.7.1784806334260;
        Thu, 23 Jul 2026 04:32:14 -0700 (PDT)
X-Received: by 2002:a05:6938:a087:10b0:c16:5e73:b3e3 with SMTP id
 a640c23a62f3a-c1c508d2345mr78001666b.7.1784806333828; Thu, 23 Jul 2026
 04:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715154553.2020891-1-vschneid@redhat.com> <20260715154553.2020891-3-vschneid@redhat.com>
In-Reply-To: <20260715154553.2020891-3-vschneid@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 23 Jul 2026 13:32:01 +0200
X-Gm-Features: AUfX_myzcjjfBZCYa3unvoWYCcxcxF1cuWrvX1gwj5Ii3MnxumJhV3ksGb8TZkk
Message-ID: <CAP4=nvRHyJr9vTm0oJe5Pp_nSa25De_zLB3P3hvUpofaKeVZrA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] rtla/osnoise: Record IPI count in osnoise top
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L7Jze3dfFJJBKf0QFbKZMpBAwGHHbuag2Tg5XOFahhQ_1784806335
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 15. 7. 2026 v 17:46 odes=C3=ADlatel Valentin Schneider
<vschneid@redhat.com> napsal:
>
> Leverage the ipi_send_cpu and ipi_send_cpumask trace events to record the
> count of IPIs sent to monitored CPUs. These interferences are already
> accounted by the IRQ count, but this split gives a better overall picture=
.
>
> This uses the newly added -i cmdline option.
>

This is now named --irq, right?

> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 116 ++++++++++++++++++++++++++-
>  1 file changed, 115 insertions(+), 1 deletion(-)
>
> [truncated]

Tomas

