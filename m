Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCA03016FD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568256; cv=none; b=jjrxLdRivPphUukeVDOvzBN7v7QBFPI0v9DflKpb0PFgqIC8oY3oYkt2g/T9+C+hHGP3hkmU7JED/t6Ef7gj5YGZAeXR6Z3vhdl/3yAlpsqLWWf1XLjAIjkNmbCQZgoNOAZldhRzTlW12Q4JgEML+ZZmw0ScCzBtDk3oO7XGviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568256; c=relaxed/simple;
	bh=h/EsNQAeyB/G+IQFkecZb+99buS8A6DJ2vzI+7KSK6k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsyLp58IQYqJsN+3sS7JDSeYgpGD4kiuslDz0r2xU+DjbcN3b5f9Nwe+sGfDoDx7nMZ/xf+fg7OvjFhKwo2O0ZovYOT+eoJoBiOwC4q0inXNhiplfgv32m4b47UV3zTmMSnPRepviFKZkWfA3v9BrtELzQYBtFJbTAY48jTVXHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YUvMDd7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YUvMDd7m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761568253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h/EsNQAeyB/G+IQFkecZb+99buS8A6DJ2vzI+7KSK6k=;
	b=YUvMDd7mtNMh26o/ipy1kzdxI5sgasZISTzIXQEy+NWaJ9sR0/YMfLs8icd5cEfYmXHv0y
	+lUqR7vJe0WdueLviy3Y4LLtjvCyeUQhzmDlMfDM5rKoh4dibtJf+Gm4kkYNxcod6Uw2nF
	fjDMeVvq5wnHQnbIrWVM+UOUYJ06+IQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-QZTCgWvNMdyrMo4-MfQJDw-1; Mon, 27 Oct 2025 08:30:52 -0400
X-MC-Unique: QZTCgWvNMdyrMo4-MfQJDw-1
X-Mimecast-MFC-AGG-ID: QZTCgWvNMdyrMo4-MfQJDw_1761568252
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-892637a3736so1359233685a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568252; x=1762173052;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/EsNQAeyB/G+IQFkecZb+99buS8A6DJ2vzI+7KSK6k=;
        b=pmAo7vKg6MQidRjIk6cU16GU6ajX7f1Pt3h2pZ2liSQ3L/Su4NtjPoGyAvlgaei1b4
         Po1lPmALY2m8/tM/ucywBezQJR8GyIZBRFMxWCAn5ojVNf2ho1Tm4iOE6d5ALuMVOJP5
         eJsLnPdu57vFAgzhjeCeslqRzrTzPO1Izi631z1Ty2uorBBz2opTih85DM0Yera4Hg9v
         fx4JjD+r336hG4htFzHJQNTS0DNOg6gyLWfG5bjXXAID8N1z0xVfayjp7pPP//kUBaDz
         78bF4LnKa2t4JY6Q3r3IG4/EMIQLfd4G2oPMuKPdVxPqGQzsxv5qNwFMGlFzdsdMO9bx
         SkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdzojC+vucXXTvuth/FOYr7HMu5/AOrYif+AVQL2nTFkSVp3AEYzyopueBRkdMgbSib2dTjimtIFNPiwVKrVMCVTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDk22/gmFE/Tgy0mVn1PsnF3+tBNi6qJcISALMvKSWH1bfQXVH
	69FYH/LAs6fDvGPqjU0vjfb9UNy59SOo3R1SsBX+bAyIN7ooQJnYm96hcCutRKC+blu+/xALqG/
	z+TwixE6XlBD1IzFSyIdTj20obbzV19njHXtWMAVBBTW+ubl4m4z5+sJJho8fyl3EvYYPB4os2g
	==
X-Gm-Gg: ASbGncti7zlB2tbfAncKbTk9NNq+F7ApWUmYyqPXi2zu7oquK5W2oMLGF5MZUuh8qgS
	V1UdOBb/cujrvV6XS3ovXE/1uC9u1WLMOxrkmL3YEUwwDnQyDJ1hoYYE9ESiFcEW++bXghdEmBd
	5eTQEW86t3UKJXrvceZ1trbpnmYwd8MnnPhV+rzKABa9tVRcsZE6U0TbmlT4u957hyID/eQA3FT
	NUzdB6J+jqmkqZ6dw5litbSofutuCb3+K7mCDdfdhq3R3kugiZaAHUFF3ATckH4ZAG+M+vehwID
	dEaJ49AgENRxmeCGpF3sNNvxc66tz8k3hqC/m6UrAzZFZEDfp3eWZbbxEgGpfoTyZRok7UoZRlr
	lpEx3i1cxSBdfjnFsVm+kvZINflli6qQm+avRKwNK/3Z66ahoALWTI0TY8BV6nU5Y
X-Received: by 2002:a05:620a:4443:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a3c4faa19cmr416255085a.16.1761568250148;
        Mon, 27 Oct 2025 05:30:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqG5ztW2QIF+ciOz8i/ASp+0t14nx+Sd6eK4WMCbAHgbOxkbgLtidRWt7KAhXpF+9VBgA4Dg==
X-Received: by 2002:a05:620a:4443:b0:8a3:c4fa:9b75 with SMTP id af79cd13be357-8a3c4faa19cmr416233885a.16.1761568248225;
        Mon, 27 Oct 2025 05:30:48 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (syn-050-074-019-099.biz.spectrum.com. [50.74.19.99])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24dd5ad9sm595808485a.22.2025.10.27.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:30:47 -0700 (PDT)
Message-ID: <17528ec0b9f6c8ff2492beea672d4b7950ef72af.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Mon, 27 Oct 2025 08:30:46 -0400
In-Reply-To: <CAP4=nvR86-pmQWdx8rCksp9Dj1mRvgS4961C6my0sVSj1h01Sg@mail.gmail.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
	 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
	 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
	 <20251021130232.2ca75863@gandalf.local.home>
	 <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
	 <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
	 <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
	 <CAP4=nvR86-pmQWdx8rCksp9Dj1mRvgS4961C6my0sVSj1h01Sg@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VVbyuNoTTQSCdg-Ygr-cj7spgQ_wjIvSSjUZigZdaVo_1761568252
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-27 at 11:34 +0100, Tomas Glozar wrote:
> p=C3=A1 24. 10. 2025 v 3:49 odes=C3=ADlatel Crystal Wood <crwood@redhat.c=
om> napsal:
> >=20
> > OK, but as far as I can tell there's no way to get the non-BPF "stop
> > tracing hit" messages without adding a call to trace_array_init_printk(=
)
> > into trace_osnoise.c.
> >=20
>=20
> I'm not sure what you mean. The --bpf-action functionality is
> exclusive for BPF mode, bpf_trace_printk() / bpf_printk(), as Steven
> clarified, is a BPF helper that triggers a trace event, defined in
> kernel/trace/bpf_trace.c and kernel/trace/bpf_trace.h.

This was from a tangential comment, not about --bpf-action.


-Crystal

