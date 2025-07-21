Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F362989AD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753114405; cv=none; b=m9T/uW9ZIV8pe/z+aGmHGclbve+1t0ITr+waOa0knMJOFZIU77gxkmC/KtCcZyj9cr2l0soZq8uZSPLCga2tzfPxUYHqPXNk4j3b7T71zIBsohzDWx7lSk6SSL/FTPI/VttZWeQxSxzsaFnlGpk9LQqtmpfm0LCg1QtR+Rorq8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753114405; c=relaxed/simple;
	bh=eP6HpFTt5M0VrV12uHRTWUJPZzddGV0wIeJ1SegML+E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efBmnxRkUqAg7COkkofMzQKRuCSb9W48IQcVBY5Bh78PpFSWiR6Nx5GZxKsuc7BdBbqqMgHB5/Tm+EJSU75ygFqdfEZGRisF9RxiKoSb6XubqoKbZdHvPsQcYv0aRBiKFZ+5PdrAZUeETb9505g2d5FKMnTESfbURxGGdYK3YHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIFywGgx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIFywGgx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753114402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eP6HpFTt5M0VrV12uHRTWUJPZzddGV0wIeJ1SegML+E=;
	b=DIFywGgxzWWN39nHrpBHe/79PXsWOAHzrQQWwTTiTg+xtV6npojDR9Lj+ugs7Jhw2m9l+a
	KedUyVrbuqn1PUFysM2dLTMeyCcnn2ONhSGg8dNfiZQTG24/QW3lRj0by/2v2Of5ozyMO4
	qvsRq+JRJyJ88zTd0XTegwLWOTfrcPU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-DcWbZAjDMtyCj5KU_D9zNw-1; Mon, 21 Jul 2025 12:13:20 -0400
X-MC-Unique: DcWbZAjDMtyCj5KU_D9zNw-1
X-Mimecast-MFC-AGG-ID: DcWbZAjDMtyCj5KU_D9zNw_1753114400
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a4fabcafecso2048304f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753114399; x=1753719199;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eP6HpFTt5M0VrV12uHRTWUJPZzddGV0wIeJ1SegML+E=;
        b=XrHlEXNYdKGvHiMGtP1+zVxa++hTzKm5SrFYxUEcp+wEHCSR2DPJ+QNw8VoqFn/SA+
         ll/uBnGW2HTEiFar6RyLH2EARVI+MR23lgz1VFIKiBmOOOqGrCCZA2PVZQeufCzR8ErW
         MrpPj5f5/HdkYnAFqPN1QqM0EwBrMZ4xI/UNUCSIhV/BSsZ27D3qeftKzkqbBjwipyb2
         sJmAaO8XdXq/vAkZaBbwi/aZqYVWWKUmNtnqDC8fnyGFJcJACuAYcgqq24vwR5rgsuKx
         ON8TUw6wschROwy5LOZ9UAdQ/4TVUQJyzKK6AzejIOwEfOXjRteOnUX/d18DimJaJk25
         5z1g==
X-Forwarded-Encrypted: i=1; AJvYcCXPE4R9dA7QaRYqvxtS/ywVf1+GYZbh6y584C20PQV1trLyMn3gkkhaqYSUzGen3GFD9nq2XGH+TP6MWL3L+V89VbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVZybM9grcnfkLgZ3nYJDUjJZrVxCGoq5ZjBGJcWlV8mfWkBr
	iFHzq3e+tK9F3Os5Y3Y+26yLVwGvnpgf8hCaHBO7opuX7eBpOUqI96dEBo3dddX5PSeXoCMhQZM
	msgxcFWZO+aD43JwrSth7HpInCxZ0Mot9wOkMG0aTe+nLIZKbIxGalasAXpBtuHswMjeyBwadpw
	==
X-Gm-Gg: ASbGnctTeLedKiKnglDC+/kvVCD0y+93TxlWwg+vmBh6bcBcHx30Dcct/X1EwFQwFkV
	n22Wz+Ltq+ecKUnYosOsUv5X7Q//Na0h27gh1CM0IyKG4Q5jm+us8PTAqJKVILcp6LxzUNMIgJJ
	YML1elZ22L+3WaMw2y65AD6nJD//0H9swqm3yRKat5nfChQaN3D8erFySj8FdnRuGp3mRiGwYa5
	aLwumuSlEpn7fHt3qlWX/UU+/22sJZiu0QxUDtendI9NxH3UDjWx0YbX25SGpqVzAg+51GY9R4i
	qkh8Cxdz0g3j9O7uxyzIEgSgyzoctmHzqjARFgbaZ1ZDgfovUqNYZ33pFfFVGrachA==
X-Received: by 2002:a05:6000:25c3:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b60dd996d8mr17044500f8f.46.1753114399360;
        Mon, 21 Jul 2025 09:13:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgHb7IPoyQZVbYZX2Z6jGkPlm/aEeWZsfEVFg5fmU98gr7ENzxCxPQYa4SNPQs8aHL13kQpw==
X-Received: by 2002:a05:6000:25c3:b0:3a5:8a68:b815 with SMTP id ffacd0b85a97d-3b60dd996d8mr17044470f8f.46.1753114398783;
        Mon, 21 Jul 2025 09:13:18 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48986sm10853554f8f.46.2025.07.21.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:13:18 -0700 (PDT)
Message-ID: <2e362bb6b1eb1146aba3e88cfa9bba5927d5cc70.camel@redhat.com>
Subject: Re: [PATCH v4 12/14] rv: Replace tss and sncid monitors with more
 complete sts
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Ingo Molnar
	 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tomas Glozar
	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark Williams
	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 21 Jul 2025 18:13:16 +0200
In-Reply-To: <20250721151539.EXglDXpl@linutronix.de>
References: <20250721082325.71554-1-gmonaco@redhat.com>
	 <20250721082325.71554-13-gmonaco@redhat.com>
	 <20250721151539.EXglDXpl@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: T0cPXKXVoEljfI-vaswaM77JVOQuYR8cQQUYQX9ymYM_1753114400
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-07-21 at 17:15 +0200, Nam Cao wrote:
> On Mon, Jul 21, 2025 at 10:23:22AM +0200, Gabriele Monaco wrote:
> > The tss monitor currently guarantees task switches can happen only
> > while
> > scheduling, whereas the sncid monitor enforces scheduling occurs
> > with
> > interrupt disabled.
> >=20
> > Replace the monitors with a more comprehensive specification which
> > implies both but also ensures that:
> > * each scheduler call disable interrupts to switch
> > * each task switch happens with interrupts disabled
> >=20
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> >=20
> > fixup sts remove sncid
>=20
> Is this here by accident?
>=20

Damn, again.. thanks for spotting.

> I cannot comment on the model. The CONFIG_X86_LOCAL_APIC case looks
> complex, but I cannot comment on that either.

Do you mean the amount of tracepoints or the state in the monitor?

As far as I'm aware some special IRQs on x86 use those tracepoints, and
I needed to use all of them not to miss real interrupts, which I need
to understand if interrupts where disabled programmatically or by a
hardware IRQ.

>=20
> But things look fine from RV perspective, so:
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks!
Gabriele

