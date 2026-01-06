Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3879B35E553
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Jan 2026 17:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767721682; cv=none; b=GzJR8k0uEg3CIA9YnI+99EfAixRZx7OQTFk43w0pV7PR6A0Ky/V8Twrd7nbhR9ZdZFhZpcOOmTxskCiDLBYbFPZDvNAFc8PKsIzTrWte/zXcsTfenAT5rNIKqdPDdy0ZyLt4obzfjhHDtXvsWs5uABE+UO4Z0tDQ4KnbDgcMPds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767721682; c=relaxed/simple;
	bh=ViV00lj7QgZuijk1QbwmF3QeewIeKfNhLoJfNv7HKwk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv+6vSXpCFPN73jkxJt9XbRI/e1Wzq/XZW6X3/rsoAWpG+fbzHs7kd0yo0CW8T3b9hfnTCCC76WTBpsbnVUhIHpfdEcsH/p5TAsC/4w3Q7VnriLpCzJ6L4yXuz/hz3fDBxynB+nFY/bawpYAvrwjRhL4W+2/GVpV+2C9vRhatQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H2L+cvjc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H2L+cvjc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767721680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oJWDVsQrdjkI82W7XIRW9GZaQx38RzjOYQDx4fy9JYc=;
	b=H2L+cvjcEhsghpimg+v0937w511anwlPF7+MphCkRm82AnnMapuThpD7BxQ23woChZvf+p
	EXNjKwJGSmnJUdqholdK1xirLNO90t1gbey20DQA25x7g27cZdQ2lmjCsiROcfuhNsnJxr
	VeCWuaJ7oiiwuzPsbzewyWLyXyvVcQE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-IEt28OH0NPS-hu3O11S_Jg-1; Tue, 06 Jan 2026 12:47:59 -0500
X-MC-Unique: IEt28OH0NPS-hu3O11S_Jg-1
X-Mimecast-MFC-AGG-ID: IEt28OH0NPS-hu3O11S_Jg_1767721678
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2e19c8558so291945785a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Jan 2026 09:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767721678; x=1768326478;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oJWDVsQrdjkI82W7XIRW9GZaQx38RzjOYQDx4fy9JYc=;
        b=CK7UJSHBW8ehDR0wkqsvnusX5BxGvFICmIM8ewb7RJI5Dtr/cyI4yYYNyUqm9yIt8y
         uhSDivVjCgnWR+LnmjdYVnqZztRL9aou3i/KuC+l6pR8mB9CTV1idNYKW+k/u147CNfM
         mf98T0luX/B9hLEeu2fvPxJcDJ18uhPIkDbn1h1cdvLX7un0sPmCBvrjTi94H/FSlprB
         LyEKBe67mtY/R9/hyBDu8/p0xWTmMGNHs9OdelZ6FshUIc3iOMOkOPtc0grLTJBiunDf
         357acvwn7flTcCldq+SjNem9pRjzvzQu6mgcYjcldQq4eriX4ydWOoh05SrfM4BP00Q4
         S5nw==
X-Forwarded-Encrypted: i=1; AJvYcCVUUOS9JV3tybkL0aTmHasDbN8aWSDv32HM9ESSIzdxQ12s2Jo32DWxjoUjn32oOLhR4TTzxUp96JIKIEAXUjHhuxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5i+kG+FGDWhTQWeBTNmduiZ39xDV/tqGiQEMkVOHt30Gp1Idj
	ZauUIGYrkNJ7xztgJTcA2uSsKwpCMGtFEAG3D9nDwCEWrOy7ybbxDqgtSF4EAtG/2cJw8xovz8x
	xPIJYbgUAZQvyOWGBPmKINdlIB2nw+19Hu57EeR3FTxVQeQvhsQsJNZesOYSbxxRohoCMxGj81g
	==
X-Gm-Gg: AY/fxX55auUOn0m+08ZxIeVxxHblXM1trflUw4bEnLjgxiPLUc8tPPcxa71Ys9xBjo/
	jsanP05wChzjopQQ4bqXjPMkrF0DdRDVStvSTI2TAddJ9TcfhmHUpmr8sedgKVUNk4pE6ki4Ccy
	m4NHyhiysghpDsrv1AI3YI2Yhf8pGIpIjaKh75Bt5ITkwjHE1wlZuAGDB+j8Obaf153gFPQKCBM
	hxuixoPGqI0YU44IlAg4nnVgfPzHMJPpcTtL90qk1g1SKxlAr8GwUWY2yQhO0M9Rey+ksVXIj2S
	4v0t38+KXRcV1H1h4wtxl61sJihwcbusfvehZ0Nu8T4iy9X3qOM/8bAu7m0PTA5qxoKmVx3A82g
	5SzKQrqvojMOTxf6WT187OOonSaokLqubY/Oo1FZu5Q==
X-Received: by 2002:a05:620a:460c:b0:8b2:ef70:64f5 with SMTP id af79cd13be357-8c37eb9531fmr459175485a.48.1767721678560;
        Tue, 06 Jan 2026 09:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYhjDvwxLGXHNf6+LajgJjCf5rsdNaikOD40LwMHuIfDWWifrsAEjgFG5uPe7nk6mz2ZtTmw==
X-Received: by 2002:a05:620a:460c:b0:8b2:ef70:64f5 with SMTP id af79cd13be357-8c37eb9531fmr459172285a.48.1767721678151;
        Tue, 06 Jan 2026 09:47:58 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:cc81:56d0:ab94:b2cb:29a6:7ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f53c422sm212786185a.46.2026.01.06.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 09:47:57 -0800 (PST)
Message-ID: <d40f598776e7995c9f1559514e89ccff51d91f9c.camel@redhat.com>
Subject: Re: [PATCH v2 15/18] rtla: Make stop_tracing variable volatile
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>
Cc: Tomas Glozar <tglozar@redhat.com>, Ivan Pravdin	
 <ipravdin.official@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>,
 John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, "open
 list:Real-time Linux Analysis (RTLA) tools"
 <linux-trace-kernel@vger.kernel.org>, "open list:Real-time Linux Analysis
 (RTLA) tools"	 <linux-kernel@vger.kernel.org>, "open list:BPF
 [MISC]:Keyword:(?:\\b|_)bpf(?:\\b|_)"	 <bpf@vger.kernel.org>
Date: Tue, 06 Jan 2026 11:47:56 -0600
In-Reply-To: <20260106110519.40c97efe@gandalf.local.home>
References: <20260106133655.249887-1-wander@redhat.com>
		<20260106133655.249887-16-wander@redhat.com>
	 <20260106110519.40c97efe@gandalf.local.home>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lZDkytiYmdQOKnuVpjMh1-bfGYTI8ro0kv1oc5vUzPE_1767721678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-01-06 at 11:05 -0500, Steven Rostedt wrote:
> On Tue,  6 Jan 2026 08:49:51 -0300
> Wander Lairson Costa <wander@redhat.com> wrote:
>=20
> > Add the volatile qualifier to stop_tracing in both common.c and
> > common.h to ensure all accesses to this variable bypass compiler
> > optimizations and read directly from memory. This guarantees that
> > when the signal handler sets stop_tracing, the change is immediately
> > visible to the main program loop, preventing potential hangs or
> > delayed shutdown when termination signals are received.
>=20
> In the kernel, this is handled via the READ_ONCE() macro. Perhaps rtla
> should implement that too.

Or just get it from tools/include/linux/compiler.h.  No need to reinvent
the wheel (even though several other tools do).

That said, signal safety is a pretty routine use for volatile.

-Crystal

