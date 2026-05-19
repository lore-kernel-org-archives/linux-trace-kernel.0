Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580A8233949
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 12:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193982; cv=none; b=hI+lzUPe4vMOLEogVYIhsSZzoP1Gd4ILVjfLuM2Z+eaKeYO9EWchBvPC9/apcrV1a0araRxjPhP+J4QwsrJ6k85uhqNd0hDJKY5qphI8L1eRx/chOmALiBmasK3+cyru1LmfDudH7BlNHE+hgQei+r52pk2f6Piu1YYof9yb3K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193982; c=relaxed/simple;
	bh=w+ogBnha7eMosYzKqcbm0151r6pKxFOdgbdkGJG7uGE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cG/dcZYGxxwBu5dKluNP/+/eBB3/9EXbMqxivT9esZYInU53JH/VEif9HwkDhEa+/07YDhBJyuoyv8hKh9Leg+CkyoX7/arEqSeuvkljdalAIuYlXV4ovq0tEehRgMCYAsaecSVQo7ukJv3KxtW6+RJfLdmgpiUpc5ovQi0qVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4IR2aBc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4IR2aBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779193980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=w+ogBnha7eMosYzKqcbm0151r6pKxFOdgbdkGJG7uGE=;
	b=h4IR2aBcOkVC+QYK/gCb18Z654tnCD/JMsTaKAS8kLsEr/SOWkPRqcU/7Ij10fO3ZvuOy3
	p+4QNbFwRonEmga4kSveVc43czPU/q7GSwMiBNanW+PfdGYW43xsRC1Wi6oZqLPkDQ4Vrm
	02M0WL2b3AEk8Px0ezkiZM/N6NT5Df0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-EjXHA7NXPreGq5MGbbIVAw-1; Tue, 19 May 2026 08:32:59 -0400
X-MC-Unique: EjXHA7NXPreGq5MGbbIVAw-1
X-Mimecast-MFC-AGG-ID: EjXHA7NXPreGq5MGbbIVAw_1779193978
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e736cac42so2892888f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 05:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779193978; x=1779798778;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ip19kcrkyHcyYYTfFgVFNzNfqOTho0coaSMWx8bqIaY=;
        b=T3aEUUpdeSCHKNJ1s9ntlijhwE8dryYNlurYDKABadi64VMQ+TsbNtYtK3tLlSbKzt
         1CaBgeYsJptW/QoxqlQqLq5cX0XY57ShxHCpqbu2tsLfPjJLPyH7gDioHSS7KYYi/nGT
         AsvADcFQuhDok+infA/wzHgK6OYQ3tDZHXEWt/48WaOSS3pr7QjlzQde76phF1jH67Mx
         rvodT7tEBYTHn8CBApX30U2e9HncGBlynV7Ff6B4lJHAx1VcmbfSxFp7jNOFXq4q9gBW
         HJiyIbUpGgH94CjiMHT/EDJpFILlnzYRRS3THO0Y0mU9wDbRPARTx0Hn+GuxIFFmSdbn
         D1Og==
X-Forwarded-Encrypted: i=1; AFNElJ9qJQLoTJX8QZruif23m4Ice7HFae08MyAvRMcoYaBxjS/ljLILE3IqYb1AIdmnpFO3ynzu7HNz6U0S1Z7Z6YRMwFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb1mvaEHHxiomkZwnCF6XvyDPl0gB85zMskX/1Fg7hN2k/lNGI
	Fy3jbLh801UvYV66JbSuf5uFE18BXJE7Sk0bNlVJKfj1wED9atVNbSZTlF1VR09e5M1yM78rbMZ
	LmjNmDhRK3qr4x+SCMW17wab8K44TsV22aNMMbgOSpusFPBXpVUTstqqlXTijrpmyEteoThHlgK
	hpMwyOFOe2
X-Gm-Gg: Acq92OGk2/ex+5CKqmsnPWIWWafemB0H8Hd+fdpzSOyg1uVR0qzq0gfAnzWeugHvNv3
	grp76jPAkNinXgQRHeJ5G0yBLko/6jlPTTr29zrC7cq9dTomLYG13ZHNrO+W5lavimqbjXLtWBd
	iYA2cjsgg2+RBva509DbLNpYfkI0DowFJOMnItCV2ywKbQlcku7HzzET41MNzsgxNMYNyvN9Bn3
	7gzyCziJoH9F4s4IRNdnQW572HYDv2crmDymzo7WUELSQH3X0Xo6bdumz4zUJoHqbXU2nXhF9pP
	Nb2scTpYaRtRXjZmjktV6Fzn48J0SAZIiqol0j+oPF6jXhDYWal+kIwQ1AZ0roRZQynWyr+yHZP
	vaX3gkWSExXFs73uXRoVsbroZmm0Wr43skuD/cu3r0XCIrCs4zfsjOluBTGQTY2PbI76Y/06Im3
	CWjnlXu52369xjX0E=
X-Received: by 2002:a05:6000:40db:b0:43f:e938:1e67 with SMTP id ffacd0b85a97d-45e5c612fb0mr32816867f8f.38.1779193978090;
        Tue, 19 May 2026 05:32:58 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:43f:e938:1e67 with SMTP id ffacd0b85a97d-45e5c612fb0mr32816797f8f.38.1779193977597;
        Tue, 19 May 2026 05:32:57 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19c2dsm46462841f8f.21.2026.05.19.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 05:32:57 -0700 (PDT)
Message-ID: <a5f5ac6b545a3beb5d6aee4328653fb8955266e1.camel@redhat.com>
Subject: Re: [PATCH v2 03/14] tools/rv: Fix exit status when monitor
 execution fails
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
	 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
	 <wen.yang@linux.dev>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 19 May 2026 14:32:55 +0200
In-Reply-To: <874ik586ex.fsf@yellow.woof>
References: <20260514152055.229162-1-gmonaco@redhat.com>
	 <20260514152055.229162-4-gmonaco@redhat.com> <874ik586ex.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YAtp23fB9k0F5ovPPv54RCrFuLdiiLu_1xZY5ukyiRQ_1779193978
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-05-18 at 10:32 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > +=09exit(run <=3D 0);
>=20
> Probably better to stick to the C standard:
>=20
> =C2=A0=C2=A0=C2=A0 exit(run > 0 ? EXIT_SUCCESS : EXIT_FAILURE)
>=20
> but whatever.
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>

Good point, that's far more readable, will apply and perhaps use those macr=
os
also for other 0/1 in the file.

Thanks,
Gabriele

