Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB0D314D38
	for <linux-trace-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183047; cv=none; b=H6X2EgYPtNZSlFDhB8swJJn4Mhk0Itnf8O/GfGUqNIYexmftpMTrcd390RTRGiRdsVRfoXCKEVAB5en9+ig4UGqex6BKclnCagLnTohfDp55S2uaLuStTPO2AZvZFWA24wp5mWAmFFmbOOorUrkkmZkO/HHSQMcgYs2ZQxrMLiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183047; c=relaxed/simple;
	bh=q48umo4/q1q1MbO4xsF7zhh0+GwClpjJz2v4mliYzIA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/DcXgziRJ9eEd7IicAmtk97o9VmERyd3M+dZfCvRpjAiP+vRUzIkoeCgg2CasqiKtukdiVcyh1qbwITv5HFHN/ynSSEsXXANMOKuVlsgxYRxaBBBc0IRwfILXfI3r0M143cR3SEmI+up2YIfyQKW1lb17R1A2TaC2uWjZkKKE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8Sw0Vfl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8Sw0Vfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762183044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpgDWPP7kl7KS2qB5bXOXx86/uomsXqBkBf/uz0U2p0=;
	b=E8Sw0Vfl/XdFu4eUTMB68g5WvV9xffSj/0eus9lxOUCMkvRgxMq6vuaw7+z8mGZArwDZdM
	SbSkgkanl/mKfXXqraI6Y9nZsIUygAiHQ5QP0sNKM1wtOu4Ao4XClo7ImV0v3Jk740EfAg
	awFmNoTHaaJEGYNGPuU1oaP+SZJTiAM=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-h853ymkTO6SopR8WkLbbUw-1; Mon, 03 Nov 2025 10:17:23 -0500
X-MC-Unique: h853ymkTO6SopR8WkLbbUw-1
X-Mimecast-MFC-AGG-ID: h853ymkTO6SopR8WkLbbUw_1762183042
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b70be4f20e0so110702966b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762183042; x=1762787842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpgDWPP7kl7KS2qB5bXOXx86/uomsXqBkBf/uz0U2p0=;
        b=SH2A8YfGEZne/GcJAeWslTu+ycFvpdVZgR+QApN5IBZEF5LWil4UUSZekyhKuopzXh
         n0kjVi966mzIjiNhdvDNKgruHAd9x2lnllHmF/gnNyxJx0eH4qP4h6Lo979Jtql9D86X
         3UMpMvSwX/TioRfJBmvTHlXmM2WTjfTuuIS79DDG0vGDr+9l+XbXsuYkD5Z6VkK+bS0e
         6RhKaBv5xaLRx4bKsficd8B/ZSmcl98m45sYkTI2dX47M4g4UzXmu9owcM1+ukG6CfyR
         6I8c0gNUN4UZ2+/O3RHf7eduLyuD2BbDDjEu80QGHQJmCzpXoLvuJ8QjV21dINIj+E2W
         VEnw==
X-Forwarded-Encrypted: i=1; AJvYcCWxxb9APTommicA2SaY6MAuWB3PDda62R/7WeR+ZVIO+4eItl31639aqUG+ZBSY/Owl+K0fazHWJA31pEknSTphrcY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4exwHvZ0pUjxfnO0VkZXsJq7z+y7JIOKVIGVnR1BMFQDL9c2V
	RShqXv3ih6edC/7N5yvIpfXxe9F1mMnHFIU6++tpqyw7ayVp6l16zm01o7mPmN5WP/fxdGEQVxa
	S0OlHw4lp/mcHHE6BV5ZNZFkcKZrlArsYQURITbQYi/VoFNPidsTsyh29vrodL7AVLLSJPTSWcD
	c2Wcds/v2UmjqGsMIOXiuiK0Yk8wjpc008FftsIz5F2hRZTNSh
X-Gm-Gg: ASbGncvJmO4qKvRa9UYiZ5oH/TKLd9OMuTASIHjLkeTedw1vUbx+d8AWlW6iy8xxBqt
	xWTk7JpQrgyPlHyEwXgNkBPDe8W35XRa2VwpTYAJz7Xw/H0xPaHU4cNoWeNRPfXCULbIj2jJK4z
	5f4Ei9a9YpNi/kYEEhjnpqcCqobO2TThDnLtdNZpKdquLv1ZBISB9cn29n5osTZxJhb6TC17JJ2
	Ge2wpZWEgF9kg==
