Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9A941D131
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 11:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784806374; cv=none; b=AXHyFAXxUftoO5V6UYdgSE9ZHRRyYY0qaJXHpkZDSsL5K7fAj/cYgxNxXcUutc5CfRZOmHUpm5AWAvAecyIabm8q0XuvFZ0KuId/l5Qe3vqwQoKV3NWMiOnl3sY7KJwHd67T7ZmSA7lsshsLWwU6jRde61T+t+WKv15GMq9fc9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784806374; c=relaxed/simple;
	bh=bmGZ+VF2JtisdCraeL/XzP+eNv3ksul7RyzIh5SIguU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5hf5SmUvtxo7SicYjgMUtv+4Bf0+qphTpPx85CxzrVr9HSv0dKWHKACo7VDCZ69kLQnD1Pu/31BoN4FVN8DWiM8dBE8uh5BgHmh/DMgMvM6e6IGHKeIgmQ3pOMetGm+g1Jm/ZQC1LGvseYqOvGvDv8SkEhbyu2SjqbhffNnWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC1DLf+L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC1DLf+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784806372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bmGZ+VF2JtisdCraeL/XzP+eNv3ksul7RyzIh5SIguU=;
	b=XC1DLf+LmzUpRF86UsY+Djz88d2dpfKs68i7Zdzo5vSwlv25DTYIbfqw2niaMCEg7t/Uc+
	TE21E0Nepq2UbD+syc/7CNadmdBC+/zRmznIjClcbrblS+yopnRJmWb9wJ5nzSloaguWQC
	LAdfY9WzhfjN3wuIhJdNen2Y00Rcmj4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-cD9VQl4yORq5znCgvMO42Q-1; Thu, 23 Jul 2026 07:32:48 -0400
X-MC-Unique: cD9VQl4yORq5znCgvMO42Q-1
X-Mimecast-MFC-AGG-ID: cD9VQl4yORq5znCgvMO42Q_1784806368
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-69e97ea7b5bso817646a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 04:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784806367; x=1785411167;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bmGZ+VF2JtisdCraeL/XzP+eNv3ksul7RyzIh5SIguU=;
        b=GdZcku0W0uxsBRQPitMiaYe4Q2Vk7hqiFn9NzXVWiuyNcJJf8RN+Okr9nCtT+AhGui
         zfgpPdsmZsvJpqyI3g8dvaX69oJXwa7oolo95T+B4G70L5ZuFKayWNgx3crwCrsO6MV6
         3NZ8hLZk6laDE4CeQGNS3pcaVbKEWAdZe3wZOzbVfXREOiNnlIIknfZjIEa8gAlmjLzz
         LujxfzU+OyJFO5ioW9gt8MMxUGJcHN+F89wrPo761nlkEa3BCxJoHj3+FRIa31UpfKdV
         h686h0+4DbepgWzb27LlIi2GW1n1oTnyc94yrPkfQveTlRlpqGi5ac/oBhzTGUp0b2GN
         XmWw==
X-Forwarded-Encrypted: i=1; AHgh+RobhrsEBlSEm9zAcrzm/WZS0caQHw2+GYiHEaQjEOvItRsHgKuKTekyO3j/uAD/IXFpH3WFVG9jgHuIRL/JBTFapm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOmGlZKvOAjcijK8AitkquindHBu9xfD5GJMIg/FOy0sQ8hXYW
	frh0HLVc88Jn4fz9s0zDfO65N3wVrQleNADiB5CrMIdh+ZUDf0Y5yunYdkeEjc7cC5rbvHEkXYf
	YPzpfyPcxn05C3KCSJZxMusl1dSj/tbVJSnMOuv0ivjokyuRP31q0Td8YJafgzClbboJPZ3RNGN
	hDbUVqjy/rwcwTDv+Dh/Z+ej0VgmaPd0M1am4wFtb04YSxNA88
X-Gm-Gg: AR+sD10gjzHLhXEReUrxb88P62SwoltEOSNTCMTHwjEg9GIjOmj0QY5sg5P8iDkkXnH
	eJD52F5l9TOBUKp/LyOmK76N514qNuJPVGyCet2AX338nucp77yv+poShPO/MVUIqYObGY4O8EI
	EuucgAR1QJg9/P/alkYQfQowP4S2lQGk5sHa0tKNfsYSG/TShJGVwXZ7cs
X-Received: by 2002:a17:907:6088:b0:c16:1655:309d with SMTP id a640c23a62f3a-c1c50d82182mr114500166b.56.1784806367595;
        Thu, 23 Jul 2026 04:32:47 -0700 (PDT)
X-Received: by 2002:a17:907:6088:b0:c16:1655:309d with SMTP id
 a640c23a62f3a-c1c50d82182mr114498066b.56.1784806367205; Thu, 23 Jul 2026
 04:32:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715154553.2020891-1-vschneid@redhat.com> <20260715154553.2020891-3-vschneid@redhat.com>
 <CAP4=nvRHyJr9vTm0oJe5Pp_nSa25De_zLB3P3hvUpofaKeVZrA@mail.gmail.com>
In-Reply-To: <CAP4=nvRHyJr9vTm0oJe5Pp_nSa25De_zLB3P3hvUpofaKeVZrA@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 23 Jul 2026 13:32:35 +0200
X-Gm-Features: AUfX_mwpeUAAe2ApssFIa4XZIfU-nrvyBh-u81ybq6mq-1QWO_FaM-On53l52WM
Message-ID: <CAP4=nvSsYuibT7Oq-hAF9b=dZx==FcR1bK5d3zNmYcWgAZmCGQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] rtla/osnoise: Record IPI count in osnoise top
To: Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, John Kacur <jkacur@redhat.com>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Jonathan Corbet <corbet@lwn.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TYTcqoOLCg-b7KaPseeL-CPedqY3jdFRY-5MyT9ohhI_1784806368
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 23. 7. 2026 v 13:32 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
> >
> > This uses the newly added -i cmdline option.
> >
>
> This is now named --irq, right?

s/irq/ipi/

>
> Tomas

