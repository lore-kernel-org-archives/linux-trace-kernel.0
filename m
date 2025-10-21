Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47522571DE
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067929; cv=none; b=EdF7cnJR5qrc/gvzwKzgle5PRf99YAlJItrdLFXlCWUGewArX+4l2rZYBlrdfoKZpeTCJLcpOl+76K5O8k/AGK+dclf7kdtuXh7UHODaRaiJLkEcnfy2P725WjZhn8uZ6Zvw14YvYWY1J9ztRutaLcZ+7EvEjUtbkhQboYdjuMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067929; c=relaxed/simple;
	bh=EngUYBDeJ5g/HtyhoZs57nS9oho3E0UOeyU2yBNu30o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXTWAucb2MCDgjvSB9rwlq++jjy80R/ICalD0eiWu4WFuwm2r9VyLuJGo+WPL7O/EquQAvhX4akYkmbi1xitIHZ2CZcYiAC6OMCYDdsTXzrQ9KtVlbAZQIbRwOGxXZx4paqlb2uZQufO4WeuPexzsmutgEUOiPibMIolX53eOQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lh01SYNn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lh01SYNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761067926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EngUYBDeJ5g/HtyhoZs57nS9oho3E0UOeyU2yBNu30o=;
	b=Lh01SYNnolLSq+j/B2W9KvDJETCFIEGVgRVDsUxraxSIP147M2HwvWO4CMbtjFt9BP04t5
	3P1qsYJTE73t1WRDor58He2g7hTrpZtLpRSup7LDG8E9M4YXCa7UwqYe1/socOY711r5xS
	xXuNRLEpmD4O0y9KJUHqTHzAgmKSk24=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-dGegeSxjN_2vyFjUmJmgiw-1; Tue, 21 Oct 2025 13:32:05 -0400
X-MC-Unique: dGegeSxjN_2vyFjUmJmgiw-1
X-Mimecast-MFC-AGG-ID: dGegeSxjN_2vyFjUmJmgiw_1761067924
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-891504015e5so187760785a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761067924; x=1761672724;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EngUYBDeJ5g/HtyhoZs57nS9oho3E0UOeyU2yBNu30o=;
        b=v68Gk8TsqtZMqZb/a5Bkk+aRiC+HTUWOrPcj5DEkW6pjEVxNINFJKJyqNjgXX18v5q
         HgL02BrhSngL27Jcvn6MWC1MDNc2TH+ysqYuDVOjFrm/xzSW5uSnDUxNopfb55yrdqt9
         2hSm26qRaiUqSPZqsO+yF+EsA32JybYnEWpZNEa/NWzjC1tlrkmznz+zVcahwU4eDaLT
         OmemRS7ImoIDiW+vqe3thhz4R1uc80RTZ6iUgvmuWUZcJQ1ryNAvix6LYPT999EVswC0
         jLofBckGXb8MILVCTYGoL4yt3pUhcCVdk8OVKMjBumCZ+NCRVFQpP/e0/nb0ZblsqPuV
         aS/A==
X-Forwarded-Encrypted: i=1; AJvYcCU0kP6Yg9r+wI1+36RQ3ljZ++VIPE8LqzvstKJH75Q+E1iIO7oft7Ptj3ylPFvxm2SGn/LssOG4Qi523AUZ8/AT1Sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkVnjgQDtGOPd+85l/IGET+c0A5jGd4LDO4pWUM6TotdehazQ
	whD2SYrpNYZyxvNx3Bqt+QXU6PUh/YgDKYzXaQEZ0+1+jg/PQZutKypVVZuHtP2PMht1EvMF7il
	Mlk9UGhUv3ufpeXr6JKd0TkHfZseW6KLUH3g7uL+efSVl8sqAwfjwpLLFicd8zAAMg9Rrj1tmyi
	9iFJkrqg==
X-Gm-Gg: ASbGncsPL3fPPzLoivu4cWoj6eZ9sJ03Y44TKIrM+8rOaNtRxIWakKfKeznABuD1zU5
	z9Yv0jCCZ3U0i5VDrI5QkvE2+ORIMeCJ+pUkgisXDqgC3h937bDQTwajZdck3QavBQYoxqEonB8
	Qz3rQJvVfaOlW2hShINeD4jp1i6XQ0Mnt5GVtxENH3KiF04XywhUBRrhBJ3zat75ljvPm5TX8Su
	wbGFYEBarV3Mpj+zxUCs/iitYqVpG4fb6uQRbAtxPOXy4WBAH4pt2Pf5PqvADf3RwV++5r09yRA
	l/5Q1mR+cVOYOy63c/KXQ6y+w2xCNN9K0nzoiY32aEoLvvfIDhk+m8E9ENTiS61dFKzqZqqG+Ny
	HOwqbVBLoccD/R+a7iW0nnAuZtVH23j4=
X-Received: by 2002:a05:620a:319f:b0:891:c248:a513 with SMTP id af79cd13be357-891c248a792mr1509681085a.66.1761067924069;
        Tue, 21 Oct 2025 10:32:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJnTDhJjNQ1qpexZXHyE5h/wTUDGSCb6wrNmM2suFXRMcNKfVQbc8YiNqvmKsKuM3t83MyBw==
X-Received: by 2002:a05:620a:319f:b0:891:c248:a513 with SMTP id af79cd13be357-891c248a792mr1509677585a.66.1761067923717;
        Tue, 21 Oct 2025 10:32:03 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d5d8bsm804157285a.8.2025.10.21.10.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 10:32:03 -0700 (PDT)
Message-ID: <321181e1e5060f0c68e0430d69e0e89688b08235.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur
 <jkacur@redhat.com>, Luis Goncalves	 <lgoncalv@redhat.com>, Costa Shulyupin
 <costa.shul@redhat.com>, Wander Lairson Costa <wander@redhat.com>, Arnaldo
 Carvalho de Melo <acme@kernel.org>
Date: Tue, 21 Oct 2025 12:32:01 -0500
In-Reply-To: <20251021130232.2ca75863@gandalf.local.home>
References: <20251017144650.663238-1-tglozar@redhat.com>
		<20251017144650.663238-4-tglozar@redhat.com>
		<c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
		<CAP4=nvT8VGpYrqQDztmB1WJPEb6JXvUuL201ksWq6eSV7kn-oA@mail.gmail.com>
		<aa0bbfeec78bc90966e660af91eb39acccb77d73.camel@redhat.com>
	 <20251021130232.2ca75863@gandalf.local.home>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nUXo56A2ctaU_NSnwnD83j6JIUQaM6rN3K0-_cSEn34_1761067924
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-10-21 at 13:02 -0400, Steven Rostedt wrote:
> On Tue, 21 Oct 2025 10:58:06 -0500
> Crystal Wood <crwood@redhat.com> wrote:
>=20
> > Huh, so I guess BPF is an exception to the "no generic printk to the
> > global trace instance except for debugging that generates a big boot
> > splat" rule?
>=20
> bpf_printk() is an event and not the generic trace_printk() that would
> cause that splat. You can turn it off.

Ah, I see.

> > Speaking of which, why doesn't trace_osnoise.c call
> > trace_array_init_printk() given that it uses trace_array_printk_buf()?
>=20
> Note, trace_array_printk() (which trace_array_init_printk()) only works f=
or
> instances and does not print into the top level trace buffer.

Yes, it's for instances, such as the ones rtla creates.

-Crystal

