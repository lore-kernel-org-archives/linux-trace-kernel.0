Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6734399CE6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 13:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593916; cv=none; b=DcEDntW9K/ftjeMNUXFhOTmcdBIBcMGJZzzgn14DJoVi5GoI5uBGMxdXGFFzE8uvbyaDEm7/7i9MxKvG/5F/djzQf5Jk56G9Hqc4hMyTGn/sa5PLB2bxpvKuovxq/7/OJSlT1tnFU4lNxxgt4J+9jjXCvrJQFNVbcI9ypN1X+HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593916; c=relaxed/simple;
	bh=WoHckFkc1wZr+e0BiLVwmRHZR75XXaGkse8IDrsqvNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nN4pEWRBykvH7hRsaNGcCljF1CKSK2Gt7kDUdHU814+Ib7w1X2Xv5h2C4/Nj7Tho0m+CJOPCK7t2fJX7TBk5FmIFVOMi4wnOMSHMcM1lRgd+3yExaGA+XetRVV1su7V7cTwxx9gdAwvNoAd3sWx1daitSMhnC/OVfQHDsnD7oSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTVBVYv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTVBVYv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778593912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WoHckFkc1wZr+e0BiLVwmRHZR75XXaGkse8IDrsqvNY=;
	b=NTVBVYv9CsB2A1cNsa+XQZZ1up2V0X5K0aIpZ+hX+PtMJ6IKP92UYdXixxc/UNIkQKiswh
	OdKtYowkzsQ05NLc3t2+bfVLEdkqw8eUx+7ijXC1ORdxxlUggdm8Jpc0y9l6JzdeOxiz4i
	/3BbA3h3z2LCWKZfmBd4jZQ1YWKTUl0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-8o8ea7HFM-GUnjaEe-AJQA-1; Tue, 12 May 2026 09:51:49 -0400
X-MC-Unique: 8o8ea7HFM-GUnjaEe-AJQA-1
X-Mimecast-MFC-AGG-ID: 8o8ea7HFM-GUnjaEe-AJQA_1778593908
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b940da8ec09so595473066b.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:51:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778593908; x=1779198708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WoHckFkc1wZr+e0BiLVwmRHZR75XXaGkse8IDrsqvNY=;
        b=LBMCqwOSDPjliiBx4aGo2p8BK5+UXJ8TyIexbGZk2RL22GWKd92+vZCm006Ho97F0X
         GjeAdKWeDovZd5deOXwL4HzztPBPh8Gs4b+LGWW5bMY0U41HiFT7O8gnt21MFbpTXeYR
         jewhPorjCb4E4sUKBbA6/Cfhpx+gwbAFbo0nNFzT3Z6Zw1LYTTdrB91wMoFErR41ynvf
         Vje8Bq4qE4HpveZkG1KhK43rkTfnH3wHwYwN46gaqcBHssWX18yzlCySsUFHoNFCRdEQ
         u8g8GNplKfeTKCVMAHBP0mGDrBdfotmwxzJSUCaObllfi1NhW1lm3O8DYdZXwv2pXd9I
         PuIw==
X-Forwarded-Encrypted: i=1; AFNElJ8G2v2I356u9PGcK1I8aU8Om770E6p5Y1GyL4ugdZlvakG/9qRlCezyrL1VBnkLG9bHrJuUDKQKZyhKtRKbKzFpuh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+608J9phEJGSW6o6ss3Hyd3agjgMFb19ytDDSkvR4DzQoz4Ce
	DGy6oDMVZL+qRUdU/PuQeiaSjhXS0yLBoTSDouHn7BLY/FkWaRhZrAil6j6HLXyYrvYrzIAzQFZ
	taPHGNud13gOxJlYnZcxQhmDC2VBQWPRRuPYtWmcU6PRnB1FWrrfVzBKshkbEtUWiyvNFOn6uAk
	0EvnbjgW/GiAkU0UnNaKniL2eOi3GQ3IRvrf3b5jOLDrl/MQNr
X-Gm-Gg: Acq92OFZqkJSpX7y7q7Gnpy0XncVQPg9pWt/8LdbqvfZE4AzNajqpwRZ0AEv7ylKVRv
	ypASINCfFyfZwMHI/4X7WYfDoFwBEs9ERK+KbUHEaVge2xEMHJ+A9e7x2H5s4wZomN5YBCBCY8k
	eSgnU95hMFJWMO0iGrAn80zZt5dAOMSlCO7eRE7XNozb1Xvz87xqFejOKD8gSslThChDSfr/Gs1
	Sr3xg==
X-Received: by 2002:a17:907:6d16:b0:bd1:4da0:b0d5 with SMTP id a640c23a62f3a-bd14da0c8f7mr475860966b.17.1778593907853;
        Tue, 12 May 2026 06:51:47 -0700 (PDT)
X-Received: by 2002:a17:907:6d16:b0:bd1:4da0:b0d5 with SMTP id
 a640c23a62f3a-bd14da0c8f7mr475859166b.17.1778593907400; Tue, 12 May 2026
 06:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511223509.1483323-1-crwood@redhat.com> <CAP4=nvQEnCG2vabuA52p3bmGo7f1_-pZJ2b6rr5N=bKmaBuqxg@mail.gmail.com>
In-Reply-To: <CAP4=nvQEnCG2vabuA52p3bmGo7f1_-pZJ2b6rr5N=bKmaBuqxg@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 12 May 2026 15:51:36 +0200
X-Gm-Features: AVHnY4L3bMDQRg4gL6CfDMWaCh4WOg-5Yq9PzyohuyNCztBf5pR7r14LNw8MR8U
Message-ID: <CAP4=nvTPdJkWRKKv5MhRL9oAEusENDqKGxPxOxvKO_sDoddYeA@mail.gmail.com>
Subject: Re: [PATCH] rtla: Stop the record trace on interrupt
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Wander Lairson Costa <wander@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qz6uRxcH7eeNeH35H5ZZlvWGSz_BiCX2bjlY1oaN68o_1778593908
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 5. 2026 v 15:50 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
>
> This affects only the "new" (since 6.19) --on-end trace option, right?

s/6.19/6.17/

