Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795422298;
	b=wSLUwGlwCy7jWLxcdFeK7qR/rcageWMCO2id4A5dvMPRcLslUAh89HBWbvFLs6Yfxr6O
	 R22rbb6in9g99b3I/IhPcucPNnHivinMxlK/j+g8F3D+6XfUHeYnXDlOCCh4UGoTJPuwP
	 Nc5WncSM+X1RAPHh6kpm8IWgtGUUExSG5P3ArX+7fAKu4q3H8v4VvmGS0tWqucDBiFm63
	 Kq7MLCjpQuPbM0tTDFweIfZQHjVYkQGNQ6Pd8k4gML3QAU/SI1/mLteyrC6XUzFQvvB7g
	 I1TnVTP2TghVZUVkeI3SKPgh8nw3HFYeRgoJxvbyRZsFMD82yPenniu1Jqm5/EySwMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795422298;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:User-Agent:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Transfer-Encoding;
	bh=0tki+M1BefXqILboQVq61NA/8ZpvcacjXKbcQqfpqGA=;
	b=xjdKnCqeFaH9e022OK3/NCXEqmh3AD3l+IMGUxChWEl1y+U23eqQ0jclIEWl6mLHqwoD
	 jH+BKrXBh16uubL3vdm+kT5yiNZxqeF+yrDhgDAk+oTTIWSuvvXF/ga3/4sntJCihmuNg
	 zctJWnM4DyyYE2GMBBJIjZBiKjS6WgieHCx/xf+qvZM9oh70QWIR20nK9hBNbUW8dUt1l
	 L5SuAl/TauoANTlvYH39qdg+d2SBJmSjOhuzrkZZZPl5BqeH3ONbh0WkV2kTQsbKopiJG
	 rkcu+bHfk3t9MLGokVvOa5NzsIDmDPSptHbJAU+7+kyqwLJ6OqYfdJWvcpOpt5/cOUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EoJX3YA7;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE8B606A31A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 08:24:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EE8B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EoJX3YA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795422297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0tki+M1BefXqILboQVq61NA/8ZpvcacjXKbcQqfpqGA=;
	b=EoJX3YA78otZc5wIcbEVNNbpv3o5HV5drVX3ZXalqgCIgCIFvFWBg5JP2bU9VZS0pshry1
	rZ2kGZhhiiYd9SfVrbyxH4WIc9fVxZqTyPsuLnnFdcD7FBs3o4ne+aiByQ0Qu04NYbIvft
	VTW2AAXhTDV23u4A5CrSe/hvzQhkUjA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-L6NVCy3hMpO3AZ_uP65ROA-1; Mon, 23 Nov 2026 08:24:55 +0000
X-MC-Unique: L6NVCy3hMpO3AZ_uP65ROA-1
X-Mimecast-MFC-AGG-ID: L6NVCy3hMpO3AZ_uP65ROA_1795422294
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4bb67b2c00cso19043085e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 00:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795422294; x=1796027094;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0tki+M1BefXqILboQVq61NA/8ZpvcacjXKbcQqfpqGA=;
        b=DA2Iox4s7M/+uYREHOTHIO9aL2ozuNNbv5Ioe45AJx+2h+8UHI3vv7W0KOAZW3drMG
         HdUv6KqARBCL4WslexGVOshlve/j3IwufaMqNCEmnSyWPw7X2WHSjzH2hCWhlLIsPsbg
         U7R3Ur+JS/yqf872iaE4J25cGymdVJnjzoukwVQdkEHAj9tAjlDawVVmThcvRBblIr5Y
         rv5C7er+MasA2Szha9gSqhZAHuq+q2QM+WNRmCJegOT0XKc+YS0HPJq1FwleeN9F+2jq
         ag3v8doqSURs5/UgN+29jLmtEXvgXkXtHK4eKJbBC0yqzTQX7qj8nwToKohSHrS/qC5y
         V8ZQ==
X-Gm-Message-State: APuU4Z/s+kny0v3sKqfRS893S+mxSeCl8H5brTy1V2yQCwNDidnrqIdH
	sGrc9s0UqbC5+/3IVkJ+aQuytEB5E+WwGhflXArGDGo1cZZlR+3kawIpG/p4D4RbqfDToN9OmVF
	QceJQc0S136ez04M9jaespLWQdQKjOdV+yxYlvCLArGByu1Ds6UlzCivSLOj52C6K0ZQ6hnZ0VQ
	==
