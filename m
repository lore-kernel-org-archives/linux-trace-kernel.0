Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07F320CC9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 14:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764080437; cv=none; b=apRiEVKZxivU0Kz1xoUdQwcvaYK4fE5DwIN3unny6FCB1QiMpkehK0wEc/8b9Yh1UTeBNkzAXgvJl0wbBHVoN8Sb55j7rQZmHd9nZzcLBAusXSx3e0hMm7DLoQs1zqTBnQQ/8+LaeKL30tRTC5x4f2usRY4PlePjqjRQZmSkVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764080437; c=relaxed/simple;
	bh=FVWgm6IR64KdZqW5wn34sRh+Agl3EA0xjeErXlSlH8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LYClk8e61UTqg0Bdv9e3NRWbnfmj7RmFPIo0mAlHxv6ggTCD6qCMfmcFIGkTC2XIIvPPhKbzAqL0EgZXPw2H15glS3uoXnh4oK4W+f8LiP/AggSYINfa1e63O5RoL7DGiTO2aETvGyCClJTrSvBoI+EWlbCIRLtQJU4voZ2m+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WJcMBBtt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJcMBBtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764080435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YuFgUmjsDWh/qL+V41JU00YVr6Y4jXOaLXN3q6tAOfs=;
	b=WJcMBBtt2NDZUDBcTlZEqhs1ylGR2s57mH/FbYaTX3OixZv92j0k7tnQVtR3wGCBz6jFBx
	178AtvzvO1jCaAWQrG5Y+DuIkufrVXo4rbXsCOyi7dnRFq/PJmLuqLpxGThssYAT2qTWf5
	I8kb1ycEXy+WXEf+7NIGopONGWB9sjo=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-kK82oeoiP1iU1T8ShLyH6g-1; Tue, 25 Nov 2025 09:20:32 -0500
X-MC-Unique: kK82oeoiP1iU1T8ShLyH6g-1
X-Mimecast-MFC-AGG-ID: kK82oeoiP1iU1T8ShLyH6g_1764080431
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5943ca95853so4720486e87.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 06:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764080431; x=1764685231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YuFgUmjsDWh/qL+V41JU00YVr6Y4jXOaLXN3q6tAOfs=;
        b=dA1KoRRfrk5EOPoOoEOi4nLpdYKuwAacEYq3qZ/atMBDnNRDajiSnPTJi5qCJdA3cD
         YaXWX3ByzT1BOgeK/HqFiTGYjhHu/ohpMfPaLB0nXQ8MC9YqtOPVnEduu0iFhTYqVuJd
         dH89BjvCnhjovN6doqahq6LH1afcNa94vP7vDm8/TZk6AFGlcGh4On++M+vYfUyiyrUJ
         7GRapZnb3dB0vDWy0bFB3C1kO5hIpRnoLigAP+KLu5v4Ge7OoPpG1/t0T6V2MkmtFdGw
         g+8n8Juu0ahEGUTLcU+6VxbPxtEcH1lWWs5jcWBdF9w3gzkxI0y7C3P89I7frBLct8pa
         T3PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUY/e8VUG5UvthOQOc1hDXIuyCXmrZEgCMFN2JUlySAYcHYRbL0pjwkgnCu+4plcXSdqRdQ8KSiPdLIZIuXGIA3OsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWwlYXAmm66kE6dCSpFxdYqWmzkGHNOY3eyh89mtrqGwtgLye
	r2f+bK1Pdb9RaZg5ojVKtDXUKXwm/DUluQpjIBqJS4u3zm+BGt208ifevXndxmqyXPLw3z4tS+R
	zbHsr8RXCvWVupS1QgJSAIKzTbu9FUCeA9k+Btc5aL71w9K9uoAie9FKANPFhqTyONBv85Xj9+X
	b2dbNtTc+3OuD7FbZ9c1HsCP1lsquIRSRgjPbd2hoJNr/LIgyT
X-Gm-Gg: ASbGncsvFcS4T9cNKk7MvMDuySSVs8NRlhy0TEIuV7RHRtV/j4DU9IdveWj3rWTcFOP
	A0VTe6j059fW/PCRi++ORnWQ3AdiTS32wE1vPZW7fDRQaJhFgdKC0poBbLPVkDeh78HHWcYI4Qt
	4NEt+7jZys8wsPCuy4ze9PJE1r/04VtdUAr4XRHISLkuV31B5ZilZBwAj17yeA335TIA==
