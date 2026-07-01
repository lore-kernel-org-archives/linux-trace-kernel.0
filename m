Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF87481644
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Jul 2026 12:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782908821; cv=none; b=ICYXlyV3w3grYBwKtzh869orof7oMQanZeRfZu5bPz7bWBQ1bubW3bBaBGGqnr+tFq4zR8mXc+IjbTNCME/GdVwxJJxMdtlm/IFQ2lceJUcRJ+F0wh+SK+7huCQLSlV7DSY2+q1W5NYvhi4CiJrkOIvrRpf16gqUGhhbR06xorc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782908821; c=relaxed/simple;
	bh=7ps1uluWfXWUbTuPquIlD/olsoNm4Iakp8jCOFBZQS4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wr5QTZ4zGKqYyfS2CUmbNGwuC118zwKob2F7mwmYMeS/MeN51dIUNkX1MHIHLqLNQrYtDQZAtzfJDbOKiNzFRZyBoNVJjRiQW0nhDBPdWJC8oxL2QLgpllN1VMgpnLfTHqpZS1EQOJxq3FLZHbCb/wtBu76R7ZLWbUMwHXu7KX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzN2Sh7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzN2Sh7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782908819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7ps1uluWfXWUbTuPquIlD/olsoNm4Iakp8jCOFBZQS4=;
	b=KzN2Sh7nKQgWpB7jsL7DZ8ULVzKokXBnItyW0+ClbVXrGu4l2e95Xtz3uv14ePlX1UScSt
	8EzVxCRqeq/v7e+fQEdEe4OYKVwohOh0OObqNdEnN23IDCLsFoFGxqVpjlmXLjrzdqUCSe
	19MaRpGW0paCBmLIN1ZIX3eV/n0MsH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-uSNLdZDTN0aDem4WnoHjmw-1; Wed, 01 Jul 2026 08:26:55 -0400
X-MC-Unique: uSNLdZDTN0aDem4WnoHjmw-1
X-Mimecast-MFC-AGG-ID: uSNLdZDTN0aDem4WnoHjmw_1782908814
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-475b0b4e8d5so483002f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Jul 2026 05:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782908814; x=1783513614;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XGzPh4RZs7guwUzUy8JZigwRdcEdUWtzLIpj0iGZF90=;
        b=MDcX905+qcwcZDz//KaZt6OzNeGGXSEREkZgGrujYBHcXH/yRxbXVR2XZ+m1oQAqii
         4mww8t0OLV3p0ROXF5kp0ef8pDDyogsaibrdFbQO5AkX7HeBEQTPrgFOhrCusupueTMM
         4K0Vjs6HnVu444eH4L8CKmFOM3Xdmcf2taqx48E9iK515GYs9qAZMASwQisaru6M9BFd
         zKSsLrJkOkyKZTwTvJXHjCzR6l0dNJigLpOKe3msqLTWlTC9PHboMTQiLiVn1VfbTHX4
         26DJtwcTwFn7qHIxii/qFevexi1/0h2/8AwRgak9iT8Y39Hk/K/2VIdByEG0PR8YILuX
         GhAw==
X-Forwarded-Encrypted: i=1; AHgh+RqvL4R4Fhgp3eQ4Q6rtKJ3hmsHxx9gfRRfTb78vLWgLPQWknFuowWkTAdPdWw9IflV+0hmAW0ub03qaBS3F9oFMJtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphCxQQEWAzA+LCY7+BH5xySCEmabsFyvWNj8Tqt/19R2+PjOK
	5huzuI05PqTRBhf8UEu3g3Mt9kFLf2+MW/Yaub+NvnS0MlPdliUoJygUfUBpN0lujrRUueuHhVI
	gUWluGKHLBo9j5pxvgYhNukghGkXRLbgoNYiISFD8Uo6chVOj7o+nPsJVvS+VkD+CXqX3q41gVg
	==
X-Gm-Gg: AfdE7ck6BA7Fi55oz5gOfJlQx1Vrx/y0U5xdN/sO0XguCwM2SQta9y3ChjNNW5mwaRb
	hbEF5M1uQxbunfHg/i+yrIsXWa91Fv0lZrTT7gaZxG9RP0JzhGn9sq5QKgbwagBHeMOQhBahM7M
	jEmtMoIOsvk3E2aWbbhya2Ihpj5QeXVCvZWzCg2CxuNl7+4Tx4BKRnRgejvy7AGlZQsCtU6lOHH
	2PjMXDzRtgVkqRWu8cdocTg/oJQvmfoyaskanwe2jhiWvLXZQWLpr9jEq2ep9RVima9ojCApj4b
	bJ+JON8MYms/hm6UDspaJYNReXtr5Hl9PhYjw4AarKEU/WSmWzL73z8ZXXVAbZaG50R+aac5odY
	V5li+fbATqU68+diD9vpTQnB1HCS1X4BwkojKbUXnztZ0nCqbvWO6txj2pkDCYpUnYJzTWN8823
	LmvdGR
X-Received: by 2002:adf:ed02:0:b0:46a:bcab:3c2 with SMTP id ffacd0b85a97d-477b5296a0emr360383f8f.34.1782908814524;
        Wed, 01 Jul 2026 05:26:54 -0700 (PDT)
X-Received: by 2002:adf:ed02:0:b0:46a:bcab:3c2 with SMTP id ffacd0b85a97d-477b5296a0emr360351f8f.34.1782908814132;
        Wed, 01 Jul 2026 05:26:54 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47566fe448dsm16621132f8f.27.2026.07.01.05.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 05:26:53 -0700 (PDT)
Message-ID: <9bc739eec41b6616e9f81cbe50759cefb1c3ad9c.camel@redhat.com>
Subject: Re: [PATCH v2 1/4] rv/rtapp/sleep: Make the error more informative
 for user
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, 	linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 01 Jul 2026 14:26:51 +0200
In-Reply-To: <d97b4b5c476e5792b6875ec9bbf8dc214f999516.1781852967.git.namcao@linutronix.de>
References: <cover.1781852967.git.namcao@linutronix.de>
	 <d97b4b5c476e5792b6875ec9bbf8dc214f999516.1781852967.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: X78M0rCE9UBeZdT6a9LNhSiChB0Jd80gzOth9zyy9qI_1782908814
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-06-19 at 09:21 +0200, Nam Cao wrote:
> -static void handle_sched_wakeup(void *data, struct task_struct *task)
> +static void handle_sched_exit(void *data, bool is_switch)
> =C2=A0{
> -=09ltl_atom_pulse(task, LTL_WAKE, true);
> +=09ltl_atom_pulse(current, LTL_SCHEDULE_IN, true);
> =C2=A0}

Well, this triggers also in a spurious schedule: current -> current, can
that be a problem? Otherwise you may either use sched_switch over next
or pulse only if is_switch.

It probably isn't a big deal though, since there's no SLEEP prior.. But
we may want to avoid the noise.

Looks good overall.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks,
Gabriele

