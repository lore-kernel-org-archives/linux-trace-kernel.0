Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D237632C325
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755782550; cv=none; b=ZiwDHHi4WXWHVWU0UUrKxNAJmwvyFow5F7bFNUFlZyczS3/wZqJghwBuJ0WxBMZcckjroMRtuhADzaTjYXSZhbfGMJAYXtLGpSVhTV6hQEpyr0vniO63YmIlC5B79stpL9nWe6++I3Ngnf7wErTdvMuoS9iplEhxdVqeB3VjIKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755782550; c=relaxed/simple;
	bh=YJxrQ7FD5/mktZk9Z49i+8l7WqlZZGyKMw2C4BluJ3M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDlLj0N/7HsX7yZeSa/vqRgEjhlUnfDZFKmYapZqIWgJTmpj7H3qA1oti8AdJHaIyklYt4ngFF14tC8lX8yje60DcO46VE63vQwasLhytd6WtuCkF4G65w4hMmNozb9b/wbJTyL8ReI4gdzzHPSiFVc32cjqWvCO7+/HcGshTYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfnSiBk+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfnSiBk+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755782548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=YJxrQ7FD5/mktZk9Z49i+8l7WqlZZGyKMw2C4BluJ3M=;
	b=SfnSiBk+bUccezP+VXVtDG2T7tqspA+RBP80TZ/YIr0hGS1r4Rt2MA9l+xisdmfE+X1H2+
	i2NgVUO73j8ox9V1Pt/CqvkNhYGCy3NfhG1jlKRrFKHYCQvljE3eUVpYMvd2iJV8FEFs1X
	Db8BSwFMMUuFIWFwkRxSlY8i0IVNklA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-94xad9KdNTCYmlT60979Lw-1; Thu, 21 Aug 2025 09:22:26 -0400
X-MC-Unique: 94xad9KdNTCYmlT60979Lw-1
X-Mimecast-MFC-AGG-ID: 94xad9KdNTCYmlT60979Lw_1755782545
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9dc553704so836097f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755782545; x=1756387345;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJxrQ7FD5/mktZk9Z49i+8l7WqlZZGyKMw2C4BluJ3M=;
        b=RC2PieuHPZfS0VL/ev03gytmTTTQ5e6UUor1hEdyTnh/OPsq6joZ8jknMziUYXM+mw
         vh6GxwdpYfd5U8uAUa4ef1+Q9LbYuZd/R//l7d8aySM8HNomcgVcnVlkJc/fooePoPdJ
         myZVsnm+6pTtLyxBfW6ESnhcyHSdO+LjUyFqciWxLa+x8A61CJe6FBdc7RJtYGQCxkev
         glM4XBmDxkZtxJ1Kfcl4/Pxlf6vSgcd2nnbYyS+JpyzrY9+6E0C5RidYYsX/rZ6MiiyL
         ELJ08kYJmbFeWrjFFK35WDYSl58MsLknz4XuGMujT4RpEyajLdTIaqUvdMDRXxc7TWzM
         tOSA==
X-Forwarded-Encrypted: i=1; AJvYcCWnKQW1AkaLCIS/JPFh8sJi6jDYXllLbelZL2hbEbXsthfda2Qn1dheuUmF9KXVyPOnCZ4TGC/szlKXBTMngCM3qwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDXS282Np1bgVVwnA0DTMdEyTt2yQ3GrZbDEaBDUkm3s8JDOR
	XxSUhe91l2NuM2EobwrLxQwJ5zkbdQLryG8YMFFUbKTxZumSC6fHrQ/mbGC+M+RIDpt8XVZNqnC
	w4U1b18W+mod7FSPk8S70FNEmTioyL8nMF8/IGTbHtnBJo21wJPi7hzy+fhaDCF1D8kVoo6S5Tw
	==
X-Gm-Gg: ASbGncutsjLS8ovC9Psu7Q33C4L5SLeELPbz3Us4SqdtO11oWCVGQpqMCZtuJ4oCP6z
	mLS2sNy7c35N3iosJVeKQu8IP1sTz/2wtnSVbSHL0L+CDoiXWVIoxPUbW7Der113iBdO8touFsE
	e+femjtIZNH6B70ks16RCqkyqXvTjdr5WCxvNObXCN3aGD1DkQv1Q9DYbBlj+QYiQTtnuSZDnCz
	8bBZNbEfdO00/JAPLVWDj4EhLOAQJJ+VRwPFmsLktZf0IfT+wTYAq9UYBc9ksUjzzxNMtWy4hnU
	mE4K3/Spm0Q6Vz5p/uOS9rlqT6/T7BUJSLP8nJ1rgkbO3w79gC05xxVaVdtg8TJImQ==
X-Received: by 2002:a05:6000:2211:b0:3c0:5db6:aed with SMTP id ffacd0b85a97d-3c497274a23mr2285738f8f.54.1755782545374;
        Thu, 21 Aug 2025 06:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKWmMoUwH90shvbiFwGWyOGLnBY4pbSOBI6/RkBga7+ERO9KAT/vEMDc9J8jOx3Yd+hLCURQ==
X-Received: by 2002:a05:6000:2211:b0:3c0:5db6:aed with SMTP id ffacd0b85a97d-3c497274a23mr2285725f8f.54.1755782544997;
        Thu, 21 Aug 2025 06:22:24 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c077c5731dsm11591509f8f.59.2025.08.21.06.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:22:24 -0700 (PDT)
Message-ID: <a87d09f61a873778fe9f737ea4ab7c62dc43e950.camel@redhat.com>
Subject: Re: [RFC PATCH 09/17] verification/rvgen: Allow spaces in and
 events strings
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John Kacur
 <jkacur@redhat.com>
Date: Thu, 21 Aug 2025 15:22:23 +0200
In-Reply-To: <20250821122210.B9iAsUFG@linutronix.de>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-10-gmonaco@redhat.com>
	 <20250821122210.B9iAsUFG@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: H0PHUOdv5eaYNTiXLAqez4eBj3LLuRtV67snAj01o_Q_1755782545
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-08-21 at 14:22 +0200, Nam Cao wrote:
> On Thu, Aug 14, 2025 at 05:08:01PM +0200, Gabriele Monaco wrote:
> > Currently the automata parser assumes event strings don't have any
> > space, this stands true for event names, but can be a wrong
> > assumption
> > if we want to store other information in the event strings (e.g.
> > constraints for hybrid automata).
> >=20
> > Adapt the parser logic to allow spaces in the event strings.
>=20
> The current parser does have a few problems. Not all valid .dot files
> are accepted.
>=20
> I have a patch buried somewhere which removes the custom parser and
> instead uses a library. But then it adds a new dependency, so I'm not
> sure if it is worth..

Yeah it isn't really robust, I tried to improve it a bit but sure
something is still failing it.
We don't need full dot capabilities, but just extract some keywords,
I'd avoid pulling in a dependency for that.

I'm imagining users would either generate graphs from the
Waters/Supremica tool [1] or copy/edit existing ones, so I'm not sure
they can go that far.
Still that's hacky because some things are just lightly implied by the
code (e.g. initial/final states, edges labels, etc.), so one day we
should at the very least say what DOT is valid and what not.

Do you have specific examples of what doesn't work?

Thanks,
Gabriele

[1] - https://github.com/robimalik/Waters/releases

