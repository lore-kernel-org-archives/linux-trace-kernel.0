Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B527934E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130579; cv=none; b=T/KXoVPmLBBXiY5CsPPJKFidS6ai7LXTpVGtHQI9Zfiud4j9OkpEZ96qbjZBXRQRMO3khMsUZ7r4uE/kuMcHY0C0Tsr37KiP9VIBUrJz95PxReTZBFWfcqOYdWyIRye/o2rqfL2+D7m4EO+WSWnZkURQK1l3zuLYWrVQpAB//4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130579; c=relaxed/simple;
	bh=z0lNAkdycMWr/VBF2cxLpwLcBbkQKrhLX9nJ1Ouwo1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L+apq1vFBYPif8UebHvKZlSrfYxaz/ibXoJ/ki8uNao7NttlzWJmEgLhgvSqVhKx5y80Z2ZOMmA7II7dYCJNhfp+JLdWiXS4cL20XwM0TMID4T4fSmOWXjwovwPlaX6jWGDEpsjR+cWGE9Az5MJI06qImaj4eEtGDMbQZLWc+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O68hkXn2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O68hkXn2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756130577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z0lNAkdycMWr/VBF2cxLpwLcBbkQKrhLX9nJ1Ouwo1w=;
	b=O68hkXn24AedsQfOY63Kem3xZMYzg2LJLliW/NYJRJ/v7R8SkO3nJiYBocYRo3qcYoQaj5
	lvTYgC/pmxXfbvGCeimpI6I9aPF6Lim2vwHKDS+QTnzjYvgZEYBzH2a40i1QjGyUHJXfNv
	2sjG/IagP5Ja14s7IFUESfv6NMM9aB8=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-nfVAmCrVN4qztcjwB9oDuQ-1; Mon, 25 Aug 2025 10:02:53 -0400
X-MC-Unique: nfVAmCrVN4qztcjwB9oDuQ-1
X-Mimecast-MFC-AGG-ID: nfVAmCrVN4qztcjwB9oDuQ_1756130572
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-55f41cbbb89so873509e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:02:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756130572; x=1756735372;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0lNAkdycMWr/VBF2cxLpwLcBbkQKrhLX9nJ1Ouwo1w=;
        b=Yg8YA2pnROSPVwUGu0uDZXD3uGabYeg0CucpeG9CXnnalP8g9v1V97D6yhLYNTEH2x
         vzDjylOrPhAYW5PmEmS3Vywigk8y5t9DhAx5G9gdBkflCab0Eobw22jYftAhZASyd0Uy
         k+6KZWQTSZVfYqEhQP1DGwlN0c/ZfmmHm8rdID7UbLALxhS+KqSGtOLO8jZSDuPJYPJN
         66cH+AZOJIn+mG8ORjbjmdAmO9Zxe1yid4Jqr6naIKbHpG1MPVyYCWdim6szBOEoggUk
         UA5j4I2fluhUccuNxMxpbZHiebN343qj/CNVIr7lagUPZuuqjF2qr12CkSM8Qlx3Hxj6
         tW8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEM/T+CX86agN9tQO+9O5uJjt9moTMQMjOmY3yEUFQLd3aJdbHTBaCX6ANAhVWy4smGvcaz25RKzrYBlTMef2GdRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzepe+oWqqq/ji8KaIeTFHuMIJpq4pDNoxV1sNwjkY8FV/fVdFd
	DOr4t+WasvwuNj6TJiV+3PQzN0f79LFXBxl6fjGSRG8zmYX85W/p7NJrwVB2eJFNUvld1LZVF/3
	joA4mzq/4TtKNF7LJx3+h6SGqadHymEUPx1zHj2bnqVDpIx5qOtbacx7byixvG2wDN2SMxpbTdg
	==
X-Gm-Gg: ASbGncsDxa4AHaLlmC9osQZuXig75Xl4jydEGa6iaCfO/qr7K9fn5X3ZoUIm6dh8u6X
	nyczthO16S+GpwSlS52QTcfxC47Jca/OmHXwUJ9XVpFx/QfvHJ+/qf+jdZPA5allc6grFt6f9+u
	8Fds7h/49R86404jMG+edYNkBiUV+104JInY2/jIZ5+2cXWVypScCTHkq0Sj8e7zz6R+cfDeIyM
	2kHR/hk2OnfLoEcDrT3g92LXkAhFVXJubKeWKhtC9lrXvlaN7Az2PAISATKMAzcfJrUb2UkJcl/
	hZJUFRhFU7gkDlHx/ZCDsih9F88/cTfcGZch6lOlKw7WZ8iG8Vrttq79AoTnvj0+OA==
X-Received: by 2002:ac2:4e05:0:b0:55f:44b8:1ed8 with SMTP id 2adb3069b0e04-55f44b82332mr1296560e87.57.1756130571761;
        Mon, 25 Aug 2025 07:02:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyt5bSS1oQEIqYObefsy8rlxTFpq428dUwOG2UZY8ok4fSpnoFwzgLRoQrXqmhna3vwFjpmA==
X-Received: by 2002:ac2:4e05:0:b0:55f:44b8:1ed8 with SMTP id 2adb3069b0e04-55f44b82332mr1296544e87.57.1756130571296;
        Mon, 25 Aug 2025 07:02:51 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f3b946df6sm1381018e87.36.2025.08.25.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:02:50 -0700 (PDT)
Message-ID: <060ae0310f6b3795856d60e36e09b1924d2fa0bc.camel@redhat.com>
Subject: Re: [RFC PATCH 10/17] verification/rvgen: Add support for Hybrid
 Automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Mon, 25 Aug 2025 16:02:48 +0200
In-Reply-To: <20250825100631.uTAyvLwP@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-11-gmonaco@redhat.com>
	 <20250825100631.uTAyvLwP@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: CsKIYo_iTVv8ewURlq3eqvHKBMN0FQbU25X9twP8VdU_1756130572
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-08-25 at 12:06 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:02PM +0200, Gabriele Monaco wrote:
> > +=C2=A0=C2=A0=C2=A0 def fill_constr_func(self) -> list[str]:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff =3D []
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.constraints:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buf=
f.append(
> > +"""/*
> > + * This function is used to validate state transitions.
> > + *
> > + * It is generated by parsing the model, there is usually no need
> > to change it,
> > + * unless conditions were incorrectly specified
>=20
> If the conditions were incorrectly specified, then they should be
> fixed in the automaton, not fixed in this generated C code.

You're right, I should reword or remove that.

> > or too complex for the parser.
>=20
> Do you have examples of these "too complex" cases? Is there a plan to
> handle them?

I wrote this before having the function/macro types, now everything
coming to my mind is covered. Anyway the parser is trying to be smart
but may not catch absolutely everything the user wants to specify.

Now the best thing to do would probably be to strictly define a grammar
and not support what isn't included in there, rather than telling the
user they can kind of tweak the function..

Good points, thanks!
Gabriele

