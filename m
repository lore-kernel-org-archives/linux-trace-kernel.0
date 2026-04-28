Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FE83D47A9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369150; cv=none; b=OyFclVzxSkZ14DjCWdLLM7nW9zdfbpbatAWCOVGWmuXP1C/Gy9Ayehizk2gBQruV1j3ZOUk7fhXZ8dz8pNW6pC6UvtwTHnUtjIvHoBkz74mjZdIuPFUVvJsmErUhG9MkZslao68DtllJvwg1WJmnL/E3nTb1lWGB3o0oFUj40U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369150; c=relaxed/simple;
	bh=6FGqR85BhZJ6h8elPP/cyihqUcN7Hm8wATEVHCmTtkc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dkj5VHVFtZ1+ygA6SSMa/8pnM4qTpw2bbi6c4m8UP2QfjuMT+ecrfEVX6IQ9zciQ6cpn9a96ujs4x+l/GwvYf0aScvldgnAiuUjtCut7ESZmc8GtRHI7WJYdI4cG5kHGzEJMbiEzgmwpMaE1PetaIZqnQTo19UCL5xaU4fbrDmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V1xSssYY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V1xSssYY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777369148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6FGqR85BhZJ6h8elPP/cyihqUcN7Hm8wATEVHCmTtkc=;
	b=V1xSssYYKrvg5oGAwU6Cw3o03RdMUeTuJ+Zg90zx4WKbclgMqW7wIhFP0Zq4XTv9f3FUBi
	W34SfWy3aTMSGa3KKtzsAvexxjbeqPIOWi09bhWvv+anwCKtMg013TtkievuA+lWjtgrdx
	xo0OyOuFnx5T8ekRI/asyFaHjugLwSE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-iq6uH_GeMLWxsF1CyL83sQ-1; Tue, 28 Apr 2026 05:39:07 -0400
X-MC-Unique: iq6uH_GeMLWxsF1CyL83sQ-1
X-Mimecast-MFC-AGG-ID: iq6uH_GeMLWxsF1CyL83sQ_1777369146
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50eb8bad331so78058451cf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Apr 2026 02:39:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777369146; x=1777973946;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FGqR85BhZJ6h8elPP/cyihqUcN7Hm8wATEVHCmTtkc=;
        b=HR7Qp1SI2dH0RcDdVbinC3IyIqGnu0qGFIfs6iTCULRDa59VdkF9LSYpEN6XmWzOuK
         9MlzHOqxpvvCQHXJo187n+HGw9DtQZjFCw9QJ+/OdEvE0k4xyxpQVCm3Nlz29je5YI/Z
         2kzsIrIJYyReiAgMGZ+w08uUatiZzftZ+S6T12+tt+QDJ0o3XcbvB97JEj4foM3i8dvv
         yz1KPWSp/lujNvRiSPp9LPflLDkQA+0USzMKRUikVYNM87FX7AT9FyERtgaGMXDLth4T
         t1cLypaGW4sUS7x2J2ZDWTz3y7IaKTsd74Etd7nPFGPlr6Arm5asmee0lyDaEi9d+ejb
         YbtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/m0dhMoyH5Z2Pvf5pJvB73s8PCU7QwtQRQJczUiGaUFdhSKCtwuWy3Nii/ZSsnXy7H1DwegDfE4fA9ftFGZDtgXlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkBgzL894drM6gijY5rK+zFg5ZF+iSs8zQRLOZ13dszScxHGWZ
	3bENKizUWMHWJr4i/9fdEc/eL+yQvF/8z4tS8/muM6TS4GrxBbQYCvvS6boVoOKdQq56bH5xLj/
	4U0VEQKt6T+FhxURb1LYA/Zm0VfzkxTQ6prykj3ZYMl5moe5R7sshIk29M7z1LzuAi+PY7dlkqA
	==
X-Gm-Gg: AeBDiesulwh/z9AyAuSeazQ2iknpTpLXze6hMfYKrhAEReLX2AttAJojYh8qEXfSd1/
	PXnpVWQslJgffVvlIOkNC3OcntUNR9fa0W/6IGhT/n3S1bRxuNaSBce/RjrJdh30pzW9UYzhewm
	MgfSei0O6sCdh37cCDPYtH/CMNmrdtCTcjWlB6CJ4oE3wiynEUrbUeH3nstTaRHNvXosQmizGpq
	jbAZq0plYplrY6lqsJ4nndyw1Sm5cNv1dJiZ6lLNEVsBcLskEY26LuWTnsnC2wg70oIXdCpzz9u
	s47rF8xKMmrkmVbDQc6q8lhd90WRwTM0tk4tt4DmwqZz+BDnPLoIPT9i7YZIcRpUfBwoFNv8kqh
	JpwTrKwd7IplhxcrBEjXX7O/xyfkb3vFYolol
X-Received: by 2002:a05:622a:590c:b0:50e:578e:bb18 with SMTP id d75a77b69052e-5100e1d5c86mr30854671cf.47.1777369146461;
        Tue, 28 Apr 2026 02:39:06 -0700 (PDT)
X-Received: by 2002:a05:622a:590c:b0:50e:578e:bb18 with SMTP id d75a77b69052e-5100e1d5c86mr30854401cf.47.1777369146052;
        Tue, 28 Apr 2026 02:39:06 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100da4d2a7sm13443931cf.6.2026.04.28.02.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 02:39:05 -0700 (PDT)
Message-ID: <b4a0f46f1b04462409b61f240aafbcaf6603c5a4.camel@redhat.com>
Subject: Re: [PATCH v2] Documentation/rv: Replace stale website link
From: Gabriele Monaco <gmonaco@redhat.com>
To: Matteo Martelli <matteo.martelli@codethink.co.uk>,
 rdunlap@infradead.org,  Steven Rostedt <rostedt@goodmis.org>, Jonathan
 Corbet <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org
Date: Tue, 28 Apr 2026 11:39:02 +0200
In-Reply-To: <d0a66f985640388ab13fda6f7d66c5ad@codethink.co.uk>
References: <20260427131709.170505-2-gmonaco@redhat.com>
	 <d0a66f985640388ab13fda6f7d66c5ad@codethink.co.uk>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3dHs9vrVygW5tVPLDj4MaudipON53JM30hr8u7hL65o_1777369146
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matteo,

On Tue, 2026-04-28 at 11:11 +0200, Matteo Martelli wrote:
> Thanks for addressing this. FWIW this looks good to me, however I've
> just noticed that the same article is also referenced in
> rv/runtime-verification.rst with a slightly different format and no
> link. I think that it might be more clear if we had a References
> section in rv/runtime-verification.rst, add links to publicly
> available articles, and then let the other pages point to that
> section when needed instead of duplicating the references like in
> this case. But that could probably be addressed as a further clean-up
> patch.
>=20
> Acked-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
> Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>

Thanks for the ack!

That's a good point, I agree it's better to go ahead with this small
patch and I can make a deeper documentation cleanup later.

Thanks,
Gabriele

