Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD82DAFBB
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072603; cv=none; b=aXIIKeDR8LqZs59OLK5nQjUcKSUEtOQ07yXQxti5VSVCPMt1Q7JNFuW33PxUCXrvNNGZbFyWMy7f1dXOfNJ4nhf5bn4n9/L05tQhpbMPzkxyWSbPGB/nISY9LHhs69gR92iUBIvo+r1wiOoBSJQ1PNZPNAkMJN40gEAqeuyVBw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072603; c=relaxed/simple;
	bh=CDfig1Vs2OYQIKyFkHBQNLu5l47DCuM6T3Xm86P9MZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TQ0AsL5psQFZyuph5RY4Fp/m74osk+ipGqu/r5hhMR8vQAftG09yYzJUEyEkX9kymmpPNZleerX3hCzBT29n5ZnX5VMr7S6Zpl1OBBZflu6HDjv/An9LIv75ixNXAGgro84TvIHB+G+Bt/EJxXe+UACVX5RL2JxnavPPqpqkqO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aKkDCiv8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aKkDCiv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752072597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CDfig1Vs2OYQIKyFkHBQNLu5l47DCuM6T3Xm86P9MZk=;
	b=aKkDCiv8fKOJlyQsheaYPunhyTSZIdIAbexyGi+SHuake6PgbRVe0VzCFiQONPIdG1nnF1
	AqYvOR233JWydHEGlFf+s36UYRgPTvuk6vOd3dJbstSTkkyg5PxY3NQ5qCx7VqbTWEYDSq
	TKxvmIaChKJSnwOvdUmgjviV6BvYNOU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-Cp947r_AP_uCyV1nvmL0ew-1; Wed, 09 Jul 2025 10:49:51 -0400
X-MC-Unique: Cp947r_AP_uCyV1nvmL0ew-1
X-Mimecast-MFC-AGG-ID: Cp947r_AP_uCyV1nvmL0ew_1752072591
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4a7bba869dbso130073311cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752072591; x=1752677391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDfig1Vs2OYQIKyFkHBQNLu5l47DCuM6T3Xm86P9MZk=;
        b=g7D591cCv0CGyl7KDD37vI4To5bwxKLcFZVew0wS1RMOn4u+uRmgAyo3FOxd2HePzn
         OQah2V+3cw3/eRFC18LW8P9kXzZXSnp3FRsOm9MnNwbJncZ9gt1GDvh21uBeHmAI8ty5
         4WkcdlmjplvaRcr2KMLhaL5ZTiEvJlDUoHVFrTyHrJLz/3wE6wM2bJMtzMGs222Q9/Sq
         mnTb/LBMsWCZOgwd/tzNbOMikyE/vkOlptZccXruzbObgi8/t3gjcYm4w+3wL09oeFJX
         fNKCkGG/UYrw7BHx+PR3/bxIF2oUJFBNVBTPeQWuOmfkcstv4OPphJxJkQwYZzKn2wOF
         ROwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjW29tr+XIOAcsOxA2R7Pmnaca8XM450TZtfpWl1qd9oR9jU+K4ar7fKY4sud81qKo9kTKcn90PZGwJBOAEyYpdac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4bDbpiXyZD3wtX4zUbknlyrCSxtf8MwswaJofEmLkCPHQomQf
	eZpN8vJkv8RVEi6ph9IlaaslW8YCvPF/OJG123aDwX8WAntBwujBWJ18RW+SFCQz01I0dW3FrQ9
	Sz8bJiFY0a/xnqHE+aUS/ZEl0FvN+VQ0BsDadBGVElB6+TuQL8njIV02qhDTdqXXUHKsYjI0RrD
	hysWUhy2v7uZwyUDdNaweOV0BQivFGICWQH8s/Vv/qPyMABEol
