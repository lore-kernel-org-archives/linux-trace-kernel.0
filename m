Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D853519922D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759882180; cv=none; b=QkGLYI/huJlNOpfjNjsdHu0zLCej9ZOi99ix4B/Xjzml547Q4f/KcgjEdhsXD9XfWUuaXIGmrXJKqhWjbcc0aYE5bwsciEYh5q5Vpmie4ieqxb6Ci5h3iaiIGKop8ZFi41M4ZM9NbwMjsXN5Z1yxXj4w8B8yBJosqK+YhX9gbhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759882180; c=relaxed/simple;
	bh=SiqBsvlUVBV9X2tD7iHdB7FMlNgyz+EJDz9g/wHLMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2jmu0OOCOtKirEG2M8GIqDlqSqOctA3YrkkKieXZ0H2rSqmhoroqNUNS5QJaGrCkcL4ESgCHCaWZxZ0zZbraZ+wQK6C01NUZex9fz8tq533jFoFIOgqMhrJiHr4o4MRJXKg4UIJgUklExmL6cvKiJXxWlY7XbvkI5qy7PoC9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7rFcjW6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7rFcjW6"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7800ff158d5so5807821b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 17:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759882176; x=1760486976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SiqBsvlUVBV9X2tD7iHdB7FMlNgyz+EJDz9g/wHLMx0=;
        b=a7rFcjW6r7uDt3uV3PmBelfsOSHGwAHATvEJXxATW+XYosSTKq5AGyirIGO+QdQPDZ
         6vQUrIqZu/l4jMVDiytw6HqVMWmdLJVsf1H3Y7ZGOXTIudixJTz3/lFQsUCKuzPW1tRY
         O3GX8NiiJHkE24LywVW0VHheuriOA30oZfMzoHvZf4AM6HAiMibmyjbIylPaO57ku6iI
         Jb0J5jTN7l06hRGFqACvKK701qRvDM18ttZ5raUoo9KvdDm/8sYUKpeuLRFUYyfsNLGp
         7ILVQ//bgEOSiphPsulS0zA0G8ibFRUmXwnbToG7N9rRrOs3qded4YeoTbN0TRic5wtj
         NC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759882176; x=1760486976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiqBsvlUVBV9X2tD7iHdB7FMlNgyz+EJDz9g/wHLMx0=;
        b=ptWqs21rGzy8dURB9EeWt+1XTFi1n27YNrcekq4hJW1hOcRnDHmpKpJWlvB8HwUCk5
         dxH0tmz24SIP4IPs5jTL3Dk1wirDIltQY07Ib/AxwC+fk/BJfDkf/e0VSpGbrhjLQhLZ
         ahQJn7ir4Mj8TYMDBI0ea6JOzHBXwB/QX//ldifxNZMmDLdf4rHrY2VKgynQ7jBpEWv+
         Cz6jgtK+OcdU/Pdmolw54qR0DiqSvfyPwkI7SgS44/ru7ZuRrhvpMYG+zSKWxsJ194ge
         pP08yJ+RbDdNuWvsycVpXKXjbPIaVkPQZ+gwzdXzz11uZ2C6QdcmRv85kvKYGrglLAL3
         0ncA==
X-Gm-Message-State: AOJu0YwLEzqPFv+aIF9knqnxfEAR1rml3Gn8A+RWpyH0jRfZA6BrUrrz
	aKToO5Tr8lLaXDbbtrKaMBpkYcs4VAbIGRrer4ttGHDPDX4At7kU8xRP
X-Gm-Gg: ASbGncvO+uPU3JNYPYQyT+uLDJGUY9E56hdeWaIx85fJ4XcwJVhp5iGPRoEFTuvxJ2U
	SJoBQ71nYrTA2qpbjLZ5ijs9ehUZ4v+rfrtINJJvw+ijbjxsxL3rGYpD/G0uer+hLbtpg/MXHFi
	mvsVLNQi3DcRS8vZo8GQAS/1eNm6G1/ZQ/5pSPh+wU9wQObkZJ0xLHiO/MeD7Df7WFs/YojOft3
	N/NKf20aHEm0L8G5uKLQ4ECy9rJw9OK0DZuKw1+iYrfODUWlwtAUbttLqbZzdv0xhQbkZxwYnDL
	ZTQR70VeCyTRPrmRa97x9+1eg4GwAv4r7K9+7Ue045oTx4xC+oIukcojhZwPcweITcCyGZjDc1L
	cGaPcAY0QI2W5Lglr+Cr45dY/MKKwQ9i+6GOn+GMyjBzjlkujmg==
X-Google-Smtp-Source: AGHT+IEHG1de0uoqO9lTHMhoFoIvSH90FZPEhO4rUV9YGSfs1T4dWZ9gPM/Xr/7y7qCcN9U5mlfWcg==
X-Received: by 2002:a05:6a00:80c:b0:782:5ca1:e1c with SMTP id d2e1a72fcca58-7938723daa6mr1650070b3a.21.1759882175592;
        Tue, 07 Oct 2025 17:09:35 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020535a7sm16838884b3a.54.2025.10.07.17.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:09:34 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F13204233430; Wed, 08 Oct 2025 07:09:32 +0700 (WIB)
Date: Wed, 8 Oct 2025 07:09:32 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org,
	corbet@lwn.net
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev, crwood@redhat.com,
	tglozar@redhat.com, costa.shul@redhat.com, jkacur@redhat.com
Subject: Re: [PATCH 5/8] Documentation/rtla: rename
 common_timerlat_description.rst
Message-ID: <aOWrvAA6AO27pI6_@archie.me>
References: <aOUMyGvkibvOV0IS@archie.me>
 <20251007185508.40908-1-krishnagopi487@gmail.com>
 <20251007185508.40908-6-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="II6TKWeT/WeCoHc0"
Content-Disposition: inline
In-Reply-To: <20251007185508.40908-6-krishnagopi487@gmail.com>


--II6TKWeT/WeCoHc0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 08, 2025 at 12:24:54AM +0530, Gopi Krishna Menon wrote:
> common_timerlat_description.rst is intended to be included by other rtla
> documents and is not meant to be built as a standalone document.
>=20
> Rename common_timerlat_description.rst to
> common_timerlat_description.txt to maintain consistency with other
> common_*.txt files and prevent Sphinx from building it as a standalone
> document. Update all include references accordingly.
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--II6TKWeT/WeCoHc0
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaOWrvAAKCRD2uYlJVVFO
o4FmAP9/w4MDtIyaMU+Ss/owPly7TFCYgH/WICY1CZthinPMBwEAzV1VA3ObJgkL
f0XErbJOut5p53OZ7XcUvsO9/0GmNQg=
=4qSZ
-----END PGP SIGNATURE-----

--II6TKWeT/WeCoHc0--
