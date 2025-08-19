Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C239322C72
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600018; cv=none; b=Lfc42S/cvmY0Olr7DNYHEAy+jbUAObpg0H4WZsqfEYroU9Uf1OTyj2Tz3LGA4oZ9nxK1jgm0KQ74vpLcW90iF4k7hyLwhNVEvMp4XFucGG7JRIE2s+HyRkj4c/11a7HpytkyxvZ5iEr1SK3UowM6hoGyD6Arb0KMsO5Uv3O69qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600018; c=relaxed/simple;
	bh=6Mh3OcWG/P/mVc70L6Bz+2SOOMG4XOUFXpU2o4QLQUQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRyoA5gf1WLJlEkVRIxuec5EAXbgWwpURW/WoRDTkdw2+H5z+3EF5gy4G0Gh8fDagAi8W8Na2ZkQ+Hpt3W5wOPMwPR1OaHjr6oys+j57uPiXoChjRqoZMrZ0gWCoTK8ZSIQ6lYQONIGoQyAREQbh0WV4NnO4LVS6CmEw01zjHzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G/+dI6oi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G/+dI6oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6Mh3OcWG/P/mVc70L6Bz+2SOOMG4XOUFXpU2o4QLQUQ=;
	b=G/+dI6oi4PLVwPLrri/Z98lDINDachkfVtThlLZkfMuKWr1YF9Ln3rqhfzWsjrG0srcMcy
	NHX8aWnfET/zTdFai9ym8YZzLMRVKo/yl32PF6WC1naooYT6WDGTUDP9e9mtC2VwDS5auV
	H8DZh7YtR5mgS2Lz5MKk0a3Y8EgGr60=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-2iC3LDNjO1mVh-sXfJrsLQ-1; Tue, 19 Aug 2025 06:40:14 -0400
X-MC-Unique: 2iC3LDNjO1mVh-sXfJrsLQ-1
X-Mimecast-MFC-AGG-ID: 2iC3LDNjO1mVh-sXfJrsLQ_1755600013
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8706a5e78so2362857185a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600013; x=1756204813;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Mh3OcWG/P/mVc70L6Bz+2SOOMG4XOUFXpU2o4QLQUQ=;
        b=P91iwf1xOm6cAf+wUEaUbnmfnD68mZq5EN99nnWQycVZo3E/aAlj/HRnnV2sQ3I21a
         XK/GvyouQvrRavI1e64ihkj1uAP9Ta2a+0qZ6umlf2mKpEoQy0sjrb55N6yyRWsbkxfW
         0iK1ESrwcYbbbwXOj1UG/HhI9W+ZkLePh2+jE6jAdsfQ0CmUqifmnmYgtyR1gVSD/ERG
         dfUoiBHVK3VEU/eRDrFl0LE/PGt7jPOEULfft8AKmBdM4YcGrF5kpvANIr3jxxbpwzd3
         Z4zbwauCfvJrFpkSA61s+4oqKOCkyIPuQxIHEvFkW/3AnMRP5+9BrwLJUqGG51Zl5BTF
         RFEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKEKzKXr4Z2aCs8bU+kwRSsvqUH1/v1ioSYOoml9yO3RG7yVySdJli6mmNtYU5Q9/1EUtZca+1Ds8YK5M2CYNi9BU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPFXDfB8Zcpae8/iODP8G5kZj+Jz+VN7Q2py1ErdTh5v5wdvdO
	Rn/ABmsQavg5U6Nn91EOq86n/9VpJ4QvADeymrYw/+ruLbyWUTvUpifzPm3O8TnwAiQL5ZRzo0u
	BbGcH//YyyS310iyPxnresZ61ZKcvf9CJc++awfnJZckvO3g1Gx1FlmVQfAKNNXH0U1U9ethtQw
	WisAgL6UNJ