X-Gm-Gg: AZFdTZd1zlcDttKVpCjwkfOErqtZtjpEZ/kJlYGMu5Ae4dOWi42EadJ0K96C4nAAE3L
	7wjpUrX5mValEExt79RFOjWEuZGL5cQU5XmtbpgNEncuB/qIUrfKCXVLfJcS8wJtMrHw54aPB0B
	Y80Pt1FcmQtbIf3RBt9s0feZLsUCINbfcuVPb7xCjDlqfEjVjUe5wCsWexFfeZjhdQz0ttWwAKK
	g95IGfEldGcfBr04VwY9a6mpXS00ErREpbiAposvFTHftmZYSrajN+B7BeRTrOe9rez8WmYAD7M
	3W5RDUACyo6FIH3Ocw0K6S3nozlLQ3UgEc7l7Cc2NF6L6+iGBB6K/wxVowyn4ZpbgP17Ecqm8hY
	Ef8SWYVNeTEU55w6WHwwkBfNhq9qd0LsP/V5o2GIyv5WxZKjZrf20sp8ZHyKSNIiqBjDNBFfVyn
	9J
X-Received: by 2002:a05:600c:a39d:b0:4bb:679b:fc6 with SMTP id 5b1f17b1804b1-4bb86157a2bmr176756165e9.12.1795422294372;
        Mon, 23 Nov 2026 00:24:54 -0800 (PST)
X-Received: by 2002:a05:600c:a39d:b0:4bb:679b:fc6 with SMTP id 5b1f17b1804b1-4bb86157a2bmr176755785e9.12.1795422293941;
        Mon, 23 Nov 2026 00:24:53 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm21170713f8f.3.2026.11.23.00.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:24:53 -0800 (PST)
Message-ID: <7b5bbd08396e7478b68c941f1f20e111a1623869.camel@redhat.com>
Subject: Re: [PATCH 5/6] tools/rv: Parse the mixed enable state of containers
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wei Li <liwei1412@hotmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet
	 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	 <rdunlap@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Nam Cao <namcao@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	liwei391@huawei.com
Date: Mon, 23 Nov 2026 09:24:51 +0100
In-Reply-To: <CY8PR19MB700974075298C61A1DB70C3EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
	 <CY8PR19MB700974075298C61A1DB70C3EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Y2Gny0fArLxrhgnKL8Xa4YBY0DhoIulOQF1TFPiLyrE_1795422294
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-11-04 at 17:21 +0800, Wei Li wrote:
> From: Wei Li <liwei391@huawei.com>
...

> --- a/tools/verification/rv/src/in_kernel.c
> +++ b/tools/verification/rv/src/in_kernel.c
> @@ -29,21 +29,38 @@ static char *config_reactor;
> =C2=A0 *
> =C2=A0 * __does not log errors.
> =C2=A0 *
> - * Returns the current status, or -1 if the monitor does not exist,
> - * __hence not logging errors.
> + * Returns 0 if disabled, 1 if enabled, 2 if a container with children
> + * in mixed states, or -1 if the monitor does not exist, __hence not
> + * logging errors.

Instead of documenting the meaning of integers, why don't you copy the
enum here too?
It doesn't necessarily need to match (that is, obviously use the same,
but if it ever diverges, nothing is going to happen). I think it gets
more readable.

> =C2=A0 */
> =C2=A0static int __ikm_read_enable(char *monitor_name)
> =C2=A0{
> =C2=A0=09char path[MAX_PATH];
> -=09long long enabled;
> -=09int retval;
> +=09char *buffer;
> +=09int enabled;
> =C2=A0
> =C2=A0=09snprintf(path, MAX_PATH, "rv/monitors/%s/enable", monitor_name);
> =C2=A0
> -=09retval =3D tracefs_instance_file_read_number(NULL, path, &enabled);
> -=09if (retval < 0)
> +=09buffer =3D tracefs_instance_file_read(NULL, path, NULL);
> +=09if (!buffer)
> =C2=A0=09=09return -1;
> =C2=A0
> +=09switch (buffer[0]) {
> +=09case '0':
> +=09=09enabled =3D 0;
> +=09=09break;
> +=09case '1':
> +=09=09enabled =3D 1;
> +=09=09break;
> +=09case 'X':
> +=09=09enabled =3D 2;
> +=09=09break;
> +=09default:
> +=09=09enabled =3D -1;
> +=09}
> +
> +=09free(buffer);
> +
> =C2=A0=09return enabled;
> =C2=A0}
> =C2=A0
> @@ -370,7 +387,8 @@ int ikm_list_monitors(char *container)
> =C2=A0=09=09=09list_monitor =3D 1;
> =C2=A0=09=09=09printf("%s%-*s %s %s\n", indent ? " - " : "",
> =C2=A0=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 indent ? MAX_DA_NAME_=
LEN - 3 :
> MAX_DA_NAME_LEN,
> -=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ikm.name, ikm.desc, ikm.en=
abled ? "[ON]" :
> "[OFF]");
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ikm.name, ikm.desc,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ikm.enabled =3D=3D 2 ? "[M=
IX]" : ikm.enabled ?
> "[ON]" : "[OFF]");

This double ternary operator needs parentheses, otherwise we are relying
on some non-trivial operator precedence rules.

Thanks,
Gabriele

