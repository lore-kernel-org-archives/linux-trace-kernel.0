Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F45F13C8FF
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219337; cv=none; b=QQ1eZO3xZ9qlOblLHM3SzyugFE8KJfV6qts9Du640p/wot/u2nY4kpII/g/yTmKVvORPPTUiw4/ONr6/takO+gc9Yvdn4fKICXwVtAdKCUBWRo3JJ3y/jG9NlPqNIS9/JxFy5JzLbulqAXATtmJdfH0MlkVDIrh+MtXk/FdOglU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219337; c=relaxed/simple;
	bh=Nho3kwq2nJYg03F8fc8YqUZGpcXDIm4zTv2hq4HoDLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgBMx3pBs44vdh3VBByl7z7pqReGXZo+KyMxzMhsKCqMMCUo4a3xrOTWeiuv3GQPvFen/LNBSsEve6pZcjZbOtu5SDTNO/VNyquS/cc7Vudk7v+LainYubdsakg6qLP0atm4J7XSlhTRJiClNpTlpoacrNq4ZC2zLOWTEyu5xDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ORxnvcfD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ORxnvcfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754219334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nho3kwq2nJYg03F8fc8YqUZGpcXDIm4zTv2hq4HoDLY=;
	b=ORxnvcfDkSKfrmYRAgze849n90HKBVQAPMcIFKx6nKoSS+jppOmOpIsbYhO4oAYEs0b2xJ
	HaktMGQznHeu3pxhoqLizlGEdKPugBp7MTXG4V5+kDy48ussK0X10jgrxIObHsmSM/UmrH
	qn9eeIM6muRH9pJbT5tT2VMBXdhvPmw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-mlSku7v0OHC66-jkk-tSiA-1; Sun, 03 Aug 2025 07:08:53 -0400
X-MC-Unique: mlSku7v0OHC66-jkk-tSiA-1
X-Mimecast-MFC-AGG-ID: mlSku7v0OHC66-jkk-tSiA_1754219332
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-af911f05997so355157766b.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219332; x=1754824132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nho3kwq2nJYg03F8fc8YqUZGpcXDIm4zTv2hq4HoDLY=;
        b=i1O2BseGyrDW5pAkoJpvRTkC7/Ln8+r2eGKJWRDwMdRZl5VVHg1IF4K9xTvG4pit36
         yXqu6fcCCnIIXS31Y07j7X7hCNp0N1LIT//DwW2BpgrXcsTDgErZ5MgyzX5Kwo63VFFM
         h/oApmE/d0+R59Ikq6TdNb6MF84I5grwsN28Otz3fNtzZXt9dpGaufogsSCdmxdTM7xI
         laaUJXLzfy3FgTSuZ3E1wfqMejm1gdUbIBtR2RJttU1qzAK7H+oMW9EKwATCDQj52GXP
         4/jgRfoiOYe7LJW3Flwgzwor+FgsI2UtHgTqShwKPc66LiAcvERXmat+eckOPClPG1PI
         GtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKiJVXk7hNb1lEMKsuEXR6+F6Ir1hqWnNrcrWh6K4nERAqsDIGSijP0lD22gHILUMsJfapz3e53Nuni/9VY/vB3H4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwThQJMf3Gmcoq4maph2AuSNNcLPogoQeQ/hjy1COGEgbUWO1b4
	b2ngz577CFnqDvyKWxAhdYvxccKFvy1Erg+Uft0VvCI6PdUMEdq0hNBXU9JXbrFe40WJZioThv4
	N40Dz4mjfKTDpQn37RqE4/iT45/Yh9T1P4EVe7gwzrXXLhyTWuvqZ/G+xtFLLEZC/4L+83fm76M
	JWh4Ih3yaPJY6eh3WdbcvbK61v3MMQj3WdQXvwx2Gpsh30tWVP
X-Gm-Gg: ASbGncvnFJChfWJq0Rr4bvp/wD3ly7M+Un2eFZcDSygXFnCD9SXXOEpDqNOuhNUvwsj
	tKtwJ5M/LMZyWtpBp5PWoWzNzLPPDPRzLlQkHMO6iSPYqW4IWbOV1sQTdsoCZZ09U2W8N5c0QDk
	pcIMuecoaxvznyM5BCnI/00x7fZUoBMPDZRkUB6xXl3hNBbfqiJ/hVBS4=
X-Received: by 2002:a17:907:2d08:b0:ae3:bb0a:1cc6 with SMTP id a640c23a62f3a-af9400097b2mr787294566b.16.1754219331688;
        Sun, 03 Aug 2025 04:08:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoe45St9oJl/hQdOjEm2D20HS5WNbCe0tPRvD+enwLjtMGO3xb9XsDGGOE9wa+2ShyOKoMeZbDp6sjKrYjJGs=
X-Received: by 2002:a17:907:2d08:b0:ae3:bb0a:1cc6 with SMTP id
 a640c23a62f3a-af9400097b2mr787291666b.16.1754219331241; Sun, 03 Aug 2025
 04:08:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611135644.219127-1-tglozar@redhat.com> <20250611135644.219127-3-tglozar@redhat.com>
In-Reply-To: <20250611135644.219127-3-tglozar@redhat.com>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Sun, 3 Aug 2025 14:08:14 +0300
X-Gm-Features: Ac12FXxmbK-i4e9CuWRaXuohysrCBn-W8fQg2VCfPR9TMziF-wZwNzYbRYZiUN4
Message-ID: <CADDUTFzG4mvTyN4cBLzqkGBWkPkDP1-jzOZKxosxP+X8rKLBew@mail.gmail.com>
Subject: Re: [PATCH 2/8] rtla/timerlat: Add action on threshold feature
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Chang Yin <cyin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fq2xURl9N-_IA3CvqKcsC_fgsV_3I2l6JHSs1XIInVY_1754219332
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Jun 2025 at 16:57, Tomas Glozar <tglozar@redhat.com> wrote:
> A new option, -A/--on-threshold, is added, taking an argument

The term "threshold" is ambiguous. The use of the term is inconsistent
across the tools. In osnoise top and hist, it means "the minimum delta
to be considered noise," which conflicts with the semantics of the
`--on-threshold <action>` option. To avoid confusion, I propose
introducing "low" and "high" thresholds and updating the sources and
documentation accordingly.

Thanks
Costa

