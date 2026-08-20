Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719B40B392
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222191; cv=none; b=ayagXtnEVzVDOqQqeXeUu1iHWCc/CCLCMElBEsWBLRn9oqgKx4q8kpNIbrpCi7YYzGJtIG6ADb+I7GYx7lkdlU60Nxc0OELNyFxiNX3fzQ3mBFFbKInP6HqRwXh4mBDFMP9TNn2efXkEglxbrtgLh/QV75Iw/o0yq+0ShAwfmQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222191; c=relaxed/simple;
	bh=FsZofWksRuzFvPkX/+F6Criwr5kIGM9zzDgOXysn/mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VU9KkSIqZcKwXlUoqNDHoCER5uuHDcJ7XwFJROvu/UvyzQUySR7gOBhaeraYkkassiRqli6lkKm4NXJwtRN6k3Y1P7GQ1n0k5saE6/tRnvOZK8KnbZkVNnRbBkqTVeZVZqilCYAKlMrGECyTSJq43+85/Gi9+/K8SRJgLEWYrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pAetInl6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pAetInl6"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954dff6536so17620545e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787222188; x=1787826988; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6er9iArCEFrdmjNmw5e8mJvsWGPCU5zllt9FnZFURwU=;
        b=pAetInl68weZ9sG77Lw3RGSefSyK/2PCNiyxHUwc7cNBUvAPLQ2R76thEMRC1Ex3aL
         GnB1cc93O/DAaUwBXeIpSCHBTkMluwUVuantMUrcP424ZC6yCW5dTEGToIw/obKNMrvH
         Zhs9aenNtVO4XoMy2DyMVlv14heRAFjWpRk+T8BXSYpDZYDz/54V8ZYpGPzgEsMSX/Jn
         vmM/F/rFufAs43rkOVEX5lw6bJDZI8K782h580i39DF1/QxP8AnbPnncTSAsFSKJAP/f
         62IPLVHfFhojZ+TYkXn1B29tQROhWuFabH9ldMBnmSQLun4q8/bKGDzqiUjvrjKZReSU
         qxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787222188; x=1787826988;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6er9iArCEFrdmjNmw5e8mJvsWGPCU5zllt9FnZFURwU=;
        b=g0IOJGz8OKTWDmUfMq4qOXpAHbBhqt8Y2bXh0JavSJUdxT3lCeXD/y20XFLpTru8DH
         p6tTpNCIwInqQyRpITAL/61AohcgGvFxn26cXIXscHTCZ/+3YIxNjZFjgobXpJ+r14KN
         hnBEgBr2zqAuuG7gHZquSR88P+3qE+67JR28j8SjlX/MOzuRQlRYdrOYjvMyVnhMFPzr
         pDc2m6oPitigRXwMUVzzFoEj/+F3+Pp5MVHAxRfCkZbVb/eF1bkaWtPAnl+MPYJ8IBJP
         yLA6A5CZgqEgfcglIe/kyksIYqOjkOLG7wBrTFgUnHlbKQhPOmDAJenCXMqSmIYqfmBM
         7qiw==
X-Forwarded-Encrypted: i=1; AHgh+RrHw23fTNMTdzVqj1nzvqHDi7lMYHHCzOCI6qT3l6a1PP6Fdko0y0upX3DKWF55S2kH+UdQeYtGnPKrhruZaFVNYpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxJyHhNuh2XmQ9VgG7XPEjBny4nCAnOJWlSGFYNTlNnhY/Dh6h
	e2N4koZ/xJISaGE6Ec4/YmwGr5jqy0DbeOSxZUcIsdW+0i+TC999lSxDnrjp50WU7g==
X-Gm-Gg: AR+sD124qAlj/LYXO7+ux2blH29UUV7MbxwJB8EadlNYpcwGljhqA/kK/+fNHEYrlvT
	4EeBZYKjRR5iUeZLaBmOVQTTmttEZ0V1jHNECfU6tY60iYN2926osbF1DdlFAzaktbAJ0z5zC3d
	CAU6v2Iga6de6o9AvHfHBXvVOZ3FGCd+MiJfP1/T33bRgywzcBn96aveD6X6FGBthyJk8gQRmQa
	OxKkd8qw1pqcxR0WHkZfBTQ00loSmAGEZmwtdPLzhQqRTo0h5bbzA/My2G4CFh4cr56Y2uWL3aH
	/C+61Qeunciea5BfuWWK3eU9Dn7szGaFdjIF3mneOIJ64+2BcgJL1TbzcixMkD/S9rpVMMjOof/
	hAUjvTEssF/KixfIrBD6VtNy2x/3Q02JHrBq1YAYeL2uBXRlj2VJS0gC9gR8hBsLG2vrq8jkjU4
	Dn/sSsKwnCtli17xQXjFqb53XkgzZ9zWSFZf0hY7TAF/QoR69xJXwxI8r42zVjNlPh0NEd5aMG1
	DF2IfxjwahPNEZ8xPU=
X-Received: by 2002:a05:600c:3b95:b0:495:48d7:f178 with SMTP id 5b1f17b1804b1-499aa1b97ccmr193609775e9.11.1787222187463;
        Thu, 20 Aug 2026 03:36:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:d956:c85e:ab42:2c9b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b29e19f2sm31708775e9.4.2026.08.20.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 03:36:26 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:36:11 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>,
	Justin Suess <utilityemal77@gmail.com>, Kees Cook <kees@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Tingmao Wang <m@maowtm.org>, kernel-team@cloudflare.com,
	linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/19] landlock: Add create_domain and free_domain
 tracepoints
Message-ID: <aobYhIt3vcs2xN0b@google.com>
References: <20260811094338.288094-1-mic@digikod.net>
 <20260811094338.288094-10-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811094338.288094-10-mic@digikod.net>

On Tue, Aug 11, 2026 at 11:43:23AM +0200, Mickaël Salaün wrote:
> diff --git a/security/landlock/domain.c b/security/landlock/domain.c
> index d0b35ccce122..7651eee8fe02 100644
> --- a/security/landlock/domain.c
> +++ b/security/landlock/domain.c
> @@ -427,6 +426,7 @@ landlock_merge_ruleset(struct landlock_domain *const parent,
>  	int err;
>  
>  	might_sleep();
> +	lockdep_assert_held(&ruleset->lock);
>  	if (WARN_ON_ONCE(!ruleset))
>  		return ERR_PTR(-EINVAL);

This checks that ruleset is not NULL, but the newly added
lockdep_assert_held() line already dereferences it before.

—Günther

