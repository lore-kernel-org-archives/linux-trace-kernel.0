Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67ED22D4DD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 13:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003830; cv=none; b=c7HnkBGAIkxRYYkzBgkGMQy1PQmpRmJXY4erANKt5reP6Wviwbi03mdo+2i/HoqA0uFYyVsZO+5lZALq4ajj5LKiimKgbQLuMaC3w+6FBbdNZ+khUvz2rfcCuHl+ZdPv38MIWgNd5r9XDRomt0PQS827lX4UjFSOUWrwTrzufAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003830; c=relaxed/simple;
	bh=JdplGQJf+BfrG/OQ6lJ2yz0j9UM5Z34otsbxl3N6ZvA=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKyOgMIy2EFewljVBr8GkdxsZoVCGGjUFop6M1b5dlD8ZbU/Oesbw4D8q5cwXWleHcfpqdayMBvHU5aK+Ym0XfYP/eSPnQUnTfgQwbUFS0tutGf8eBpvDZ2aJAeANNicGWLyrYvanVzkGALRk5mNkuV36+gkcE5eyAkjPgjGBjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzyPBcXz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzyPBcXz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769003826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JdplGQJf+BfrG/OQ6lJ2yz0j9UM5Z34otsbxl3N6ZvA=;
	b=gzyPBcXzcPgkg/oaA6igpJXfHIRVecPt789CklG2bmPi+lOXJ94jweY1U8Mrga++b/ezGV
	taZ3l7xtwUolYqZk4CIip2SbRGhq+9pQeLMKV8AhdVNmQq5bp1f0ZJ920vdGp3z7u33b8b
	/OiynW5AvT5a1/znQRZxisa49rphPwU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-CqTZ7F0cOJaPwhYzi9s33w-1; Wed, 21 Jan 2026 08:57:05 -0500
X-MC-Unique: CqTZ7F0cOJaPwhYzi9s33w-1
X-Mimecast-MFC-AGG-ID: CqTZ7F0cOJaPwhYzi9s33w_1769003825
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d3c9b8c56so76942925e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Jan 2026 05:57:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769003824; x=1769608624;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JdplGQJf+BfrG/OQ6lJ2yz0j9UM5Z34otsbxl3N6ZvA=;
        b=qW1ZARI1diMykObhs+tAHjAwHI8iI5P2fSdcaIGekzGfY9Czab9JODSUfSJZyv6zlQ
         w/1mODahzc44MHGYAHlXibUIe0NIRllHIhFz4gUOh/luMlUnOpCIeCIkcn+RISJbFpcn
         A9Gg6hD5e5Z2rPxJi7nzM5I5LRALWfjXcK9g7lnc2i1VnYg9Tr/+YSEiciz9k+eteIru
         Uw8097vddKu4jLhzj2Iy8AcLqBN490GMnrKe66jJX8B697Oy5dTQuMaX/pqA3EtMyC0s
         fw6Q8jk0YD/16eRyjxy93wHzl2g6BavjBpqmjgVJE9m5p/I+nw1tv74UTgptJ2Noj0w3
         Ww6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxkJWqi49iaKaI/rNbHRF5AGtG0e9yxhWk5lmWhW5hcJyGZyrqPrc3NDH6EdsxzjuWaqV4AODAio0XcL33TY8LBIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0cj5Om30RbkPx1UlIjna7MMN/gPFhsqya3NLih/NFtA1k92RA
	cTLlWcES9p5UhJT0O6p7YVKZKtw+IJ7jMIJnWQcb++Za1oB8oJjVotZC9fkyqmGx4jVoannfRO8
	Bo9Vuea82P7JxsBoBtbX1YY4nO/wwCwUcdwcTixbpEl66P4+lbvYmZyYlGtB1HEDjqBcO7Wt1vs
	114EUJCDvE
