Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4430E842
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600819; cv=none; b=T41nGI2hLJoiI4b4lHy47TgOOxDhKG4b5U0AG6ibeW/OYGN9/pxnsOdoOxhL6XK7v9oP/6hehOdpG8ciGU87ZnXy+PBANuRQsqf90FQw6ve+uuxgR37KD61uDkOSRYyexjMb7YRvJumW8dxroik5Zis9Rbowql42gzMH8y3HoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600819; c=relaxed/simple;
	bh=EO7ENISm3BJxsvKkBt5+Cb5jSwNR2GlaMZL8G5qc7Rs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c3YPY18zPXmDL4LRZGsApVhrlts1fXDXl7g4YfDQ5gxHomlhYvWDblXIEru47C3b6IQn+Rbg2qIqkv2ukAyMpXhe+sSdT9a4rqxlyZoxo/ZIa8bmvNt0Jf7/Nr9n7PG6sN4fVJOuCi+DVHSN6q8I3yK85bT7xfx8DrwL8lKa79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5IZ6+dz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5IZ6+dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EO7ENISm3BJxsvKkBt5+Cb5jSwNR2GlaMZL8G5qc7Rs=;
	b=h5IZ6+dzc/LbLaPgSzfZd2lCym58f6YCWlPnjGczu/2VXAgc5rwZVSsLY/cM7uQLKWHMgt
	5jt0thVcv+2sl0/mA6LT1poTaxHtHyJIIbiDQgKX9lFx3eeaEfps3BZ7/1CfHaJVckZrb9
	inJ+RYrYX5/OtfAE5Gc2eIWh4v+Z7kw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-s_rOwHcsPC-uOVyDW_u3pA-1; Tue, 19 Aug 2025 06:53:33 -0400
X-MC-Unique: s_rOwHcsPC-uOVyDW_u3pA-1
X-Mimecast-MFC-AGG-ID: s_rOwHcsPC-uOVyDW_u3pA_1755600813
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704e34ccso2112260985a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600813; x=1756205613;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO7ENISm3BJxsvKkBt5+Cb5jSwNR2GlaMZL8G5qc7Rs=;
        b=ulBGJIuNyn7h1VlGGjdkBcsA77z9hEjekD2hEz9092NVHGab+sKzLoMeeUORojXLt5
         xKZ5OviBJXgHE7rnmzUeRCRCcTSEwbpPE3qEcO/dr+RsI+Gj+KTqHj8BjmYDrxW5eBVY
         Yy4YM5bkMSdLl7zURA0wM1mzbA07kI56CHoxk5ISmC1zpp1jL/FYSzw2C7GjX87G1gnj
         MYoTHnUwtlboMO4GFVS4Pz0kaqGTF8M4O1yH0Ygk20Uhj8ssm521gFV/g91y19/UgfK8
         muaHLa7MaJnPiu9Ksu+KEdhlIPDZhX1HbGx5j+KGQ6xylX6OPp8wiQECXmSi/S5uCUZ9
         hKjA==
X-Forwarded-Encrypted: i=1; AJvYcCXHfwOU+inlajOv9NfvGN65aA/PKFxZxHnwiv+V7gpH0rjIOg/FlnlKoFweeG0iasuHGEHFj6q28YkyB7A14DAt6no=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDhW5U0C/8wTg8JVwhSDT2Xit7kd45nOXUtDzMJwkhNFUleuSF
	WVSWdeBl66E0WKHWhxTr9kWrPPe+MjdrLtIOaYF1LYrdE6YNbvG0m91YVfAbbxs6r2/yWBgIMbi
	5g+hlb/nj+b7bBDLk4sb5+seeuSObz7zcQtzCzob3qiX7yyvHuV9A2+vuF6WLUSIhAWVuIZfOQw
	==
X-Gm-Gg: ASbGnctiXk5bq5pfnO1Zrma1j9CYJZwXevyRLXyhMlVhpYggBw1r/XvgPV3ca/zVhOq
	qc3U31UUE1FhJmMoWUQjJLym8Xq4uja/4ot3g0mN7oopgtyugmdf00DkVoYDltKMfuGFn7jDrap
	iyOLTe+Pxfvo59NH4gV4uIPl/l++LlG4EW0Fh+ULlUqeJp0Ad5lPcYOFYGxG5GJ3hCaJ6fBXeaS
	v+ou46wvo7aJrLoRdsqyylbiMr63qnhA0wsME0i+vE5pGZkLKPP0upXrumA6PduqOnm/AbMzvCI
	mDs42qX3sT+vsAtRDnlAvv68Y6QObjRAUHaHmdf2gF3WABmJ3XfPM8BSkdCgYZPFcg==
