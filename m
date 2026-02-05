Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874D035BDD7
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276285; cv=none; b=Ib2kDxrJmhT4c1T2EGUyNEtdozVB1c/jTL1H0zwNDwdrAIHprikoNCLLopz7ql5RjhMsvEyjcp9RcN8jd/YT2f0qvnqCLgGJI5lDClZny79sN5d7TafmCRoJPPaDEPiA7TdauJm6G3DzReIlfHExPm0Kr7KWNWd7OWxfkTAv1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276285; c=relaxed/simple;
	bh=2Jav5KHK1ykxgbwdXzPoz4VJrXbf4+LJGQzu/29rnGw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipHlMvWWgazPv9bbzGRQkC+fc2ERQZ/6MFMLb2BCbW99v3Zhr8pP2VOzMfVlhQ48qTyhMtEVa3U/wFpgjvj4iiNwQS/bC6B2mhWqoRWghY3r9PrAzt/aBcbqMuNjc1dFoBqAxfMFPe/pzOXTYEtzVEZFxH+xfett4QICg+bG9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ElvYhwg7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElvYhwg7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770276284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2Jav5KHK1ykxgbwdXzPoz4VJrXbf4+LJGQzu/29rnGw=;
	b=ElvYhwg7FQVY2mcHk0VoKAxDH7QKfhIxBBttPzxmbd9rDj9Pdp+YniZYayDTyKPgn1WZc8
	/3uwxOdnHzTWfXArgVwESCYAtaocE3sF9E17eLyIucEHL6xm18hamRlxvihdOcKjcilauv
	q6I8QkRkMCtwvwP87016C71vdfva4HY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-RzifEsiCOkCTkQVI41IVCg-1; Thu, 05 Feb 2026 02:24:43 -0500
X-MC-Unique: RzifEsiCOkCTkQVI41IVCg-1
X-Mimecast-MFC-AGG-ID: RzifEsiCOkCTkQVI41IVCg_1770276282
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435991d4a3aso467661f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 23:24:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770276282; x=1770881082;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tK4FZC418zNNLTLQpI+yuB0hOA+LANd8dFsFLw6h/Bo=;
        b=raFJY3q/nF+RzYxlTmo5o//AaRfAeIXxvx37JPTm1R7kmDqj0P64GqR9uD3lPcntlw
         u8BrnyigyxJmv6dsrEEBozTFDfPeFkFxgw7l2Dehsd2c7cA+qVIkH9T3UvhgwZmEWqmU
         D++/sc3kjQJYnPm9ZSUjLiU08O0cZm/kPSnQdgCKdaOoj6THMmZo64b3dmvTHaYOwZWT
         GVgeYLUh4EPIZFWThSk4hmZBCnOszWJyBVDQjOIYy8Ja4LQOfRwXtrBPTpBLUcgIrPla
         fjMTrBwNSG73uOn6j2fFsygrCVvXHOseklG5EfxZPY/nBAOu/eM8RaWyGMFkix5BTPTd
         iCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXePs2e7qIk4zXSxpkQB0M/HcbiXERVf4is0tHvB1jOi5+0Xnxb3cbOucmquqP6W5MwtOKOj2OmnuYH8pUBLV6KuME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5q+ookl9K6ZaOoOij1z08MnyVRAWRN7dmX+BHByDCNNBe5QU
	excjOl1lc1SIyo+zDjeaknMfuIVtOxKIeFTKdxyU1NqO4WMFIrERwlNIzW8cWVvoOO7UmP0Pu9t
	46eZTcb/Fn5hukOLS2uz4H01cGTKKcte/RTpp299GQoXqoNOU4MFIOUtxzkSKLOwaNchu2mqyNA
	==
