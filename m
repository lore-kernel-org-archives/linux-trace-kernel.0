Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A139020C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 22:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119896; cv=none; b=bNS2s7DWIIV+qBB0iE8ZdouRy/ZH12kxr1o++/jtEETIzSytUBOkTUMP5dz5lwYjCNXs5QF5IpjJFioQPs3ObgtnYG4Z2O210bRbFDq9LV3JvtFLCRcIpgVygg+ObmPum9YVnWxTCBbCKGCAKWpkT5ykWwuj0o7SKtFJL4bUzdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119896; c=relaxed/simple;
	bh=AepFIl5sGKiy8IHmXV3ZD/d4Ox6LeKc15IFSBh1eBYs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQWMbUWOdi2vc0DMXScjvwc3W28M+fTlZ1lSq6jsOExhTgb4ksnP8MdXWmreO7ob2v1B7B2tiZGEPLTOa8893z8mB59q4aiz9W8Xm88xx/geR8SUXdKa6+gxYLW49Ycxb5LLTWlDUFElnsgNEEn1iCIMqbVE3tHdbE6WBNhnaUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ORGxxm; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ORGxxm"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a48deebe95so40946766d6.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 15:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776119894; x=1776724694; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i5+vxxLyC5WQO0AugNFfK8SLmwyI1aIjZaJmeT/G/1I=;
        b=W8ORGxxmWcKXuqODiSXZnXf79efQwc8iWiZYagzamxfKjVKPBp5MrF51QSPiv+r1BC
         qJ8sct/Ov7vUo0nYyeIJJYD7QVLI7bpHdA8YUB40YCVL4FR5KdKZyo3W33qHAipcN+k/
         pYRoNyn2c60gcp2LnNe6PSq500cUQrSuDgIxtYE5/9PtWTUU8PoZzrKlz3AMTxbCGbfR
         ozCCgcOTvVPMDgvAq/84kq5gxn+A0RSUQg89D3NPcBksBAiNut8+gF/zdw22GvkheFGq
         A+BXtxlEo1kdsYQCrnMzATthK9FKCpM8k4RLJaj2zpUqzxvAOXZYW9m2AU8O8HwhIpPx
         tcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776119894; x=1776724694;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i5+vxxLyC5WQO0AugNFfK8SLmwyI1aIjZaJmeT/G/1I=;
        b=jQGKV6IwG/K9v/r92Brpzj3/P5IlYKIf8qpYsR3H//HP0WLVr+7m7KvS9hMkeoZnLe
         UAHG/mjsC7u0CBuywr+60I4pEAvbqATsfuowMMPcRj9YWe1ukqFLmQjHvqdKpck9rijM
         AadtAwcn3aVhRJh6SW82sIxqTKNcKm0lvjLOx63DDWIBuq0RFl1sp8K/2xOfMfBZqvVi
         mmJekJFL076jPeQXIXww5rK+VoTLMq4SKicCDatq4kDDZnJpI/qNgMk0l6TFxZZZCyxH
         arWR3eU5qwGx3lvjykiCw9pZmw63PjHS9DvnyIM3ig1nV8AW3dtQLnYpldZjkauA3h1p
         VGwg==
X-Forwarded-Encrypted: i=1; AFNElJ+a5X8ntKd1N/aWwhYR+7CabJ675rKSuZBsQLheCqKjUFpCe3+M3QnuVTFlR108witcbHjRDrK9KY7pelNmHbMFZnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++045AcVtkXGf50D4zmDlZZEym4nWADnQ8VJKf9F6VLuZy+h0
	B4esxhZJV4YKfKl2vuahHtE71MCIP7FuLIcang/oQrOImJTit4DlSEQN
