Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34150273816
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 15:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765898928; cv=none; b=Rk+v3wxSAX0A/R8vYiXcQp0sR91KbkU8ZTlf82F6R9suKuQCGcIOyaEP7dIRnc1UMNldDCP5Nn/sF9TXiFT+ghui1XWeKbDOSFzArC4wwVpqAZsTnosbB39ASG7ygRMBGFkAFreC6nG30wbVUaDdaNHsNK1AZLOCBh7iL2KCSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765898928; c=relaxed/simple;
	bh=KPp73ZDZISUoJEigPxZYHEgew9GVEIVBUDnEVLaFyfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH5rIsVFFpVpR/uX/5yfYvgWMiahs+We8RG7UWdi+DrKfPW8hwukP43mEc5yQuD2vpWOvcNKH8Kwoh8oAMrglo3VmMB2ZkqI1rNFqlieNd+faOnSPJUwDAv97CDGLLLLYvZ7ZQWy6VWae1fVdhCUqKkjR9xka/o67E0n/KDHnc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gs2wVODN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gs2wVODN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765898926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPp73ZDZISUoJEigPxZYHEgew9GVEIVBUDnEVLaFyfw=;
	b=Gs2wVODNjmc7pHYwPDcj9YjGT2drWvsxHYuOXs7/T5HqUe0sYcmCR0WZA/eeIrjyfHVJdS
	ERQwWtJDjsva9XMyWSvae9GV9RYE5iZKEdkmF6q7AZcAhhWlWVwoy4Jwl15E+UnKcsTOYa
	Thq/AdvVmxpLMaV+PSApa+jit9Om1Ic=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-hFWnRgbeOy6_FolU7ZEkRw-1; Tue, 16 Dec 2025 10:28:44 -0500
X-MC-Unique: hFWnRgbeOy6_FolU7ZEkRw-1
X-Mimecast-MFC-AGG-ID: hFWnRgbeOy6_FolU7ZEkRw_1765898923
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-37a4e2bbbc0so20635561fa.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Dec 2025 07:28:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765898923; x=1766503723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPp73ZDZISUoJEigPxZYHEgew9GVEIVBUDnEVLaFyfw=;
        b=k5jjEwk/oWmq4zMrSdufRxJ6p0LGlj38/rdfvDHUpsb60dqifrmO+CjgLh45j2X9m5
         AwH5P93ecNf+3GQ4rMzDghO+6kCmHfO36kCGBKoyWf3mi0VWNQ99YDaP77uApRAIsGbi
         e6fx9JaQ5fg6S3GeCu3VOzbKr0Y7CQ7m0UFn4mq7PBPfFvYzDeDr6wOmdo305ESbhxoR
         +vznhd2Gh8fRO4aehFZC/bOZgg4uHAo5FPUMOotj3+hriic88d7aXYhT7QwX2L8G1jaC
         yBNX/KoHeGHLsRlsudKgBW/RHHg7pSZ7zlPPUwe4+jOzQNrOys6fEh9RpXvlcT6OkZYq
         LsIA==
X-Forwarded-Encrypted: i=1; AJvYcCWhB1oVSRFWXNDWPjy2Woxl8rZaZiVrbc31aYNv2uRW2eJZO0nl5W2zxEs0jG1FcQr21PDGoQ5W6yaVdkO+PhyiWsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJSmjY69D1tvQrxEeMqLbHy2QrSCFUmh880Sz0IrM2dF1uMAB
	USTPYXJiLoXMg2fyNT5SGBRfCk/qAp0n4S64N3QRfUooRpM2loqZ9fOn/FRIy2JZWYHcwy+rcrl
	nJyAgFDrtQMCoeDD6Qf0H509wOa2TG+OtWMt67s2a6dQfmQwIPJDcrykmllDnpN/C1iTEg7DT0g
	IFF7vDk1z5MK1bgjHRMpViwmmp3XvwxuwBHYEFMt+7Q3gHsTmy
X-Gm-Gg: AY/fxX5islAnst6tBj/TSo18BGBEGJ52cbTfk6vscKN6eyOW/1Y493PcsubZ24sMA9m
	e0vqRbsHchH3qbLFQ3/C+C15560kdp293BQhR01gvy9eC7nN0rpAK3Mjp05lvrzgC/J+l8/V/4F
	9tMyfqMe73P7uYK2vTIuNBN8syyDgNVFQM3nvtREQAem/gFrSju1GG0Injvv9Lw96/iQ==
X-Received: by 2002:a05:651c:1502:b0:37d:1911:7a45 with SMTP id 38308e7fff4ca-37fd08d0905mr44048301fa.42.1765898923292;
        Tue, 16 Dec 2025 07:28:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+FqwlCHRZY2ci2+AaSIr0FsmwIL5yBqXELZMi+esVUobc1Jip6JKSY5jgM4KTAD5KRr3T53CCSdF6Zoz5Y6w=
X-Received: by 2002:a05:651c:1502:b0:37d:1911:7a45 with SMTP id
 38308e7fff4ca-37fd08d0905mr44048201fa.42.1765898922886; Tue, 16 Dec 2025
 07:28:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126144205.331954-1-tglozar@redhat.com> <20251126144205.331954-4-tglozar@redhat.com>
 <yha47my7tmcu5yvbwelst32ipectzkhekxdorgpxws463kxsno@fcw5vv674yo6>
In-Reply-To: <yha47my7tmcu5yvbwelst32ipectzkhekxdorgpxws463kxsno@fcw5vv674yo6>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 16 Dec 2025 16:28:31 +0100
X-Gm-Features: AQt7F2p_H30S6K9lNynhT8i9XhooeGnWZpSsXe78pGq74lzOtiCGZ4dAiaf_Jhw
Message-ID: <CAP4=nvRT-sgGqL4=YoawJHzaEC=_yvRz1zaUnapu9qckQaWB4w@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] rtla/timerlat: Add example for BPF action program
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Crystal Wood <crwood@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mqseDCZwGvM_rCH6atWArwLa0cEETassTPJQ1EVBO80_1765898923
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 16. 12. 2025 v 16:22 odes=C3=ADlatel Wander Lairson Costa
<wander@redhat.com> napsal:
>
> I couldn't understand the need for the `filter` function.
>

Oh that is copied from stalld, where the dependency list includes .h
header files. See our discussion from before [1], I promised to remove
it but forgot about it while doing the rebase.

[1] https://lore.kernel.org/linux-trace-kernel/CAP4=3DnvSJq1kOUvBRwy_5Fh_FX=
=3DQx-=3DxiRfngSyky1eVdZsGrrg@mail.gmail.com/

Tomas

