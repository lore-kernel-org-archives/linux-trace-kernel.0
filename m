Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF8D198A3F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643589; cv=none; b=XtILPaw1spzprvgdrckDAuUxYNYZGsD9SM1SYbswNjdYcz6kidmGkgZ47BtfhNQ16uL5xk+s/Cn6sMIbPU1X+99KkDINFvX8kZ8QBmQ7g9sGm+GYMaO/vdYxuozbPwtRBEsMuCTLIogm3gqarm1mupQKf8MNezgMrEYRMqmMn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643589; c=relaxed/simple;
	bh=z+hoVd7HmcKFQ/KTSjaNHnElfpGbfutvAi0O+nOwq8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=He7BO5VLmNU38MA6euigViOUVF0FB8l4ytBjqlYGzejCpqwRtrHyCwUFhXcXjZW/rcJMBGpXEQkVlEmjZj1iTiTvfLAbVnwjIwHpT7yY7WGcVX+OZG1WHUmGnnchRZ6yK+TN3ZXo64duITP6CuOwnvFw5oXJoWV/Gp5dLG58Koc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SEetEDZk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEetEDZk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728643586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+hoVd7HmcKFQ/KTSjaNHnElfpGbfutvAi0O+nOwq8Q=;
	b=SEetEDZknmECjNs84g2tda2hmGutCB1vK+gIJTK/8yMfHgSaxASeGihub392da+Q0ZNI8r
	TjM2BIWpDQFPUDQ99Yzl2zRyIZ651MxPTzbKEjPKg/b3z+v4KErPGAGKjVQwp5qpaA4S4C
	K8olNC+N/lDKL4g5pQgRMQpAm2f7gFM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-x5HE5QQ0MFuFgJ6nSDPitg-1; Fri, 11 Oct 2024 06:46:25 -0400
X-MC-Unique: x5HE5QQ0MFuFgJ6nSDPitg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a995056fad9so140198866b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728643584; x=1729248384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+hoVd7HmcKFQ/KTSjaNHnElfpGbfutvAi0O+nOwq8Q=;
        b=urL4mj64OgNMuuC2my6/QlB5ZQiFI65ew0DSXGkVmYT8Tz+UmsxcDq32KIIp1FM5sI
         scNCfnfzoF94E7dZrlb3CR4x9Pnspmk4mEIZu82YyK7BhrSAWi68EE3nTuXHWe8NEtw6
         2sXfjwaf4XhzVGHEjR2Sltv3IJXF8JApJpytlST0vzDg6tw+Ze/aUGF/F8wNf/lcYWT3
         RbCpzWPwEDEM7EB/Y7+AsDdCDtjj9Ixm4H+5yxnM5bo3bDJPFSkEQPS2MwcM7XftMmrH
         +mdsLc0rP2quqbgeu5i1KM2ZUy1EO7IAoUM4wl8uVPeaPmqjnJTQU/E3giRzZn1+dpcA
         FZww==
X-Gm-Message-State: AOJu0YxLu9CsYU/5wjPEe8tWVkRBox8yi3VtiR5/nj+sfdCjRNTXYU/8
	76d9lBXF3gwV7UX6giXtfA4URM2AW+bDIx7mK1T1gxgMMqtkrLY7iEbiv5Ac7pq8nxz5AdrLqx0
	TtV41iV/UY8apQSkHxZKdn3rNT4maqXR1Fp48Kqph+O3CAfeTBedx/TvPoP0iq11rebyfXeDhwL
	styEX/oQHhf+syZ4bTILX6CDjLCo9xL4kmjcR8C1+0WCtz
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id a640c23a62f3a-a99b930e9d1mr174007766b.13.1728643584073;
        Fri, 11 Oct 2024 03:46:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtGhhBlf70YMusmFyFxV2Hg8ctO2ko4xKYjA3/oDoChs6bbjyeJoZL0B/QuxqamTFe+DEMr33r9jaigl1hvCU=
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a99b930e9d1mr174006566b.13.1728643583712; Fri, 11 Oct 2024
 03:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004095014.2492813-1-tglozar@redhat.com> <20241004095014.2492813-4-tglozar@redhat.com>
 <20241010160637.4340b269@gandalf.local.home>
In-Reply-To: <20241010160637.4340b269@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 11 Oct 2024 12:46:12 +0200
Message-ID: <CAP4=nvSk1ZWM5NfU1oov+P1245BRuKuSp-6M=fFQ9Xpo1EVSSg@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 3/6] rtla/utils: Add idle state disabling via libcpupower
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jwyatt@redhat.com, jkacur@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 10. 10. 2024 v 22:06 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
>
> If nr_states is zero, this returns 0 without ever allocating
> saved_cpu_idle_disable_state.
>
>> ...
>
> This returns -1 even if nr_states is zero. That is,
> save_cpu_idle_disable_state() can return success, but this restore will
> return failure.
>
> -- Steve

Oh I see: there might be no idle states to save,
saved_cpu_idle_disable_state doesn't get allocated at all, and then
restore_cpu_idle_disable_state behaves as the saves weren't saved
before. Checking for nr_state should fix that; I'll send a v3.

Tomas