X-Gm-Gg: ASbGncsALJByGpJ58qypj8n1D0NCe1OZCjsufCPAMKHxqqYXSSHaueek62oUeC69mz3
	YIKAyEBw2LxF3klOHSNwSby/LPxoO78TKFGE9qoHeHcF4e2sfeRgjmDMBt3Dp0hB9cf7jvaWMRD
	smviWkkV5H/WmVl9F0z0xChx7pAskSHNkDOON89sbBqFmXb3M4+mYyxVBI5W8IsKqVo4Bix0beV
	frX+TWL3wqL6rA0BUieDG95mqMQVoNi28GITLWGqj0nW+eyKPGbEnoySG0V1whGG++cqb4pq2Vj
	Ie9wDg4Cspg5oTUW4KcHFkXDqOBCEZ5q3L582MDwcBOOJ71wbh/kksqENJn0Cg920Q==
X-Received: by 2002:a05:620a:471f:b0:7e6:998c:99c0 with SMTP id af79cd13be357-7e9f32eac3amr281911885a.24.1755600013514;
        Tue, 19 Aug 2025 03:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx+fHRkuCSbwkkENyWo6GP3r/1txAJ/JN4LqgGMck+98eE4qPrdw+WG4j41jvp+1cDdp6qNA==
X-Received: by 2002:a05:620a:471f:b0:7e6:998c:99c0 with SMTP id af79cd13be357-7e9f32eac3amr281895985a.24.1755600010157;
        Tue, 19 Aug 2025 03:40:10 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1c0eabsm745844985a.64.2025.08.19.03.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:40:09 -0700 (PDT)
Message-ID: <cdf1912c57cc49d203aec31c645c1c38e863a0ab.camel@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet	 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  Nam Cao <namcao@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:40:06 +0200
In-Reply-To: <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-12-gmonaco@redhat.com>
	 <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jwYcagN_xNzdIjCGnCGG8bi6zxpl9hgwxB9_hOJQR8k_1755600013
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-08-19 at 10:53 +0200, Juri Lelli wrote:
> Hi!
>=20
> On 14/08/25 17:08, Gabriele Monaco wrote:
> >=20
> > +
> > +Examples
> > +--------
>=20
> Maybe add subsection titles to better mark separation between
> different examples?

Sure, makes sense.

>=20
> > +The 'wip' (wakeup in preemptive) example introduced as a
> > deterministic automaton
> > +can also be described as:
> > +
> > +- *X* =3D { ``any_thread_running`` }
> > +- *E* =3D { ``sched_waking`` }
> > +- *V* =3D { ``preemptive`` }
> > +- x\ :subscript:`0` =3D ``any_thread_running``
> > +- X\ :subscript:`m` =3D {``any_thread_running``}
> > +- *f* =3D
> > +=C2=A0=C2=A0 - *f*\ (``any_thread_running``, ``sched_waking``,
> > ``preemptive=3D=3D0``) =3D ``any_thread_running``
> > +- *i* =3D
> > +=C2=A0=C2=A0 - *i*\ (``any_thread_running``) =3D ``true``
> > +
> > +Which can be represented graphically as::
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0=C2=A0=C2=A0 v
> > +=C2=A0=C2=A0 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D#=C2=A0=C2=A0 sched_waking;preemptive=3D=3D0
> > +=C2=A0=C2=A0 H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 H ------------=
------------------+
> > +=C2=A0=C2=A0 H any_thread_running H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > +=C2=A0=C2=A0 H=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 H <-----------=
------------------+
> > +=C2=A0=C2=A0 #=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D#
> > +
> > +In this example, by using the preemptive state of the system as an
> > environment
> > +variable, we can assert this constraint on ``sched_waking``
> > without requiring
> > +preemption events (as we would in a deterministic automaton),
> > which can be
> > +useful in case those events are not available or not reliable on
> > the system.
> > +
> > +Since all the invariants in *i* are true, we can omit them from
> > the representation.
> > +
> > +As a sample timed automaton we can define 'stall' as:
>=20
> Maybe indicate this first one is a not properly correct example
> (correct version follows)?

Yeah I should definitely be clearer about it. As you've guessed, this
example is to show things can be done differently as a tradeoff with
responsiveness, I should make that explicitly.

Thanks for the comments,
Gabriele

