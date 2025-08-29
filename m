Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2D11B87C0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756504145; cv=none; b=QVGhGFqVYq1984YJUl4MozN2et8QoJ1RTpGvZCB+RJ90bvewZrOPiEB9QvN+I0OG8SGKT0yhV0VVKUpq1QGsvwGyWWGlpGN7Rzwhb0wH+MV1Wlr3/pqVTK+Cj6EJqvVnVfg0lZ1b8VZ9RbY1IjFRua994giBkCdyAerZ8r+tlWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756504145; c=relaxed/simple;
	bh=GEhNHN676j2czLrWWfqvWUez2ldPUCQwOVU8o809qzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlTMlo1x0HoNNxx3tk1Rmq/hDCmC9QQHDBU/vAKf5pUwznOZJqZ8O6ohlCttOeRHo0Z6oOpQXXRHC0I6aidrUtGWMlld5AUh5nqVz9ITO/UKH22I3DAdX+JsZDFy8ZFbw23wO9Msxszt9G5pqUm7Ag9CZPvr4MJmn1SOhJQp86Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IhU3B0AK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhU3B0AK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756504141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eySXqmipCYOtmMzzhXrQZLUPIfTo/ESUkQYefrymAlg=;
	b=IhU3B0AK2k+66wmdpo1EaFEYrk/8x9kd31jcIH/90Qv3fHF+GZaw/AxoRd/oxWekY5HUS7
	xzVHXiumhxOA3LOlIZK+3R8RhNmrblDBaQBkyILJAVB74ImWMhPIA1K2Jaf8OlnQD8+Bda
	uxKkGDcBS/9mb/epVCrpsMWj6rux9QA=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-ruiCFsyyOzSxOpUH0YJKiA-1; Fri, 29 Aug 2025 17:47:46 -0400
X-MC-Unique: ruiCFsyyOzSxOpUH0YJKiA-1
X-Mimecast-MFC-AGG-ID: ruiCFsyyOzSxOpUH0YJKiA_1756504065
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3f31ac5bd9cso7884305ab.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756504065; x=1757108865;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eySXqmipCYOtmMzzhXrQZLUPIfTo/ESUkQYefrymAlg=;
        b=K3QgiAxaFagX/66+ic4/WI40dOqZciXROXsQjcv6v3cc2Jqv/H/uoet5sPXY4J9kP4
         0Wj9F3KqD8PDnNj7YYz+qQBx3ZtolM3tyP755mbD1eizhtOBDqK91HYt4F4X3oP/wM9R
         j9UWs7oa/3/mYc+fH3K0Py4R150EquzoMO03BLK+5tcMEFQPXz3g4oWVGMgddyeWLKcw
         fNpVY2Twr4uOvvAW/ae5GVLP3lDnJuxVExUKEoCJej+igehhTb4dyeXkg0ahyQBNgFiw
         NMLhJ0WFO+GGnTzTxgXXrEjg1fiO6GvY4nFpJCBPZsJSkyrjvm3eukAPFly95a3VuBrs
         uiPg==
X-Forwarded-Encrypted: i=1; AJvYcCUq0OYOrJXMPiOBZcLvmvUPC99XJuRD2ZVQOjlDFf4XrtCd1r+OBXjjKOYUSd09xiHpu1ArZEgXGtuvwK+sBu/Lcms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4ZXws6OUfFmEf3E2dgk7h2d2fjm/b9001RqrC4l/cIdbhtg6D
	AVt+7XoVjow7OP2KdWIINNLIMW6j3F8iuSwnFD8swohsoT/ocmtToz6P5iVxBu09qeb/j5NslzN
	v99qzm155zY7ZtHEz8T70VV1zirWJ/TOitOhJq3G4dEHcfq40dwz2S2+lXGXClGFQ5/7fiJqr6Q
	==
