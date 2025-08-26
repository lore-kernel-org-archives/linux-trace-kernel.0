Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F42F83BA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217772; cv=none; b=eIV5Ab9yLrBiqLl4bBob+MddBy0R9+mXoBcUn++T3RMyccQOW9gHjUpxYM1e9Dqoc/tEkk1OnQHd/+XrbvDFflYrnaeXdPaXh6VP3A1LOnycELnojxrU6Dw84QaoWLcHhjzMUwb9n3pddrUIfm7qpXd8PcFRTnArDjUwbjjdx7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217772; c=relaxed/simple;
	bh=OaOkKQzr3Wm5LvpzOefpWtpSOL3Ztx9iqW9FSVxRbC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q4KGkePA45xy4MqdRb/XxFADSZ1C1IFCRRdZTfqkZ6EXgLm5kxFjnTPFKnnI4kFhwntwL7aG6yq9ng0k4ei/UC4fR/tk5TEm10F5+5alBQ2zRrcVegXadIg0ZKLuyMBCasVbleE8Wd+znsI5sHJD9LOW0grQ22N5byYEC4uW/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rfs+jn79; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rfs+jn79"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756217769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OaOkKQzr3Wm5LvpzOefpWtpSOL3Ztx9iqW9FSVxRbC8=;
	b=Rfs+jn79d3c3Vf/xaRHaB/yBufLC8WbohUhhSJYYnZfXBuXALE0ZRzj+JKNosuEQ6VRbjk
	mHYVP3LOUd+AcGdMXCAhDEn/2BRL/1uxqO2jtUbL8zV/R3P9YWlNKdh1+lcHIFRwdIt8Fn
	QosEtuBgE14HAszKlOtA3WZQPao8wP0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-L6-9AIgJM6OLual7KwVuJA-1; Tue, 26 Aug 2025 10:16:06 -0400
X-MC-Unique: L6-9AIgJM6OLual7KwVuJA-1
X-Mimecast-MFC-AGG-ID: L6-9AIgJM6OLual7KwVuJA_1756217766
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-61c8a21cacaso1411159a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Aug 2025 07:16:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756217765; x=1756822565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaOkKQzr3Wm5LvpzOefpWtpSOL3Ztx9iqW9FSVxRbC8=;
        b=PI61F0lmVTTX/Drz3y7/kNsL4j9TQyEd4ZE+K14EYu7dR1RQLE8fRiO/wexdQXPDFt
         l8thqZlB+ZSCFFFdpy/s7PVw+4TqAvApsBHgflaM+U/j851cushGfBQRH+tDCjZ2Jaf6
         g5NP6pVEewdpF+yuHseNvGy3BCD2wBGXrtjkludVHx/6/NJn0yVbK/BBxKq0hycOuJJ5
         rogdNPGEJB2Gb/G4w7CTVqHHajxaJzYca51Dour5I24z7HiqdsyxZu/axmEi9lD0pWrP
         jaANB+x+CxC477jGBBFl2uw5e4ZGX5r37xFPJC9ZU1kLTbaqvxic1/a+4Xvy4SiNDO05
         Au6g==
X-Forwarded-Encrypted: i=1; AJvYcCUEt1FtJDZl2+v8raHp3be3IMu6JnaCHMqJumvP8T7kBpIXVaigJ8ufj1bNYu066dbugLWooQ0w3onCJER2zilgdb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaZnQZ313MkDxKiT7ehqej79KNzYArqOnEKWdG7IRKm2c8z8N
	jgO268zhdFXO4Dm6nLuH55SPJ9gZQeYpdT/cF4suJKN2a38Ngw4ikPScd+EOFOiNiCo6iGeVa0m
	J5qmyfjZxp/cp9UxgN45XOkHYlStPjw1m3IzGKD7JzrbZP7hSIEvw3LNX/N+EGBGs4TTbbq4rIr
	pA6jT94Xq0ELLwVoRrq6jg9AsyJ1quNQNii9yi2eBRluKOVmK2
X-Gm-Gg: ASbGncvvEUV4HZEWF4bcGC1nQyaPDQOJMwSsNl9dvIUd7aetMMR3MW7WQ5EdaLluit/
	spapa1k0GxprsNAM3QJrM9n2XfnOtliVQnQT/IJ8NQHcwUFuzrpAbhtnZZDaTch9ZZAJ3/0iYzZ
	GgUkOmGA7lfqw/5IFEp54=
X-Received: by 2002:a17:906:d54d:b0:afe:ad5b:f5b1 with SMTP id a640c23a62f3a-afead5bfc21mr211213066b.32.1756217765581;
        Tue, 26 Aug 2025 07:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHu5yBUNwUPm3nbE+zuzorDGOPuG3MzOV4aYvUUcyLWMynZw4XvOj0i94B5+qukwasIYzTxndgQxZ33xJmy5Cs=
X-Received: by 2002:a17:906:d54d:b0:afe:ad5b:f5b1 with SMTP id
 a640c23a62f3a-afead5bfc21mr211210066b.32.1756217765108; Tue, 26 Aug 2025
 07:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-2-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-2-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 26 Aug 2025 16:15:53 +0200
X-Gm-Features: Ac12FXzbh8Y8DGHuHLJ7OSz8b36bnloHK81OpbH_5vSmTKvSi9EX93YUME4u2l4
Message-ID: <CAP4=nvQJXe-uMAs1MRLuZwCCq7ZjnA8svnVxyvzT8S7hcVorSA@mail.gmail.com>
Subject: Re: [PATCH 1/7] tools/rtla: Consolidate common parameters into shared structure
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d4xFd1UDCDpqb2BGbTVh18a-UpPXLdOGK5FKB2jbxQE_1756217766
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
>
> From: Costa Shulyupin <costa.shul@redhat.com>
>
> timerlat_params and osnoise_params structures contain 15 identical
> fields.
>
> Introduce a new header common.h and define a common_params structure to
> consolidate shared fields, reduce code duplication, and enhance
> maintainability.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> Signed-off-by: Crystal Wood <crwood@redhat.com>

There is an idea in the osnoise tracer that timerlat is somehow its
extension, for example, it uses struct osnoise_options for some of its
settings. But osnoise is a distinct tracer from timerlat, and this
mostly creates confusion and IMHO we should clearly separate them from
now on.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>


Tomas