X-Received: by 2002:a17:907:980f:b0:b6c:38d9:6935 with SMTP id a640c23a62f3a-b70701bb7c0mr1268330866b.24.1762183042425;
        Mon, 03 Nov 2025 07:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElx/perxXX9P7/6h0riJ/rQ9LEZ9cmufxqTXsD3ZsskR/uVYi6Xx21LwvaUDRKH62Nbslp3x326tIK+km7h3w=
X-Received: by 2002:a17:907:980f:b0:b6c:38d9:6935 with SMTP id
 a640c23a62f3a-b70701bb7c0mr1268327166b.24.1762183041955; Mon, 03 Nov 2025
 07:17:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027153401.1039217-1-tglozar@redhat.com> <20251027153401.1039217-5-tglozar@redhat.com>
 <u4jf3ut26njnm63qgyfhq5xik7zhioecjzffok2h6jmd5utd7g@2ptjrmuvbehq>
In-Reply-To: <u4jf3ut26njnm63qgyfhq5xik7zhioecjzffok2h6jmd5utd7g@2ptjrmuvbehq>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 3 Nov 2025 16:17:08 +0100
X-Gm-Features: AWmQ_blMMM5E0pvRVAMUQDjGcAd71yBFqSuHOu0EGid7MRzf3MGBpZadKnPGprQ
Message-ID: <CAP4=nvSJq1kOUvBRwy_5Fh_FX=Qx-=xiRfngSyky1eVdZsGrrg@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] rtla/tests: Test BPF action program
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G8qdE0bPQoBE1Nil4-rQYB8Bow3CuKMmxrAl3TcaNPk_1762183042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 11. 2025 v 16:10 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
> > diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
> > index 5f1529ce3693..aef814b639b7 100644
> > --- a/tools/tracing/rtla/Makefile
> > +++ b/tools/tracing/rtla/Makefile
> > @@ -76,12 +76,18 @@ src/timerlat.skel.h: src/timerlat.bpf.o
> >
> >  example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> >       $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
>
> I didn't understand why the filter function is needed. $< or $^ seems
> enough.
>

Ah, good catch. The filter is copied from the Makefile of stalld,
which includes a "vmlinux.h" in the targets. That makes the filter
needed, to prevent passing of the header file to the C compiler. It is
not needed here.

> > +
> > +tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> > +     $(QUIET_CLANG)$(CLANG) -g -O2 -target bpf -c $(filter %.c,$^) -o =
$@
> >  else
> >  src/timerlat.skel.h:
> >       $(Q)echo '/* BPF skeleton is disabled */' > src/timerlat.skel.h
> >
> >  example/timerlat_bpf_action.o: example/timerlat_bpf_action.c
> >       $(Q)echo "BPF skeleton support is disabled, skipping example/time=
rlat_bpf_action.o"
> > +
> > +tests/bpf/bpf_action_map.o: tests/bpf/bpf_action_map.c
> > +     $(Q)echo "BPF skeleton support is disabled, skipping tests/bpf/bp=
f_action_map.o"
>
> Why not just not creating the targets if BPF is not enabled?
>

I could do that, but then, I would have to duplicate the check target.

> >  endif
> >
> >  $(RTLA): $(RTLA_IN)
> > @@ -103,7 +109,7 @@ clean: doc_clean fixdep-clean
> >       $(Q)rm -f rtla rtla-static fixdep FEATURE-DUMP rtla-*
> >       $(Q)rm -rf feature
> >       $(Q)rm -f src/timerlat.bpf.o src/timerlat.skel.h example/timerlat=
_bpf_action.o
> > -check: $(RTLA)
> > -     RTLA=3D$(RTLA) prove -o -f tests/
> > +check: $(RTLA) tests/bpf/bpf_action_map.o
>
> Will this work if BPF is disabled?
>

Yes, the bpf_action_map.o target will simply print the warning. You
can try it with:

$ make BUILD_BPF_SKEL=3D0 check

Thank you for the review.

Tomas

