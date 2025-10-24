Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ECC1BD9D0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 01:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270551; cv=none; b=c0VTk7ci463dyiJAl6a6mdE31LyXSwwpERr6qnaju+/YvXTQAyhvgjOXaZe9alr1MnIu7QJYFhvxc2mfhm+uJTBo5azVVrXuYMhkjK2kDqyBNCwCahopUhLkZI2zaPmUfO4COZPOvPeuL4bojiB+snKuzAdKX95V3Txm+70ROPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270551; c=relaxed/simple;
	bh=Yl3u9R8DqGEdSBgxABIdGTVu2hAd+PBgi0XIyNSnalU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipp4mD2DX3G7fMypv3h2j1u/oB5JOVr/7Tb1YwC2Ybfhuf4+EiYJpCZjQ3+WeD1SONN9Uj6rYXhfli0XO69oTJYB3gBmlPjoS5QQLXw+9YK9KplW4h1XnixzNOCgF2hQKqaNkv0TxotqG7KcpzDqHp+Z7bP6ZpZ80SvYjUx0cA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQRY5I/3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQRY5I/3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761270546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iaP1LO38e4/f4gjNwkOlGA5+LCuZXp5lWw5XIw2ivgU=;
	b=KQRY5I/3EFWetLd87E75LpdELfQHqh85wU7nBLf3tv96+GigLspyIPn4uK0GRD8vznCVFS
	ex+I3xi/vyJ5jWBKKA5Wkg0a0M7n5ojbfWQkg49kK8depAlGJ0JZQwTcu+Maf50Xn6FI6z
	WkTGIBYSA1vJtqjb+BNLGaex0pFE58c=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-QituveDdNPeCTg1bdElVcw-1; Thu, 23 Oct 2025 21:49:05 -0400
X-MC-Unique: QituveDdNPeCTg1bdElVcw-1
X-Mimecast-MFC-AGG-ID: QituveDdNPeCTg1bdElVcw_1761270544
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87c1f435b6bso16338246d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Oct 2025 18:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270544; x=1761875344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iaP1LO38e4/f4gjNwkOlGA5+LCuZXp5lWw5XIw2ivgU=;
        b=u75uYbr6FOVmBYXZsJdDAQVEhiZwKpz4usG8HCfSksUFD7U8JAVLjtoysqaAYQXHAC
         sI7Tg91muvQ+JdbUpE0BnAPn2a4FBXwCumJK1S4+LyLgHXOmPDdVd+yX4wLLvT6RglhW
         QeOWFjteN+94oysqoeJbrkHOua4TdC4SpWfGSyDBfDeBniZz5PsvX0SYqy867CgZDsTH
         b+r+tqWEPQ8gieYnm/0Nck7Z6RpOGIVH1gP0TPgIl4YWCuyUZhFdc5AsZrulT8oUznkk
         7DzQZAsmTsPEzxzojqRx1dMiHI+HxD/qOafZCOl1w6m2QR1t9fN0jBSJM47e6Hz3j4vt
         j62Q==
X-Forwarded-Encrypted: i=1; AJvYcCWRFZ9rO+lq+D5pkE0jMoDUNLeaCg9YGZa4glLCHF0AZJjmfV4GnkZifOACcUNtJtrvY6agZht/03Sld3RnwviN2ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1UVJeaNmU+HuQQtsNRB4CmXMrF7dC6xL5T71MmjYThlnooW8
	hOSgWwnfHUIB0JfpQh5gOYUsZ/neuc0pnsVqdGm+AEooPv1s2OS0DczM3dnLLu2jYXtBLDUDxiQ
	0S7nGf9PZqabqa36C13bt2rqp/1k0Tc7ziydcIZ4fppvEFbhfWGt/MDZFPXofUR8GB8z1cNpBwA
	==
X-Gm-Gg: ASbGncs3O+bh4wHGaZpYtBiPDJ/BTYrnnpsUkvplr4B5Ucw9rNbfzcLwIh3QFTm7NCh
	ZzihmbH/RQLnnXoyr2qNYPr5th6iZOZcoOV4FdLdLfPmqmiK8IZOhjjvmy9yitsiCJb2jm7Trsy
	LNI/f7j8uLeweue08X+5IVVghyfXpd4fjwAsa32ZfjPiDycFlmglbzO0CChXMlaLWPFP1CtpC1L
	NnL9tsCZx9L+h1gAXqzDiWHW2MTnjb7ke45D7VfzOX92QsgsZwZvg6VIs9YCJJm1svD9mzli0Pt
	ay7gVdq2j9YetKlKx/Ce2zRkVNFd79Axm3JnSjhQPFHYYuvtdsebjW/woCPgMOvUYcZoe6uKVVN
	gVGfxG72UNnPBL7LGKmHSlPArkwTEpgA=
X-Received: by 2002:ad4:5c44:0:b0:839:112c:1332 with SMTP id 6a1803df08f44-87c206398e4mr381179026d6.55.1761270544558;
        Thu, 23 Oct 2025 18:49:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkekBeKt/UBYBK9lMa4hj3CeOCtL78ldOAual+TkPrSzY56RttSscXLjrpnEwizYLA7MNPfQ==
X-Received: by 2002:ad4:5c44:0:b0:839:112c:1332 with SMTP id 6a1803df08f44-87c206398e4mr381178896d6.55.1761270544218;
        Thu, 23 Oct 2025 18:49:04 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fb5681868sm4474386d6.52.2025.10.23.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 18:49:03 -0700 (PDT)
Message-ID: <ecedb0d1f2d0e51c56e462adf75df47e8d593a8c.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Thu, 23 Oct 2025 20:49:02 -0500
In-Reply-To: <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
	 <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
	 <CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
	 <aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
	 <20251021130232.2ca75863@gandalf.local.home>
	 <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
	 <CAP4=nvQGM_L3dpVpb36umrwZiCT+S4kGQOfENHBXRRNcy0MA8g@mail.gmail.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L5JQadpSzEQ7hpEi4DQ0AHP8b6XjJI3IOO5ceSQm_iw_1761270544
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-23 at 09:27 +0200, Tomas Glozar wrote:
> =C3=BAt 21. 10. 2025 v 19:32 odes=C3=ADlatel Crystal Wood <crwood@redhat.=
com> napsal:
> >=20
> > On Tue, 2025-10-21 at 13:02 -0400, Steven Rostedt wrote:
> > >=20
> > > Note, trace_array_printk() (which trace_array_init_printk()) only wor=
ks for
> > > instances and does not print into the top level trace buffer.
> >=20
> > Yes, it's for instances, such as the ones rtla creates.
> >=20
> > -Crystal
> >=20
>=20
> Right, it actually works with the trace instance, when set up properly:
[snip]
>  Saving trace to timerlat_trace.txt
>     timerlatu/0-47791   [000] ...22 863353.286497: bpf_trace_printk:
> Latency: 21282

OK, but as far as I can tell there's no way to get the non-BPF "stop
tracing hit" messages without adding a call to trace_array_init_printk()
into trace_osnoise.c.

-Crystal

