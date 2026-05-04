Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64952347BA9
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 May 2026 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903382; cv=none; b=reW8LYhe5bDxcp3qEjNvD4/+XwHzvRbNG2fPHRZH8DUvHsAeSHhRVWmGykZGbqqHh2rzEMnQ0Ta3qEiEiAnM+ib0LieHJnfUfllFBhoobkQ2EHaoOsKZ9+iyg/w/jvymXpRi2KJKb05buETKc2xkGXA+vZMcW5hkyNcWWzZUz5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903382; c=relaxed/simple;
	bh=K/jSmocNRi1O+eKM58xQtp9YNLk8SgJ8WOOJH3LSXxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVc6++7D73aHk/OAVuQb7hzBMh0spp3xXG9s4Hoq/F8XfQAhpj79uFwBgyTJ6nu4Mh5L2K5+LosiEf5QIMSadHtpVxuJOH8TvOdKDh8ISCt3PJeTgUN3A+/FbTQDsSGOnI0/8XrZMFBVgbtUMtMHarVx6c1fL8FiZ8hYO8LZMjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtkC2Zqh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtkC2Zqh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777903380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=K/jSmocNRi1O+eKM58xQtp9YNLk8SgJ8WOOJH3LSXxE=;
	b=FtkC2Zqh5EEHQkyR2Jk+JiHQmZC4Iea0SxYaM7tOUmw+tJZN5L7eu1dGwqPR9ZSs/V9DsF
	t4OFio6mi9FMfZcqK+m25eTFqaw2XjQSE8QyKZW+1/NBASVZGfV/W/cpgWsjE4qDlLn5sG
	mILlSCeyUc4YQmtcrV9axQLeJiQpmu0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-ntMGdgUROJiQ-c3AvTtxAA-1; Mon, 04 May 2026 10:02:58 -0400
X-MC-Unique: ntMGdgUROJiQ-c3AvTtxAA-1
X-Mimecast-MFC-AGG-ID: ntMGdgUROJiQ-c3AvTtxAA_1777903377
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48a7994e8ddso40696495e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 May 2026 07:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777903377; x=1778508177;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/jSmocNRi1O+eKM58xQtp9YNLk8SgJ8WOOJH3LSXxE=;
        b=GGu7unwq7O+lgyz1HlRMnKdqYjXeE5pExA3ibkQO1NRStC3iyTNCp1fz00JhRB8dHQ
         FCR/+wBTIrVhZ20fwikclcGQi1ZJyF9D7qg4KxIwSYnTLOzr/EupaNNNY57Ll2+inlLd
         xdFWaf3J6H5O71hYSs9bgaEsvyMNOQHFFkkWI7t0LjO7tOsLnNpwy9P0epaIxRXs95r/
         RBDUakTq3FDan7kcWdav6f1lHEoER3g/imZ9A+3B3bcPsZj8lMsCmI+EX24OdxVtLSr5
         /iP07ePuH+8QM6oiLK1VaA0zjgy6qXj3y6ePv6I0dEuXzfbfY7/PMAOHozkikGflW/2O
         cvPg==
X-Forwarded-Encrypted: i=1; AFNElJ/BMMc73/BQ4rPugOsvV7ad26cmDYm+biVIzBS52kljy2TcLYb2Y0Sj8ZXMNNcgza2KSAP1cdwPSf3J8OvBm3fc9/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh+KP99Gj8gyXC1IZ41AzI54Gm5Hl1kG0xb0RnxRAlbjjVyc9U
	IBOWX40kQYTH8dq0u49PvEYogAsmPD538bcQLxk30nHuIcCgmiLb2NxroTVX3qzZq2oRsOgemUW
	TngMFojRLcZd+igTH1Gby4e5kDU5qMAkfkHOb9lmt7lpvckwF/GQVEShdUGFpneVI4ger0lcI3w
	==
X-Gm-Gg: AeBDieu2LY0HvdUc+sYUTz8XBTHVTOlbBIrb7aCFl6Bwn6K/+lGUP2csGz0NDZU4cfh
	wOw0A0442++arhcqQWVo7xbSsoBLzFO/0E5HMg+PLhdKvUqiZzYljJT/XPMtrC5u1g00HbB/x6f
	rZCUhEqS0mouX7zyVsvkYXmZy+lEI2fGLWhx6JnHy6igri1NoOUQ0axsHnDdBrHhwV/ugY4U050
	Tn61WjJgriLG9KKstGUokWkWag1UB3+Pd86FQOfshQqo9XI3Zqb58cTbhY1x/lshPNo8e1+LWhT
	NRWZLuz4x4Jv8nQGc8eSv4+09hvXUUQDTe4Dg/xfwEgmuagL4jafECCkXlqttA1KCeifiaYl4Q3
	HltjUzALSX1ZExWGPMwN+cl1vi5mN4z/TZBbxXkK23Wc5rbXibnasc83uB6nr7h+TVSDjlXoEfn
	fQO9n2eShQzwUKIve346hN8dm5og==
X-Received: by 2002:a05:600c:c4a7:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48a986642a3mr158095405e9.20.1777903376858;
        Mon, 04 May 2026 07:02:56 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a7:b0:48a:6fd4:d3d3 with SMTP id 5b1f17b1804b1-48a986642a3mr158094615e9.20.1777903376132;
        Mon, 04 May 2026 07:02:56 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eba865fsm249488225e9.10.2026.05.04.07.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:02:55 -0700 (PDT)
