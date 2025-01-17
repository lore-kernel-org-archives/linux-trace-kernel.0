Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B461FDE26
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737111248; cv=none; b=ta77SKlrYBHeBbDghs6+NajoTdmklEKGBFr6IhdrPAzVjzs+kYQ79TFHbYDeULmcZVqItUTnf2Hoa9w19PiQz9Dh9eubk+3r5uaLVB2kLHS/fDHc0JMj/i0EOSmRxtQMOWbPDEw3Y50rwKiNXjjJO7mkydHRMNv0lPf4tzagYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737111248; c=relaxed/simple;
	bh=8WfirOxhWh/RGcuKLOW9AQKFqmcs7eNj92KUq0VHJFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gxSJHXI4qMEzD84dMGun/eKD3uUiQlr+EA3QjEZ2hAMc6o+HMNPwsY757LpL24y87tTmzMkUJRut+XL56Mijs2L1BDi0iN3EVzalGtB2tVlawNHAaFKb3AIYvFXD64dHdrASRSu54LCACjrMvJd86keclE3WCNJGme2WoHBiq+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRLrFcji; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRLrFcji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737111242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sP33ifPRKY/r1ilta5y4R0kyQRh+pwj/230KWpfCHlY=;
	b=eRLrFcji9fLyyfPA7hnTfOR9eVRd48/ROm+QzaYRDA0M33x+j3Kam9qKHnmI6OQHVPOvWD
	PahNbMGsrZk7y0bieNJtB5U+OrXmfffE/c73g6rAYzHhmHJmbJixCSRBJ8h4wzymi9kSAd
	oU07xk6nTk+9otuWwIKsVD96UjGxQ2E=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-B_0sUL-xOlWMha-c0vktiQ-1; Fri, 17 Jan 2025 05:54:01 -0500
X-MC-Unique: B_0sUL-xOlWMha-c0vktiQ-1
X-Mimecast-MFC-AGG-ID: B_0sUL-xOlWMha-c0vktiQ
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-aa67fcbb549so173006366b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 02:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737111240; x=1737716040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sP33ifPRKY/r1ilta5y4R0kyQRh+pwj/230KWpfCHlY=;
        b=s3HuLKPOjRqGZANWDyRZdj2nuBsB5wj5KtX6yUB+hy5yL6l4FHhYMYn68xPdwZpAbk
         q4H7ojAi3efOtrXROVu9gESYJUcU5Psq4wJ7v/vY0MSN98A8QBxzMknq1/tt5mW75vDS
         ZSDS//x9WwThvUs5hyi/wrQZN0YHCMLrkxSv2q67SP/tCTxpXWLLATpUdsbIoKq5GIv9
         XKmVMc1EcDtkWLzkiDdwI2gvTI+uBsMj+EVpxC6qGq3siFDsFtIchrSYl4x6bSyawmoy
         ktDQOQDRVHMAlEkeRisXF1sfIz4XFLSvcFgEziT18r/5LKmMy/8pZMrhaI2nPJVBDonq
         4/gA==
X-Gm-Message-State: AOJu0Yy/6nqEy3DwKmoyUiEblH6O53ul4dgc8QpCpgQQcSST4swtOIaz
	inrKBGJFdSGbNfMdDoiLVMO4Y47hWUHhzxRNbMPzC9xk5cQ5FfWeMh+RU6hlFRP0yN8PVMdS2LU
	v4HxwxZdbLWsqPKejmMeQvCl0YbWZ+oZXr+PIQDi/O8czvroTVjrwUAP+7rVae3s1L7nyGdAgE5
	THOCa4cb4Fxg4md6awcu4fKI88eAnc8XW1TPiPiM+/SVCm
X-Gm-Gg: ASbGnctGCwTxF7tpuCF8pflJW5PdCS4ZoGcQOKVw0q1LQIQgGECfr9cd2QL/h0OcKHC
	Rn52xFHxTywmAEVhWWMFPUFliEByHbhO7pw696LRI/PJl6hLQKOS7O9hMCGIIn+fuXLYfIA==
