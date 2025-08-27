Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57C21B9DA
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756294443; cv=none; b=NKmz8FXd6WOH5wf/c5expU5EVhbs4NPRoi7WCKeQtKiaKtVmqBTVChGvLaZ168CbXUQb/OKa2pNjz7KUxGJUWya1/B74Rl4KbYRTy7QLOws8JKsM4djg17uaVTzH31JLz44rxFCXfAq/KcNARuvW+Bgjop/hMrttYX/dQVuR5m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756294443; c=relaxed/simple;
	bh=5PnxxqVLr73U3nVof7qw0XykiE9Dqn224cBtpc4rpJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SvwanMahNrdiUkYbvoDG3WbyE05mz8l0j18614P2cfRB69jcmtHJ8wDp2/BpaJu/yyVjOkhOimS+3F9hJADwIbD8f46W+t1xUrMcZiaCIGUF7tKSgx8jYqGRjikkpdc9uTpfiqv5rFy4OG3kt59+/3cdCqsWF70U/UrH3XGTRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aYUmhe9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYUmhe9J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756294441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhYvpzvG1QLU6WXqIqVYTDuWBcmmAiykL3sskQNbuGU=;
	b=aYUmhe9JEO5Xn5CiXX+shQQF/xKVYLsJK91QIIWDpDXr2At29lSXcM0eqMiYcHqrk8nHJx
	3qgUYcb/GidIpJMFz315txKl2028YVUIjlcACATrtljOv8wqqb5yfi9AIrdMFD0glhGYfa
	cbspRQgc3pLCxWZ4eYW6xZFkTizavL8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-676-4n800O_4NYqOrpLbDPcsBg-1; Wed, 27 Aug 2025 07:33:57 -0400
X-MC-Unique: 4n800O_4NYqOrpLbDPcsBg-1
X-Mimecast-MFC-AGG-ID: 4n800O_4NYqOrpLbDPcsBg_1756294436
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-afcb7a2d707so460144866b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Aug 2025 04:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756294436; x=1756899236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhYvpzvG1QLU6WXqIqVYTDuWBcmmAiykL3sskQNbuGU=;
        b=GS4Ha5s6QgRkDLN6B1MsNfy8xIme+eGUVv0zWlZ97A9TwiGM9NXIV5jwjynedKpjEB
         hnn7oj57Sp2RVG02ucowj9SLyyRHlfzDvtH0JyvnlscfE0jwuCxLtoShW030vebbWhy8
         UcM5G3j9zxWnBOQ00fSL2hsQkDYE5I03yOUTZsKw/jiZsFJCAKAAmfHhKYB71frCSJF2
         f2TZenwn7QRzy4KOJZa+esO2DN/uT8DxVFIF6FJhcSmkzQ5aRWdqMECfZe0edMRcLRN9
         11CLdLf0nrDxNUeV11CWQkjgWJOFpFLVRLFtENQ4e4Yw8mIx8iowZuWja4mSNEOzPzT/
         /qBg==
X-Forwarded-Encrypted: i=1; AJvYcCUECPI3IW+dK3W68/GJV0FSgM/h3ak2tGqcsun+saQl0X3XCRegTBgJPT6JBYwzDvNQhjm9KZz836i0zLfAkx7tGMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4M16yTRMP+X4DWsgpJDSvTMrrI2CZ1JsauTJq4nFBzZYld7rG
	ku5B0sTbfnU+TZ621rcu6PldmdyQUWK/5PsaIq6xy986D4juibkSD6WVUZc/W67evwQuTJrBlIN
	6wg7a8O5xms9hvaXd5OxnN8zzbTAybzw+V2LeMTfTe/amoLzPltSFmrmNK4ErRJcRV+/ZxT6M5m
	dVUkz+rT2WQ52mi5A31iSxty0vuC+6iXh8XO31HeqsSjmLwccv
X-Gm-Gg: ASbGncsv1TiLL77yakJVsnux/aQ4GOeQAxx35o2BqYyfaWJpan+vJVqV7MD3bsfQcml
	Z7nLaup1kbBDwPl9pQDAvapr5d2t+2i+IXjD2pX9L7H1HzrG4jljvpdhz7LnzhgiNwwUaZjk3Ci
	wdOLHJAeB29eGYTAcP6YiPVnbDC9p3wvm+mCiCgsXxnP6ZcnM2B1s=
X-Received: by 2002:a17:906:1d13:b0:afe:9e58:7550 with SMTP id a640c23a62f3a-afe9e587a39mr527084966b.19.1756294436444;
        Wed, 27 Aug 2025 04:33:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmIKrD07d7hjuPxla9NTSl3j9izBPR+tnmavw11VnA4HBsOChrmKiyTz2UynMaxOYddvXvX3Zgoa/zntkeltY=
X-Received: by 2002:a17:906:1d13:b0:afe:9e58:7550 with SMTP id
 a640c23a62f3a-afe9e587a39mr527082866b.19.1756294436039; Wed, 27 Aug 2025
 04:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821035719.137161-1-crwood@redhat.com> <20250821035719.137161-4-crwood@redhat.com>
In-Reply-To: <20250821035719.137161-4-crwood@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 27 Aug 2025 13:33:43 +0200
X-Gm-Features: Ac12FXy03JtiusG0Oc-4rDQzGmJuyZ_UAHRwaFa-B5ETltlaZyS7WCJg8tnRx-o
Message-ID: <CAP4=nvSVh-KUSMC9vT_59+wwmOHe_+reObznXZ-o5kd2rD_LNg@mail.gmail.com>
Subject: Re: [PATCH 3/7] tools/rtla: Create common_apply_config()
To: Crystal Wood <crwood@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	John Kacur <jkacur@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _nkR0SeGfDxeoSxsVBJWmRaICLepoitPVdHBFl8V84I_1756294436
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 21. 8. 2025 v 5:58 odes=C3=ADlatel Crystal Wood <crwood@redhat.com>=
 napsal:
> At some point it would be nice to have all of the common code named and
> located correctly, but it's a start.  Do we want to stick with "common" o=
r
> go with something less vague like "osn" for things that relate to the
> broader osnoise mechanism rather than the specific osnoise tracer?

For functions that set tracer options that reside in
/sys/kernel/tracing/osnoise and are used by both osnoise and timerlat
tracers (like osnoise_set_cpus and osnoise_set_workload), I think we
can call them tracer options, and make the function names
"tracer_set_cpus" etc. Or just use "common", that seems fine to me,
too.

> +++ b/tools/tracing/rtla/src/common.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE

Nit: the newline is unnecessary after the SPDX identifier, other rtla
source files that don't start with a copyright comment after the SPDX
identifier (e.g. timerlat_bpf.c) don't have it.

> @@ -44,4 +103,12 @@  struct common_params {
>  int output_divisor;
>  int pretty_output;
>  int quiet;
>+ int kernel_workload;
>  };

It stood out to me that kernel_workload is moved to common, while
user_workload is not. On a second look though, osnoise has to make
sure kernel workload is created, but has no user workload option, so
it makes sense.

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas



Tomas