X-Gm-Gg: AeBDieuRkh6K9J70CblVcptH97BHq9cOR0dAum1Bo9sijOjupg0eeu0ieGfiEqoKHCg
	8hgZmzi8ru2WaXoL8whcUcpvVNVlS82jekzjCwnFvVcR4Z9xSwGbPMrSCIetjm5G/OzulzZGcTn
	ONmJTTiEN/ybqFRwQ/Z2Y42XTaPkeexHgetfH3OFbLz70+bezlG2wLI+bvzhcbo/8+rgdHdOr1Y
	weP6UMXwTnU1R1s7xZI1M0Hqxvhqj3w0PN/JGMcFYRnbF1oGDLeQ/ohOI/FNfkdU/5UOtmvzdd7
	TPN+1Ge8UnMRyeFEOe7tbwxKCMLrkfTIhtqlS6M3E0ZTa4XUFt+V1faS5rO/4Ff7qt6KhD6ElIV
	KcSEwZlDVRMiQjxcuVxP0xsylyvpTwoZ6huskoavDtkyG99hu8/YwiGcds7niNDN3QNTB6atSI4
	ivNAwZou1etMhUaTMMcgvxzQOcrJSS5htrN4c6ZA5JrUe7+nWo6XcE9lKVtJYgAq2stX6zDfKGH
	cnYCJid
X-Received: by 2002:a05:6214:4411:b0:8a1:3ba4:9832 with SMTP id 6a1803df08f44-8ac861ad3b5mr235412526d6.16.1776119894039;
        Mon, 13 Apr 2026 15:38:14 -0700 (PDT)
Received: from ?IPv6:2601:246:5b7e:1b40:37d1:d7ab:b3b9:2d93? ([2601:246:5b7e:1b40:37d1:d7ab:b3b9:2d93])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac849dbb44sm103807366d6.10.2026.04.13.15.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 15:38:13 -0700 (PDT)
Message-ID: <ae1725c9d2e9868b435434edf66417ec433f499e.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] tracing/hist: rebuild full_name on each
 hist_field_name() call
From: Tom Zanussi <tzanussi@gmail.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	tom.zanussi@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 17:38:11 -0500
In-Reply-To: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
References: <20260401112224.85582-1-pengpeng@iscas.ac.cn>
Autocrypt: addr=tzanussi@gmail.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-04-01 at 19:22 +0800, Pengpeng Hou wrote:
> hist_field_name() uses a static MAX_FILTER_STR_VAL buffer for fully
> qualified variable-reference names, but it currently appends into that
> buffer with strcat() without rebuilding it first. As a result, repeated
> calls append a new "system.event.field" name onto the previous one,
> which can eventually run past the end of full_name.
>=20
> Build the name with snprintf() on each call and return NULL if the fully
> qualified name does not fit in MAX_FILTER_STR_VAL.
>=20
> Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist tr=
iggers")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Looks good to me, thanks.

Reviewed-by: Tom Zanussi <zanussi@kernel.org>
Tested-by: Tom Zanussi <zanussi@kernel.org>

> ---
> Changes since v1: https://lore.kernel.org/all/20260329030950.32503-1-peng=
peng@iscas.ac.cn/
>=20
> - rebuild full_name on each call instead of falling back to field->name
> - return NULL on overflow as suggested
> - split out the snprintf() length check instead of using an inline if
>=20
> =C2=A0kernel/trace/trace_events_hist.c | 12 +++++++-----
> =C2=A01 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 73ea180cad55..f9c8a4f078ea 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1361,12 +1361,14 @@ static const char *hist_field_name(struct hist_fi=
eld *field,
> =C2=A0		 field->flags & HIST_FIELD_FL_VAR_REF) {
> =C2=A0		if (field->system) {
> =C2=A0			static char full_name[MAX_FILTER_STR_VAL];
> +			int len;
> +
> +			len =3D snprintf(full_name, sizeof(full_name), "%s.%s.%s",
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field->system, field->event_nam=
e,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 field->name);
> +			if (len >=3D sizeof(full_name))
> +				return NULL;
> =C2=A0
> -			strcat(full_name, field->system);
> -			strcat(full_name, ".");
> -			strcat(full_name, field->event_name);
> -			strcat(full_name, ".");
> -			strcat(full_name, field->name);
> =C2=A0			field_name =3D full_name;
> =C2=A0		} else
> =C2=A0			field_name =3D field->name;

