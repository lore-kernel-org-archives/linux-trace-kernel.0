Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84D30E82D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773407118; cv=none; b=ei3lbI5SSbOjMSFOgtnEUs16BdulxizDqhT6lGVkc0CPkvV78tiX++fOyTnENj2fsmZChCMvA09jSrCRGr3nvHM5TKHr+WKdXEdNy8iNh09G3b4AxWwXCYE0pktidVicbzgH6rYbTwuoIKPTEnTr/nxAZLSOLZj2GPLjJp2pdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773407118; c=relaxed/simple;
	bh=QlDMUd7f1JdkVm7v5UibiBKuEOhJyK5M/xPgVuOcFWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGx3NFZO6w5eO3AEkqn2hFfOqQyjNkn9oJ5UWK3ihQ+Gd/Z+IZfe83q1DD2zD9a6Yc2A27VZjzDEj/ELIJrXde4HEirgQKJLZQgXdHlDHpg5Az0hDd2VHSVPxouLopiIIs5BFyS/5xH4nCG1uHmvyVAI77jr0H9NFJFxX11AoHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BUCCOfhh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BUCCOfhh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773407116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlDMUd7f1JdkVm7v5UibiBKuEOhJyK5M/xPgVuOcFWw=;
	b=BUCCOfhhX3iAk8jyQhLLWcdqDtr6HTTaEM0x5jn96BMvedCKIffqlWhK4mkDIfKE/KugmH
	TCa3P76WbFeLsGUv5OE9yK3jBAMJCQWk17XPcpITidMDe97OE3oMZdJk7oGbLObEMFIfKo
	AuPFBt4IQI0q08KIBSsp5VOMYQ01RG8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-jsZ-3HcfM-G8ofCy8PHcvQ-1; Fri, 13 Mar 2026 09:05:14 -0400
X-MC-Unique: jsZ-3HcfM-G8ofCy8PHcvQ-1
X-Mimecast-MFC-AGG-ID: jsZ-3HcfM-G8ofCy8PHcvQ_1773407113
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439bcec86dfso1971717f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773407113; x=1774011913;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlDMUd7f1JdkVm7v5UibiBKuEOhJyK5M/xPgVuOcFWw=;
        b=L4j3Mfh1EwT4wROgTR2WHATO+rcuo9quRE0DfzBaZxeHujs1kl1D9vlFl9FaIx1b7h
         rCto+2bT8n5/dJmYlsDviFs7Ji8rouSvF9jN9qFJi3D+816jdrXmSnlWBW3vx5aUWnBw
         so68irmoamjBSoAqwXvHvSnRDgZRduVg7Zwh2WV/1B8iiPw1jmBKSNs9THw/cRpPSheI
         EYcNBeUCIkKUzrXc7hDSpie8mGvbEauxdYaNOKDy77NGciQsumIsSQld0bJCWwUBhMIe
         LkVZDtvjAmTZQueOK2tf6iTqztkpVpVR9aVvRs61losHUfAIfySnKSdOJwt6XQFa1vMJ
         tO5w==
X-Forwarded-Encrypted: i=1; AJvYcCUz+P25z/6zjq6DavQK/0e3BN7qPpLplv+9PU3x+LBJdoGuZRslX+cU6R2i1z1qT5FzHkAEQgLYkyJ0TzjnluuSz70=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNfU7xXNjyJK67JutSkBDvuaJ8laxHmx8GU9AGqxkfCbyAi8R8
	iorGYd3tRisK3XoL46PChQbnwRa1jKVm4rqRFoZM+suHmYL1cDCnM0+WZEOHyJDSz6roZVFiMTy
	EA2HAwnj07ryRXsaOD1ZvPeTXSgJL2hCUHU1IsqMBUEBX/Y7O1Ovjr435JAzaeDxoNLNLm72TyA
	==
X-Gm-Gg: ATEYQzwkF3czEPYpTvHSnWW2aoIu21AponUwj+Rrxp7gITkrqYMVkdsDD4Taw95tTkp
	AneRk5o4BOJFGKadrr/H8ub2ZiqA7JhKzOfLtBunIwDrvPBkS365TnwMtFrpnIQaAhRMciyQERh
	6+1ZXyFdgw+/ee38jd73PsWfOqKIckyplvt3s1pCGtVMohW5XPUnmF9PyIfeQedLHqXlXUJllTD
	0b9PdeQIfi1WXaAitmKsAYv8aDvjgrsw8t4+rfFiR9fhnCtUr8i39bcvIEsX5WsDtMbz08ujFtH
	EACpClnqtc+MvQS1a59SB7aeNqRXPk7dYENw9M6YfraHLCKR59EKmjNTv3mJnwy8niV/L1p38yf
	crzJCKM0gIRN8Yas2ysy2LIIadg==
X-Received: by 2002:a05:6000:288c:b0:439:c9dd:cd5f with SMTP id ffacd0b85a97d-43a04d863bfmr6367994f8f.19.1773407110687;
        Fri, 13 Mar 2026 06:05:10 -0700 (PDT)
X-Received: by 2002:a05:6000:288c:b0:439:c9dd:cd5f with SMTP id ffacd0b85a97d-43a04d863bfmr6367443f8f.19.1773407106833;
        Fri, 13 Mar 2026 06:05:06 -0700 (PDT)
Received: from [192.168.1.166] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe21b631sm20184469f8f.27.2026.03.13.06.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:05:06 -0700 (PDT)
Message-ID: <4620e92b1c7f4d87f192a017f3026dfc17bcaef6.camel@redhat.com>
Subject: Re: [PATCH v7 05/15] Documentation/rv: Add documentation about
 hybrid automata
From: gmonaco@redhat.com
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Nam
 Cao	 <namcao@linutronix.de>, Juri Lelli <jlelli@redhat.com>, Jonathan
 Corbet	 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  Tomas Glozar <tglozar@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 13 Mar 2026 14:05:05 +0100
In-Reply-To: <abKX1XO4vqY74uA7@jlelli-thinkpadt14gen4.remote.csb>
References: <20260310105627.332044-1-gmonaco@redhat.com>
	 <20260310105627.332044-6-gmonaco@redhat.com>
	 <abKX1XO4vqY74uA7@jlelli-thinkpadt14gen4.remote.csb>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zoZXwDmWIQJgmY7QPam96pCA0qQZ_bTxz1A-gOTfoJE_1773407113
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, 2026-03-12 at 11:39 +0100, Juri Lelli wrote:
> Very minor nit, feel free to ignore, but ...
>=20
> The formal 7-tuple definition includes 'i' (invariant function), but
> unlike other elements, 'i' isn't stored in the automaton struct -
> it's implemented as generated code in ha_verify_constraint(), IIUC.
> Worth a brief note clarifying this design choice so readers don't
> expect to find an invariants[] member in the struct? Here or below in
> the example C code section.

Thanks for the review! I haven't really thought of that.
At this stage we are not mentioning any struct element (it's purely
theoretical), so there shouldn't be any expectation from the reader.

Later I mention "The function verify_constraint checks guards,
performs resets and starts timers to validate invariants according to
specification".
In fact, also guards are not represented as part of 'function', I may
mention after that sentence something like: "those cannot easily be
represented in the automaton struct".

Not sure if saying more wouldn't make it even more confusing than it
already is.

Thanks,
Gabriele

