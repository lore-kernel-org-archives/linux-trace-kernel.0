Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CD5356A11
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 12:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768221558; cv=none; b=nE9p8Nb/mm119zdzGC9rZKNmaMBKjGnVV//XL+cnGYR04f8jeWQZH6z8ROmdgAUzbrj/+TfnvAbeKkMyIMoKd8TU2FXtGMbr1EJCKiiiUYhXyDOyQCYu3oL1nxrc7Txdc2CMgTRA4xqzTbGA1X4n/UK+xUzdsAadv5AXLBQ/r7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768221558; c=relaxed/simple;
	bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nzIyydMBFIda5pB1V4tY2iB3VBVjuVd1FRXRKwmQ1jtXYa8PIF9jr1F/YyV73P8YnBDEOIz5lyKxsVqtDkodiqn8Nglxe015G/vX0iNPxuwk4eLmZyBKtHfFdbLOU9ae474rUVHi/hxJVbmD84kisVeioX+iru5uVkFtJ4g3Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z1Rkhz04; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z1Rkhz04"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768221556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
	b=Z1Rkhz04RE21eprrJc5oAZs1rckpqwON6+JRWGgnucQEoZXttSy+BS3Rzvt4Nnv7ZvJtWS
	h6LoMhDXI/XHEprB3jkkbSb303jUo9nX1YAeaUU1utkuWPcb/SI1RXl9wighYKnIWWBjpA
	cz6dlKS8AfJd0tf+eY5zkpRyZlHg3CA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-5tLYW5mQMAe1D3ICqnvxpQ-1; Mon, 12 Jan 2026 07:39:15 -0500
X-MC-Unique: 5tLYW5mQMAe1D3ICqnvxpQ-1
X-Mimecast-MFC-AGG-ID: 5tLYW5mQMAe1D3ICqnvxpQ_1768221554
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8715c50725so112089466b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 04:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768221554; x=1768826354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zPmMnIUeMW/xGbc72LiA4361srUY4NN+6TfLE/qZZo8=;
        b=TE2hkCCWSSlmWBva2AqErF1HxFf+EW/l+r3YicA4bqOd1GKWRcFTeT4bX/KwVuAAzZ
         gNuvdvMu+rj6ck1cTyI82wqAY1XSwbjw8v3RixFmWhT1bvvTfel/iZwb63qsq8rX+8u6
         Kdwbf/E7gI2wsjU5EvtlOKDsup7TsZf6bBlOn2f64cJclKKLjAfqtntOyO6VlNCEwOHQ
         pvP/b5e0isFK5i5GdfBP4dJ+AGfzs+/DTAHD41qZR5R084Hvmdcy+6mvZRz9oLCaOFm4
         pjeOSzsFHl1toDKdxpGI/XDg0KlOCjLNU6h+xlx4XpFN88fulwrmo+se4EPXq/VX+izo
         xwqw==
X-Forwarded-Encrypted: i=1; AJvYcCVF6GVg1nyAsqxMwJM8VGq+wZaMJuhiTIfEsu/26FHVf3QWqV0r5B1B6+3oaUyryE7Z1kEZsB9QytU3wQoQLefikDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRrrVGBDbr0ZPoxl+M2Bdqf9bd/0IBbVEMwYDS66AeMn7r0Vf3
	MjydIWSvaT1x09OBpoWV/KMqZXeE+UjuCM3ZMpRYShaiOQ3CeoPEXin0FBnddDw/jMEE7NHB90V
	HGVwqtr9ANXKuYfXVPH3ZpcUXbxgPshtaKlzLFvuTnNTZ3QS3dDQGWGTrv0BDBqonTM7tfe3ctZ
	Gl2PI6UwgjFRwpglQNu5+x6UWbbIxXIQPEqcXh2xzG+Ni3nJak
X-Gm-Gg: AY/fxX7JKxm27YR8xQOLXOhuhmIxt1S/M+rRMFK8mHmtZOPMak8C6NiI6et0wlBdL3w
	BKqZxR/TNEeNkk6Sz7PBL9g7ih9okn9TC5D7vPuC1EwTOW4L9CP9yb0JAddCji2b7T+PckAcfSI
	Y4atj83PWry5yItbuqnLOLC4a71hH7TX+hZmYgDjBrPMQWQGZnDTR7DDR4e5pSD5h7sZ1InaquA
	3t8AE3RVI+OyD3962IThAvU
X-Received: by 2002:a17:906:d54f:b0:b87:718:5da2 with SMTP id a640c23a62f3a-b8707185ecfmr471401366b.1.1768221554304;
        Mon, 12 Jan 2026 04:39:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH3+obAgvpI3XGqVs/x4/87zfrvhtWt19z8TWgbdUn/UY6KiSt7yf30J8rO+jMO6vWIwvauNVnXpg2n56+W+L0=
X-Received: by 2002:a17:906:d54f:b0:b87:718:5da2 with SMTP id
 a640c23a62f3a-b8707185ecfmr471398866b.1.1768221553899; Mon, 12 Jan 2026
 04:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260106133655.249887-1-wander@redhat.com> <20260106133655.249887-5-wander@redhat.com>
 <CADDUTFyEJxLHKHiaxya5QxW49kzWdhj=hzTygQYa9JPUOe8Zgw@mail.gmail.com>
In-Reply-To: <CADDUTFyEJxLHKHiaxya5QxW49kzWdhj=hzTygQYa9JPUOe8Zgw@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 12 Jan 2026 13:39:01 +0100
X-Gm-Features: AZwV_QiopI6W-8pUbNsGpRjKtlB-Ai6Lekl1JIddbiz00sbteCjQLnK3nAzzz4g
Message-ID: <CAP4=nvQaunTud=CT8Dp4cYCuB=m7t_0VsCsvmxRtBxC_T6dvzg@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] rtla: Replace atoi() with a robust strtoi()
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ivan Pravdin <ipravdin.official@gmail.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-trace-kernel@vger.kernel.org>, 
	"open list:Real-time Linux Analysis (RTLA) tools" <linux-kernel@vger.kernel.org>, 
	"open list:BPF [MISC]:Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hi62dixWZ2BtrWsvnClVCA7xmtn4krOb3kUvv6J2Frc_1768221554
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 12. 1. 2026 v 13:28 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> This commit breaks parse_cpu_set
>
> ./rtla timerlat hist -D -c 1,3
> Error parsing the cpu set 1,3
> Invalid -c cpu list
>
> ./rtla timerlat hist -D -c 1-3
> Error parsing the cpu set 1-3
> Invalid -c cpu list
>

It might not be the worst idea to test more than just "-c 0" in
tests/timerlat.t :)

Tomas

