Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DFD2AF19;
	Wed, 12 Feb 2025 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358650; cv=none; b=N7h8YDhEGw265tEBmJ6H9Od0wYWOSODdwr1+4csOW7FlzG96vpYRepSddZhBX62IZ8ShsaAP47JBu3+ZfAW6XNITvUQw/qahs4hi19CeVeiX5/9i4QVpFOl8P2HrZA7B3x3eqQPDGBB6XYLEYaUCTRFsFDNjPI0wjsLsuhl+oJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358650; c=relaxed/simple;
	bh=r79VELnViF7+zIzfkgy+4Z0CPtTiHpjajGKPiHY0sQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOqzY2ICWJToFPUztUAPnk7tT8Nkz0C6b6Gw05gkie5oLS0UiPhcZyeaXI7adRwl80ZoJonFUWiyiTteFs7VSsv+0SbV6VizK+paZ6EAS5b5nxjjJZVwyWHSOcWaR0U+pJiBNRR8DdxV1GGKv7un5VxXoRH15xzkncebQSzKrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neO4g9XF; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neO4g9XF"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f40deb941so144886845ad.2;
        Wed, 12 Feb 2025 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739358649; x=1739963449; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a7fijWHvwPLZETcSwOhX6AJpI56/uusqCA2JoLk/IPY=;
        b=neO4g9XFVWb1XbZZIkfGaRNkJYnwRx94ikmveCBAw1WNVW2UiqYjebpXhwPn5AyTG1
         vBhgvYWLlidkeQqf82+YtOgK0754W/qEQFHR14TZa5sgNzpBv55whiM0dKEiFdHNfOh8
         Yv470DjerqAXWeMGwZepx7kIwrGn49+LCOKjmcT2Ui7s/nPjd+QldWbd01g80wZWb/+w
         e0PQdnfE5PdK7LYm4je9SvDxo3zM9IJ3yApkm9vqPIcOnD9VAoA2Y+5QfWB/mjf9Fwxp
         AAqysxVn8bIfNSvk6ipVW25U6RfCRCtccSbkX8TR9HXHKC3aQlJ2Nx21dgIbbfQhV+PU
         ESHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358649; x=1739963449;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7fijWHvwPLZETcSwOhX6AJpI56/uusqCA2JoLk/IPY=;
        b=QCU6YpRF52gcyed2ig+5r37C7E4V7xQrSuINjiPH0R0FoDYrdAMMiKuVPzLvitbj5j
         iZpzGc0ofODwwSe4WGsZ1d9EGRFz3u3YSZ8CxOOSzUE1thMgAXIlLwwkzGv7VSpMn2Hp
         6VfvHBhFnPViaZ0PW6whKpbcD8egDfwez87U+NAZp1qke22efrNT/qJ/L7H0oQQ3w2BA
         vdersyCeE/k85NMF8dO8TXW77LSpwL5EvxiCRPyqr6bQCHZFG/Y7q9gu7SWMz7t82ptl
         wjuwubS3zdg0o2X7vKviTF+L7fpc2lNGCetIZu0uPt3SiriEKRUxiUqesI+Or85y1pJ7
         XT1w==
X-Forwarded-Encrypted: i=1; AJvYcCVuG8oH2CCJJFVFUL/RQoz3pQrhkrVQ92nZcMUukGH9FfZcxJ/NsH2HZeVgLjdrL3bd//VEIMJbfPzCay5k@vger.kernel.org, AJvYcCWlD9M7eGnuA/ZXBOabUdz1+4bpnrmu38NwYaIP93e+BR/TYZVKHa+uLohMLtKxAiTo8NYOu0lgOnc=@vger.kernel.org, AJvYcCXhvXN3hoYN8mEcuevsXQts2EAo/+38GK3W2opX4Jy43Uw1uU3/NpybREAwmhg8vCnZvViMKmJtHjxcMpmdXT+2qXcJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yYvh7kwJt/mh1TkdQkAcHQLmmDRN6+qgeUBXwvl4BrCfWcx7
	bgG5v1+lYdRv8N/0dx55I7Obszx2dvQ9punOE38mcsKeXwZ/LvbY
X-Gm-Gg: ASbGnctuhoI1/mxPu+zDOcQXb7GWS4qjCmekBvnksYTORd8zS5Rl+2+YvztQ3NvvmOL
	qUoKXHXEoPFAWpb4QhN8hQbSWjlmg2SdEEzMIyQqzhLEIDhJeQhKnyYe6cOh2kn56bEvnsiICbw
	vELnV7t2XkgmFXhE3SeHwVOsdAdNrFzerj3UnG6TqmU7adqkATE8Q7S47LAKPyt27ckQDnFcj3v
	EQAajAETsVBUYuSp6RuS8rwMC1wPSpYvj4sRj9xB8z/l/yseoMyOkY/FHFoUHDJdd7ZpifZdvwy
	BlJSXOcLZxqgSPs=
X-Google-Smtp-Source: AGHT+IGp2GrkTxnkrKocmv5gmhrc7t4bOc4wq/AeiNfsAXB6wLiZu11bnsEFtrqJaXyjiakK2bDQ0A==
X-Received: by 2002:a05:6a00:2e28:b0:730:8526:5db0 with SMTP id d2e1a72fcca58-7322c3fe428mr4533067b3a.22.1739358648568;
        Wed, 12 Feb 2025 03:10:48 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7322d4c2fb2sm1071798b3a.166.2025.02.12.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:10:47 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id A937F41F5559; Wed, 12 Feb 2025 18:10:44 +0700 (WIB)
Date: Wed, 12 Feb 2025 18:10:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Purva Yeshi <purvayeshi550@gmail.com>
Cc: mhiramat@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] docs: trace: Refactor index documentation
Message-ID: <Z6yBtB7mjoiquKRj@archie.me>
References: <20250206141453.139613-1-purvayeshi550@gmail.com>
 <20250210174556.70fc53b7@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G4fEeRqeY7bfT9kX"
Content-Disposition: inline
In-Reply-To: <20250210174556.70fc53b7@gandalf.local.home>


--G4fEeRqeY7bfT9kX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 05:45:56PM -0500, Steven Rostedt wrote:
> On Thu,  6 Feb 2025 19:44:53 +0530
> Purva Yeshi <purvayeshi550@gmail.com> wrote:
>=20
> > +Introduction to Tracing
> > +-----------------------
> > +
> > +This section provides an overview of Linux tracing mechanisms
> > +and debugging approaches.
> > =20
> >  .. toctree::
> > -   :maxdepth: 2
> > +   :maxdepth: 1
>=20
> I don't really know what the maxdepth gives here, but there was no mention
> in the change log why it had to be converted from 2 to 1.

:maxdepth: specifies heading levels depth of the toctree. In this case,
the author wants only doc titles (hence 1), whereas 2 also includes
second-level (section) headings.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--G4fEeRqeY7bfT9kX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6yBtAAKCRD2uYlJVVFO
o7o7AP9ZDuLNx/pS+dVzBbJANlqkQ6/aBRBsp18uCVK/VSXP0QD/erPFR5e1iGi1
Y96FwEN5+wlxAfr87V4jb7YnOpTMmww=
=pH/s
-----END PGP SIGNATURE-----

--G4fEeRqeY7bfT9kX--
