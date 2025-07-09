Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9604B226D1D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068168; cv=none; b=emATRzF0aaW5qdWzjRZ3oR/3mgUlRfuManfQN0dLYS9qSZMV6LDzPmfzCKbuPcuOAUjV1O8MZW+H9DfyePmB64yVWQ3ovx5MDnmv0bb6DqQE+OhKdNRBhMfTL1qZp/UAYrroJntq83RG+TP9aqW0QWr4RVRT1z9DPVaiY0P4cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068168; c=relaxed/simple;
	bh=eqEtyyZVHwgeHDKi4pSEA0NHYMoZ+A867z2ivGKxh20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akhJ1LFnWHkZI+JUfBUGJqoDk4OZbn5kWAgCTWePbnR7xcb7mAC2OaWirb00ofiQbP5YFlEUw6Ukf3yia1D4wfqXLeEnlildg2VoHCAxbC5xgwllI5xPl3FPvGSpl6uEjsycwLY0K8xGq1dsdk5VLxlds39o/YSIzDaMwVeYOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMj4xhy3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMj4xhy3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752068164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqEtyyZVHwgeHDKi4pSEA0NHYMoZ+A867z2ivGKxh20=;
	b=MMj4xhy3r7H38Chff8Mu34lWVBCebcqcESMzUGa/i7V3qHJUD2OQdeik5eDO+yDdbbCJXn
	U/mFLJV6G9eStXTzCsGaQ9+pMZIR72m2R7JDo/V8+qwkZywZ6DWl5Tcv/a3tpmOJAzIf2F
	xcqPR4wAC9ODySkYhsgHTnc5qamxhzg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-xIEdp7LzPJKwNeHmm2GiWw-1; Wed, 09 Jul 2025 09:36:02 -0400
X-MC-Unique: xIEdp7LzPJKwNeHmm2GiWw-1
X-Mimecast-MFC-AGG-ID: xIEdp7LzPJKwNeHmm2GiWw_1752068162
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a9e1de6f5cso10672151cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:36:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752068162; x=1752672962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eqEtyyZVHwgeHDKi4pSEA0NHYMoZ+A867z2ivGKxh20=;
        b=bvzITE4Ibda9/qTrTdtgCJ3G/VuA7NkZWaXl4j09+cjEYZaNxIqPpjan1vlyYXhHck
         +43WX2jcYF+S3gf77ukdS12xHpVSBEygKT/vItVPuovYWnWZna4ppNYqNrQXc1pZAsF7
         EY0hUgelut/exS2SdkkO0Vxu44uLEIHghgHh7xmZpH7XIIdkESIaiLiCv4cvfnx3UYqM
         TJFGplSFu+IGh+CVUliViVbQOEx/MrhyXaYNeQ2SYJxLb5Hec9tbRqaap6dlaKRjticY
         dUNI+svEdQLGGGz5taiyMmxaCZyQGzR0ApdB6/AGq3PoIzwRAGzck+OeCMFE2PVLpSsH
         og2w==
X-Forwarded-Encrypted: i=1; AJvYcCX/7L5aSGosYUuNj5JEPNRpn+ARPUgievfPzQSPgos7+wqlgnfiQGfA8tPAsm6Kq34xBsXLWHQi9XvDhDDAdE6Qg1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfukWgnkT6GBbfHDlVfL//z/42lbFnpuxiAvP9oHAxNgZdXRF
	ksGppFXQqFnWLOJWxKz/6kViqp+sNYBgn16IN2LucGfGzZex+Nq3las49zvvbFDCuYgQX+L8ekY
	oEpq4lxkT0i2Cek7BQyjPzvlGCC0pa+anO4u8/O/rH9Yobg2CSxi9XG909R7twVRa9CfQ659pz6
	XPcVVgMcKOnP4zjv4lBnCbCLXqt0TFT+wsPjnAF1szx0ZC7j/P
X-Gm-Gg: ASbGncvS9dMwHBADstdJxz3d9mkE5oDRqIUUXAleePg/BuOxxBK2RVzFoHwwhw1lUl+
	sYL4QNrPN33aLoLrOuHFLY5d02aaW9e7hJ5v9Ky+3cy6ts4YojcH3SJP0ENwPKNSt2UaGCQF9L0
	TxdUTv06ZvYqKpTVLcZHzrIdK7pMrQyavxUD4=
X-Received: by 2002:ac8:7f09:0:b0:4a9:93f0:e228 with SMTP id d75a77b69052e-4a9dec29279mr34551801cf.1.1752068161591;
        Wed, 09 Jul 2025 06:36:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYc5vsGllycl+RXMiSuYfzk8U7dnfUY+sNJIFkjl/O4iokoCHvRs0OAlE8JVinxjj5VrbetYBd4QXqaj0LYBo=
X-Received: by 2002:ac8:7f09:0:b0:4a9:93f0:e228 with SMTP id
 d75a77b69052e-4a9dec29279mr34551371cf.1.1752068161026; Wed, 09 Jul 2025
 06:36:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620085618.4489-1-gpaoloni@redhat.com> <20250701195939.3e297e20@gandalf.local.home>
 <20250709100626.fc0611eb6801b7a8dad9164f@kernel.org> <20250708212539.054a7d5b@batman.local.home>
In-Reply-To: <20250708212539.054a7d5b@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 9 Jul 2025 15:35:50 +0200
X-Gm-Features: Ac12FXx5NWw9UHzx8YL3iucBA2PdBGf-Feo4aqU3LLlrumvb9g_yTwBvoL9WwGA
Message-ID: <CA+wEVJab6Gwkd7q58=v8uVhfmKpwNRAqtK67f15JtZcKSB_ziA@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IkwVUkqsEdjmndFKUJW87nnmTaEY1fA3qlssXQtR0hk_1752068162
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[resending as my previous reply had HTML stuff and was rejected]
Apologies for duplicates

On Wed, Jul 9, 2025 at 3:25=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 9 Jul 2025 10:06:26 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > On Tue, 1 Jul 2025 19:59:39 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > > > + * __ftrace_event_enable_disable - enable or disable a trace event
> > > > + * @file: trace event file associated with the event.
> > > > + * @enable: 0 or 1 respectively to disable/enable the event (any o=
ther value is
> > > > + * invalid).
> > >
> > > Saying 0 or 1 should assume that those are the only values. Don't nee=
d the
> > > content in the parenthesis.
> >
> > BTW, it should be "0 or !0"? (or we should make it boolean)
> > This description means if it is "2", that is undefined.
>
> Hmm, now here's an interesting point. So this is to define requirements
> of a function based on what the function is doing. But does the
> function have to have strict requirements?

IMO one of the main goals for these requirements is testability.
In order to have testable requirements we should state what the
valid input values are. In this case:
0 -> disable, 1 -> enable, everything else -> Error.

Now checking the code again it seems that the switch statement
is missing a default "ret =3D -EINVAL" (or else it should be changed
to boolean, but I guess it would have a wider impact on the rest
of the code...).

>
> If it can handle "0" or "!0" does that mean that's how it will be
> defined? Or can it just state "0" or "1" and yes "2" is UB. That is,
> it's not part of the requirements but if someone passes in 2, it could
> act as a 1 as it's UB and implementation defined. Not a requirement.

Right now if 2 is passed the function would silently return success,
but do we have a use case for this? I am trying to understand
where the implementation defined behavior would be....

Thanks
Gab

>
> -- Steve
>

