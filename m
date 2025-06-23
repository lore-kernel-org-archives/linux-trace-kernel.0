Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D4C6EB79
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jun 2025 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688151; cv=none; b=n3adh6Z8tdPmuquZPlT++0lmw8Aozjl6vPlnQWYvWEaqQqN2oYWcjroO39PEXVJAC9ht0GRTkRc3zgEVgTjNkN5ymIHbAqZnTFYfPPLa9Ljz7qvWmnxFVKGa6t90qiUXRiiF2ymiLdhBoeEJcEqu6yUoiW7XjWd1AmQLtBc32Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688151; c=relaxed/simple;
	bh=EyJToE/pte+ssPp7y/bG1BA6jfNjqT0fWWgQuZcOyUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBAJw7jeVs3GIHCVO5+uFA7NoKNr8WCp/+tUYIc+m8j4Jcsmi2lOtCM1nsvZ5icUuc/7IBD9OhYL74ApriOvqH4qdk7ohOEK8Kk5W78ZlP2bXuuDITJZ5aQIG6ZfmLcT6NbDSNDlgkIUwAdbp1MKVsbg1H1vEYAXnNO+7NVnNQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fJ5fD4uu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ5fD4uu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750688148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EyJToE/pte+ssPp7y/bG1BA6jfNjqT0fWWgQuZcOyUM=;
	b=fJ5fD4uu7g9KDIRrIno4MA4Uvi0Vzqj+gozli1wlyMqau4Tjl73cD0upOyRlmJ4aPIiHvG
	VASwkXZd2BPFDfj6PeQdxF2l2EOiTiiH+9nrhyu9sk2EDbdKucQwVH6uJA5WLy9h7aJ8sO
	ANWBRK35xBP9qiju2MmuMwAemN5EuS4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-hLrV_b2qP1ORfeOlRjm1vg-1; Mon, 23 Jun 2025 10:15:47 -0400
X-MC-Unique: hLrV_b2qP1ORfeOlRjm1vg-1
X-Mimecast-MFC-AGG-ID: hLrV_b2qP1ORfeOlRjm1vg_1750688146
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ad5697c4537so387084466b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Jun 2025 07:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688146; x=1751292946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyJToE/pte+ssPp7y/bG1BA6jfNjqT0fWWgQuZcOyUM=;
        b=OlIdim6ePfQoz/M28VZEamskyKiZxk+9LTbeXH/Md8Shu+t/HNC2QatwxtaMRkHUwQ
         Ih7JmIhKeGF46fHBj7WJzLz0dNBhgFSW1+vq6fv1n8SjgU53njhukLw4ZAxTcYoBvdCU
         cUND9qnwp4rFNMcF/Ve9hZi87XShjnYnK7iNNDLJJhTNQt93LEefUF8YcaiVVc2Dq3zg
         ZaVW+lV8r/fhMGLmLAqV8S257RMJy2+cMoj32rgrjIxBBhCIv6gcScaH3+PuhInTiJuy
         4LiaTR+oPTncPxojtlyduVhT9XkX9pVScQB4S1RmqIBuCUHnQf33FLvpYIs5jctiBzZ8
         mzQA==
X-Forwarded-Encrypted: i=1; AJvYcCWWjHfiMWM5iaH5p/VTkVdEc9hBxjh4zH3Xx6xvmb7SPaFAd7liGfwVTYr3UBLKKu1ayk4fZJDHZ8EY5nOtKjunLsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz3rpcYOIkJY+DknI8Sw9PhlXpOVjFpLl+Yx2CQ1Kokkp5X5I/
	vYRXE2M7mN1zn9arKa1Bx84heQACPI+h9NbFfqL4nntYINlhv6RCKR4aPVVe0yBXVVL3Phi04P/
	e3y3AXaS/aKLviNZbMqfverT+V9dbUiFw5RNwSxrItC8oe/lL77viWlqo9OIvhSoo+EBmfIYJ+Z
	GcL4ibLpcsRqmNbn2jxz2JHK9QTzC03C2LAQtdjvjzk3VupLON