X-Received: by 2002:a17:907:70b:b0:aa6:8e72:e50b with SMTP id a640c23a62f3a-ab38b3d6c45mr196710066b.56.1737111240282;
        Fri, 17 Jan 2025 02:54:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwfDChaTVNCQZEBcLPGLTN6Gn09uUsXQfrGBYNkU7kOtBZyIRAKoQj/F7xRmfdBF1+mbgIIag2b3OWLY0B3MQ=
X-Received: by 2002:a17:907:70b:b0:aa6:8e72:e50b with SMTP id
 a640c23a62f3a-ab38b3d6c45mr196707666b.56.1737111239835; Fri, 17 Jan 2025
 02:53:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109133852.360122-1-tglozar@redhat.com> <20250116201808.3c8721c1@gandalf.local.home>
In-Reply-To: <20250116201808.3c8721c1@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 17 Jan 2025 11:53:48 +0100
X-Gm-Features: AbW1kvYZYmRZZayY5Rs23oQJBj8xbUhzj6nVNtfRoX-BczHdyku-oVKLxOYyJ0M
Message-ID: <CAP4=nvRm8Sp4n0J1oWS6D-KbzQ-KeE4eW1cw9CZ8mU-Woi78+g@mail.gmail.com>
Subject: Re: [PATCH] tools/rtla: Add basic test suite
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Chang Yin <cyin@redhat.com>, 
	Qiao Zhao <qzhao@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qic0BU4lqa5JeJpAaym_h4xLQx8IhsDQ050DlN9QsIY_1737111240
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 17. 1. 2025 v 2:18 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.=
org> napsal:
> I tested this out, and it failed the last test:
>

Thank you for testing this.

> make[1]: Leaving directory '/work/git/linux.git/tools/tracing/rtla'
> RTLA=3D/work/git/linux.git/tools/tracing/rtla/rtla prove -o -f tests/
> tests/hwnoise.t ... ok
> tests/osnoise.t ... ok
> tests/timerlat.t .. 9/9
> not ok 9 - hist test in nanoseconds
> #
> tests/timerlat.t .. Failed 1/9 subtests
>
> Test Summary Report
> -------------------
> tests/timerlat.t (Wstat: 0 Tests: 9 Failed: 1)
>   Failed test:  9
> Files=3D3, Tests=3D20, 451 wallclock secs ( 0.07 usr  0.11 sys + 10.57 cu=
sr 74.09 csys =3D 84.84 CPU)
> Result: FAIL
> make: *** [Makefile:89: check] Error 1
>
>

I have not seen this when testing the patch. It looks like rtla exits
without any output, I will send a v2 that makes the test engine print
the error code in that case, it will be useful not only for this.

That being said, it's not like nanosecond resolution rtla-timerlat is
without bugs:

# RTLA timerlat histogram
# Time unit is nanoseconds (ns)
# Duration:   0 00:00:02
Index   IRQ-000   Thr-000   Usr-000
over:         1         0         0
count:        1         0         0
min:       6102         -         -
avg:       6102         -         -
max:       6102         -         -
ALL:        IRQ       Thr       Usr
count:        1         0         0
min:       6102         -         -
avg:       6102         -         -
max:       6102         -         -
rtla timerlat hit stop tracing
## CPU 0 hit stop tracing, analyzing it ##
 IRQ handler delay:
1442069690324.42 us (23632738287847.00 %)
 IRQ latency:                                               6.10 us
 Blocking thread:
                               :0
------------------------------------------------------------------------
    IRQ latency:                                            6.10 us (100%)
Max timerlat IRQ latency from idle: 6.10 us in cpu 0

Maybe after enough time repeating the command I'm also going to hit
the bug you saw.

Tomas