X-Gm-Gg: ASbGncukyYvJmG0il5/EitOj2kcVIq9/sBm322aXRD7RB3y7LMn/Nj9ujKNU+BGEyAe
	3wEALgxkbM46aCvkdDZB4MrGnKpREuSJpLMUhD5ZEL+/i7XzlYVCYWJj+2J15tcPJTbSv2eo0XF
	NHOcJliRhsYZywBwM4ygiiHmwm3goDoGgVznrtW1spSyvsFbxB3Ajr+mx2HrQ7aQkGe8wdA+flR
	fUiFbhuPQDAty3SsAcRw24Sx0mYk+bz6ApEGHjZphZRkqOjXd7XnQ8TPFkAXompU99GLtuKVdIh
	j2YKy8Rd4d0eyHF32k+YijYY9lJUrla2bwoP/+gxyJu5l7t3fRYz5UF6EkzvkxBKKqhd
X-Received: by 2002:a05:6e02:218e:b0:3f0:aa7:9f6d with SMTP id e9e14a558f8ab-3f4000978a7mr3881735ab.3.1756504065339;
        Fri, 29 Aug 2025 14:47:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHeILHX1FWLKQntsrY7/ViB9odWpQjSiYLD9GEdwqqeNNUR/DgwyYr/s4NyAkzWr0oCVnqug==
X-Received: by 2002:a05:6e02:218e:b0:3f0:aa7:9f6d with SMTP id e9e14a558f8ab-3f4000978a7mr3881435ab.3.1756504064994;
        Fri, 29 Aug 2025 14:47:44 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31c90dsm131522173.45.2025.08.29.14.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 14:47:44 -0700 (PDT)
Message-ID: <5073b47f6387a8e4b7a54fa4986213c891fafa81.camel@redhat.com>
Subject: Re: [PATCH 7/7] tools/rtla: Add remaining support for osnoise
 actions
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>, Jonathan Corbet <corbet@lwn.net>
Date: Fri, 29 Aug 2025 16:47:44 -0500
In-Reply-To: <CAP4=nvTFy6dZ1ab3ny_Yze2ttWjXXxiRKyUDcBzSc8qKcOHZVw@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
	 <20250821035719.137161-8-crwood@redhat.com>
	 <CAP4=nvTFy6dZ1ab3ny_Yze2ttWjXXxiRKyUDcBzSc8qKcOHZVw@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g1ispNIDC7fxNJ9Im8rB8gOOMAfn5dnrLYjhejHsmAA_1756504065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-28 at 12:57 +0200, Tomas Glozar wrote:
> =C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
> > diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Docu=
mentation/tools/rtla/common_osnoise_options.rst
> > index d73de2d58f5f..ba8e6674c220 100644
> > --- a/Documentation/tools/rtla/common_osnoise_options.rst
> > +++ b/Documentation/tools/rtla/common_osnoise_options.rst
> > @@ -1,3 +1,11 @@
> > +.. |threshold|  replace:: **-a/--auto**, **-s/--stop**, or **-S/--stop=
-total**
> > +.. |thresharg|  replace:: -s
> > +.. |tracer|     replace:: osnoise
> > +
> > +.. |actionsperf| replace::
> > +        For time-sensitive actions, it is recommended to run **rtla** =
with
> > +        RT priority.
> > +
>=20
> Unfortunately, real-time priority won't really help you in practice
> for overflow-to-action latency, since the detection whether tracing
> was stopped is only done once per second, when pulling the data. The
> message should be instead just (something like):
>=20
> "Due to implementational limitations,actions might be delayed up to
> one second after tracing is stopped."
>=20
> until either a trace event is implemented for stop tracing threshold
> overflow (proposed in [1]), or rtla-osnoise is moved to BPF sample
> collection, too.
>=20
> [1] https://lore.kernel.org/linux-trace-kernel/CAP4=3DnvQWCWAOefHAqA82-VD=
b-00_y1-0fPOPBEyETJ2Q1EWEwg@mail.gmail.com/

OK.  I'm glad there's at least something we can say there, since RST
didn't seem to like empty variables. :-P  Looks like the workaround is
to set it to a space character.

I was going to ask if it should reference param->sleep_time instead,
but it looks like that's not actually wired up to any config
parameter...

-Crystal

