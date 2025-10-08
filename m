Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5281D22339
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882136; cv=none; b=EjiyazXWPAEsMR2GwIGywae+cYRdLx2raVd1LYXSrU6t98mgClm18XCMP02QDQewg/9mr68sBB5I1i/mo9jrzHWl43RKendkaqlkFjZDNYBdfLc4I4FBusDVs2AjWhhr8bzPXiziluiHF5q95lZKnjuoAbkPqtkL3bSa3NwJUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882136; c=relaxed/simple;
	bh=TzNbj5F09hehstERxCAIDX4BS8a4whqVaxlUmycH1V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeyEGIstTg7oUwppsoi2aLQ2LlHaymCzIvpP98+U1yUUIPa9o41sdogcj0DeDejWmh/YYXNowndBRCEY/ocX12GPVNqY6cv685uAhu1NJjOVqWWoCJAnNpAzaNmvyK9QZlDn6KfQII72vqqtvWpJjZsCqWltSbZdv0XviusBBiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvc7zp2Y; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvc7zp2Y"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b55640a2e33so5107466a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882133; x=1760486933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzNbj5F09hehstERxCAIDX4BS8a4whqVaxlUmycH1V0=;
        b=Uvc7zp2YtLGsPEPTE4M12zTHbD2E/n0JxnU+r3OqlxYyEciMsvIPMCoksg80JJqgyd
         QUh74XE906/BgKc7yuwprYfYm+VR0eI8MxtLc2EQtbGj7FYdarFXCSTPmwZNjrQP9xuQ
         ikD5iRbJJi5H/6S0Lz30BmN8e6pz4DXZhqCt23GCtWPq5GGUIliS+8D3v1800ymu/eTu
         Crlc+xRJsqDsuFGWoAB2ByxQAmp1rWkB915XipFdpYIqZxRsRyY0xLTtA3wnJiaYFZ+w
         keVCBKiL5CoSaobO4WjOGKd6ZJxBXG1zicxQp+72rzt0vfrjiSYayZt6OzKloBG3wajK
         WWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882133; x=1760486933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzNbj5F09hehstERxCAIDX4BS8a4whqVaxlUmycH1V0=;
        b=Xl1IGtfgZ1R2HUV4gt382HBZ8756s8evjrlnCPYTc0h+YyDJX9Zxqe2SJTAXFGe8j+
         csEDJqkfmu2cCNqQ4/ynzWw3mtizFUNd6b9TA6zGSIEXW/FAD22TFRjermflpwzijhms
         hEKeqfJn+J4GNCcCH3gp+Dy1odk6Nsu1nld4GjK51PrgOlgRaI5hz0LZ/JzjVQ5Kg6wX
         sCGofBm0nle/uFntCO7LP9Uyn9KWO8t2+mwPi4HX0/Ku6W4Du2RmyXmBp+eRSHhvTGA6
         AitfAoTiVC9+pvDP3JJ4WnKKQz+NMZG6OBBQ9iJwJPztleMMVlViST/40rahAayeSQ/a
         0WOQ==
X-Gm-Message-State: AOJu0YySi11AhWG1yyQ/aa/LQi+eNjc/aizm+NQ+a5nVZVeiJM9E4oQI
	hVRYVKcglPXdb6WvEW1CuqydLMZVCT4DD18iq5cP8slHAPcTeaWY8Sbh
X-Gm-Gg: ASbGncsNdvqOt/jyFKi9vl6/Lu7JROA7GbZ0Y32fV2oy9h/Nyl95zrJBmo8liprXVI5
	btNgTvLBiJnFPDHGxtQXHMNdOm49xkPi4Yu6RNxR5xgA3tkIUOzIv+PqBTxBUnHDkboBUMs+zlm
	rn0hnHyNcwrdoTq60WC6/0qFo4TiiIn7g23BIvX8+KfLiNb7qN9BHYt30Nce46qSCLcwgZZmcso
	O3fLr3jw/xZa/Wy6nkB/tC37oaepDsy7cT/jWTmKGx+hqmZrsEz1Ncq4y9PoJd2Fvp180b3NqwA
	2dA743QbVpYO0gBS1iCbTplz2iR/mhiwv15NTIlUMzbEI3klBlwKy8momYVm7vPUwue8CX3UeAQ
	+GTfVl4QYLunfti2/2Q1xF1h+AW4IvKS1KSn2Qtv26tfeJoYyKA==
X-Google-Smtp-Source: AGHT+IFz4iqQnGC++UNb9avJGyf7WNgIxVS5Iniz0mvnqB7gDtzJOUwL4fBGjQJWpj0aVrcA8Elc1Q==
X-Received: by 2002:a17:903:2302:b0:263:ac60:fc41 with SMTP id d9443c01a7336-290274030a0mr16042285ad.48.1759882133374;
        Tue, 07 Oct 2025 17:08:53 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1267d7sm178391575ad.49.2025.10.07.17.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:08:52 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A68294233430; Wed, 08 Oct 2025 07:08:50 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:08:50 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 4/8] Documentation/rtla: rename common_timerlat_aa.rst
Message-ID: <aOWrkhlBoKDH4fRi@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-5-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UKApmRWlee9TbfyG"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-5-krishnagopi487@gmail.com>


--UKApmRWlee9TbfyG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:53AM +0530, Gopi Krishna Menon wrote:
> common_timerlat_aa.rst is intended to be included by other rtla documents
> and is not meant to be built as a standalone document.
>=20
> Rename common_timerlat_aa.rst to common_timerlat_aa.txt to maintain
> consistency with other common_*.txt files and prevent Sphinx from
> building it as a standalone document. Update all include references
> accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--UKApmRWlee9TbfyG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrkgAKCRD2uYlJVVFO
o15NAP9cMZH7s50QpPUQSGh96FcYFqRpcCt7ov3hAmYqpMrSTQD/ZF0oz7pf16FU
vZKihKt7nGCu8ziutqKJOZ38dw3sEQg=
=whcv
-----END PGP SIGNATURE-----

--UKApmRWlee9TbfyG--
