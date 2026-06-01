Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE537BE71
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300312; cv=none; b=TjUQpwp3cX0UBJlTYQQLXSbcYxWmMNQw/wR2AhcmLcQzK/0cyUnDsO0G805ofABH6wyc4K6jF+gyYjjLGCIY9LhN91KIHp88M/dSIuv6RBPskxhcXvgoGc+C6oT/NIt+2koob5P8/6QNu1n7GierkpohTGsOzQxol/uUprR5mM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300312; c=relaxed/simple;
	bh=1ZezTERSeITTMVNn8Qnu08ChmRSoFgA1UvJZWKe5qNI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DNrpmPMabjguGNQfGHKS7A2dBLcIFCMQNZzMLsGWkrMyOsuFuGgGDIOmptN/Nu/D0Jcv1VMPJrPJK/9f/opwP9C6mYjQuNTOagdUcaRFgECzymM5n7PG3GJMcQjksE7xwVaxVxmDR2OOw9v4NlRyIKd2RH4BSb4PyzgS18yeZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DdIdHsSY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DdIdHsSY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780300309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZezTERSeITTMVNn8Qnu08ChmRSoFgA1UvJZWKe5qNI=;
	b=DdIdHsSYdrWy0Cni8aR4Sm8ri+ami3HCvFxvcmUWzsQoPyzeHvHGep7UUWYpBSL8WnI2jc
	kApcr6MarIF+8CxI6Wj7Dzg7MrlH5PQ3tWgkxWskQFdE2o+GRo0hsfC4fOjIBYHZsrQOnd
	mz28GKUX//32UrpLvv7fW/Sn2aY1L8c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-6tbX5VVWOtKfD6EfrHvE5Q-1; Mon, 01 Jun 2026 03:51:48 -0400
X-MC-Unique: 6tbX5VVWOtKfD6EfrHvE5Q-1
X-Mimecast-MFC-AGG-ID: 6tbX5VVWOtKfD6EfrHvE5Q_1780300307
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490ae0167ceso1080495e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 00:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780300307; x=1780905107;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tE5GTkPw868kwEOFbb8DCyrZt7dMlF83XvmEKjd+iyw=;
        b=T2bxoY9cKIrtV7wpIDq173rbGlSZKCvm2dRXqnHtVHVFbjwq1MJ+5VUarademL4Pi0
         0VpJpUfGFhFXYDYyDaVcTWwUJwZhJ0chu2vPDhEb7WaWvYmVQAJ7KbfVb4lFL8l2p85Y
         9nhYneXJ6WYti0BFiGh/5Q7BMJI9nY7Sne7aBUXo2KRiNFc16iMOQqfVg1OYEkGUrQsv
         i33FJjfKK5EPwQlt3QqJro5BTV0NmhVk7CxFRCktV3GjywBjhF9ea2VcasPyQtvjQE1R
         q7JX/wvrfNAxydvCTeu1xKyS6EjFkUOUfFh4sBsrSWjFrlPcTr5UZxKZP+7QVzZI4mWD
         3Vzg==
X-Forwarded-Encrypted: i=1; AFNElJ8hP1M1k6/RbUV8CLU2BgdGDyMneOX4zwTr1bKnWLGaTHh/nkH2Up8oEXyL6Y/KTa2wWCEkiZiPSxw5oSMVwSO64Pk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFve5Qyv4lRswco0plkl7vyxp6oSVB1O1dacUJiH/ngWhhdMA1
	zJp6X5HP5bRk7QqHkaGrmrOkZHbDnKKDc06TNEazEBQ2EYAnw7iFgdgdy6pth6oPtF3n1oieJxp
	PKFNEp8H9qUraBkgLzph6K/VbiPpUVnPVBfcFKCCdH3ArjfE1HknI4gZVPTMh23Wd0zin0xxvRL
	9sHNKrpQ==
X-Gm-Gg: Acq92OE264gQPbNsBqLQOjIiWD55mkVqyBqhfYyM9pPqxhwRXcSiRj6sZVEIvfHxZFv
	T+CzntI4x/pJY+e53YwSP9ZUOkJgDykOqQnXSLyosaS0sVyvjMcLdeknMx5NjwCcuAb2+w2NMi8
	5jJuSnNmd5NcF2WmIdPV3TCrWXB9zIta3J0jp3t1IgT7dVn+1mW1PY+f/yZpS7CtiRfrORQQtfN
	Kw5olhFePLOFpS7poHl2EiKvWQnqfE9OFdn/BmqcFrz7wkXUxpDAoa9g6GetGmu5YYQjkYEVCDb
	fv+a5PStuPCUrDFj+vkn9WOv5Cfrr1r+d5gvXUQsh6SDNcM/FtdBpuAma29h+XlydW51JS1pGGI
	v3/6B5bp2Qzmsn3CRR0SSnwKd5IqFHMBqlEpY
X-Received: by 2002:a05:600d:6402:20b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-490a2933aeamr124314685e9.19.1780300307189;
        Mon, 01 Jun 2026 00:51:47 -0700 (PDT)
X-Received: by 2002:a05:600d:6402:20b0:48a:58ae:9938 with SMTP id 5b1f17b1804b1-490a2933aeamr124314335e9.19.1780300306766;
        Mon, 01 Jun 2026 00:51:46 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490aab4f87esm10940815e9.22.2026.06.01.00.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 00:51:46 -0700 (PDT)
Message-ID: <d4366f9f457ad54e20f763ce0a9072e9e630896e.camel@redhat.com>
Subject: Re: [PATCH v3 07/13] rv: Add automatic cleanup handlers for
 per-task HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Wen Yang <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, Steven
 Rostedt	 <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Date: Mon, 01 Jun 2026 09:51:45 +0200
In-Reply-To: <877boiyaig.fsf@yellow.woof>
References: <20260530141652.58084-1-gmonaco@redhat.com>
	 <20260530141652.58084-8-gmonaco@redhat.com> <877boiyaig.fsf@yellow.woof>
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: v7oV8Mq8Pmp3DVTTuXv4DO93Sj-f4u14-UWc04N_-nQ_1780300307
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-06-01 at 09:39 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > @@ -123,12 +144,15 @@ static int ha_monitor_init(void)
> > =C2=A0
> > =C2=A0=09ha_mon_initializing =3D true;
> > =C2=A0=09ret =3D da_monitor_init();
> > +=09if (ret =3D=3D 0)
> > +=09=09ha_monitor_enable_hook();
> > =C2=A0=09ha_mon_initializing =3D false;
> > =C2=A0=09return ret;
> > =C2=A0}
>=20
> What if between da_monitor_init() and ha_monitor_enable_hook(), a
> task exits while a timer is still active, and then the timer callback
> is invoked?

We are initialising, timers shouldn't be active, that sits right before
setting up other hooks, and the exit hooks this way is just the first
of them.

By the way, in this case, we likely have a valid reset scenario on an
invalid (uninitialised) timer. This is also what checking the
monitoring flag guards against.
In short, in that handler we really should reset, but need to know
whether we ever initialised in the first place.

> Extremely rare, but I think it can be fixed easily by reordering the
> two functions.
>=20
> > =C2=A0static void ha_monitor_destroy(void)
> > =C2=A0{
> > +=09ha_monitor_disable_hook();
> > =C2=A0=09da_monitor_destroy();
> > =C2=A0}
>=20
> Same here, there is small window between the two function calls.

Likewise here, we removed all hooks, then da_monitor_destroy() is going
to sync with them and clean everything up. Swapping them will expose
more races because we dropped the slot by then.

Am I missing something?

Thanks,
Gabriele

