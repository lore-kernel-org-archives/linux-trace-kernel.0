Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5E2215F6B
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405869; cv=none; b=Z4DYC3EV2IytWTDDNjU/1kEeibun1ACtM+5Vu2erNxcKiwcNMjIaeEJ3C/z9Oq+kpNtk8dfn1lY+PgNxklXeNkQP1FE16TzfkUCee0qqEos+B9IFEV5xZVGqYOh8exzXtNwuGKSsAahN+S2nmkacFfS5J16JS+jxCVBJoQZe45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405869; c=relaxed/simple;
	bh=lYSrYjyITg6FoWhawfIVBWYZIkjwQZwO69z6RDWV1Pg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sshJ14EsQgQLIzdBxZ2hihNmOSMN1wMWAFNWdL1qXJQcHbJ5lf1CMyZsVSLlkPgnVNMw3Q1icpW0VjmI7Zc4Ylo0YM+ZI8Fq82az+I8Ju11yudplzPdkOSmNYObD7jDoYPGjLb5AexVn3ndASlbOttUajTJYIGk15M03tOSakbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DcwiajMF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DcwiajMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759405866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lYSrYjyITg6FoWhawfIVBWYZIkjwQZwO69z6RDWV1Pg=;
	b=DcwiajMFyPuYvA5B/TJG+d8GRI+ZYOe1rnn+fD481+HH1cG0rNImYbJavwzjYWJod2yWSu
	ol/4U79pOrkAZKILTeuS0iOAR4Fu/AeZ4/b/UEEjyMG4fnWhErO/CTlOejKc8a5dXnTDPf
	VEgtHDPNB3RtZxG/S+Xa0acITA4qdrw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-eAejpRa2O3Oh3Eh8Sw4zlw-1; Thu, 02 Oct 2025 07:51:05 -0400
X-MC-Unique: eAejpRa2O3Oh3Eh8Sw4zlw-1
X-Mimecast-MFC-AGG-ID: eAejpRa2O3Oh3Eh8Sw4zlw_1759405865
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f42b54d159so652179f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 04:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759405864; x=1760010664;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/UdOTSJuFeuz61ETEUJOhsl+GvhZM/EvZcDfUCVmxI=;
        b=bBm7g0ENDl2GCeXWUi3xOGZN7HEVvbIM9FAwZ0l0Rhe1+hcfHoWUYsLpAgQ2FB2x/B
         tT8ykJq4K7nSYad8wefdIAn/2xxmBe3E1NV/QM4FgJRR/OA7DRNzSF7bnd0bK58HB9co
         9ft/7CVOOqefJuQcdBir6i9dty2lO30VkfoeDeCSPyXBpmkr6Grt8caizUVNOt4w6h8Y
         JawoEncg6sNFWwLtOcxia6NnyB92uY55JkL4hdhswRDAnl2+qmi/ZyZBjIj9SyPydPcl
         xWEBhqg34VR2p9Pa7SbGxj7rGim8xMO8SeXgfJP+RMUYYFwUpYSjsAoA4AhbnOYJswaw
         caYw==
X-Forwarded-Encrypted: i=1; AJvYcCUh5wH8wAoNyXtZcJDIgaAFE3/u/lXAgBmX+KANfJNrhLH+YzWr30yf/hghQmPnBiFpt0Z+F3dWy9aV/iGzHGpj3Mg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdxCCsrwNGlH96xHZT/sND6KrmzHUGt9GVskRoi/5TqgJRqLgW
	/zToVUQ+A8Q9lC2ENVQryYg+mHmjmvz9vBol0rFhp4Q/GIc3GQG8uKWzfIgG1vYIV18PnAH62Jq
	Fr5fMBMI+H4N6GuCzaK/dDqIsTNYVjy3hgOUkNiKNXcVXWUGqhmFMYM2rYGMG5LPhU2z5FIZpnQ
	==
X-Gm-Gg: ASbGncs3QUL/cG9FcqRCcDVvaiNIsyVqvWqqk44R78HsehCrFU0QvpvaiePkWwcddn7
	PMsukL6H1La1InNRQjlc4ZGM14p3OdxqRVHedXdMsIZbtxynSMFC0nrDhgQ3I1ikLq6vwWexaNp
	qQj7uWXdocr07FAr4xON2f1QB+HZaJuB0tL3FvEbwjG9vqNRgAJFzXNm9rr4GsY62qz2diFEL0N
	ybNZ/M0R7GAgPnOjNiYPlzfZ6osTLBbPtS6yekgrtyq8iovtLDG40mzgta4ymxjLIkNm7wU20Qi
	PvQgf5xeR7RrblLvzHyfHRwgBVqeDDkP43xO1PuhAgV4fg1YUuRd4bxirE4EwXkI4oh7K/A=
X-Received: by 2002:a05:6000:40c7:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-425578197dbmr5097953f8f.47.1759405864535;
        Thu, 02 Oct 2025 04:51:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiZ0Tp7eiBzvf0DenM28iIPgbDIMFoVMsSJWueKET191HqUB2L04iRl6mrUsuKThJQn393hA==
X-Received: by 2002:a05:6000:40c7:b0:3ee:1279:6e68 with SMTP id ffacd0b85a97d-425578197dbmr5097936f8f.47.1759405864120;
        Thu, 02 Oct 2025 04:51:04 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f45e9sm3367076f8f.51.2025.10.02.04.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 04:51:03 -0700 (PDT)
Message-ID: <067420a47d3fd7d9f50e4bc97248d0b4b812f9cd.camel@redhat.com>
Subject: Re: [PATCH 2/2] rv: Make rtapp/pagefault monitor depends on
 CONFIG_MMU
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	stable@vger.kernel.org
Date: Thu, 02 Oct 2025 13:51:01 +0200
In-Reply-To: <20251002082317.973839-1-namcao@linutronix.de>
References: <20251002082317.973839-1-namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 27kEE5AIMhGlfdZ5KtiwYBfyZQbbLLD2dp_BwgUWpgk_1759405865
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-02 at 08:23 +0000, Nam Cao wrote:
> There is no page fault without MMU. Compiling the rtapp/pagefault monitor
> without CONFIG_MMU fails as page fault tracepoints' definitions are not
> available.
>=20
> Make rtapp/pagefault monitor depends on CONFIG_MMU.

Makes sense.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

>=20
> Fixes: 9162620eb604 ("rv: Add rtapp_pagefault monitor")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202509260455.6Z9Vkty4-lkp@intel.com=
/
> Cc: stable@vger.kernel.org
> ---
> =C2=A0kernel/trace/rv/monitors/pagefault/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig
> b/kernel/trace/rv/monitors/pagefault/Kconfig
> index 5e16625f1653..0e013f00c33b 100644
> --- a/kernel/trace/rv/monitors/pagefault/Kconfig
> +++ b/kernel/trace/rv/monitors/pagefault/Kconfig
> @@ -5,6 +5,7 @@ config RV_MON_PAGEFAULT
> =C2=A0=09select RV_LTL_MONITOR
> =C2=A0=09depends on RV_MON_RTAPP
> =C2=A0=09depends on X86 || RISCV
> +=09depends on MMU
> =C2=A0=09default y
> =C2=A0=09select LTL_MON_EVENTS_ID
> =C2=A0=09bool "pagefault monitor"

