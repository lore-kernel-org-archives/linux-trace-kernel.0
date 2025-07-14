Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157B2571B6
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501391; cv=none; b=q8EHf4uF6/SDbjdRhVXdHHl3oiazb7r+6If2lKt/h6wIRX4f8k3Kle+y4PdpWim0UOjW+CdoTjnUUpMV6+1C7oY1EqveQiXf3UtCvAXhdHC312tJZ0xJ9zK4Fs3XDb0bLYf2Sud8E0VB0bB2U4KVOU+fJ4BodAVcK2RgfYOGQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501391; c=relaxed/simple;
	bh=qyA1qFNIaLVQF/XRj5OmeTO5tr73BNBKw7ZYH5jkqOY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhxNZSAddEKYeL6mBh4bFhYe4h+Ur3yFKVLrClsh9fnFhXT1tt7dUnyO+YyG+kqJCBvr6xvuPGcf57vrzBHp+GMQE8LrfUh/el8MqToi9bJVDin7glNvpdweAUBVgdNnBS6Fcj50qgVW5rUDjPkAo+Jbobb71ClSPt52ybjANjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XoN6pmEZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XoN6pmEZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752501387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=86I0O0gZKCw9vWxYdEORpb1JAwg7kmLZEFRZ/Wr/EGk=;
	b=XoN6pmEZyeQQo4suvw63cUtWG7dWomVCb9jbV9L9YvRGVWED++aicwp+msW8C+ZbFLVIET
	IWstYW6myuDX2C6LlzW/ZIRzHu2bz2bESChWCdtCZgk24eEm8S/9wGIrLDF5OTdTIcEZuQ
	VBJAsk9mJT/XyiqqW/APpWxINT//U7o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-yREYokaFNZyy7r18ICws2A-1; Mon, 14 Jul 2025 09:56:26 -0400
X-MC-Unique: yREYokaFNZyy7r18ICws2A-1
X-Mimecast-MFC-AGG-ID: yREYokaFNZyy7r18ICws2A_1752501385
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so2165671f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501385; x=1753106185;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHUFJOCGVx0R6dkQg2YQGh551B9n9gOmM8Fe62lW4Pk=;
        b=EFZT6UFWLfGiSzcToBc2Zb12m04elv22ns0cVUnUzkYVPD9eh4qcen3CIum8ZLvbS6
         La9LOwlR05A5u1Mjq2YgBFoQXPqNuQdwjRQzukG/H+h/B4zMwsnCY4Rbl/ILvDo6FosA
         4GBlSg1ScYWwFi3G24HpX2y29U8SblWT1vi1U3m0cmX+G3FaK9wORBD2nVQgLMCinnVh
         KJu+S/l74bbXEw7ANefuCe+so9LKt/un7r30b1XoR/ks9aCjWrGso+9q/aosxT7cITop
         FhIP/YExY648E5+o/XH651GoI/x+mHHD7C24PPm872pU5is7m3+QZuiNrujyuupx9tFe
         t4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ83sZEjlZzzPHkgzxZidWnEgaH4Xf3mEzenJaKdmfonPTCLwlaBLAi/UyD2Upuku+9zwS5o7VKwuLLzYFW4b4p8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQdh6u6Kjo8lfsesne2pRhiX6EYtxmOU9GUAvotYhwJyED0BMt
	8gxHA86/1WxyWJtGlhP6NNYpSRnYpHGugcJfTMZwDIsO4X+v2wuhQLo4TIre85i2rjALoxUnRQ0
	ZJrqpycBB7F9xn3tKx8pfEmCtjrWbd/EtalocR6i7jaW0v+UflXrvSe8g5tOB5xrQZhadqm+B3T
	hNftLOi4UC
X-Gm-Gg: ASbGnctgW0L8lGbntE291SUvrLVrhg8oXen4gSbfUAg1Ek9bcwee7M/L/rN8xD0Tkuv
	TuEyTT0CuPWJLpy/UX4OObf3LTRa/G2pC5zNkalN9DMMLbSaKuyfJAxl5D10OC4LSR/nBcHuqqc
	opdqbzVS92tmlJP5gdAteHwqrBFsyvdixtZgdneE79gBXVggH8tkJIgzfeWXedhjyRs8ljaVI6k
	Ojg+t5BHE51+61LfprG/+HYbxRZsPgl96ZcqSeDgOuStqOKrAo4Kh/25hL5C8x3vJvuPpWFXDrA
	vbPV+ouiFIpXOUHGFfhcqdslhARjhkgSbANx7Rg4xo49z+IRHF0LrnLVu8jiTE1fVA==
