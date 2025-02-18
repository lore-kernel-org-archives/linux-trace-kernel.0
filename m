Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B60185B4C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Feb 2025 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739862412; cv=none; b=GHRDDXS87YiuOdpSy+X47ve01wuzQT8ZSAPTMYLW3dLlEwQhIXPeByB1p6Rm5ybnowkVbDQanUtEoDGNTg+81eXNy3Yz4qYsvB93VwRLg58u68O17GJLtSwQlzAw4OY5NwBiPzA6CniRBAjLYzHSI88m8MT/TLnBIg5ExAjWWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739862412; c=relaxed/simple;
	bh=0Osaq50h6lLdTTfyX+gYBfyYE/s1RmLresU8JaRo8KQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=smjxkiwfamxNiTPR1AKF7we69SnzP7R5f4F9kuFNs3kDOua7yj4vpYvoB/89zu+UEFWD31FJTCBK/0CxaYIWcpvOhIv7i8lv69BWW95nGDysl4AQ1W6lN/MaOojbeQ2XSZZlEiRaY76LFx/KUuIC16PDBrmlIV0J+jzd6NCWOko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JWaVCIxn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWaVCIxn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739862409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0Osaq50h6lLdTTfyX+gYBfyYE/s1RmLresU8JaRo8KQ=;
	b=JWaVCIxnTAgDTnuhvXJpfVKStIRzb3jO5MiIT6Vu+VdZ4rPi+CBRjQTncFoF4JbD2nQfa0
	rbVYl3rR9AvphimVikCKrq9V6orb0VswU3zI4MQpDYoh3pmLUBmcqI5sqDTNgBAIBrsbCB
	fR+3k2qv9Y3F0bU0LsGUPaSmL2c0H+0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-FpXNltWnPfu9rHOKVZrBYQ-1; Tue, 18 Feb 2025 02:06:47 -0500
X-MC-Unique: FpXNltWnPfu9rHOKVZrBYQ-1
X-Mimecast-MFC-AGG-ID: FpXNltWnPfu9rHOKVZrBYQ_1739862407
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f36fcf4b3so1690747f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Feb 2025 23:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739862407; x=1740467207;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXAuPVdEAvFPuxLiXceyoEIdgydrp1/DHy6puhvJS8Q=;
        b=kNegKfwNKXvxipjZbb/FPM8iLb2NqZb3is6HD4+Y4D7rEpBke9StBWfqAx5lFxIfr0
         XKCanMqGOyZERoiBRMN1xLv9dP60Y00oTqsyOUlsN2P5powpT0gNYQ0JrnaySzBfV1/w
         PKHvJWr8AIfR0537k2xANIVF8ACnDgIkIFlNrdBbUaE1lGhUQVTqZpampBui1M6g0Rqi
         +k2NdteVSsTumwWVvDLyjoN3XR441rpO8/gQYF0Qxuvru2PBq6wiyFhrzl0aAPX+ZWQ+
         lX72RyGNyziAOh1KBM4xrvzGq43zCw501kPwrscZpukiMt2zMx+r7AZzvau3iOQ5iNxN
         5xZw==
X-Forwarded-Encrypted: i=1; AJvYcCViDYDO5ctVkoabk1pmhOfl2hzZtNHarAV8KW2tDp+chp1RzaFI37cjhzP5DSW0GRFHZzsrqT5VyN6JrMxaHdai4dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu4M5fsJ16vuHt5YgTA9c+Bso8/PwvMY/IDpwZme5uRbT9yiLu
	bgo9URAlucE0TGO5OCtCNjSGctXZYZirD/X9CwyUSHacfh6Ee1jxTuNFiNifkUquNmsC8cxDXGX
	taYpDNwr+BfIjaI30U2qDp42W25bhpXuR6nIV0S1dv3C8IpgmFVnHOIuTj3OH0UP4my5Wuw==
