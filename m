Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F26219E8C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757645721; cv=none; b=rx9xTk8TMI2hUEo0XU76kXN3e5D6eqNWzi8UtWQPVWP344ghuFAy/vZnrjbBB3nl+vE9lv2UHoPqVq4xpTXrZOpCHptjyz5qCJxo1d5/DsDfHrW7zNI1+q+MiRqjKIQHnaESU5g4SJu00KdecOOWvcaLrmjsq1AWtAxJKnBA+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757645721; c=relaxed/simple;
	bh=8dUblNqD+QvR3lypM6+6pgQKaz5acFHh70UWBGlz9eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmLY8HHc/Bz8HQNM+vlo0nTW0/jMHBwZNlqLeDDGmYApNbcp2VBep+yi4cuDzZsWNHO6zcSiuXeO6T/E0acuF/mDBug0FNn3Zmw6R4+HVUygD6xv9A9goKqfypTW0uVz0eZkaG9kCpOTdSZywcvc9d4BtXKC9ZEeY2/pHCY61/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKoIXlND; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKoIXlND"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso1050761a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757645719; x=1758250519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8dUblNqD+QvR3lypM6+6pgQKaz5acFHh70UWBGlz9eA=;
        b=VKoIXlNDVjjQcM0nV8J6JZHH10HMkxnCiF5gnIodzWTX5ioxi3aujvaz4MP4X1JgaE
         gMg3L0M4m5Ykn4sFNfDpBvLAijNPWD44+UVuscgXpHhJn4lJfPIGnvxIedOYeS/9S800
         qiA0A7DDRCTduJa5zK7HqOBc1dv8EeKJUKMqvrH3WJ3FXiUMqZ4ObrA/PHTEE3ntiTjQ
         CfSkB1+OuOl84NrRiTB7BPkMGo2Kt0Eku4xt4znS20bqfufpJdSc7TadRbgcUq2OVSyd
         wMdGS81EkZuHLxsXzB+e1DQAEEY6csky8ch9I4XocMIjQG1Aepm1Hd/CUTXkFOzoMwRw
         lS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757645719; x=1758250519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dUblNqD+QvR3lypM6+6pgQKaz5acFHh70UWBGlz9eA=;
        b=BXubN2CUI9y4A26RbdnXTOzPx8uU/C2ImXJY6AYtQGG6mIAWRpMz+DiGk3oO+uCVse
         UVGysVKTlYKzx3gJyjO9I4VS9zXIwYyBCca2EZNCDz/V8LdQATbZqVTa8GsUWWdGjHdL
         tDICFtaFOBYV7ey270NgRSs0qupScDgANv6qOkW5drFjd+5VnO89Zfsk8gy5ijqXNhq5
         VTU5arOYDWw2w60BLPVBiAsuFczkimJDlt+NxNILW7aMGQuYVFf+bl16PV93rO/72oRu
         xJac48B87AYySWFY5+zyffkCBGDCd+pLeVb5wnMGblEZora3zcdyv3fToRJ0EsNGRZef
         BzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVkfmteFymfDHdGdvF9M9quM8O3YTYaZ22aVU9bu+k4WUH3u7dYUAfwLnfFVhBcc/JPvqHdpFjVrm6QsoqSVqc0YE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Y4lwuOjbC8karAxMFCnmrk6z08xzVzu2Iix4prDYGT1rdwyS
	La3Ga77Ho72oDGulwuwwUfjE1f9FmdWQi1SFXA/cbJwvmwNvpz9PFjQ/JIBCDQ==
X-Gm-Gg: ASbGncuPSk6P4ceFfn02F3ur+s6QxwD+lUl1JsYVUAoqs9E8qgnTimFdmiiYTBuhzlH
	w01g/KrxgeKltclWzXn8y1O/MFK3N+/yk+I1ijIBNjvRZKX5a/sW2D6V0tSpR1wfdkFBRbkyrzf
	1F5cyZfWliwitkS5a9pGCjINNI/PXYTLoSbVOS1XNa4Qfo3XZFz+HerjOUSqB2+gPD5FCX7gG73
	ypJkcVFUC7r0aqJedGJhH8UnYiQRb9eYKbjjagOPak97Caq5+hG3p5JGkMJod9kIuEWkvnXkIik
	tWhfq+iczfPqYqd0tbqZoAnaF7XV49OrH0mcr6p6hvqJ5ZhnKl5pL5BLAVFuNuY/jPF1LheShAr
	gb6jR55CVg9YrdCM0vXDsEIywnA==
X-Google-Smtp-Source: AGHT+IH5JN5qNkoNcsYWg6dw0fXdbfeF5sEn0cts8H3wCmJnWb9B3BmToRmZiDopftsOn3Mj7ikpQw==
X-Received: by 2002:a17:90b:17d2:b0:32d:8eb1:4e26 with SMTP id 98e67ed59e1d1-32de5144a8fmr1650790a91.30.1757645719140;
        Thu, 11 Sep 2025 19:55:19 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd632692bsm4479084a91.25.2025.09.11.19.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:55:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1BF0941FA3A0; Fri, 12 Sep 2025 09:55:15 +0700 (WIB)
Date: Fri, 12 Sep 2025 09:55:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 5/5] Documentation: trace: histogram: Link to ftrace docs
Message-ID: <aMOLk7SAOrjogIy-@archie.me>
References: <20250911042527.22573-1-bagasdotme@gmail.com>
 <20250911042527.22573-6-bagasdotme@gmail.com>
 <20250912095827.3d5a3feb80d5c6c44667328f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0lyQ/UvkQaG+h1EJ"
Content-Disposition: inline
In-Reply-To: <20250912095827.3d5a3feb80d5c6c44667328f@kernel.org>


--0lyQ/UvkQaG+h1EJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2025 at 09:58:27AM +0900, Masami Hiramatsu wrote:
> On Thu, 11 Sep 2025 11:25:27 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> > In brief "Extended error information" section, details on error
> > condition is referred to ftrace docs. Add the link to it.
>=20
> It seems this does not add the link. Can you make a tag and
> link to it?

Nope.

What the patch does instead is to convert :file: markup to proper
cross-reference. I will fix the patch description in v2.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--0lyQ/UvkQaG+h1EJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMOLkAAKCRD2uYlJVVFO
o+jSAQDIDumTK8LVsSWKsUI3RUgdsGDqRYt2dirDbpbLNSnz0wEAhsnSBv69gyj9
k5kn7BpHmEuJjj63nZFMXRa0UbXj8Ao=
=+PaU
-----END PGP SIGNATURE-----

--0lyQ/UvkQaG+h1EJ--
