Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531D24EF86
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Mar 2025 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187055; cv=none; b=cSks6fQXdHOv/2PjO557LS464MMK2Y4xcMcQQnf5hqTz0O2jsYYh5fdA0iL7aF0/RLuSDML25gzMZuzwxJDgH5Zpk7IivmqygrGW6RVIU2t9z+uhRwkyHJ4x4Tdiam5JXCpGG3AzEfqiXxk5rFoRc2jlzvp/VAFwJljB1BLo2mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187055; c=relaxed/simple;
	bh=t5eNaNrX2l+tZef9ZgJzRD8AjzR4E3n2CK9UhuofW3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1SsSE8s96M7DYCKAG0aKoOMnyyp1e8zfaEcnqInrrnubhGe3hbXdgY3jGrMaIsqo/3dMnKzSRf3Ym94VacM5FIoFeWaSbOEQwMKDHCNZ3xpgDktgQtywHdiDXCxzgkuWNgKr/lLUc/I+5qf4p0l3dm423rIEWR+3cAqhDdK3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E0fyhTpI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E0fyhTpI"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38f406e9f80so5291356f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Mar 2025 07:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741187051; x=1741791851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLmgp+4BNcFGyEe+zA1DNg0CWSPx2N1T/nc5ywlKYT8=;
        b=E0fyhTpId/xgNl4mabkCJHJlzGzPtK4E5BvoAhvo19Y0up2Rdhafm/wcZoHuPEKFQx
         thcCC4Mief+uWfCxeVps+muFMU2CrE+XNW7ZbIQOJEjt0eWJxROgfS1uL/CeDzKK+4Op
         0aSHbmv2iKKppZ60uvwgMNpbi8NEn21B2+VKGKWGFOdKqDEnt5eBlRNrD7Sxn/uwuKWL
         a+oX1rIJw4Gz7ur+HjoVXgdkHz2P58fagKBc3B4Wq1vgaBclSwWjSJCugyhFCTLUP3lW
         T8agu8SD68LHPYdh6kXkb4EI0waExr0BWcscMWRCgRNbzbqMHrIU9OyfMSEPNPZ6wtiz
         i1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187051; x=1741791851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NLmgp+4BNcFGyEe+zA1DNg0CWSPx2N1T/nc5ywlKYT8=;
        b=c/YfRIteM2wf4+hyyfM00VhVt0D/I6deD6wYV8FRPhJIRFqHCpllPps0MVxix1y7Xh
         AXHi5Z/0J1R7x5G5vh8mlXBVK892bCv4/ob1UDCSUioyqJ+UXclJSlq87DlIrAZr9uxg
         CQE7TbbAXbBO752VnWSTmZJMn/93ij5nVBTwmc0jf3I9uaqHBSpWTad562sG3LfqG9D3
         i+qO+XUuJASZJucR6v3c07JQQ3ndowkv0gyq5yfSlcfL/9lg/gTy/8rRFqax6HUArdg3
         KcMATcy/bK0U26UMy7559ksdK6OM1sURsU3OXcM299c7ZauvugogQJSSTvx9Mf482Sqs
         A8zw==
X-Forwarded-Encrypted: i=1; AJvYcCXotPev6PyJqgqXQLcJqm5uBfxjstz9m7R5gBzkjyeCtB/xS/O9/24AyJiHcaFhFU/Nhjf3m7ax+FkA69Z9vwTZz8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSBoVOiRZSboUEMUAUaR7uNMMHv9rID03c6kBbNsrfLYprBfOQ
	MuvULjshgk/P7+e1Gr2FugBBZp221VYhZtWnRVhteAskLlUMjSTDgCabYkLzyhA=
X-Gm-Gg: ASbGnctKS6B3cOJVxBgljbWSvK/QM052Uycm5mTVaBe2c0gFDTMHIOBrk6B+Nc6kUNg
	CTwF3ORr1n5QxUL6G26WeNpUYh0lLo0ET/k+DDOpLHgJvte1r3fOaCqZ+8hxQYqsNpxpBECwJxJ
	oKONUzSblglAp3ZMwA0BNQHyrTma2TVE3LsrtwszHbvYz0FY5JcOAAmTzvgo+nvWz+hs56ovCMT
	R5IQrhcPTgZDGCZwzm4qJzyn+Fc/xE+vmuouC0i9HL6KCGLn1fnKUP7rjaYDIXYATLhem6T+9KA
	N0zcaNu4iTk7edrWdwjCVQvrl9twP7tKIInUCiT48ayApcs=
X-Google-Smtp-Source: AGHT+IGlWpXBw5ri3FaDBssVibQSzlL8JZY/24FSPaE5MWfcweC0DmUsA0HmZ1zjcuQDZS2k9Zzqjw==
X-Received: by 2002:a5d:59a5:0:b0:390:f1c1:d399 with SMTP id ffacd0b85a97d-3911f7bb9b8mr2998938f8f.41.1741187051174;
        Wed, 05 Mar 2025 07:04:11 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485d8e4sm20907920f8f.85.2025.03.05.07.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:04:10 -0800 (PST)
Date: Wed, 5 Mar 2025 16:04:08 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
Message-ID: <glmbovmv7ahln6omzoas5lrktaafbmxdkbs4mfoummhrlayl7u@s2nv66r7yx43>
References: <20250221170249.890014-1-mkoutny@suse.com>
 <20250221170249.890014-3-mkoutny@suse.com>
 <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yphetxzk2ql5urd5"
Content-Disposition: inline
In-Reply-To: <20250221161854.8ea0dd0b2da05d38574cefc4@linux-foundation.org>


--yphetxzk2ql5urd5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 2/2] pid: Optional first-fit pid allocation
MIME-Version: 1.0

Hi.

On Fri, Feb 21, 2025 at 04:18:54PM -0800, Andrew Morton <akpm@linux-foundation.org> wrote:
> This seems thin.  Is there more we can tell our users?  What are the
> visible effects of this?  What are the benefits?  Why would they want
> to turn it on?

Thanks for review and comments (also Alexander).

> I mean, there are veritable paragraphs in the changelogs, but just a
> single line in the user-facing docs.  Seems there could be more...

I decided not to fiddle with allocation strategies and disable pid_max
in namespaces by default.

Michal

--yphetxzk2ql5urd5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ8hn5QAKCRAt3Wney77B
SeH/AQCl7M3g6jWcHR92iwej1BFLEym+t1kmSZ8IyoLg8iToxwEAolDqAbNbU2Vi
T/noTfl//D4KGYDllskbpZOuGNvu2gQ=
=t4Hk
-----END PGP SIGNATURE-----

--yphetxzk2ql5urd5--
