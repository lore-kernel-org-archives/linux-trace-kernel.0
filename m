Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A613453497
	for <linux-trace-kernel@vger.kernel.org>; Wed,  6 May 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079112; cv=none; b=Bxbg/FXhB8tlzaOPqErX/9Y8rtBupDwkTUEcIeNWDlckKB60AcjRrzY3kvfcZQZoNsEzuDRevtbygu+3PWZHTgyNIjll8DWvTobLLm+OMics8Go1CcL8GY7qPgbHVO72JSAAIkzoTSdOm/T64JZIScHlxn3fEwEXj+bUaMPIPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079112; c=relaxed/simple;
	bh=wo7aMKYy8D81xdmuhBD0tlpNN3IdcDezjKyuK5AJKWc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jy8MByLFGhqDZ0sxAdFiCHCy6koeO7mDhywDKohbXgBOAPjS1ELbjNvpFQZR+U46VJLga8l847PvPk8staACYy5Q+Jhdx1KJ3YsjfUKGhT1Ze+LgmTchBmlvMc0TnUYgy/EIZmu8SBjo+WsZ0RRWmfR2uI3glqKLyVlSHhnCX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cyn9orpc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cyn9orpc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778079106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vX2z4kejheVyJIAOh19JthEE0n+5Ngdo9nAQdV9h2Xk=;
	b=Cyn9orpcUw6jzqGgk1E9HZPZgPxlTi/u7hRB8fzGI/ROZ7F+hfhy1sUmN/6CbTwwaV70nU
	PRVwq4KEpgYnV4sOYL4DoeWX+YiN8Wl2DDthMVMJwk2tNadxAqEF96lzVngrs+xYbJjCcj
	kX3FzmqZh+YI2Fmplj/HzOLOgk43iKM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-FQWkP9wgPCCmnCeSYwI_8w-1; Wed, 06 May 2026 10:51:45 -0400
X-MC-Unique: FQWkP9wgPCCmnCeSYwI_8w-1
X-Mimecast-MFC-AGG-ID: FQWkP9wgPCCmnCeSYwI_8w_1778079104
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488dcaf2f2fso49568675e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 06 May 2026 07:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079104; x=1778683904;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vX2z4kejheVyJIAOh19JthEE0n+5Ngdo9nAQdV9h2Xk=;
        b=ZUNkoGijzi6zyEleMcIAfBRdqHQuje32mhgjeExUme1zkzX8pqROpRfLNOyODQoMlK
         8e5/tFlq2b8txyftanHZ6A6F8BghGAsSRSDlXur49PXGzIpftjoXha4+LSaeeYzHWIKd
         2+E/UWWCrrSe36OwhioztpsVPKGX7Bh1idmBhDMawypz35ym/wfX1gppFBo/fW/3QIcb
         7P10pVSoTsUvMLRqx/3RYCHvF2l9DNwv9crW5a1QXZ6PJq8xDpU5Lxx4k2EBm4RXvQ5Y
         47GpPhEG47rf4mssrtiBoPx25RkPqtUoU58hD59ND4qakTxkNGxL+BzRa63NKNkFV5cr
         5xpA==
X-Forwarded-Encrypted: i=1; AFNElJ9/IfDyQe+K1XgCc2F3hdXLAeyRea8XzwU5S8idhy70Zmj04xFp0xdV6Es9Xxu/7uOqZIPyuhegDOt1qtUK8lWTrsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyps/1JyRs+pO2svwxUn1haTzoVE8VbV89HagZdcnDwYRUVhfQm
	RWwDEhjUF5WBZ1Y8BOattkA/+iwExysI7NvRmirQZxquSz3Y07yE0TVngcOvvAPTGfeF1ieLDki
	ldE7ctlybugo1mYRVV+j7VNjTItAVSmVdrQS8jy25WuDmuSa4FmRcxvxqpohwL77AaSMCvHaaiw
	==
X-Gm-Gg: AeBDieueGjL5SISznrVptx1dR7OzcxJ2scwYZFoHntTKqfgfS6WjiVXEBuz6w/HnwpR
	XLPn7MzlMimikieD45Tl8OsVncjxwyfxQ+nEcGZbEviLQMb2keQmDcx9Z22/myktTwkla0/wI82
	OK+GNTmq4ULGx6RYzcV5zGgaN4vvClRcogX1Y8Gx7N1F4zNAWYAZPcErFgJs3cgH0KtvbOe9spc
	OxkCodZuFH00AZh9VZb+ZbdIvIdoVZ11az0KhZJxcmJ/o2aGCZP7m3Yn783t9tYbDolKwhDTNXQ
	RVi1rfAukqjxZ91+6n4ArpstsDhK+lz3WYehBDcMEtTcdwhlxvNLEb4yslyNVNmcel3uFAYNctV
	dhefMgYvrIqQkNehtz4RMdK/RfOzJF+2putOLPE5cSklr4Hyn+ZLmF6A+SGpzQZZ7vZGkDcfslp
	SQnRrlQ3HEuGre5MzdEv7f4ItRFw==
