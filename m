Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738DE30F95D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383454; cv=none; b=ZuDjRlX6B3SzRbLdU0WVADcX24F3ZlFXO2jKnNwpzYGTu8/7qI9OCuieWDDoPosBpGGpL6oXchibGbyTmIYO4bqrAquOCO0WMhQC7yMK3ckiWfHmUYHpxEsDxX4mhskitDtQJiHWsDUdUHvzIJiXoQy/zE4ppG3ofPPhp45QnFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383454; c=relaxed/simple;
	bh=c8L6HSo/zN3rXMUH3ZqsTsqpBeaIloN4bIJIfK/qhXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYSeLvGM26h3LZNfdZ0TRf40HaSPsGiah0lEugWujb2GV6Xvfb8pSMpZmyfMisNodalETTlwcHLdule6ftN9Z4+ZcxC23W79gNwu0g2arVqbrzNA3K1HYL5kgbkaPJxeLS1PWbSF8iDUiyjtcQEkITqtY0dhg4azKXI6oxgSXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeQWjLpT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeQWjLpT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756383451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWaOgO4jpoluN2Qx6CVMt0VGgcSixW+/nMYe+GAjQss=;
	b=UeQWjLpTgikxzlFbzNLg5XZggVco/HiNudLWGm5fJuxPV48UE8ZJ+66FehteNNs/eu/5D3
	GDb8k/Qk8TxOTrqZX2OO8Spf2qmihjhnpTCECqeyZTnnRajYGmDaHCguU2WgZ4Mr6uwWLE
	jUkkhS4HI7J0fDropwGQju0s8O/W4bg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-Q6CthPJ1NAKDt1bRZOS6Ow-1; Thu, 28 Aug 2025 08:17:30 -0400
X-MC-Unique: Q6CthPJ1NAKDt1bRZOS6Ow-1
X-Mimecast-MFC-AGG-ID: Q6CthPJ1NAKDt1bRZOS6Ow_1756383449
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afedbb49d64so66940866b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 05:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756383449; x=1756988249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWaOgO4jpoluN2Qx6CVMt0VGgcSixW+/nMYe+GAjQss=;
        b=vhX2uXfjIf2avM9Ycst+uTJcC33HsL9KuPQ8wzA2qZc0jYfrR2iHpYd3F7EKhENDOb
         ENlpq+7fBIGNy5CIy+n6fPbAnrL1uBFtWML/E4HxMaFIfIIu7sl/Kk9j++0zPDaIcbck
         t9g8WVg/4rDHIKuxg0IFCNEo+J2RklStZz605du3h6rOC0uMTJ1CZVjO2dLr+fCH3NvY
         45mj3A90DfTqKE20V+FKfdawWrUAyy5Ck+u4k7cezee4SIzvs0AzpM8ZsLd+eREO/jFI
         wPUSAtpm3w8KtiTRItMsSgjFk4I7fCXtPbJ0M9xCLUtlRzF9OAEAasz43ZGX5wpBk+ke
         Hy1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWjPOYfvfx6LTODJ7L2Sz01U2j6hGrmVP+8rukFvQkYKKcQguQWHAm+7dbRudblcAP44nUzs7DWQPPML/vp/GUXcRI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1IULBpQCwom6N+AW398p5dMDBIWLrIG8f9M3IbJ58oWD2stdS
	6r4260wwbTryKZ9GHVhZPYOsWOkpPZtt1tPEkc/bTgXf6EpSI9XoWG7YB8roptYuAJvG5+btTsA
	JZhez8aWY9M6HJjEOEVlVE/YeItGfpYg934C1N/J1KZngNF3C4WFwxUUAAoVSgAGkgOq+OPvk/R
	smoXUs6YdacqZPNbwitEF6UzigHKjf/9YEknh+vIA5qHU0MWtc
X-Gm-Gg: ASbGncuiRIJWUN8zpRYlGkFeysERKMEGhqM/+wORtNLNKtnxSaenvi7PQrB6LeJTQGO
	l+aBqPKKL/AA2qYTdP/msjcOqrQRO9R8kkR8m/JRzNtoiVS9Pa259qozQ6GFv3WqXQVtmcjg3TQ
	FEXqcQSRhBT8H5XR/SpKo=
X-Received: by 2002:a17:906:5a8d:b0:afe:9e58:754d with SMTP id a640c23a62f3a-afe9e587a44mr706156866b.64.1756383449201;
        Thu, 28 Aug 2025 05:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC1NApuk3PreLppjRFJa8Sx4eXldlrKGys952/ULp5a27DqEMQZaYlRXXz/vQZczNt3zV7J2vH1LrA1VhXB2Y=
X-Received: by 2002:a17:906:5a8d:b0:afe:9e58:754d with SMTP id
 a640c23a62f3a-afe9e587a44mr706154866b.64.1756383448779; Thu, 28 Aug 2025
 05:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1755018581.git.ipravdin.official@gmail.com> <358400afe299a82806e9969570cd3009621bcd8c.1755018581.git.ipravdin.official@gmail.com>
In-Reply-To: <358400afe299a82806e9969570cd3009621bcd8c.1755018581.git.ipravdin.official@gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 28 Aug 2025 14:17:17 +0200
X-Gm-Features: Ac12FXzIu27PrjYZAW398ij3mtMrwSHWcJpQFNT-nJzeNWxfQFJ1-m0bEKi5keE
Message-ID: <CAP4=nvTfYc5YmzYAoNEw7z4sjFEf3ANa7eFMXfmvp6kGxtS63Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rtla: fix buffer overflow in actions_parse
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: rostedt@goodmis.org, corbet@lwn.net, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GjsoBCzQZKSUi-QjCG4-xYeFjaQP3mWG7H-nctjHU0c_1756383449
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 12. 8. 2025 v 19:21 odes=C3=ADlatel Ivan Pravdin
<ipravdin.official@gmail.com> napsal:
>
> Currently, tests 3 and 13-22 in tests/timerlat.t fail with error:
>
>     *** buffer overflow detected ***: terminated
>     timeout: the monitored command dumped core
>
> The result of running `sudo make check` is
>
>     tests/timerlat.t (Wstat: 0 Tests: 22 Failed: 11)
>       Failed tests:  3, 13-22
>     Files=3D3, Tests=3D34, 140 wallclock secs ( 0.07 usr  0.01 sys + 27.6=
3 cusr
>     27.96 csys =3D 55.67 CPU)
>     Result: FAIL
>

Interestingly, I don't get this failure on my machine. Maybe due to
some compiler difference, the buffer overflow is not caught. Thank you
for the fix. Since the "signal" field is next to the buffer, and is
written after the strcpy, this might corrupt the PID number reading
for a command like:

$ rtla timerlat hist -D --on-threshold signal,num=3D2,pid=3D42

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