X-Gm-Gg: ASbGnct68S1UjtwPnGL1fOUks+jxGHVHjo2uf99UAadmejB7kEtooQsvkWDRlRZ/QGq
	NOkSUSiOI06/YXb+qqsb9yrocDYdA/9BJsFvh54i7U91h3IYGJXwzxqrz55MJX7fDPvFBZz1pIq
	On2hPgIuNpiGniDh52jAUTAAdNjGSva57o5pk=
X-Received: by 2002:a05:622a:1101:b0:4a4:3b2f:cc30 with SMTP id d75a77b69052e-4a9e92faca6mr100431cf.11.1752072590696;
        Wed, 09 Jul 2025 07:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxoTgrN0uV1FyvH78vCowCYgJSBaifp6bq9xohfH2baiCbJ0gY3aYvPlS/LGW5BiAxJqrcqI4sySU3oZpk/04=
X-Received: by 2002:a05:622a:1101:b0:4a4:3b2f:cc30 with SMTP id
 d75a77b69052e-4a9e92faca6mr100031cf.11.1752072590350; Wed, 09 Jul 2025
 07:49:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620085618.4489-1-gpaoloni@redhat.com> <20250701195939.3e297e20@gandalf.local.home>
 <20250709100626.fc0611eb6801b7a8dad9164f@kernel.org> <20250708212539.054a7d5b@batman.local.home>
 <CA+wEVJab6Gwkd7q58=v8uVhfmKpwNRAqtK67f15JtZcKSB_ziA@mail.gmail.com> <20250709101216.5949e86f@batman.local.home>
In-Reply-To: <20250709101216.5949e86f@batman.local.home>
From: Gabriele Paoloni <gpaoloni@redhat.com>
Date: Wed, 9 Jul 2025 16:49:39 +0200
X-Gm-Features: Ac12FXwwCZqMDFTyYYFREweJbRjIa_PWtDKIGBqGPHwVX_GVTlz4BsfGHZMs6Qk
Message-ID: <CA+wEVJZRFGW-8-FT9qJJcaWZ7So+tFeAdyupoOMG4ev_8Cpqdw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qUGBGzmuLU0fLW2UA0yIBsypdLuneq6D0VmSh27uwA0_1752072591
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 4:12=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Wed, 9 Jul 2025 15:35:50 +0200
> Gabriele Paoloni <gpaoloni@redhat.com> wrote:
>
> > > Hmm, now here's an interesting point. So this is to define requiremen=
ts
> > > of a function based on what the function is doing. But does the
> > > function have to have strict requirements?
> >
> > IMO one of the main goals for these requirements is testability.
> > In order to have testable requirements we should state what the
> > valid input values are. In this case:
> > 0 -> disable, 1 -> enable, everything else -> Error.
> >
> > Now checking the code again it seems that the switch statement
> > is missing a default "ret =3D -EINVAL" (or else it should be changed
> > to boolean, but I guess it would have a wider impact on the rest
> > of the code...).
>
> Well, it's mostly used internally and the only places that call it uses
> 0 or 1, so there's never been any issue.
>
> >
> > >
> > > If it can handle "0" or "!0" does that mean that's how it will be
> > > defined? Or can it just state "0" or "1" and yes "2" is UB. That is,
> > > it's not part of the requirements but if someone passes in 2, it coul=
d
> > > act as a 1 as it's UB and implementation defined. Not a requirement.
> >
> > Right now if 2 is passed the function would silently return success,
> > but do we have a use case for this? I am trying to understand
> > where the implementation defined behavior would be....
>
> The issue is that all the callers pass in the proper value, and that
> can be easily verified, but by adding the "anything else ERROR", it
> would require adding more code that is not needed.
>
> I rather just switch that and soft_disable into a boolean than to add
> superficial error checks.

Many thanks for the explanation. Please consider that, from a requirement
point of view, it is also perfectly fine to document the assumption of use =
that
no other values than 0 or 1 shall be passed by the caller (so the bool rewo=
rk
can be avoided eventually).

Gab

>
>
> -- Steve
>

