Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870591DB122
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 21:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756503302; cv=none; b=pQpGcqk0QHStpMSWAtQtHnuXPogqwxRehE1w7WafKnHZCkd/U5U6OndMDoqJU4hSarYYhM/Vko3y4SNgC2XsUz/EJ6S2fxG77b3AiyUPBXMZKP3uakvqcow0TfFccIEZqpFBfuUhR5I5YsTF1j8PYGYngh104Nme277jLoa7xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756503302; c=relaxed/simple;
	bh=AubJXeCmzn8brBp2b0/mkarosshOuK7KphL2BAqRYSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK1flrDjoua+nBLSIWo4lSaKiLmAIsaKgL+RqRulUWEfK53dJGGPMi0ZWX2wRjMJa7OU0m79I0+DBb8SaGKn5P/TSPrzqYHnv51+hwP7j1QTqJ9pL3oX1aZ8AR9w4FGqIrbpqjV+HLrSuJAHz3E+1fH1taUhrkz0cBQChsDmnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A61bpMuc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A61bpMuc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756503299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T9qTq3ysDGu1yq9wy5VtiyZ/Yo8tO3oxAZ43iPoiSiY=;
	b=A61bpMuc7MC3wxEy4xN1bTAHbkxoMQgTaGsmhZUKAag5bXwHtBVZcj40fmOknx6y/t+STV
	Gg+EDikelN7e1a+xPSkkylsVlN1Wc5fkFetyDeO9IhnJeDcMfvspA/gaHD443O4l7Gl4A1
	bA0KVshgOXLg2SxhuReGSvlZGMdGh/8=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-jl_HaicUPEu78IaLe39Q1g-1; Fri, 29 Aug 2025 17:34:58 -0400
X-MC-Unique: jl_HaicUPEu78IaLe39Q1g-1
X-Mimecast-MFC-AGG-ID: jl_HaicUPEu78IaLe39Q1g_1756503297
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3eea931c037so64626295ab.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 14:34:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756503297; x=1757108097;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9qTq3ysDGu1yq9wy5VtiyZ/Yo8tO3oxAZ43iPoiSiY=;
        b=pXoqJsGjOVxQQQ3TNEWDZA6KFm550c3PjjC0sb+PaXATFK07Dn2xA87FEj7TYsKhi4
         eZu6UIRcXBTZFQca9VuQdgq4s4tj9R+srE3W7xxAfhS+rQKCyJqtqZDu5ZI7wbGAFD9b
         eJSV+ZZGe8L4hog1LqpxVvBTFkec9E+bCFv4ZhBd9kI43rDWFcJPf4p/2u1VMLcEpM8+
         1LStkpR4kLWsm2S1LMEmm+G48lVNCQ6iRJ4gPZJ7tjfFQI+mmzgKwRHYH2GmCINhw4jX
         34BTZnaXgn01tvlZ1OZRk9yuh5tGqeVKIrjL8WxehjH9xaZ9Ap5ZD5m1UdLIg4NNc4lv
         4thA==
X-Forwarded-Encrypted: i=1; AJvYcCUhhwYtKjPm2ogtzga9ijBAyX8y7JNiOGi7yUzAjO93fqdWw6av8M1Tos7Yyp79BjBQUkwStgOeIhfOUs7JRxMGtKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8ZAOq2E6ufKbYQdJ0jWhHF3Kw9ciJeX/NSBEwVZqsu26gXTG
	gxyslYOhNG2Nz4dq9sDHVfNGUjY1faG0W1R4YnvrFLoPDRTRdX3P4cePRgqCROPOrUgf//aWSaM
	50wpIIkBUWZaF0sfUXOSq6hGi+sg/txmWYy+n/zB/DQBGeJs6oNY1lT4nZu962NVYzUG/8OedIQ
	==
