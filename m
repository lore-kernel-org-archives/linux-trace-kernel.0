Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E420033D6C1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 13:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003048; cv=none; b=jth5Ck+NF7UvJZzPmyyMjfCvtksETLUtQnOtbhobqmT3l7jpAn0t5nhiDNURL9n1LS59jGIscTAridg/KxbJEDs0SfwXxN3YqURtr7m5Cy4tZQcFCPFfcqf/OUZIf81OyRqvKeWjWw54SMg4WX7OMXruwctpBQ/D2ShJGj5CFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003048; c=relaxed/simple;
	bh=Q7Ax6j/bSX7wjx7A+SEIOMV04l40q375Z2jGslCodMw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xgn1gQRNA5YpD3/u4V0xwJM8naK29aCGwvreGnjSkedaYjUHXfi1ETJYBDuz/dH+0IjO0gRbGquSd8Bu0C3ZljDjtHdVzHaW3b9PonET9ufBO6tC+98CR1LBxzYvLo7MIndHRDtVq14EDaY7WJ+IIm6HbQv/Qo0zpbyGVsTutqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d3n2sxa0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3n2sxa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769003044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0ySSMpi/fJ/0LmtMMKxQ5EmM8mjj/cLtAeTe6QHLFJ8=;
	b=d3n2sxa0v/pFsdLKb3orypNCuvwlf5f5ZGAhfBj41W6B70BfgxL0vOS9aC2SoMGzcdG9EX
	lJZJ9WAJlVVTSVG6UVO/pfqSps5rur00sbsTnRI2EtKDJKCja+ThyUWyamvRnpFg/Zqx9J
	4/FYNMWfNd/a9vAK2WThk8mxd1SKuKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-xvsBCmakPgSVx9nRZ-olPg-1; Wed, 21 Jan 2026 08:44:03 -0500
X-MC-Unique: xvsBCmakPgSVx9nRZ-olPg-1
X-Mimecast-MFC-AGG-ID: xvsBCmakPgSVx9nRZ-olPg_1769003042
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4358f1c082eso623366f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 05:44:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003042; x=1769607842;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ySSMpi/fJ/0LmtMMKxQ5EmM8mjj/cLtAeTe6QHLFJ8=;
        b=C9/vToOLRnHvX/Ow/P4VVVOU3OoSUil9d64tqnpVE2K3xoUPB2Ghm3lXVbyKDXeqdN
         GLZjvR6CU3AU6Wx7LjK1q3iTUlt3pvovTI219y7vnEi9ySz3wtYuoizwwn59B19Iz/4Z
         8eCO80ipGVn5LymViYggSuvfh8+YZV2OVhasex7FCzbZkTmz1WyqQviqGOVSksAyh4UM
         3E2CWj0N5qP4mY0EGLu3woNmKPLkJWjP/gq5lLN7d6/+a5TZ090beLiGXHAPunBY9HsP
         HebuwLKuiAcjjuyvhIBjCCSNLDnVDU73xcMbFLoHIA0bYc9L8X83ZV3DnijGG4P5JQrl
         k4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCWos8KyRCPRS+dO5aoSSVFiXz2CdNG/LWMQk2S9ES5tmvM0mHKqc0TAY4fMqJKEYvbcTyV2E+OB3CO9vb4BfAV83V4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyD9nhkynds0m7KSZ4bnGk0Lt9gcNo2gMSIqCLsOcUMyHXJRIe
	oRldi/2oG7ch+/h6xh3amyaqmcnH9FAUDs+Td5OdnG9v7Z8ED9B3jDqjqGosgpdLo5sf2EjUcci
	eV99w1yMmJ2qejXS0/yiINiPq6D8EqJ9hutjbt85xaoBzH6JeP4SVE3joaEADv9PhEq9PNvdb59
	oPkcDsoJRx