X-Gm-Gg: ASbGncuhTV2S8uA+F2CQ4OhuF5zaEF/ULSKx7WVMQ4gZUy4rcrYuS8QeJqbQRLQ4RuE
	1/3Qt6njJ09sX/qJUPNynCbOi+nGO93fpWzeO2WeJSO5fweNAvx8Pim0U8x8p8mS1jdRPi6QzY+
	eMsbuKmiYc4mjVrack0s/6XOojELazCWFRwA==
X-Received: by 2002:a17:907:d86:b0:ad8:5595:ce07 with SMTP id a640c23a62f3a-ae05afc0710mr1078703566b.19.1750688146134;
        Mon, 23 Jun 2025 07:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoFh+lf9cKfPw5/PaFmRHhpg9V/2Pj3aVIVskh3oL37UFb1YPi0qYcUDrFyqTAiZkD7oZwHlHU31LwMV9DILI=
X-Received: by 2002:a17:907:d86:b0:ad8:5595:ce07 with SMTP id
 a640c23a62f3a-ae05afc0710mr1078700866b.19.1750688145716; Mon, 23 Jun 2025
 07:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611135644.219127-1-tglozar@redhat.com> <aEmWyPqQw2Ly7Jlu@x1>
In-Reply-To: <aEmWyPqQw2Ly7Jlu@x1>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 23 Jun 2025 16:15:34 +0200
X-Gm-Features: AX0GCFse79ZjFCqQvREHj8XeqJ7aESkxQmRMY9ubWHRlvs8xYcKjt3uVJs2GtUc
Message-ID: <CAP4=nvRVG9dxUQRQe13Y9Xyw01epNTpgxDmb3wbi_ZXBkAC_DQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] rtla/timerlat: Support actions on threshold and on end
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Chang Yin <cyin@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -EuHzJ8tDXDamNG64qjupRreb7FfzIrk4gREhkwq994_1750688146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 11. 6. 2025 v 16:46 odes=C3=ADlatel Arnaldo Carvalho de Melo
<acme@kernel.org> napsal:
>
> I wouldn't add -A and -N, leaving just the long options, as it documents
> scripts (and we should have autocomplete as well), leaving the one
> letter options for things that are used super frequently, which could be
> these new options, after a while, time will tell :-)
>

Hmm, my reasoning for those is that one might have multiple actions,
and the action argument itself is long, so one would get a very long
command, e.g.:

$ rtla timerlat hist -T 10 --on-threshold shell,command=3D"echo
Threshold" --on-end shell,command=3D"echo Tracing stopped"

for the command from the example below. But it's true that this is an
experimental feature, and I don't even precisely know the direction in
which I'm going (which is to be determined based on the use of this in
practice). So your suggestion makes a lot of sense.

>
> I think having the documentation together with the new options is
> desirable.
>

Right, this is a user facing change. I did the documentation
separately before, but that was for a change in implementation (BPF
sample collection). Also, I did not have the documentation at the time
of sending of the patchset ready yet :) I'll add it to the v2.

>
> so --on-threshold ends up being a list of things to do when the
> threshold is hit?
>

Yes, the list is executed in order. Now when I'm looking at the cover
letter, this is not clear, I'm only talking about the "list" of the
supported actions (which I perhaps should more accurately call "set").

>
> That is an interesting example of cross-tool integration using existing
> mechanisms for detecting special events and asking for hardware tracing
> snapshots, good stuff!
>

Thanks!

> At some point we need to have this signalling to not involve userspace,
> shortcircuiting the snapshot request closer to the event of interest,
> inside the kernel.
>

I have a feature in mind for that. We already use a BPF program to
process the samples [note1], which means that BPF tail call [1] can be
used to implement in-kernel actions next to userspace ones. Those can
be built-in BPF programs, or custom BPF programs supplied by the user.

[1] https://docs.ebpf.io/linux/helper-function/bpf_tail_call
[note1] In BPF mode. However, outside BPF mode, actions are not that
useful in the first place, as they are only executed when rtla wakes
up to process samples, incurring up to 1s latency.

Tomas