X-Gm-Gg: ASbGnctSzDGaH5RBYhujWcC56a+pMSH253/B/wusMkU/lLRXw6RsLLzMIiXP4RRsKU4
	WkmyX+h2VxlBoeSOcn8lhVbBCM6St4DNh5gsqwHirGkMMjaqvCze8E7wYD2kz1YLk7Z1mQRcesW
	2WQRfOMc4IQSJDGHJEXoSQLkJpwOlMlyxhTmT5huC2OQmOVJ9n4cQruVKwNyVbQ1oPRWyGhkPrI
	vYoEG/zhr8rvoOqs0p1dvzcK9mE749Yy6x7hJmuWlTqNkv9SpteC1Y5wQYh7LVod+O4L2KMoSW3
	38qPkAQVqoMRVdHFrcNHTSf11zeMvik=
X-Received: by 2002:a5d:518b:0:b0:38f:2f88:b034 with SMTP id ffacd0b85a97d-38f33f4e284mr9078449f8f.42.1739862406712;
        Mon, 17 Feb 2025 23:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDVOrLB4SIRjherMTEcmhlgcnodEoU6RQbfFJA+eEr9lfODG7fwZ2FnVVkhdYR/PU3kKvwEg==
X-Received: by 2002:a5d:518b:0:b0:38f:2f88:b034 with SMTP id ffacd0b85a97d-38f33f4e284mr9078420f8f.42.1739862406348;
        Mon, 17 Feb 2025 23:06:46 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258cccdesm14150414f8f.26.2025.02.17.23.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 23:06:45 -0800 (PST)
Message-ID: <98ff750749a78c50d882f24e89fdc10ab145fa5d.camel@redhat.com>
Subject: Re: [PATCH v2 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra
 <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, Juri
 Lelli <juri.lelli@redhat.com>
Date: Tue, 18 Feb 2025 08:06:43 +0100
In-Reply-To: <20250217121647.0b9ead66@gandalf.local.home>
References: <20250213090819.419470-1-gmonaco@redhat.com>
		<20250213090819.419470-4-gmonaco@redhat.com>
		<20250217113844.5ad7893c@gandalf.local.home>
		<20250217164917.GB40464@noisy.programming.kicks-ass.net>
	 <20250217121647.0b9ead66@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sTDAHDuSlieiJh_Akp2ymzbxFTVAWR9I0Wjp7t0gA-w_1739862407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Mon, 2025-02-17 at 12:16 -0500, Steven Rostedt wrote:
> On Mon, 17 Feb 2025 17:49:17 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> > On Mon, Feb 17, 2025 at 11:38:44AM -0500, Steven Rostedt wrote:
> >=20
> > > > +void __do_trace_set_current_state(int state_value)
> > > > +{
> > > > +=09__do_trace_sched_set_state_tp(current, current-
> > > > >__state, state_value);=C2=A0=20
> > >=20
> > > And this should not be using the internal macros of a trace
> > > point. It should be:
> > >=20
> > > =09trace_sched_set_state_tp(current, state_value);
> > >=20
> > > (I removed the current->__state as mentioned above).=C2=A0=20
> >=20
> > But the static branch is already in the caller, no point
> > duplicating
> > that.
>=20
> Regardless, you should not be using internals of the tracepoints.
> That can
> change at any time and is not reliable (as the kernel test robot
> pointed out).
>=20
> It's a static branch, who cares if it's added twice? One is used to
> jump to
> the function, the other is for the tracepoint logic itself.
>=20
> There's several places that do this.
>=20
> Perhaps, in the future we could create a normal API that will always
> call
> the tracepoint, but until then, let's not use code that wasn't meant
> for
> that purpose.
>=20
> -- Steve
>=20

Mmh I get your point.=C2=A0We definitely don't want this piece of code to
break whenever something changes in the tracepoint API..

I will revert the change and prepare a V3

Thanks,
Gabriele