Message-ID: <c2e0126585cce2317f6133cccc857a024e58bfea.camel@redhat.com>
Subject: Re: [RFC PATCH 10/12] rv: Add KUnit tests for some DA/HA monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>,  Wen Yang <wen.yang@linux.dev>
Date: Mon, 04 May 2026 16:02:53 +0200
In-Reply-To: <87v7d38fk3.fsf@yellow.woof>
References: <20260427151134.192971-1-gmonaco@redhat.com>
	 <20260427151134.192971-11-gmonaco@redhat.com> <875x531scg.fsf@yellow.woof>
	 <edc43db747832223dc2e7800c7b692327a1f5f82.camel@redhat.com>
	 <87v7d38fk3.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cV0oBrda7Y3hGu8DfZPZ1czmf8ZQF2EJaOa80HSicYc_1777903377
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-04 at 15:33 +0200, Nam Cao wrote:
> I added that missing RV_KUNIT_EXPECT_REACTION(), but I still see a test
> failure:
>=20
> [=C2=A0=C2=A0=C2=A0 1.070721]=C2=A0=C2=A0=C2=A0=C2=A0 # module: rv_monito=
rs_test
> [=C2=A0=C2=A0=C2=A0 1.073512]=C2=A0=C2=A0=C2=A0=C2=A0 1..7
> [=C2=A0=C2=A0=C2=A0 1.077641] scsi 1:0:0:0: CD-ROM=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU=C2=A0=C2=A0=C2=A0=C2=A0 =
QEMU DVD-ROM=C2=A0=C2=A0=C2=A0=C2=A0 2.5+
> PQ: 0 ANSI: 5
> [=C2=A0=C2=A0=C2=A0 1.078494]=C2=A0=C2=A0=C2=A0=C2=A0 ok 1 rv_test_sco
> [=C2=A0=C2=A0=C2=A0 1.083256]=C2=A0=C2=A0=C2=A0=C2=A0 ok 2 rv_test_sssw
> [=C2=A0=C2=A0=C2=A0 1.085783]=C2=A0=C2=A0=C2=A0=C2=A0 ok 3 rv_test_sts # =
SKIP Monitor not enabled
> [=C2=A0=C2=A0=C2=A0 1.092365]=C2=A0=C2=A0=C2=A0=C2=A0 ok 4 rv_test_opid
> [=C2=A0=C2=A0=C2=A0 1.093462]=C2=A0=C2=A0=C2=A0=C2=A0 # rv_test_nomiss: E=
XPECTATION FAILED at
> kernel/trace/rv/monitors/nomiss/nomiss.c:306
> [=C2=A0=C2=A0=C2=A0 1.093462]=C2=A0=C2=A0=C2=A0=C2=A0 Expected ctx->react=
ions =3D=3D ++ctx->expected, but
> [=C2=A0=C2=A0=C2=A0 1.093462]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ctx->reactions =3D=3D 2 (0x2)
> [=C2=A0=C2=A0=C2=A0 1.093462]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ++ctx->expected =3D=3D 1 (0x1)
> [=C2=A0=C2=A0=C2=A0 1.095699]=C2=A0=C2=A0=C2=A0=C2=A0 not ok 5 rv_test_no=
miss
> [=C2=A0=C2=A0=C2=A0 1.109418]=C2=A0=C2=A0=C2=A0=C2=A0 ok 6 rv_test_pagefa=
ult # SKIP Monitor not enabled
> [=C2=A0=C2=A0=C2=A0 1.115146]=C2=A0=C2=A0=C2=A0=C2=A0 ok 7 rv_test_sleep =
# SKIP Monitor not enabled
> [=C2=A0=C2=A0=C2=A0 1.118050] # rv_trigger: pass:3 fail:1 skip:3 total:7
> [=C2=A0=C2=A0=C2=A0 1.118053] # Totals: pass:3 fail:1 skip:3 total:7
> [=C2=A0=C2=A0=C2=A0 1.120622] not ok 1 rv_trigger
>=20
> Any idea why?

The nomiss test is broken, it was not failing by sheer luck, maybe your run=
 was
not lucky.

Basically a few silly mistakes like using deadline instead of dl_deadline (=
which
is left uninitialised) and doing udelay(10 / 1000) (which is 0).

I'm going to fix it in V2.

> > So I'm actually thinking of defining yet another macro that fundamental=
ly
> > does
> >=20
> > RV_KUNIT_EXPECT_NO_REACTION()
> > handle_event()
> > RV_KUNIT_EXPECT_REACTION()
> >=20
> > which would make sure the reaction happens exactly there, plus I'd add =
an
> > RV_KUNIT_EXPECT_NO_REACTION() in the cleanup sequence to ensure no
> > unexpected
> > reaction occurred (or nobody forgot to expect a reaction like I did abo=
ve).
>=20
> Sounds nice, go for it.
>=20
> > Yeah that should be neater, but weren't you the one not liking macros? =
;)
>=20
> It's not black and white, I like whatever makes the code clean and easy
> to read. Sometimes macros are nice, other times not so much. I have
> spent hours reading the tracepoints' macros and they are still black
> magic to me (but to be fair, macros are probably the best we can do for
> that case). I hope we can rewrite those in Rust's generic one day.

Yeah makes sense,=C2=A0tracepoints are a fun one indeed.
Rust would probably be black magic to me but I'm going to have to learn it =
for
good one day!

Thanks,
Gabriele