X-Gm-Gg: AZuq6aII8h/o2iVtfFkFHh/lczZMs0qFZVvplCoUrNXCsKExhWfv4jPuWPyZ2Sa3omk
	jaLfzjjE9pFLTXlg8KZFnMdpU0VQfEUsF/BeRzIjJc8qPNjA5cOY67wq15foiIhImWPvfyQBEjU
	nrO7YSJCxTQWigVFTRwnOHGTyup2BoMc+9kmozkdMKvLlSfJcUUHBC8+xDuKy45nL0veX+HDaK2
	/5ECVvOjfWS9xrCPN/FTkTEeIjCV3l8rDkuehfdcPrG+0ZYQKr/V7kZgB2Qj7rXnxCV3ln2tLnG
	fYACNIY5J3c5IjGEXFtUEy6SEnHkJen4LVJLa1p78qFWbKESL/j1vTPNG94Gl3pVYNFtkkL70f0
	TOE4f3BC+VMYiXS8znMflTV9QVdOCN1GtUKCTRSQukGkzjZxIlREjdogl6Hfsj/cdRTx7J8+fpS
	TTueLOC1BF
X-Received: by 2002:a05:600c:81c8:b0:47e:e807:a042 with SMTP id 5b1f17b1804b1-4801eac800amr231482555e9.15.1769003824449;
        Wed, 21 Jan 2026 05:57:04 -0800 (PST)
X-Received: by 2002:a05:600c:81c8:b0:47e:e807:a042 with SMTP id 5b1f17b1804b1-4801eac800amr231482265e9.15.1769003824080;
        Wed, 21 Jan 2026 05:57:04 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f4b2755absm469405775e9.15.2026.01.21.05.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:57:03 -0800 (PST)
Message-ID: <1f168ff5ffb531570fd83e3f398380e8df053275.camel@redhat.com>
Subject: Re: [PATCH 18/26] rv/rvgen: add fill_tracepoint_args_skel stub to
 ltl2k
From: Gabriele Monaco <gmonaco@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, open list
	 <linux-kernel@vger.kernel.org>, "open list:RUNTIME VERIFICATION (RV)"
	 <linux-trace-kernel@vger.kernel.org>
Date: Wed, 21 Jan 2026 14:57:02 +0100
In-Reply-To: <20260119205601.105821-19-wander@redhat.com>
References: <20260119205601.105821-1-wander@redhat.com>
	 <20260119205601.105821-19-wander@redhat.com>
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
X-Mimecast-MFC-PROC-ID: oUel_B3OsNC15Jw8IRRlkpu9aJC3LwbxWiTdijfaH6o_1769003825
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-01-19 at 17:45 -0300, Wander Lairson Costa wrote:
> The ltl2k class inherits from Monitor which requires subclasses to
> implement fill_tracepoint_args_skel(). However, the ltl2k template
> uses hardcoded tracepoint arguments rather than the placeholders that
> this method would fill. The base class fill_trace_h() method calls
> fill_tracepoint_args_skel() unconditionally, which was exposed when
> the @not_implemented decorator was introduced.
>=20
> Add a stub implementation that returns an empty string. Since the
> ltl2k trace.h template does not contain the placeholder strings that
> would be replaced, the empty return value has no effect on the
> generated output while satisfying the base class interface contract.
>=20
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>

Mmh, this is a bit fishy though.
We the patch using the decorator seems fine, but highlights how this method
isn't meant to be in Monitor if not all monitors use it..
Adding a stub here is just sweeping dust under the carpet.

Here should probably keep the common part of fill_trace_h() in Monitor (e.g=
.
replacing MODEL_NAME and other common things) and create specific
implementations in dot2k and ltl2k for what is not common while calling the
super() counterpart for the rest.

Does it make sense to you?

Thanks,
Gabriele

> ---
> =C2=A0tools/verification/rvgen/rvgen/ltl2k.py | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/tools/verification/rvgen/rvgen/ltl2k.py
> b/tools/verification/rvgen/rvgen/ltl2k.py
> index 94dc64af1716d..f1eafc16c754b 100644
> --- a/tools/verification/rvgen/rvgen/ltl2k.py
> +++ b/tools/verification/rvgen/rvgen/ltl2k.py
> @@ -257,6 +257,9 @@ class ltl2k(generator.Monitor):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return '\n'.join(buf)
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 def fill_tracepoint_args_skel(self, tp_type) -> str:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ""
> +
> =C2=A0=C2=A0=C2=A0=C2=A0 def fill_monitor_class_type(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "LTL_MON_EVENTS_I=
D"
> =C2=A0