X-Received: by 2002:a05:6512:158f:b0:595:840c:cdd0 with SMTP id 2adb3069b0e04-596a3ea6320mr5165593e87.2.1764080431281;
        Tue, 25 Nov 2025 06:20:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK7mkjTE8tfDwtcmLLKnCvTrS/LKgN9IW6L4nU8sopNQNGJ5FyT1zqAip/JpWy9Us5ih/Twipu9As0QwWcY3k=
X-Received: by 2002:a05:6512:158f:b0:595:840c:cdd0 with SMTP id
 2adb3069b0e04-596a3ea6320mr5165586e87.2.1764080430839; Tue, 25 Nov 2025
 06:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117184409.42831-1-wander@redhat.com> <20251117184409.42831-8-wander@redhat.com>
 <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
In-Reply-To: <fb5b468b38ac9570a5f3fb948452d1b5b03c9f9c.camel@redhat.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Tue, 25 Nov 2025 11:20:19 -0300
X-Gm-Features: AWmQ_bmz7MJciJqDQz8Mppekett5WnLxv9QLQUUdHlfTABxmQ5nou0kEG_PqHmM
Message-ID: <CAAq0SUn=eK+9YZZhdL_bs0S2cfVMhuuV-v8DSRMkTOqoL=SEWA@mail.gmail.com>
Subject: Re: [rtla 07/13] rtla: Introduce timerlat_restart() helper
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, John Kacur <jkacur@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Galw1YIL3Pdm3gYlBxZRttLaamNf--gEVSaWKz-MunQ_1764080431
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 9:46=E2=80=AFPM Crystal Wood <crwood@redhat.com> wr=
ote:
>
> On Mon, 2025-11-17 at 15:41 -0300, Wander Lairson Costa wrote:
>
> > +enum restart_result
> > +timerlat_restart(const struct osnoise_tool *tool, struct timerlat_para=
ms *params)
> > +{
> > +     actions_perform(&params->common.threshold_actions);
> > +
> > +     if (!params->common.threshold_actions.continue_flag)
> > +             /* continue flag not set, break */
> > +             return RESTART_STOP;
> > +
> > +     /* continue action reached, re-enable tracing */
> > +     if (tool->record && trace_instance_start(&tool->record->trace))
> > +             goto err;
> > +     if (tool->aa && trace_instance_start(&tool->aa->trace))
> > +             goto err;
> > +     return RESTART_OK;
> > +
> > +err:
> > +     err_msg("Error restarting trace\n");
> > +     return RESTART_ERROR;
> > +}
>
> The non-BPF functions in common.c have the same logic and should also
> call this.  This isn't timerlat-specific.
>

I will replace them here, thanks.

>
> > diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtl=
a/src/timerlat_hist.c
> > index 09a3da3f58630..f14fc56c5b4a5 100644
> > --- a/tools/tracing/rtla/src/timerlat_hist.c
> > +++ b/tools/tracing/rtla/src/timerlat_hist.c
> > @@ -1165,18 +1165,19 @@ static int timerlat_hist_bpf_main_loop(struct o=
snoise_tool *tool)
> >
> >               if (!stop_tracing) {
> >                       /* Threshold overflow, perform actions on thresho=
ld */
> > -                     actions_perform(&params->common.threshold_actions=
);
> > +                     enum restart_result result;
> >
> > -                     if (!params->common.threshold_actions.continue_fl=
ag)
> > -                             /* continue flag not set, break */
> > +                     result =3D timerlat_restart(tool, params);
> > +                     if (result =3D=3D RESTART_STOP)
> >                               break;
> >
> > -                     /* continue action reached, re-enable tracing */
> > -                     if (tool->record)
> > -                             trace_instance_start(&tool->record->trace=
);
> > -                     if (tool->aa)
> > -                             trace_instance_start(&tool->aa->trace);
> > -                     timerlat_bpf_restart_tracing();
> > +                     if (result =3D=3D RESTART_ERROR)
> > +                             return -1;
>
> Does it matter that we're not detaching on an error here?  Is this
> something that gets cleaned up automatically (and if so, why do we ever
> need to do it explicitly)?
>

On process exit, it does.

> > +
> > +                     if (timerlat_bpf_restart_tracing()) {
> > +                             err_msg("Error restarting BPF trace\n");
> > +                             return -1;
> > +                     }
>
> [insert rant about not being able to use exceptions in userspace code in
> the year 2025]
>

I actually find exceptions an anti-pattern. Modern languages like Zig,
Go and Rust came back to error returning.

> -Crystal
>