X-Gm-Gg: AZuq6aLyw8Ik/r8jHmsEdysEBKdF+/BpeUr4Nsi289ztcFjBIaZU2DtV8DRNszY+dnr
	kCb15CZnbs2rQLQQa1AH2z6W/6j6VncYniJPuiCfGyeO7I6Doc9IsWZJXYMiqjDlSn/6onMMsss
	0juFXUPgzWHhDpzsg2vuxEhTXjxppOzD9Q9cMWPY5Yk/s7EHq88esYVUlAoNWOXEXxOVSyImzPl
	jk+SSpPasGzXJ/mv8iyP2LllNdEPhHCsiC3J5F4+GHfVNQL+gepPYuujmun/Xhu0d8Znf5ovHQ3
	QQTbWHnq161xRrx1v+AwJ4spAYDS1p+gAQ6JgzBs7f+1cPw8k+OXHW/P8yucLuAmzTV0291i8N5
	OBrRb/oQ1fd6fpiJSWnxmO9nEtXfnKBF24Pth5hnLKuPVpglW2uisauoib7Rdb5Xv7zWDii/E70
	9Qa31jD6bw
X-Received: by 2002:a05:6000:1841:b0:432:5b81:48b with SMTP id ffacd0b85a97d-43618061687mr7957491f8f.61.1770276282031;
        Wed, 04 Feb 2026 23:24:42 -0800 (PST)
X-Received: by 2002:a05:6000:1841:b0:432:5b81:48b with SMTP id ffacd0b85a97d-43618061687mr7957465f8f.61.1770276281680;
        Wed, 04 Feb 2026 23:24:41 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e250bdsm12447503f8f.2.2026.02.04.23.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:24:41 -0800 (PST)
Message-ID: <1edfc4451310645ffe89a60e461682eb49ff6006.camel@redhat.com>
Subject: Re: [PATCH v2 20/20] rv/rvgen: add missing return type annotations
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, 
 "open list:RUNTIME VERIFICATION (RV)"	
 <linux-trace-kernel@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Date: Thu, 05 Feb 2026 08:24:40 +0100
In-Reply-To: <20260204144914.104028-21-wander@redhat.com>
References: <20260204144914.104028-1-wander@redhat.com>
	 <20260204144914.104028-21-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: 4TaRN_Ho4s5HxE0oClemR5IzmJaYDGo9KYh2yRlER-o_1770276282
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-02-04 at 11:42 -0300, Wander Lairson Costa wrote:
> Add missing `-> str` return type annotations to code generation
> methods in RVGenerator. These methods return strings, and the missing
> hints caused errors with static analysis tools.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
> =C2=A0tools/verification/rvgen/rvgen/generator.py | 16 ++++++++--------
> =C2=A01 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/generator.py
> b/tools/verification/rvgen/rvgen/generator.py
> index ef6c9150f50c6..4b984869a7b3d 100644
> --- a/tools/verification/rvgen/rvgen/generator.py
> +++ b/tools/verification/rvgen/rvgen/generator.py
> @@ -73,13 +73,13 @@ class RVGenerator:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return f"#include <monitors/{self.parent}/{self.parent}.h>\n"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_tracepoint_handlers_skel(self):
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_handlers_skel(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"

Those are the ones that will raise an exception in a later iteration of thi=
s,
right? I wonder if we really need to touch them now.
Anyway I'm fine with this if it pleases your tools, thanks.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_tracepoint_attach_probe(self):
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_attach_probe(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_tracepoint_detach_helper(self):
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_detach_helper(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def fill_main_c(self):
> @@ -100,19 +100,19 @@ class RVGenerator:
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return main_c
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_model_h(self):
> +=C2=A0=C2=A0=C2=A0 def fill_model_h(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_monitor_class_type(self):
> +=C2=A0=C2=A0=C2=A0 def fill_monitor_class_type(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_monitor_class(self):
> +=C2=A0=C2=A0=C2=A0 def fill_monitor_class(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_tracepoint_args_skel(self, tp_type):
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_args_skel(self, tp_type) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "NotImplemented"
> =C2=A0
> -=C2=A0=C2=A0=C2=A0 def fill_monitor_deps(self):
> +=C2=A0=C2=A0=C2=A0 def fill_monitor_deps(self) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff =3D []
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff.append("=09# XXX: a=
dd dependencies if there")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.parent:

