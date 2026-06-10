Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126B38837D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781075865; cv=none; b=PJvFJYpQnJJtIfqsyNDoLl7cI2mYjT3LpfoNxZXLutyUUYQcEWvDZZuvhPV13nUTk/XoQHIfLUwN0aUrkOMa+YclWOizeGER6LKvySc5ar+twwOSBdYtBRAlP1HrsiWSk7rkcmvxW3Oom3iIt4lSgkH4/m2b39FNZxB5vmx9mmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781075865; c=relaxed/simple;
	bh=B8s1qoLnuglQUjq0RRHMM9ZdZAGNRyf/EaVTEnHb9xw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YGKSHZ8qmhSfAov4m+Jju2Cu30QviJKOzte4rz11tcBazfS31kW0HL7lPuxJe/GXBSSiXgi37993WWf8v2i8x97gBOniQpaeIjLA7S/pNwcFMbZspLjDo91FhBcB0SEuOMPy8Q/fd1YUGwPC8iI/mkc5ntlFdKQKXOMh1jF16Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=L2LMRfn9; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="L2LMRfn9"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490be03d47bso55400645e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 10 Jun 2026 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781075862; x=1781680662; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jCKu57IyI+CSX2VlpGJW0vtGLD+VdGclrk2Cs3IIERU=;
        b=L2LMRfn9XiowuXB2kpH64mrC78IMm/Gop0wsR7FTQYPo7axTx4S4Q15QUHOltlFZ2F
         M8wqy507ULCp3qwLASC6Y6iWrtDMDmuNwaJaO7hHav0rMUdOZP8jGuH8om0HE1imf57E
         gMnF64u2UPo2gvIEsklVumpG3L0BQm3rmIhelWWp6GKMzI3jLeg4a3FARSJMIvrNDVsu
         MHmDXNv/bTJFiyWK7jpJ+N4RNSjrxQJ8jNd/FX0zey368LO1/FVdTeAPty6f49NHDPjh
         9dbLxmTq58cbb/sSo6dtzoF0xaA6ihJYhA6EROPAgPAaoAfWepfwVlYNqGNkO0SfBH/Q
         41IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781075862; x=1781680662;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCKu57IyI+CSX2VlpGJW0vtGLD+VdGclrk2Cs3IIERU=;
        b=cTukfaaG8v3AeYVs09PNgmluX+THREsSX2VSR1738edkM5BdwT2wgD6juo6byXZ+Tl
         Rglsd9KtXOGtz3BdQfO2bAH4cjNgsRdSVaapJbDXVPbPw+WAuv/Bnlah+qpH15iAoleV
         vsGnJwwOy7rI9rFXXUsLIgqkMG1UQb18yApLV4tcoIa8+4RhGGc8igjy18Vmo8YEne6Y
         nyvN28wK+YcJpGPcdSFIc1gZJHjZkt3gvqlHj29bRITBgKBltmkLKF7u9A54gq3VgEec
         zONInZbPufABBn2HK8kOxboWVp9uUJo1SdDcWBb3zs4MJPMqLncfHApt0U4XwO6I6IsV
         9plw==
X-Forwarded-Encrypted: i=1; AFNElJ+/MR70t/lLTThqQXB4Fhtvbbqi2x/OKGlwYAVJYHZvd5dxXRgPOn0ZWrKQ+QqvWDeUbm7mCSDfnUfe8rY+wzER0Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4+i+1eCNI4e7q4FzlS5H2Xk3/t0aUGc6V3uGA/F5wD9yRcdi
	xMS5JcD4aAViK4OFzSNTOtwZW5n/R6DCZHKUF/7g2m9ClQW4/PO7R+oj2PhRjK80qWo=
X-Gm-Gg: Acq92OEXX7q+ufVotxEfa8pHi7oHUIlnhjIwV2+zQprxQJxytm4QYM0/cMwDTivZ6/O
	y6+x9DUMSa5pD4i9byAbo20QpttBsgSvLaSLwiSGFX+jBR/8oGxEw8I+NPYE5kUuGu+eGZeMzqB
	eV4JisfgkPSwgje+nQ0SGGYbE6nI3w/MLmKXUeDehAW7o985TKjQZyqwS5U2N6ETwBrsaEwlOjZ
	VrJAjv8bXxyDqMSCQ51XyFwJamtvPkeOGuylIyJe2O0bqAGqaiokCJFQWFtEgvMmAAKvxVt//HO
	Alc1ulV7UJBpaWiG6pcZxgDRRKUAJdzuTfBSLwgoXtPBAg7c05l9gO60DQhSJHiscVkGBItXd0M
	fqrWswDxXs/wjC2GXXS5/Y9PSkSiM/EVqXRd3FiCrWA3GYvpkbjzAGnOxos7zpP2onMNcKukOq2
	jqrY9CZpYjoXOp9YUkYOEG5LMPtr5vhA==
X-Received: by 2002:a05:600c:19d2:b0:490:bb45:79da with SMTP id 5b1f17b1804b1-490c25af9a3mr394180585e9.13.1781075862004;
        Wed, 10 Jun 2026 00:17:42 -0700 (PDT)
Received: from localhost ([2001:4091:a245:857c:6881:1355:3b75:b347])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3e59f5sm571522045e9.14.2026.06.10.00.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 00:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=2ba03cdaaf9b280556526733e9e94fc337c9b0cf04e01cba1cca21aa663d;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 10 Jun 2026 09:17:33 +0200
Message-Id: <DJ56P3IGUGBJ.1NDUNU380KV10@baylibre.com>
To: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Heiko Carstens" <hca@linux.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
In-Reply-To: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>

--2ba03cdaaf9b280556526733e9e94fc337c9b0cf04e01cba1cca21aa663d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

On Tue Apr 28, 2026 at 10:30 AM CEST, Markus Schneider-Pargmann (The Capabl=
e Hub) wrote:
> fp pointer and unsigned long have the same size on all relevant
> architectures that build Linux. Furthermore this struct is only used in
> architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
> set only for 64bit architectures (apart from LoongArch).
>
> Both fields are aligned on these architectures so the struct with
> __packed and without it are the same.
>
> Remove the __packed as it is unnecessary.

Friendly ping on this.

Best
Markus

>
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
> Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.=
com>
> ---
>  kernel/trace/fprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index cc49ebd2a773..21751dcdb7b9 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned long *=
stack,
>  struct __fprobe_header {
>  	struct fprobe *fp;
>  	unsigned long size_words;
> -} __packed;
> +};
> =20
>  #define FPROBE_HEADER_SIZE_IN_LONG	SIZE_IN_LONG(sizeof(struct __fprobe_h=
eader))
> =20
>
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260427-topic-fprobe-packed-v7-1-f44f9bbdedf6
>
> Best regards,
> -- =20
> Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>


--2ba03cdaaf9b280556526733e9e94fc337c9b0cf04e01cba1cca21aa663d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaikPjRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlN7
agD/fKZ2/snVbOXZFeTOY+OixC7CgZWMKMzXf6AVsK4sNbIA/jZFv/5PqoVoYGnv
JL3mwn70VOTb79qv8v4dmRqwhwEE
=Aine
-----END PGP SIGNATURE-----

--2ba03cdaaf9b280556526733e9e94fc337c9b0cf04e01cba1cca21aa663d--
