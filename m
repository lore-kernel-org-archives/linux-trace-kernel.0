Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CB935BDDC
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Mar 2026 15:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639530; cv=none; b=A5zfERnbWwOAgYCz2VrDB5SxW0t6ADEZAKyiDb+vkXfR0M5nzCqPJxhs6c5WnjbXYEqUM3/o9mjLpCuQ+dgcYpA+DttFhzG5XhN/vc9WuHVWwreJNSGguImKugCTxUmiH8XmWg62TePte+q5jgHd4Wt3bKj7kUl13twMmgnEmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639530; c=relaxed/simple;
	bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZeomKVwoD+K9IW0EBLAurrsMidJrmvmMA78oOwESL3Q8gExsTblDWX0nzudV3Gg7F++80Vf4qjjev2Pli5KHDcrlPXf56iCXAQwzDqnCOhhlsI5orpI0CN0QoBHitWYZzbvl3nMOn+ei9kaZwFNITmM63irWXm258u1Nx2nbkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iwpvJLnB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iwpvJLnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772639529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
	b=iwpvJLnBsnKMGSk1rKeabFpPVE7Bqf2n5lxmMQY88hVrgOzkEfuVq5C1ZiNWUUQITC5DHq
	4iP1W8fEn7pitW93wwgBWakKEJjb4s3ZLrXCk01ktjrcn/Ii9+Tb4T9IkwJ8S0tmUcZ9NI
	/K8gsv2L75MSltBM7Lmk7Iu6/i/vwfg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-3NH0niXJP1ylrwZtwgMYIA-1; Wed, 04 Mar 2026 10:52:06 -0500
X-MC-Unique: 3NH0niXJP1ylrwZtwgMYIA-1
X-Mimecast-MFC-AGG-ID: 3NH0niXJP1ylrwZtwgMYIA_1772639525
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b90bb54d034so822982266b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Mar 2026 07:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772639525; x=1773244325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qWKCUMdT2eOS9e5Yd9IJY2VraltrZvXceyC3PloL9PM=;
        b=O88tELCfEw+IqiVLwNhNtJEMSU1sAPjbk3p5lics75sJONBILRHzhImy+RAmqbMoTx
         gerEZLv/U9j9jJWkYdNACKcd6VBWs+cNcD1+JaEdFOJXwG9TBZz7lA7qUd0zKoCmjzeh
         5sgwRsoTfYeipYAPvwR0VOtDI/7AYgTq+G8L7GS969L8cH06A7l3g9gHIAU4mb8OoEWl
         PfTFUvZ1xfO9OBlLvQTDVOpLLpBFlK1QWKP8oVpjs+S2qX6HPzDY/EDt61BiXRB1ak8D
         ZtDJe1OL5Ng41cPFx5ljPqN9g6JCzOTpasYGgZXw/V4Pd6wmO3mM0UVaQZZkPry05WJr
         TPsw==
X-Forwarded-Encrypted: i=1; AJvYcCVzfEFHyHcW8SRbpubuZDPm6VOvDP7YbbdCXQ+rZ+r8LMemNhlektlEW/DJQWMDNW41tGE/+mo34ropeto4fyYM/6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNY1UHV4mmt5FZgCHDXVaVmDmlPo3z2tsuwDkCLCkppN6GGevn
	Q7K+I/2WnloWoWLD3ln2w7q8QnSh6vAuNk9xFqFrWHY0NwLqgo/ylMLzxaidySGRSXl2aE7sfqG
	lh9w/w6mGRwaf6r5xZBwu7ft3l7rVgR7BIHl6TIzN/2XgnpqPYMWxcNd3OuvDcsLdcFOdi6rt3E
	OuZ1cAYdWz/URb4jbnJnPfN+Z72nYscwbdYbQ/hy0bKk5dEckF
X-Gm-Gg: ATEYQzzoBTduUrJM9jOJeN58tN5gZu6vpH2MXOXhytT+87n0MKR5zVcSReTnomdLODr
	u7egddsgoav+R1XYPbILPbtpSaimMNhYm03KshGP8B9vzaVqDrhEY0mVnwh9y6W6LJcfPVjadCD
	/vIjixLDwdquD7nSYrGA2YDUp6VI99h06R88z80zqefD3/OlNkeYKStBPqSM1s80fgVjs6VVQSn
	GyfVg==
X-Received: by 2002:a17:907:2d27:b0:b88:4ff8:1300 with SMTP id a640c23a62f3a-b93d4456f4bmr404789566b.26.1772639525249;
        Wed, 04 Mar 2026 07:52:05 -0800 (PST)
X-Received: by 2002:a17:907:2d27:b0:b88:4ff8:1300 with SMTP id
 a640c23a62f3a-b93d4456f4bmr404787266b.26.1772639524826; Wed, 04 Mar 2026
 07:52:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213115234.430232-1-costa.shul@redhat.com>
 <20260213115234.430232-2-costa.shul@redhat.com> <CAP4=nvQ8xFr2mD4z01e656hfE9btiFRu8xrqHiR0zGkDYsiVSQ@mail.gmail.com>
 <CADDUTFwD6i=JJCSSndFK=XHG5YrL3gnW95EMQEQmOM9HCs4tDA@mail.gmail.com>
In-Reply-To: <CADDUTFwD6i=JJCSSndFK=XHG5YrL3gnW95EMQEQmOM9HCs4tDA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 4 Mar 2026 16:51:53 +0100
X-Gm-Features: AaiRm53ZP18AvCpSKzFJWQmpMDrtZxm5xUbL7Z0s2bgHsQVA9E8yqYaLnUciwAw
Message-ID: <CAP4=nvSDX68UuHn9xMXP9E-3W7uMs8G46n=cy-e2bNWCzZ_-MQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] tools/rtla: Consolidate nr_cpus usage across all tools
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>, Ivan Pravdin <ipravdin.official@gmail.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iX2eWrPQ-EgfC0sIORNNbLKQe6g-HVaSpNXxcZ7vvrc_1772639525
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 4. 3. 2026 v 16:41 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
>
> On Wed, 4 Mar 2026 at 16:59, Tomas Glozar <tglozar@redhat.com> wrote:
> > This should be updated on top of the unit tests patchset [1] to also
> > include and initialize this global variable in tests, right? Without
> > that, unit tests fail to compile with undefined reference.
> >
> > [1] https://lore.kernel.org/linux-trace-kernel/20260119105857.797498-1-=
costa.shul@redhat.com/
>
> The unit test has not yet been approved. Which patch would you like to
> approve the first?
>

As the unit test patchset was sent first, I picked it for
rtla-for-next and pushed the branch [1]. You can use that to rebase
this patchset with the unit test tweak.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglozar/linux.git/log/?=
h=3Drtla-for-next

Tomas

