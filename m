Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBECC2185BD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653746; cv=none; b=tmPSGuLe68JPsnEp8HwooXvMXQuZdHqsCqyrRkJO2pl0HalQmDTn53pgRJiAvKKXY8n24PwpevIXKWhko+XswqUmxl7EeukuYkukdV2z/HaHSYFq8aMDLo6C7NIseNQhynNKjjxrSAdqudFuTBgeYK7bvRw/eHnpuMLzhQHVIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653746; c=relaxed/simple;
	bh=69rWR0/aru+5xlZntFf1i6hw42uow1P4BoGG1sg3XiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oXkL4ZnKJaty0RiGD7IhhvATODy3Enef5Vn+pgYdGPEpUHrMFWQ62NSvuyloynGBMTmJXCqj9eMG+yjvG3/niikBN38gEbpF+mLVM2mEnHINDWcxDIjOD2dhpdBZGFDSYL2PTZLV5u5yfzDfkQt2bmWXthVmU0NJPoDSgHOYciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BeA4JmE4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BeA4JmE4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728653743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=69rWR0/aru+5xlZntFf1i6hw42uow1P4BoGG1sg3XiU=;
	b=BeA4JmE43nuPRuThqu4HmAzn+gbJWPpho9pNJ1uyO2f6Yb/nZajMZhTf7syif1QYjMv8Me
	ePZrtcWvSSYXhNqHTMhKnz20QS6Ljwwel2oY0brZkpz6tXEjRAa0IIu085CkxszjUX/ZCn
	pOGusi7GNzN7TnBKI6UysoxC/Oaha4Y=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-bK_dAaI1OAS_Kw0zLISUyg-1; Fri, 11 Oct 2024 09:35:42 -0400
X-MC-Unique: bK_dAaI1OAS_Kw0zLISUyg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a994cd8089aso151498366b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 06:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728653741; x=1729258541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=69rWR0/aru+5xlZntFf1i6hw42uow1P4BoGG1sg3XiU=;
        b=Q3L9hZCF+uSbyb8yvaSYrKEy2ZGXZRrAlRaS6OJYQpyVjpdJJUJTOBbE4KEqumhp7T
         onrHAleSf2/H3dUScx29QTiRBcMyPdrRj12B0Z59KCCOUaUwhd4KpE0giw1QcDDMZlRW
         49Yu4vrlZgkSGfTos/gonRhkrG3qyN4ARgsaS/5fs1EV1HsW8+2KHNrKt6o0hXWNY2on
         mzGe3lADvZu4NRnKocUYWczODqoemn+f5WpClSF6hJ/+47r/EWhhumjAUOMog5FVO1KX
         KSWCEBwc9QALs581ssSVkS0rzdpzDxpnDQNJTYSktRAkkO/5ImsPGPFyLxTqu2/v0qJJ
         n5vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsFLRlFVlzPHYSndVW9hKrGcd7UxDJ/F+yiuenLwo1aU5ihgks8QANL2jbJfQwoFaIx+f9aXxNW+m8iKbj1AglzdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXPdwNePNcBLcZg/CqgQ3juFnAdjaGHAY9Pktv3xdAvmeWNdwW
	Q4kphna6ssKf9HrmokvKWFctKF+J/MeM15NPTA9HMms9SuNK/iMY9nTv6Hqcx9etHdv6V8MOpKJ
	Z+vKwWVNhy3+PJE8f1wHEtGQ/W0XU5hqqVMvidelFIZmbWxMQ70JNuhJte6K0fw5ByALfKPARys
	RXXCa1aogLgDPqYk49jUzOQrC2cmGiUSm2/8llKDZM1e0e
X-Received: by 2002:a17:907:e647:b0:a99:4ebc:82d4 with SMTP id a640c23a62f3a-a99b95e9a86mr226740166b.55.1728653741211;
        Fri, 11 Oct 2024 06:35:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEXJeRdZAuJH4LkEt9wzO/lfW/8ZLnIzxuJEPjwkQTXQ6PNmGW1RAfif+J8kUcM+DUOJLdLuTq/HytDuqXYpM=
X-Received: by 2002:a17:907:e647:b0:a99:4ebc:82d4 with SMTP id
 a640c23a62f3a-a99b95e9a86mr226737566b.55.1728653740864; Fri, 11 Oct 2024
 06:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <HAxOlk1o3vhrAUlyVMtrSLGP39PFS1TLfGT9C9pB6cXgQpGB_fiNeGSuWS_4-4zeMxunluuBnkc4Y-k_c0qrlstVpYQvgfkJN2p_VnfMO-k=@protonmail.com>
 <20241010202956.5aa773a7@gandalf.local.home>
In-Reply-To: <20241010202956.5aa773a7@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 11 Oct 2024 15:35:30 +0200
Message-ID: <CAP4=nvRQUmDVyveYxvC1BQGGjsH-vm3=TeXJCC7uQG+0cUsKww@mail.gmail.com>
Subject: Re: [PATCH] tools/rtla: Enhance Error Handling and Readability for timerlat
To: Steven Rostedt <rostedt@goodmis.org>
Cc: furkanonder <furkanonder@protonmail.com>, 
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 11. 10. 2024 v 2:34 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis=
.org> napsal:
>
>
> Tomas,
>
> Can you review this patch?
>
> Thanks,
>
> -- Steve
>

Yeah, I will review it.

Tomas

