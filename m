Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAC1DEFF7;
	Thu, 20 Feb 2025 03:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020949; cv=none; b=Oapt4NoYNnot4V4jJOu9UKWnhIgnf9qMBTaefIyZsf6UzjzfxfZ8xMcKaQTaM9qlF0w+6PI+f/A06lRgea05QJdeQIj0SXS+HMVgiqAT73fMDJn+7oYIfvG/v5H4Ug+KKtjcKMvZI3pbjFATYRhUKRlf/9RViT3wLLn+1x+rsgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020949; c=relaxed/simple;
	bh=SIIxMmbbjCnZ1H7d5BftVx4BljoiEjzP6fU+7MNNPY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cTc3rori+49sKhia8dMEWyZ2IeEc08gE15e69XalYTgrTMJ3pTR/rJ6sSNNBhs0RzxdIWsibxAnP1hQAN6O0FsEECEq1eXthOZvp58YikEJ+m+SOQDToi0CLNtpKtOkmSbr7s7XhPjd7dSi4vkLymr6FVftFCIYiPTOTqDNO4wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g7cTiT7j; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7cTiT7j"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so709604a91.2;
        Wed, 19 Feb 2025 19:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740020947; x=1740625747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SIIxMmbbjCnZ1H7d5BftVx4BljoiEjzP6fU+7MNNPY8=;
        b=g7cTiT7jTLJsqEbH7gc9kSwgk9WKI0QAfOCY5JklBGRuj3GbrtOGeYDhn+uSfJBAWe
         AbcdhlyK78+eB/j/YWxY97fbkr10g+UaIBunJCJN2ZocuuIGFV9NVjcVV3gGsdP6qARA
         1wPWzS4Eh6QQU+5adYrf0R/NP5+Kmhm4Wjp9sh7ha89TCpVHUu20LhPLQZL4/0qINzdC
         ApaYcNND2uXV28ViahzCe6CQ3Ry425T1orqmqj7v92lXl2vIDS3ZA2kYjbTOj5gZFVFI
         tPazfjpO11L1/1hfyMRcYhgscjkbeWn5AK1hQdKxj36fiJbXwki1LlW6Muf8ey+8hMgB
         Lylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740020947; x=1740625747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIIxMmbbjCnZ1H7d5BftVx4BljoiEjzP6fU+7MNNPY8=;
        b=bcSwDKHlkBVDdGTahynw7We9Zio/LYkVBmiZOh0S8O3KFpOsSOOusb9WXYEl6yAx/h
         qfpSOT12WeZz41vgKpfhBWffAGAb60X4bVns4dbF3HqbKSsGFbecOB1V5UNC1YJjcwAL
         i+HmhCJlhUBDpHeATZgwNJCAjUoXGfKUO1Qiw+8NlRwF9nOU7PXW++t3L7erO2CLDF9z
         U7yFAeqOyY7okbOro/zn1KQXVHHZRKXNqCdKUreAxjqpti6UvTRbSmpQKaPHEUrxqaJk
         Of9OQEd9iL+Y7aQiXF9SYzq+pXBqc6VOookRuxchDwiUWWhVFIRCuCl6rYyAGi3rpzvp
         4TJA==
X-Forwarded-Encrypted: i=1; AJvYcCWpVRpZVbN5ZDMJTGpvlM1xUSPOnW6U5GBvvQks1eif0gsu/QJr1eXWVC958vNbr3rKavQo841OeXODl/d8jCkCe0i3@vger.kernel.org, AJvYcCXSzK+XR9ckP0Uo8v/+Qfi1fhvVyTblzxO3GGevYE975qxY6h8+rrErYzzmCBfgvEThrZnyJXFpXKBQ8hsh@vger.kernel.org, AJvYcCXuIvMNz2Ty570XKeGEFhGknyrg7QFA0VgbqJPQvxUYFALVP8o/IUIVxqHHM1gLk2sduW0ORxYiBRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUnmtAM6BaWL8qZPoJH/YUM7AY77VaThwOTzyms4eVg3+wynR8
	pxakBeQKD1jege0CUPDhXJQoLJZB7FLE7OZqIXbVe7VbiLItAKKf
X-Gm-Gg: ASbGncssfNPXT6RkUFe+35ghv8ei0OqwIq8Au5V0hfHsqlhIbyTwcN0nNKWpAk8/J+g
	lUBeVgTci/XwO8c4xO8mbx22Wo+gqDt5j9Ig5HpcKAK97lVOG3SJjSHQIZ35xWlhb7DTz+Jo1kU
	oszi4N3aDoXOLUZwm7oC9UW3xMLrmuAV0Ma74eIBic4Bdxi/dmcM6GCUibZJMkjvGXGxFLxql+q
	m6DZ3qA6i/NSDqyATuX7X55n5u+biBudDAcu6rzUZ80XImclTxDNdzIO3Sc9zXR8dozc58nEVVs
	3VgqnxeC2e659P4=
X-Google-Smtp-Source: AGHT+IHY+jkVOxxqyb7oeuPNdMxN/x/S20vcx2nSe/tuB0SSxqUCO1KkygpT8VsNxFzmTEcR5XhbIg==
X-Received: by 2002:a17:90b:4a49:b0:2ea:aa56:499 with SMTP id 98e67ed59e1d1-2fc40d13e61mr31473657a91.1.1740020947025;
        Wed, 19 Feb 2025 19:09:07 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3255sm14701558a91.8.2025.02.19.19.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 19:09:06 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 1F4794208FB6; Thu, 20 Feb 2025 10:09:02 +0700 (WIB)
Date: Thu, 20 Feb 2025 10:09:02 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: tracing: Reduce maxdepth in index documentation
Message-ID: <Z7aczkdNVgLy1NeP@archie.me>
References: <20250217112109.7734-1-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zfvOq29s0SxCOtX0"
Content-Disposition: inline
In-Reply-To: <20250217112109.7734-1-purvayeshi550@gmail.com>


--zfvOq29s0SxCOtX0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 04:51:09PM +0530, Purva Yeshi wrote:
> Reduce :maxdepth: from 2 to 1 in index.rst to simplify the table of
> contents, showing only top-level document titles for better readability.
>=20

Is this patch mean to be applied on top of/squashed into your toctree
refactoring ([1])?

Confused...

[1]: https://lore.kernel.org/linux-doc/20250217110637.6640-1-purvayeshi550@=
gmail.com/

--=20
An old man doll... just what I always wanted! - Clara

--zfvOq29s0SxCOtX0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ7acxgAKCRD2uYlJVVFO
ozBWAQDOLzWpuGIWnJnyZ4TZ4GfFwpnG/SQ4r4S4B3NYiBRs/AEA48g0UAiGeSgh
WGK0r3sF6uZ84Ahm7ecC/1WwaCUxGAw=
=IEAJ
-----END PGP SIGNATURE-----

--zfvOq29s0SxCOtX0--