X-Gm-Gg: ASbGncs7v4P8ALo7C70tBUQ1FZOuSqb72U2ft0c7MG6m853Kj9lM6aXSktZ4gwI9cMX
	9NpCMYGYeVnp6R6HfGFEwFwLOY8Zxr78OwL22U0IBd5YOQ5WPGPax/w9PoMos7c+He9WnUNdBuL
	AV3OO0TahBPUH8AUP36/QCE++Lc5mIfyBZ5chQIVsveZxjP7oKpZMo+4BnlA0yM0ULZBw37Ojth
	t2RK7btRAeYKFA8u1hzwTxcysh+d0GKQ9A8nocHw8cpIGuL1FaboSIqC4Q44htVU413WlYh60IK
	ZbimAm/vsyTun9ImiaUqD0/9OKT3g1Bh0K5drzypxPP824cKzjTZYto68LHaU85TOLIc
X-Received: by 2002:a05:6e02:1748:b0:3ef:ae37:528c with SMTP id e9e14a558f8ab-3f401be6e48mr2287335ab.17.1756503297392;
        Fri, 29 Aug 2025 14:34:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH49VRGRTHmtROYZ2LiGXYlp0E4DXhSjD1JxD/CyMNMNppnyIFRhFexl8dJuwvHPEflZOYLQQ==
X-Received: by 2002:a05:6e02:1748:b0:3ef:ae37:528c with SMTP id e9e14a558f8ab-3f401be6e48mr2287055ab.17.1756503297038;
        Fri, 29 Aug 2025 14:34:57 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3f3e136cd19sm1295225ab.48.2025.08.29.14.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 14:34:56 -0700 (PDT)
Message-ID: <d11da952ca2ef28e3427fd09972cc02e727606f3.camel@redhat.com>
Subject: Re: [PATCH 6/7] tools/rtla: Add test engine support for unexpected
 output
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org,  John Kacur <jkacur@redhat.com>, Costa
 Shulyupin <costa.shul@redhat.com>
Date: Fri, 29 Aug 2025 16:34:56 -0500
In-Reply-To: <CAP4=nvQthvoE9tGPqbXmk3dP_XJjmgkh_wXDd9JiVTTGvM3nKQ@mail.gmail.com>
References: <20250821035719.137161-1-crwood@redhat.com>
		 <20250821035719.137161-7-crwood@redhat.com>
		 <CAP4=nvQthvoE9tGPqbXmk3dP_XJjmgkh_wXDd9JiVTTGvM3nKQ@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lcKSkOlsvhOHRy2PPt6HhgaWwwJWFmy5Mnz6baLXZrw_1756503297
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-28 at 10:09 +0200, Tomas Glozar wrote:
> =C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.co=
m> napsal:
> >=20
> > Simplify the code so that we can print failures as they happen rather
> > than trying to figure out what went wrong after printing "not ok".  Thi=
s
> > also means that "not ok" gets printed after the info rather than before=
,
> > which seems more intuitive anyway.
> >=20
>=20
> This change is causing some formatting issues, e.g.:
>=20
> tests/hwnoise.t ... 2/6 # Output match failed: "rtla hit stop tracing"
> # Error iterating on events
> # Oops, error disabling tracer
> #
> # exit code 1
> tests/hwnoise.t ... 3/6 not ok 3 - set the automatic trace mode
>=20
> (the comment is on the same line as the previous test)

I'm not seeing the "tests/hwnoise.t ... 2/6" part.  What is printing
that?

> Furthermore, it's standard to first print "not ok" and then the
> comments, see the documentation to Test::More [1], so I think we
> should keep that.
>=20
> [1] https://metacpan.org/pod/Test::More#ok

https://xkcd.com/927/ :-P

I'm not a Perler, so I didn't recognize it as anything standardized.=20
Still seems backwards to me, both in terms of making it easier to see
which test failed, and in terms of being a pain to implement.  And we
don't even get the benefit of seeing the test name printed before it
runs, to make it easier to see what's taking a long time.

Seems like Linux uses a variant of this, though:
Documentation/dev-tools/ktap.rst

I'll fix it, hopefully by sticking the error output into a variable or
something rather than duplicating logic.  Or should we be using some
existing test infrastructure?

-Crystal

