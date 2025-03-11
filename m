Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351917C9F1;
	Tue, 11 Mar 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703018; cv=none; b=J2UUdfXCCTtMDsB502KF8xIpOPKrFxSxJDMvgRNmTKNP1+P+tmcXOt3lOPZFNAxUtYZCoKZDoKJEh++gWQWNWEYzymmyCxedjTv1ByRV5GaQRztlX1azGW/0FwK7B6F4YmNCevAiy7HPuVZubfinJj4NMxMVH8UP3WNHB/Ejzqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703018; c=relaxed/simple;
	bh=bVsNey6nqpLgc9wuzfwetyTPGy3g4G0YH24pC9RLxqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjYpMnGXTsXt3bz0XGw7piYV6RFZBba/BLmD9/YhFopJbhZVj2ygqnLZxsP0mCil7jVyL/HEja7S7A/APb9SKj5/x7DozJ4IuJzYkQm189V5LOKNlHyZqAH6JtUgtVeM6wNG7nyE+OmK6Xs/w4p09bZsNBeSudsBFvKX1jLbOZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InI0GoQz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InI0GoQz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225a28a511eso7144475ad.1;
        Tue, 11 Mar 2025 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741703016; x=1742307816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bVsNey6nqpLgc9wuzfwetyTPGy3g4G0YH24pC9RLxqM=;
        b=InI0GoQzsNjF6suEIDz9jLS+cBs6zHcmm9E5uAzcHucpUIEPT/cgBMAt9imUlTMvrr
         ctvWClFb4XMkEoJxSCjnjtyIMkKoG8Z0ZkeNmsIhZ/Ykj+/xyEnNAbgNn+/G6rSapXQo
         qrWfkeV+Z53io1xB2sXFXuM68Jqpgdl1Mkzxl0reZXtNHegyyFt4pOxRszmeuz0jsvit
         TRCOj+pge+gA/wSo/9mBIpUJIuUrKe/Rx8vefK7TI3auVthkcsdsiFdrrEskbT2fhhvp
         usxvTmNHzeIUgze39udWtDuWHAMopsZrWVwXbbs8kgJ1AGlkaflOQE++Ujel0yKeEhh8
         jGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741703016; x=1742307816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVsNey6nqpLgc9wuzfwetyTPGy3g4G0YH24pC9RLxqM=;
        b=VJ+DIdxCrgd5YVzJI7VssWAvF+gTBTCCCvmkxb0lag9pRsXshN/1f+zU4vnd7T8DdA
         acvpw4slh+mvYPgCYadt9kGZLdDwWHl5i6NQAetdV94DYH/F5uRxUOFymjQOQp3uET2W
         tQWS1Brqdr6XEheu81eN5fuaUkcNzvOR/ML+AEQ7+9mho3Zv6Tx3N7b3BeA67T8kri4P
         7tew5wsj1d8xxV5SrCFoYWhegRmeqyoPZgWq7FklFqDzJ4K1J2EzoYjDsaH69/9NmOZM
         CWlvwcJmZIKoUI2EL1ygjfzvVehLoo9sOBbd8vNDtx/AeJuO14aBaYAg6UMoFY7h4tc+
         vReQ==
X-Forwarded-Encrypted: i=1; AJvYcCULR4L8PdrtywudHR4hdQFc2nAer07zYp8YwaXaActwS92+zOu7dQmV+CFzwckfRMl51y88CFjuDYcnmEnw@vger.kernel.org, AJvYcCV98p9f05b5yEP0OhsGl4fvG558y/W+GSrLHkxRcjm97ZyITR/ee8MzKVgREMb34IAMZDSmHoa4870=@vger.kernel.org, AJvYcCWWliUuheWGda6d7PpEUmrHChqls4beYiT24fScqateDOf2CrOEn8YmrlbrAFc3Z2TcB5XEr7Z6KseiwGV9QasWYe20@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwNynN+c271tfwoGtNIZWXQZ5ab+ovaXAy2Y5+3X1lGShEbcP
	SZgIeNipMH29cHVdxKkPUW7TRjWwDhIWIRLmPkyhAJkJxuYVaaPp
X-Gm-Gg: ASbGnctBboH2a1BNi5l6dygs2kDhFiOsvn/kinwp1Dp9zAgFAHACM5tOJ0uOXc5NXoW
	yGJEt0kFFeU14lLgJz0X1BBiO3LFdsI6YhCcVEvTcf+o5suWxL8j14/ToIOEOELU2hunM6cUwor
	F4V3g7CzeZxQkEXjOzCmV/03bceph6k/VZjuUB3veprBubagFZX2wARJBNmfjqpla+GHc++OeoU
	jmIj/kSeenev1zGUvAK+tkC7HT+ru/OUZXUVAHU2XM3EsWn2cerELS7/YS6fmUHnvU1NVISgVXq
	KIFsfu/HZ3zx8JUAlu+si78cDU+xf95ETMFiydIg3pYw
X-Google-Smtp-Source: AGHT+IHqrPFh17Cmi1OZseYWRYA77dEJerZdXXiZoErlG8RlygvpGsCvt+XYSvfs8p54D3Zlh1fLkw==
X-Received: by 2002:a17:902:f686:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-22428ab535bmr240669445ad.30.1741703016149;
        Tue, 11 Mar 2025 07:23:36 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a91985sm98340635ad.194.2025.03.11.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:23:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CAC7A41F562C; Tue, 11 Mar 2025 21:23:31 +0700 (WIB)
Date: Tue, 11 Mar 2025 21:23:31 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, corbet@lwn.net
Cc: mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] docs: tracing: Refactor index.rst documentation
Message-ID: <Z9BHY1UH1Q3fET4P@archie.me>
References: <20250311124158.22950-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IDclmnVtmqF5WZTo"
Content-Disposition: inline
In-Reply-To: <20250311124158.22950-1-purvayeshi550@gmail.com>


--IDclmnVtmqF5WZTo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 06:11:58PM +0530, Purva Yeshi wrote:
> Refactor Documentation/trace/index.rst to improve clarity, structure,
> and organization. Reformat sections and add appropriate headings for
> better readability.
>=20
> Improve section grouping and refine descriptions for better usability.

Where are patches [2/3] and [3/3]?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--IDclmnVtmqF5WZTo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9BHXgAKCRD2uYlJVVFO
o5uoAQCj+toCQB1w4pPX2Y08OQjlVmrltaLUyZYWdezv2/Rz2AD/UnpRB4fxSlqU
EWbYci2rNEeq10P541gFEii25XTTRAY=
=QEAM
-----END PGP SIGNATURE-----

--IDclmnVtmqF5WZTo--
