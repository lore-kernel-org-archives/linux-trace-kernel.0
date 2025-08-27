Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5A634A32D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299321; cv=none; b=uCyZyG8N/RAgq+zJAOFDi+ohQsYKqHvrC8elsJkhJ9PaRImlmADJMdkUwanYrWy2FaA3Qr9ThheGB/LyqJdT6oWZ77cBlwjRc5yaWKh9Sav+mZnpkpO04FSyrttfRkEMsdtiSBOXcvRTv3+ruIwMUSO9UZIFdcS9Gj7KJzgs0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299321; c=relaxed/simple;
	bh=W0wpz7aHc1cEKeIbA63ZwEnrrCEqc5hVDILFjPMUv4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pHe03o477sFIGl6KvtA9433PsevjiON2CV8AHBjPR3s2uvnmjTgdTG+2GlQ1PHT13JHi471zz95LyRK9N+8bEHnxqJ8uEPPi3R9/5SfUcsXKKAZzgMHRrihX8U2csfOVwn9IB5aQv6m6Mh6OU7QbJcdiKvaaJ9X8ME2cRhQTFDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gyo3n2T3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gyo3n2T3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756299318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0wpz7aHc1cEKeIbA63ZwEnrrCEqc5hVDILFjPMUv4c=;
	b=Gyo3n2T3aoxJlZTgV1vcWp0X2SAkzGN9EY/2bnoneoez3eASxtB9p/3sphvVWI3kmGMVfC
	g0+O3ScVW+AsIGpZxhfhfdwvMYK7kVeca84yQhTCIcJdkqUvbefDJHcehLHfuirVsenmyx
	7JMuJ8dDk0os/bIIL2gs2d9csts6jlA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-SoF5l8BAOzmrspMyiv-L3Q-1; Wed, 27 Aug 2025 08:55:17 -0400
X-MC-Unique: SoF5l8BAOzmrspMyiv-L3Q-1
X-Mimecast-MFC-AGG-ID: SoF5l8BAOzmrspMyiv-L3Q_1756299316
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afeceee8bf7so30349966b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299316; x=1756904116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W0wpz7aHc1cEKeIbA63ZwEnrrCEqc5hVDILFjPMUv4c=;
        b=sCjHSSsqPRdQ1OW+wLhPrGy9KCRqRCj1Hd8zRD6w3OTg992OV7RY8ozi+xN0HEeFDR
         zFwws1Y3IDpfbm0bZC4T1pgVR7G+pigG6lKKfJiybNr4dk+9cgals9Jbc+7hwqafhNBk
         cec5GAjbXirrEEOzfXjAhF4pEzLBVjFTxIg4OnY6B2xAjtAyXFlQ7nmcof8OSibGUIa3
         XW8s4Q3AsjzueOW4ZPnWOMfbKEsfRMtOvftUbPF6jA0m/sy+rCb6aBk9l5DxtVgcTMr+
         SWIt7ZkB65vlI2NEM8nSgjsZjzKrQuPKyg4tn2lyyFf8gcVpqEmzGx8ywrB3UtGVsuU/
         0fnw==
X-Forwarded-Encrypted: i=1; AJvYcCUVZMy0vd4nGpGzwCOlwBBdJVclok/yQp9OL6ldhINwrQ3Vf1R0G/XkMoNJSN7N0oDBegvOGHlFMApKwjLM+ubrbGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7AuiNTfUeY5zQgevgkNaHrlHP5JoXAMvklHrBrvf0xt+RwWI
	EzPTQZKDR0onCun1Yap/nM5R46dwDya4LCiLGgzBLUZwjZqETTVhmDuUQaqFdQ0ChN0tyDT3T5u
	Tk8u+FVFfbWUA39+kc9Ljm1CoR3CUiJ9JpuS6PRlLF5cMSyYwIZSPRXWbCtSscT76rTMhxJFANk
	cNCbS/R9ksNJJf8m1ttzzgDTqB5pGfh6AlyLTIr4b08aXjSB8I
X-Gm-Gg: ASbGncs12DC/E8O5q9PdZDmf7Vztb2oN7YDTzbZsl9sUi0LrGO0lQClmxS8SC3CFwa3
	7YQI0Nc3idCls8LNqv68yeEkSlupomMkWFIQeuJwxLPux5z0p9v3nRbYx6BI4v0A9mHoMehSQwk
	8+wkK0jX2JIT68HLZRUrY8gn9Kxa2ZTLt0DFguxSgPh7UnIKD8d/E=
X-Received: by 2002:a17:906:eecc:b0:af9:3eea:3531 with SMTP id a640c23a62f3a-afe295d2ac0mr1672155966b.35.1756299315779;
        Wed, 27 Aug 2025 05:55:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvBpNG4E8wpkH7etJGDlmHbxw/lBZDcPBYMHximW8V7CiaXM/jXwaLoqcTkAe7MGFajwOJiwpu48NubuoY1dM=
X-Received: by 2002:a17:906:eecc:b0:af9:3eea:3531 with SMTP id
 a640c23a62f3a-afe295d2ac0mr1672153866b.35.1756299315459; Wed, 27 Aug 2025
 05:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-3-crwood@redhat.com>
 <CAP4=nvQtKguNDikon2idnaET=Rpfsuo2DQeoRD4Nn8_FFRUX=A@mail.gmail.com> <b14451e2823743c5f884c862edbf4954991cf629.camel@redhat.com>
In-Reply-To: <b14451e2823743c5f884c862edbf4954991cf629.camel@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Aug 2025 14:55:04 +0200
X-Gm-Features: Ac12FXwawR-spLjcFRxeoIFP3Ard6aeZYQjcDe1y_mOLxnmVYAjCi9Xhvm6CiZc
Message-ID: <CAP4=nvSmEN6J+oEQOhmWFxY3nGp95Y-f3N9STD+C6-HocMULkA@mail.gmail.com>
Subject: Re: [PATCH 2/7] tools/rtla: Move top/hist union members elsewhere
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YClaKu3PRZvFYJJPFGThzfKdhm5w6TyhLClwHvvE_Fk_1756299316
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 26. 8. 2025 v 21:42 odes=C3=ADlatel Crystal Wood <crwood@redhat.com=
> napsal:
>
> Because that wouldn't be pretty :-)
>
> (it just felt like it was repeated enough to be worth it)
>

Ah okay. In the context, it makes it look like the value is computed
inside the function rather than being a part of params, which might be
a bit confusing. Maybe I'm the only one confused by that though.

Tomas