X-Received: by 2002:a05:6000:40d9:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5f2e298d0mr9095766f8f.50.1752501384698;
        Mon, 14 Jul 2025 06:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2GPTMLNsaQYuBEk68tW+FXjGbMsBQrCUnbTAwpVWxXClUS2qcWRimiu1Lm/16yIcBYMh1bA==
X-Received: by 2002:a05:6000:40d9:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5f2e298d0mr9095748f8f.50.1752501384214;
        Mon, 14 Jul 2025 06:56:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1fd7sm12308168f8f.26.2025.07.14.06.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:56:23 -0700 (PDT)
Message-ID: <f9c8b5d5a0eeb3f1ebae601383ddb984f9df91ad.camel@redhat.com>
Subject: Re: [PATCH 2/2] verification/rvgen: Support the 'next' operator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness	
 <john.ogness@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, 	linux-kernel@vger.kernel.org
Date: Mon, 14 Jul 2025 15:56:21 +0200
In-Reply-To: <20250714124802.kjqjNWmr@linutronix.de>
References: <cover.1752239482.git.namcao@linutronix.de>
	 <9c32cec04dd18d2e956fddd84b0e0a2503daa75a.1752239482.git.namcao@linutronix.de>
	 <7f4409eae10023a804d24ad2a9c67d368db152cb.camel@redhat.com>
	 <20250714124208.qVXvUVqp@linutronix.de>
	 <20250714124802.kjqjNWmr@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: 4EP6gu7vV_s3ARYB0vU6TT9z0WWh_9EDdVl3RRJcb4A_1752501385
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-14 at 14:48 +0200, Nam Cao wrote:
> On Mon, Jul 14, 2025 at 02:42:10PM +0200, Nam Cao wrote:
> > On Mon, Jul 14, 2025 at 02:18:05PM +0200, Gabriele Monaco wrote:
> > > Now I can't think of a way to rewrite the model to allow a pulse
> > > in
> > > sched_switch, that is /whenever scheduling turns to true, the
> > > next
> > > event is a switch/ instead of /any time scheduling is true, the
> > > next
> > > event is a switch/.
> > >=20
> > > I tried something like:
> > > =C2=A0 RULE =3D always ((not SCHEDULING and next SCHEDULING) imply ne=
xt
> > > SWITCH)
> >=20
> > Be careful of operator precedence. This rule is also what I would
> > suggest,
> > but you need parentheses:
> >=20
> > =C2=A0=C2=A0=C2=A0 RULE =3D always (((not SCHEDULING) and (next SCHEDUL=
ING)) imply
> > (next SWITCH))
>=20
> Actually no, this also does not work. You need double 'next':
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 RULE =3D always (((not SCHEDULING) and (next SCH=
EDULING)) imply
> (next next SWITCH))
>=20

Thanks! This one seems to work.

> Not sure what you mean by .init field

I meant in ltl2k there's this condition for variable usage but not for
variable definition. I'm not sure exactly what it stands for.
  _fill_start():
=09...
=09if not node.init:
=09=09continue

But I guess you got what I meant already.

> Btw, I think this "(not X) and (next X)" seems very useful. So we
> could
> define a helper for this, perhaps something like "rising_edge".

Yeah good idea! I see myself mixing up in the future otherwise..
I guess you'd need to define also a falling_edge for its counterpart.
Or perhaps making it more compact as just rising/falling (with good
documentation or references to somewhere defining it).

Also we need to make clear this operator takes 2 instances, so whatever
happens after (next) it needs a double next.

Maybe it gets complicated but in the future we might have also some
nextN (next2, next3, etc. with a sensible limit not to explode the
generated code) or something along the line.

> Thanks for the report, I will post some patches to address these
> problems
> with the scripts.

Great, thanks!
I'd say since those are unrelated and the next works as intended, feel
free to add

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks again,
Gabriele

