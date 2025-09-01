Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B02F3C11
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Sep 2025 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736654; cv=none; b=ASJ0i3TVyf739JE6CD4HoAr9zhXBR6Z9N0GuJT3MQE1NTqFwxCDJ74QFWm6mwSUuqFMRiwVPvTS+57wqwKPiUsQAbaN9a5AAPXSgfmJy9yt8BBKVjLt+PmddWNPBbluy9BgHVDLrq4+GOrshIxLUB+uLWRXV4naf3VFZ6mabhMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736654; c=relaxed/simple;
	bh=qAAqpIJ1sZ+WXhv9jSL+yNgDxW9OQV2lwq5CpKUVeRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P4kufR3z3cPP/TaFkcJQzMC2ALSRiHz1Palyfir9lNkJcsJujcDd7+CL18GeMXtHrIy8W7IMdV5XdLK6NftLrCflUQ++g7JfCPUDJIr45oG8x5I8XWN8iz9Q+GErgeiolg5ti06rkXGOy6NLeh/2AB/N53Rs6oEEzf31PLQ5kiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Taf3q1Md; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Taf3q1Md"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756736651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DIgXc9xeVr9BBWUbZa2zZn7PQsTxZuClMXuY+mTcrPY=;
	b=Taf3q1Md13l9t/XFe03udI8KY30l3Kx+jd8BC8QX6jrdyLhIvBw7lZFDcYmgnov5RbWQ0x
	fLjEcIlxIdFypVI+mGFtgh0LSJa65RfzLSA4ZpSv8X1eiDNz1myl4F3gzGiwl0AyMq5kGG
	1f0EwqzdlO50y876YlgSg4SG92ShRIM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-iUQtIQXgNza8I6ouz_FUuA-1; Mon, 01 Sep 2025 10:24:10 -0400
X-MC-Unique: iUQtIQXgNza8I6ouz_FUuA-1
X-Mimecast-MFC-AGG-ID: iUQtIQXgNza8I6ouz_FUuA_1756736650
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-afeceee8bf7so423058166b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Sep 2025 07:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756736649; x=1757341449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIgXc9xeVr9BBWUbZa2zZn7PQsTxZuClMXuY+mTcrPY=;
        b=RdE0lUu8endTNxlyj4s7xNa4n2N8SIltUFsolVbM/TYqpdwfK94PRQDOiNr/VoyyyH
         ZN2sXTbFK3w/5VIB9tJ2qpvvtE56VFTjrXEXpGoIR5c3PYzpR5jpiR96wfhRJ80l5B+s
         EtdpS8BIAcMC+CnqXL0EaaFl66J4QuxLPWaiSCzk+BqGKYbBp23vvbtaw+rCPvp48qdD
         1mCh/NHWSdaSONPHWkRJHIpEDiL8Kw8ktmkmUsCRdQ8/DgWqovHXFWXQZkrORHs8wERX
         3p57uJ1Ohkc2mTTjihDnO/TUtlyH15MjoFTr33K9zIw85A9JHsrxLAgdaoNMEZL55enM
         V6rg==
X-Forwarded-Encrypted: i=1; AJvYcCUgb0zLK6QHOftlx1AigHPMmv9TAyNnwP+EYyFmG6aUMpjHSqPhc3uAh3rnJPTD4OQGiWyctdAhc8Idcicgvm1JzRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVXOFAv4999nWakgKNl6SoVQ2mXKNihypIg2ttkCJbUzfgVx6b
	abz3LfAtSPfMBBs6NCcwHFnikcPXJcax/TXInihzjBgikF4W21qbBnuM2WnG6UvqLkNVlx+gFx6
	EL+P/SzTNK46RS81z5ZOqIiwfoaK0URFtijZgSKNg0ZAn1ImNgjInT/Kedis5aXQpEueJOABw6N
	+7wGGHem7Q3QL8qi+6pfOC4rXzUnha8kj3H/32TGEI1mIA8IJo
X-Gm-Gg: ASbGnctGgXv/wYjJSgNvKj2YGNpTdK3p5hQAGX2ePmj18HDRr2FvM9Or8F7t7eI0Rxn
	xfRnvc2M3yuO5Phbw6/Xx4UedqEhwqiRSyPwxL3TuC4gRGe5rTXlucRZHUcwDl7fCpuEP/MKyIv
	tQ1bDSku/ScHlIj2yo/FD4Y5x0pFBfbej+c7QmdPGGSQTlyFSDWiE=
X-Received: by 2002:a17:907:94c8:b0:aff:7:4f12 with SMTP id a640c23a62f3a-b01d8a2778dmr739983866b.5.1756736649581;
        Mon, 01 Sep 2025 07:24:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGn4xY0HH8qCdFSyK5OTzgVVXjJ12ZvaUYluQIqf0B2o60S1nht1dzIxUJp1Vzx3IwFYsWYnxkzkFbv5Vovccg=
X-Received: by 2002:a17:907:94c8:b0:aff:7:4f12 with SMTP id
 a640c23a62f3a-b01d8a2778dmr739980466b.5.1756736649117; Mon, 01 Sep 2025
 07:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755018581.git.ipravdin.official@gmail.com> <96f305f622de233c28d4ed9f23583b4d6ab2d1ac.1755018581.git.ipravdin.official@gmail.com>
In-Reply-To: <96f305f622de233c28d4ed9f23583b4d6ab2d1ac.1755018581.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 1 Sep 2025 16:23:55 +0200
X-Gm-Features: Ac12FXx63Tybu7ddN4dNpy-VZp0KptTHLkvU7Nm5KFnqWm7q4-qPMwNWVhWSlzk
Message-ID: <CAP4=nvRZ_SY_xdC6N8LkKUA=a-QP5gc5SMgBr4jod6+tu0TFeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] rtla: fix -a overriding -t argument
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TAAROBpFWhOr_U4-izngtUf6jmZg-9agp-0fTZjPT1w_1756736650
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 8. 2025 v 19:22 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> When running rtla as
>
>     `rtla <timerlat|osnoise> <top|hist> -t custom_file.txt -a 100`
>
> -a options override trace output filename specified by -t option.
> Running the command above will create <timerlat|osnoise>_trace.txt file
> instead of custom_file.txt. Fix this by making sure that -a option does
> not override trace output filename even if it's passed after trace
> output filename is specified.
>

Yes, this should not be overridden, it's a bug in both the old
implementation and the new one using actions. Thank you for the fix.

> Remove clear_terminal in timerlat top as it removes "Saving trace to <fil=
ename>"
> line from the terminal and is not used in other modes.
>

This is not the correct fix for the issue. clear_terminal is needed in
timerlat top (and osnoise top) to clear the terminal before the
updated status is printed, the fix removes it without a replacement,
breaking this behavior. Also, this is a different issue that appeared
only when the actions patchset [1] was merged, and should go into a
separate patch with a different Fixes tag.

[1] https://lore.kernel.org/linux-trace-kernel/20250626123405.1496931-1-tgl=
ozar@redhat.com/T/#t

Tomas

