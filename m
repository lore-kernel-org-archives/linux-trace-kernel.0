Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9C03AD517
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268734; cv=none; b=bzR37oXIHUtwBtmH7Pifb6HAU+aj67pgAib9ol+kgytetWhQ1vsu3l5Uoi4PfEAhpawL7MP5QsoVEtS3CNRWoNW/kyy3lnsDPtE1GXAV2Xc74t5mCmXh2pxCWCjPQZ5n9OsiJqk6QUXYdu4s7EPhc2vxP+2Mp+wAscQsbnlCqXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268734; c=relaxed/simple;
	bh=cStNl0TAPT93gNmUpgiu3tt/N/MKv25GszYVr3I6KiI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=XZExkqM1VkhWMy0ldxzRfFUxI3C2qualo2BQwCk4NPt7i27NoK17VbPlc7mmPMrQIH/liZhMhWuAIUIIjNvlsxcJq7amu2RRt2yWY685fVMFpShBLqtbg05Iw/F4Gpg6DHkVQp0WKR+VI0/nZvIC2au1uiLjzQxE9uByI0Ahgy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=oCnTSqK3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="oCnTSqK3"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-45fd45e596cso529111f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781268728; x=1781873528; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BanM+9FqN0NH2f7uUkajDPjkggu36+oU5qieAlWT7rI=;
        b=oCnTSqK3r9pfU4lXlVBCY6ViuzScer0ftri/qY2+sJSSCmu7ay+VpVdjVuXqkvn8pi
         zybpoYgc8IPDJEgOjNjy3Evd0fcNk7u9hOPRxczmvgpsVquTtef2hSOUZ0LkoC1vC1KC
         XimGxmirgA8h6RpShNlfwKHyyR8F4VZVLCzv2/mCBzvxaa4SXXKeAKgBX9BlxAgtTg3I
         2pQIuOrSzmobpC9f6hqntiqigLmUWx1fFuzYyT99jcMb1hv0LYL0EsifFdrmdqfrP1ir
         o2dOT/vxmrbtvLHdCbQALPwntGAo9+1sZN60YRiziI+WklFSlnbdRIx3QbTytdHtQ5U7
         l2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268728; x=1781873528;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BanM+9FqN0NH2f7uUkajDPjkggu36+oU5qieAlWT7rI=;
        b=PXNi9WTcTyEyi5XjHuLDe9tLD2+A1DxtWGLlVxrRqJ6IvBSG0a1OxsBTkNtVsFOYhf
         dCZfqQ9f25112E3GMHebVquO0jyInMVA+YbTW93x4BhW26pjgpf/BinbcTxXwJc44vgl
         qu2OlHqMmCahq0wn8Wk00ny89/4zbm80dQzAyR5ep8na8dB0I+IWx/psInkJYKoDmDT5
         GPUHY3lN+qvBZnHUDMZPQgBbTAihavHMqJpneFe7zlaByUl2KTPrKWfsoUMidPKzXXpP
         eEIKIWLACyq0cvWQCDmQkNMeV01bAXgj0WWLHCCaCNwrPZimIZ/u316G5xG7cz0aMWqD
         ocag==
X-Forwarded-Encrypted: i=1; AFNElJ/wXXFJE7Ts+5BLAmfKkQHeHoAjudfc3xA3bbgWx/DzaUj5Sehqm8G7LHjtwmbyISyloU1LIQrkqJg5nBx32DFeqzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1A1Ay1wVpJdGxXBIUhU1ddNpy0WxTmCStoN/tcAQfl3esRFBO
	uofD2asq7ofLHS4XyUbcG0dGM+xOidHFqtWWkfA//3E5Fx78mfOw46p1Cfo+2kWQp4c=
X-Gm-Gg: Acq92OGuZ9j5bMuvWVfUqflnWn4o/vUmX7e8qZKmL4EILdFoKeyNr5/Ruvf2yJxQg/d
	ppGR/dPxAhMQpt16WcosW0NpAKt8xBnSzDmFimmUkW/VUPXSmdepHV+egfxluTWz6KAip7feOk6
	SnazI/ggfZgexDxNHmjgyON/4eFIDyiK11cOeEqnzzBLLCq15su0Of9VKkamMw873XR5bT4bWV/
	6Nb+d6/LWeViccFHW8Er8lsM/K38G4Csvsg02Rz/IGu1i+V+i16rCOAeHkytzjlMRL9kq683KZA
	qJPxcQpSD47e0Il6sarySrQBdBnc8hPalazQd1v4/1Gq2T/K7ncr6BYbOTKo4NOvyG9u7z19FtD
	Q/ER5gJIoRtRNObiq9+LfqLjdQ9koKU7IKIvRE1FTet/49qYaKbquLCIQcpstMgfyx3FbcvdBQe
	E23dOagJCKW+/UaE8wsQ==
