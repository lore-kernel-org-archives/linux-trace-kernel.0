Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9F1FB3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108963; cv=none; b=RXd9x+Q+oNTnEVFWUqwyQcrG+o7ai7qH5Nkcnrk4Bws4c6ycPmpW1q2NmKrgndynnUtZBjrIb2gaqYw3KxNxZuaM8/346h9z1We2LkJM/g832iBSPgzy+74lt0qPAAFvKf+68xPMAhJqRbzGsbvRt+3Rgf1Wb33OW7/67eTBT98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108963; c=relaxed/simple;
	bh=jrrBvg1VQMuOzTpt8guFhhc4ovCR3xsp36v4Evz3JdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsdKXOCv1gmg5YnLnc8WdDJAcK9YUw4qFRW4872ebjBr82LlIrX8au9TSEu60Hp8Cywjpa61ZLvH2nEQnwRWQzJzB08bb/740TbplOZmIefSP4Jc/MRojLeBd+ohO1TBD+tI4Mm375KJGOaHFgnt1CCIix7UYVGnwLmYa6P2UO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JlAqTHHF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JlAqTHHF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756108960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jrrBvg1VQMuOzTpt8guFhhc4ovCR3xsp36v4Evz3JdQ=;
	b=JlAqTHHFozqCVr/orzQu+E41e1BUmY+XNFYbYTuRgWZGeM2EpPajQEQPf4UB7MjRRjFeO0
	7Y5IQL4qxLT4Zt78r1VLibtm9KrOrvCBJqHlGEZPT1K6PVEOtFHsscIisq1SN5vWPlt7Tt
	DQbu98NT3We4OjOiPUoSEEVWFIUZtN4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-iBNSoA-xPHygHygBpGvtCg-1; Mon, 25 Aug 2025 04:02:38 -0400
X-MC-Unique: iBNSoA-xPHygHygBpGvtCg-1
X-Mimecast-MFC-AGG-ID: iBNSoA-xPHygHygBpGvtCg_1756108958
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70d7c7e972eso94510726d6.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756108958; x=1756713758;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swYiZ2KuheWlNy62lEXuye07ubCnuW3AXIo+P+pAkUQ=;
        b=LeZZnGg7mxM7ix22PE9OALhQhgQ5kQuRDP9TeFlWMvMlRvmBRY3DSnrZ+In7HBTJcc
         gbj9hCDPG2MB5A427d4iCBkyfT0jb4fZMSSE7Cll3XcaLiOc6EMa0lH1IX0vavKHkQIC
         EfyMOeXYT/MKNYeObIWfhpbPonkgmar7EJB9ltHK/akPTw2XGa89AM+AmkaIxyiBtsZd
         PI88/qeK8+axeBRpztd/sTo2ciov0oiZXv0Z+Ru2KwVTEJAoXau5sipVYoKEteEkHoqp
         6gEDLoHX/idUriSNT25hP+2cmeAWnqJXH37wHmXSrUcq6fAMWdgZCLS61T5U72dp+P1M
         yLag==
X-Forwarded-Encrypted: i=1; AJvYcCUhDzMLIFCBh9HMaCy8Hm3dhgTlbAL/DUy/aYmpkl4brphvGRPdraPAySiMr7YXh0uiXVtlsV/veU6KkiPZRmRbmL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSKkihicwewN8Fobv9r0BcKrsTkQqbYm+VdkFCUpYk4gK3AgUt
	dz6Ckz4xcXafOFslsjMjFBLrI6uXY7QmEGpG80We8YD4oY1PAVmyZY0VoU+IAD+AzZCNs6c6DyI
	jqqt3Gsa6mPU/lhoNVrfSJpuSb0Y8Je/TURGFUgQdyfYfRU2JcqI1nRuw5Hvmk+b3u/+mxKXiUg
	==
X-Gm-Gg: ASbGncusaQoQwXVyIr7EYfkjOT8gbSBuLOEhlGmz8S5doaQhpT0YJoVouZ6u+C+ITiU
	17TbFqS3zUhT3BVf2IA6aLaIozBgS/y29QEAGFkxkqtM2F1ygj/agQlGT3Hc+KOlpsz1LfxKitk
	wtXzhUsW0iHCz9U/RI7Z2dab/GDLyHDZJe5SVV0LYN3l0Ef0O2PdmhV3wimkJgvqzJlUxNLmvkH
	Sa4Mn+iocbygCqvdDYG/tmWKVhBdJwavd5JiwVxAjjrJwnuvibRMVhaOhKixCBDN374MGdW23lz
	H08xi8pxMCCphqgLpxxguKILocwrl9JAP1kpTeLOXuTqbP6bc4FFzA/lD2JGs0sD3g==
X-Received: by 2002:ad4:5c89:0:b0:709:edde:53cb with SMTP id 6a1803df08f44-70d97097766mr121861226d6.1.1756108957915;
        Mon, 25 Aug 2025 01:02:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu61qI2y1NfXoRCal+kkQuMJpjsJ6CjTOn/WkZ07F8a4sJKCIPxEExtscCdby/+v2hXxZxJw==
X-Received: by 2002:ad4:5c89:0:b0:709:edde:53cb with SMTP id 6a1803df08f44-70d97097766mr121860836d6.1.1756108957360;
        Mon, 25 Aug 2025 01:02:37 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72ed68csm41461496d6.75.2025.08.25.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 01:02:37 -0700 (PDT)
Message-ID: <5e122c0ed80fb57223f4630d0d83186a110bf056.camel@redhat.com>
Subject: Re: [RFC PATCH 01/17] rv: Refactor da_monitor to minimise macros
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 Tomas Glozar <tglozar@redhat.com>,  Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 10:02:33 +0200
In-Reply-To: <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
References: <20250814150809.140739-1-gmonaco@redhat.com>
		 <20250814150809.140739-2-gmonaco@redhat.com>
		 <20250821081405.RQhrWVKp@linutronix.de>
	 <d790d27cbe83a1c71dca88cf5e75af14ae214fbd.camel@redhat.com>
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
X-Mimecast-MFC-PROC-ID: -HbNjf6t5Pt2qtv-pDW_0FNELMA8LZg4Og8o4RW2dZY_1756108958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-21 at 10:49 +0200, Gabriele Monaco wrote:
> On Thu, 2025-08-21 at 10:14 +0200, Nam Cao wrote:
>=20
> > > +#define RV_AUTOMATON_NAME CONCATENATE(automaton_, MONITOR_NAME)
> > > +#define EVENT_MAX CONCATENATE(event_max_, MONITOR_NAME)
> > > +#define STATE_MAX CONCATENATE(state_max_, MONITOR_NAME)
> > > +#define events CONCATENATE(events_, MONITOR_NAME)
> > > +#define states CONCATENATE(states_, MONITOR_NAME)
> >=20
> > I think these macros make it harder to read the code. E.g. it is
> > not obvious what is "events" in "enum events event".
> >=20
> > How about renaming these to be the same for all monitors, and get
> > rid of these 4 macros?
> >=20
> > Something like
> >=20
> > =09enum states_wip -> enum da_states
> > =09state_max_wip=C2=A0=C2=A0 -> da_state_max
> > =09etc
> >=20
> > Just my preference, of course. You probably have your reasons for
> > doing it this way?

I had more thoughts on this and I guess at least these enums might need
to stay as they are.

I'm working on a patch to write some sort of unit test for monitors,
where I inject events and see that the errors are triggered.
For readability that requires the events definitions and, currently,
I'm putting all those tests in the same file. It looks simpler to keep
the enums different.

But of course any suggestion is welcome.
Thanks,
Gabriele