X-Received: by 2002:a05:600c:c11c:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48e51f46d48mr44969965e9.18.1778079104119;
        Wed, 06 May 2026 07:51:44 -0700 (PDT)
X-Received: by 2002:a05:600c:c11c:b0:48a:52f2:a0f1 with SMTP id 5b1f17b1804b1-48e51f46d48mr44969625e9.18.1778079103745;
        Wed, 06 May 2026 07:51:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538a5486sm55149775e9.6.2026.05.06.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:51:43 -0700 (PDT)
Message-ID: <11c22d8e2d641325fad604f3f7964c334769271d.camel@redhat.com>
Subject: Re: [PATCH 06/13] verification/rvgen: Convert
 __fill_verify_guards_func() to Lark
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
	 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 06 May 2026 16:51:41 +0200
In-Reply-To: <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
References: <cover.1777962130.git.namcao@linutronix.de>
	 <e8a636c8ea6da554fd51b1241b9181f65af420c8.1777962130.git.namcao@linutronix.de>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LaSYDT0vEPn8UNFTSqHAsijMs-eDsd0s5GNCoHUGifo_1778079104
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-05 at 08:59 +0200, Nam Cao wrote:
> Prepare to remove self.guards and self.__parse_constraints(), convert
> __fill_verify_guards_func() to use the parsed transitions from Lark.
>=20
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> =C2=A0tools/verification/rvgen/rvgen/dot2k.py | 39 ++++++++++++++++++++--=
---
> =C2=A01 file changed, 31 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/verification/rvgen/rvgen/dot2k.py
> b/tools/verification/rvgen/rvgen/dot2k.py
> index 3a39ae29e41e..cf7e5ddc649c 100644
> --- a/tools/verification/rvgen/rvgen/dot2k.py
> +++ b/tools/verification/rvgen/rvgen/dot2k.py
> @@ -221,6 +221,20 @@ class ha2k(dot2k):
> =C2=A0=C2=A0=C2=A0=C2=A0 def __parse_single_constraint(self, rule: dict, =
value: str) -> str:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return f"ha_get_env(ha_m=
on, {rule["env"]}{self.enum_suffix}, time_ns)
> {rule["op"]} {value}"
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 def __parse_guard_rule(self, rule) -> str:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff =3D []
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for c, sep in rule.rules:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env =
=3D c.env + self.enum_suffix
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 op =
=3D c.op
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val =
=3D self.__adjust_value(c.val, c.unit)
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cond =
=3D f"ha_get_env(ha_mon, {env}, time_ns) {op} {val}"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if se=
p:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cond +=3D f" {sep}"
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff.=
append(cond)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 buff[-1] +=3D ';'
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return buff
> +

That's going to add the ; before closing the parenthesis (if there's one), =
so
the ; should be added in __format_guard_rules() (which adds parentheses):

diff --git a/tools/verification/rvgen/rvgen/dot2k.py
b/tools/verification/rvgen/rvgen/dot2k.py
index 12589fbb180c..52570d5f1a4e 100644
--- a/tools/verification/rvgen/rvgen/dot2k.py
+++ b/tools/verification/rvgen/rvgen/dot2k.py
@@ -226,7 +226,6 @@ class ha2k(dot2k):
             if sep:
                 cond +=3D f" {sep}"
             buff.append(cond)
-        buff[-1] +=3D ';'
         return buff
=20
     def __start_to_invariant_check(self, inv: ConstraintRule) -> str:
@@ -266,7 +265,7 @@ class ha2k(dot2k):
         rules =3D invalid_checks + rules
=20
         separator =3D "\n\t\t      " if sum(len(r) for r in rules) > 80 el=
se " "
-        return ["res =3D " + separator.join(rules)]
+        return ["res =3D " + separator.join(rules) + ";"]
=20
     def __fill_verify_invariants_func(self) -> list[str]:
         if not self.has_invariant:


I found this and the other issue running on the tests/specs/test_ha.dot fro=
m my
selftests patch.

Going to check the code more, but besides the above it looks good.

Thanks,
Gabriele