X-Received: by 2002:a5d:5f44:0:b0:460:1c5b:f25f with SMTP id ffacd0b85a97d-4606db96c29mr4446363f8f.20.1781268727756;
        Fri, 12 Jun 2026 05:52:07 -0700 (PDT)
Received: from localhost ([2001:4091:a245:857c:229:71f5:91db:9ccb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2b0bbfsm5561589f8f.23.2026.06.12.05.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=1d98463f0909420db3aaf81a6f6c79f939a96177e69408b418dd1161c3a1;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 12 Jun 2026 14:51:58 +0200
Message-Id: <DJ7328G40P9R.YB03MWLT8GQF@baylibre.com>
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, "Steven Rostedt"
 <rostedt@goodmis.org>, "David Laight" <david.laight.linux@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, "Markus
 Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>, "Heiko Carstens"
 <hca@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com> <20260610171740.c30c43c5faee0beac3ad7546@kernel.org> <20260610120659.7c61cfa6@pumpkin> <20260610155139.01b6def4@gandalf.local.home> <0ea2ae74-7452-4ba5-9549-59197c766c25@efficios.com>
In-Reply-To: <0ea2ae74-7452-4ba5-9549-59197c766c25@efficios.com>

--1d98463f0909420db3aaf81a6f6c79f939a96177e69408b418dd1161c3a1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Wed Jun 10, 2026 at 10:05 PM CEST, Mathieu Desnoyers wrote:
> On 2026-06-10 15:51, Steven Rostedt wrote:
>> On Wed, 10 Jun 2026 12:06:59 +0100
>> David Laight <david.laight.linux@gmail.com> wrote:
>>=20
>>> So you only want __packed on structures that might be misaligned and th=
ose
>>> that contain misaligned members.
>>>
>>> If the structure is only guaranteed to be 32bit aligned then use __pack=
ed
>>> __aligned(4) so that two 32bit accesses get used instead of 8 8bit ones=
.
>>>
>>> -- David
>>>
>>>>
>>>> Thank you,
>>>>   =20
>>>>> Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@bayli=
bre.com>
>>>>> ---
>>>>>   kernel/trace/fprobe.c | 2 +-
>>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
>>>>> index cc49ebd2a773..21751dcdb7b9 100644
>>>>> --- a/kernel/trace/fprobe.c
>>>>> +++ b/kernel/trace/fprobe.c
>>>>> @@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned lo=
ng *stack,
>>>>>   struct __fprobe_header {
>>>>>   	struct fprobe *fp;
>>>>>   	unsigned long size_words;
>>>>> -} __packed;
>>>>> +};
>>>>>  =20
>>=20
>> Does "__packed" really do anything between a pointer and a long?
>
> If that structure is allocated at a non-void-ptr-aligned address, the
> packed attribute will ensure that the compiler don't emit instructions
> that require aligned loads/stores when accessing those fields.
>
> It does not change the layout of the structure per se in this specific
> case, but it informs the compiler about the lack of guarantees about
> alignment for the entire structure.
>
> x86 32/64 cannot care less about this, but it's relevant on other
> architectures.

Thanks for your feedback. I checked this before submitting the patch.
The struct is always aligned to sizeof(long):

struct __fprobe_header is only ever accessed through
read_fprobe_header() and write_fprobe_header(). Since the read will only
read what we have previously written, only the write part is relevant
here. write_fprobe_header() is only called from fprobe_fgraph_entry():

  if (write_fprobe_header(&fgraph_data[used], fp, size_words))
    used +=3D FPROBE_HEADER_SIZE_IN_LONG + size_words;

used is always kept aligned to sizeof(long), in fact the above snippet
is the only part where it is actually changed. fgraph_data is assigned
here:

  fgraph_data =3D fgraph_reserve_data(gops->idx, reserved_words * sizeof(lo=
ng));

fgraph_reserve_data() returns a pointer into an unsigned long array
ret_stack. ret_stack is allocated with

  ret_stack =3D kmem_cache_alloc(fgraph_stack_cachep, GFP_KERNEL);

and fgraph_stack_cachep is allocated with

  fgraph_stack_cachep =3D kmem_cache_create("fgraph_stack",
                                          SHADOW_STACK_SIZE,
                                          SHADOW_STACK_SIZE, 0, NULL);

So as far as I can see everything is sizeof(long) aligned here and it is
not allocated at a non-void-ptr-aligned address.

Best
Markus

--1d98463f0909420db3aaf81a6f6c79f939a96177e69408b418dd1161c3a1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaiwA7hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlO0
gwEA1oCSzd1Hbai4Da7Y1FjR5B6IlbDp562NsFYQJz6VxGgBAMmmzm8vHk/eOP+g
n+ibbZWP+b156M1ITG2+ajqWbhoO
=L48n
-----END PGP SIGNATURE-----

--1d98463f0909420db3aaf81a6f6c79f939a96177e69408b418dd1161c3a1--
