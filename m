Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0B16B399
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718720563; cv=none; b=qIRfTBiBF9ehxBKNNvjrgU50egzh56pMYs2ts4T7SCmLl+S2+vHGkBx3i3feMf7E9kNjk3pKW8Kaygzpc5+NMTAR/QTfn/r5li19u40EUIdgQvB/i7BCxKdr38gWlL86bx+587RGyMSiaHzB1zHgTwtxSOvH7zZLaZ05/8qkexQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718720563; c=relaxed/simple;
	bh=U96e2ewUPGUwtDxZmjwxc3i6uzrFQ77Dn0ewyfhwgas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHPpQYAazDyjVuhgBbGaLNLbF+OA9K3UcDFG2C+v356Cx1PWDwHUuoJBL42YUBn7ba6AbldHLIoTGgsc9q+ZSgjntYPZE3WoDtHyTSNsEvicAwVrD9r4lxfjDP8Pd6aiN6A+K0sY71sJy+ef0VgoP2aWvv6e6MWlyqmftNOkotM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LAHP0OV9; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LAHP0OV9"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6ad8243dba8so27244926d6.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718720561; x=1719325361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U96e2ewUPGUwtDxZmjwxc3i6uzrFQ77Dn0ewyfhwgas=;
        b=LAHP0OV9310lpWuj18UtKOepuKRku28QRHcYYbeXvwyqd3mC6YypVZmXP4knIgOk3U
         UcIcgRO3POk4KsL5apSQ5qms+iG532MCIAMx+nmkeJddCojXiBEjm3xHwyClDYluKrqC
         bL0yZT+E2J6NGfwoF9JXNGlm1xU1feO7RKMfrsl5TZ8iLYjecImWqsK7xtNs2RBynCx4
         8TTT+8bxgDZHiBbpa+p4b3CJKc4mvinAya3OM9KnYHUhrXUGr2JNAyEK3HMSkiYFDpcC
         1DEWviKbCBfzvx+q9IqNHpi0OfdD6Kzpy/TyKuD3FVtxme9agtHDtr62bgNUI9s31dQ8
         lZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718720561; x=1719325361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U96e2ewUPGUwtDxZmjwxc3i6uzrFQ77Dn0ewyfhwgas=;
        b=axGndWx1Gbqsu+ussTSBRVyV1p8AdpBlXle1UnMt5TsVfVTCfbVxzCAnhrScOw9gS+
         x5J+LEOoeROk41NZKXPixI7Cc9CrGb2YOLW58A9S95jUAiq3Mx/zee8N1Qk8Cm8Qut/k
         ddHJ6ZrTxWHxjmkxv4WzUJnYisy1AXt2R94zHD0tJB/KRbMRcwnNIa2PxqwIWvC6H5ZT
         vPAkP2XTlPCADvtnc2SRpMqQVSR141kW+cyiNP5YLGbNrgxLVRPGTRchKHO3FKxrNmc3
         KI/PUOuN9AYbVvydkc6elDFsfWr4QpcUUDdXAKU/0zKXAxc0ajwirJFWL/eK9IxWbWeG
         atRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCw8dM+jbJJydVJLqeysGxD8uBQ8UYyPEh549g7qf+Cdg/izHRdhIpye84qbfvS9dg8aBvm0hWIWjpOXpUgZxf6PWQBXKHg4qcNDM9JUx46zTX
X-Gm-Message-State: AOJu0YyySV3ryoBIT3MNp6W24Ngd8ixLzjAHGK5tll4MdkOBWfWWakqT
	JPgSsv6CJC9ywqNcdwG4Vzq4+YBfFzMlJ+ChuUAfsa1UpsXpWGHtaEYmnRgUddCxlGpBXcFxKKX
	mHPYRmCm/msZiEneqiwRknGfgwHTzyp9wqf6l
X-Google-Smtp-Source: AGHT+IGILaqPOZ2ED8ohKLixFiVuadcnP7+nr4oNkquXFmcYtsIiJ9uoXj8gq8qFXs/ZH/i6CuJp0jOeYz/h62OJDhY=
X-Received: by 2002:a0c:f345:0:b0:6b0:7505:8846 with SMTP id
 6a1803df08f44-6b2afcf228amr120592576d6.39.1718720560961; Tue, 18 Jun 2024
 07:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-16-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-16-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 16:21:59 +0200
Message-ID: <CAG_fn=WCNsF6HGALo0WN2POcyZ8ngmjpP9Wgqb9hXd4P9Z6geA@mail.gmail.com>
Subject: Re: [PATCH v4 15/35] mm: slub: Let KMSAN access metadata
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Building the kernel with CONFIG_SLUB_DEBUG and CONFIG_KMSAN causes
> KMSAN to complain about touching redzones in kfree().
>
> Fix by extending the existing KASAN-related metadata_access_enable()
> and metadata_access_disable() functions to KMSAN.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