X-Received: by 2002:a05:620a:6919:b0:7e8:5bb:b398 with SMTP id af79cd13be357-7e9f33150acmr222348885a.9.1755600813293;
        Tue, 19 Aug 2025 03:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP30Q9P2VNlQmQH24vup08QANMA6P1yMtCmVsXUmoSlrvw+NxlGy89RF9eCDaDscDIOYA0ig==
X-Received: by 2002:a05:620a:6919:b0:7e8:5bb:b398 with SMTP id af79cd13be357-7e9f33150acmr222346485a.9.1755600812832;
        Tue, 19 Aug 2025 03:53:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e0228f1sm759267485a.8.2025.08.19.03.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:53:32 -0700 (PDT)
Message-ID: <d907bcaa640a44ecb739b3253df49e16bcd4e38d.camel@redhat.com>
Subject: Re: [RFC PATCH 08/17] rv: Add Hybrid Automata monitor type
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Nam Cao <namcao@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>,  John
 Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:53:29 +0200
In-Reply-To: <aKRNMHCslAt3dx5t@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-9-gmonaco@redhat.com>
	 <aKRBg-KhyCqgFEg3@jlelli-thinkpadt14gen4.remote.csb>
	 <762f7d52bf75475d3ec2587a8e370e4fb2a5ae6a.camel@redhat.com>
	 <aKRNMHCslAt3dx5t@jlelli-thinkpadt14gen4.remote.csb>
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
X-Mimecast-MFC-PROC-ID: 2Vb2axjXc-j2yaWnT9xF_-AHY7fICxzilSlYzrZAdpI_1755600813
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-08-19 at 12:08 +0200, Juri Lelli wrote:
> On 19/08/25 11:48, Gabriele Monaco wrote:
> > That's a good point, I need to check the actual overhead..
> >=20
> > One thing to note is that this timer is used only on state
> > constraints,
> > one could write roughly the same monitor like this:
> >=20
> > =C2=A0 +------------------------------------------+
> > =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enqueued=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0 +------------------------------------------+
> > =C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 | sched_switch_in;clk < threshold_jiffies
> > =C2=A0=C2=A0=C2=A0 v
> >=20
> > or like this:
> >=20
> > =C2=A0 +------------------------------------------+
> > =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enqueued=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk < threshol=
d_jiffies=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0 +------------------------------------------+
> > =C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0 | sched_switch_in
> > =C2=A0=C2=A0=C2=A0 v
> >=20
> > the first won't fail as soon as the threshold passes, but will
> > eventually fail when the sched_switch_in event occurs. This won't
> > use a timer at all (well, mostly, some calls are still made to keep
> > the code general, I could improve that if it matters).
> >=20
> > Depending on the monitor, the first option could be a lower
> > overhead yet valid alternative to the second, if it's guaranteed
> > sched_switch_in will eventually come and reaction latency isn't an
> > issue.
>=20
> Right, as in the first example you have in the docs. I was thinking
> it would be cool to possibly replace the hung task monitor with this
> one, but again we would need to check for overhead, as the definition
> that does expect a switch_in to eventually happen wouldn't work in
> this case.

Yeah if the overhead is really high that might be an option. Although
the monitor might become a bit pointless then: if a task starves
forever, no error will be reported.

If that's a real issue, I might look at other options where to check
for constraints (the tick perhaps).

> > > Does this also need to be _HARD on RT for the monitor to work?
> >=20
> > That might be something we want configurable actually.. I assume
> > the more aggressive the timer is, the more overhead it will have on
> > the system.
> > Some monitors might be fine with a bit of latency.
>=20
> It might not only be about latency, as if the callback timer is not
> serviced in case of starvation (if it's not hard) then the monitor
> won't probably react and we won't be able to rely on it.

I think hit that in some conditions and changed the ha_cancel_timer()
to handle this case.

After leaving the state arming a timer, we always cancel it (to avoid
it expiring outside) at that time if it was expiring but the callback
didn't run, the monitor fails.

Again, if the monitor never leaves the state, we'd never report a
failure, but I'm not sure how common that is.

Thanks,
Gabriele