X-Gm-Gg: AZuq6aIaAAI+IHKT3/UxS68U2zYfLGv09cRAD8Gsi0ZOgld5MrlT8oDehZd/bUT5WPl
	ehpjyO8hL2lrkjWHGM+jHUeJ5/v5UZHxI180A+EUZaSCvolxSQhhTlgr1hYo5kjRK7wriyXu1pc
	Y4mNuTNf6iyLs6MkMJ46axTtEGWlUSzAQcgdgvryW17TiMkXIih/wuwv+Dkq+qJznOpkyzCrZSd
	0l/vSovyGQ378nYUqkwNUNwdox+2P9ZKpuuDxAVp/B1KbcHDNJSzSIBgmKAQYvsTPpWTDBiekIA
	DAiva/tVMgXvxcQ9c0dmcPywt1muoDwrHbKuWtqZi8ugvZn4fZA1oGGXRbgcddu2OyIv8DLRQP/
	6686hgDdk6/igPIC3/XHAFWyUo2qI1Rivi+LUlZ34Q8cyrYesRsbkyNXxQVP7/8Tph81ZErxLnK
	DtOx4mvrOs
X-Received: by 2002:a05:6000:128d:b0:435:92c6:d556 with SMTP id ffacd0b85a97d-43592c6d608mr7777626f8f.16.1769003041938;
        Wed, 21 Jan 2026 05:44:01 -0800 (PST)
X-Received: by 2002:a05:6000:128d:b0:435:92c6:d556 with SMTP id ffacd0b85a97d-43592c6d608mr7777615f8f.16.1769003041460;
        Wed, 21 Jan 2026 05:44:01 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a705sm8896830f8f.14.2026.01.21.05.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:44:01 -0800 (PST)
Message-ID: <123046455f123d9964970dd8fcf87f2c0b780fda.camel@redhat.com>
Subject: Re: [PATCH 09/26] rv/rvgen: replace inline NotImplemented with
 decorator
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 open list <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION
 (RV)"	 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 21 Jan 2026 14:43:59 +0100
In-Reply-To: <20260119205601.105821-10-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-10-wander@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: iWCcfVoG5T41qwGOdNW6TrTEJwH-1xwpJZyP6y-zdEQ_1769003042
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
>=20
[...]
> +=C2=A0=C2=A0=C2=A0 @not_implemented
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_detach_helper(self): ...=C2=A0
[...]=C2=A0
> +=C2=A0=C2=A0=C2=A0 @not_implemented
> =C2=A0=C2=A0=C2=A0=C2=A0 def normalize(self):
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise NotImplementedError
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...=C2=A0

Is there a reason why you didn't collapse it all on the same line here (lik=
e you
did above)?

  @not_implemented
  def normalize(self): ...

I see it's probably better to break the line if there is a type annotation
making the line longer. Did you keep it separated because you will add
annotation in a separate patch?

Anyway this is minor and the change is good, thanks.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> diff --git a/tools/verification/rvgen/rvgen/utils.py
> b/tools/verification/rvgen/rvgen/utils.py
> new file mode 100644
> index 0000000000000..e09c943693edf
> --- /dev/null
> +++ b/tools/verification/rvgen/rvgen/utils.py
> @@ -0,0 +1,36 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +
> +def not_implemented(func):
> +=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0 Decorator to mark functions as not yet implemented.
> +
> +=C2=A0=C2=A0=C2=A0 This decorator wraps a function and raises a NotImple=
mentedError when the
> +=C2=A0=C2=A0=C2=A0 function is called, rather than executing the functio=
n body. This is
> useful
> +=C2=A0=C2=A0=C2=A0 for defining interface methods or placeholder functio=
ns that need to be
> +=C2=A0=C2=A0=C2=A0 implemented later.
> +
> +=C2=A0=C2=A0=C2=A0 Args:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 func: The function to be wrap=
ped.
> +
> +=C2=A0=C2=A0=C2=A0 Returns:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A wrapper function that raise=
s NotImplementedError when called.
> +
> +=C2=A0=C2=A0=C2=A0 Raises:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NotImplementedError: Always r=
aised when the decorated function is
> called.
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The e=
xception includes the function name and any arguments that
> were
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 passe=
d to the function.
> +
> +=C2=A0=C2=A0=C2=A0 Example:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 @not_implemented
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def future_feature(arg1, arg2=
):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pass
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Calling future_feature will=
 raise:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # NotImplementedError('future=
_feature', arg1_value, arg2_value)
> +=C2=A0=C2=A0=C2=A0 """
> +=C2=A0=C2=A0=C2=A0 def inner(*args, **kwargs):
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raise NotImplementedError(fun=
c.__name__, *args, **kwargs)
> +
> +=C2=A0=C2=A0=C2=A0 return inner

