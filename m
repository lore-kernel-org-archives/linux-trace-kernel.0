Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964120CCEA;
	Tue, 18 Mar 2025 14:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742307843; cv=none; b=BvzlLfYBO9Ani1NvbZDJFR+k8U0J+3ao4QUTayPY0zroGs/ooDo/fItkRlU0Ua5cZzmuccDBg7JCzEZEcfR4SrBNdwoqzvhBdKeJ0PNmCnn3wxh2OPo2rkvAxP+eVemYXA4KIYcIybJUOuJ0gkrVm4dFyYMhtOsX7dx8u4AJSM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742307843; c=relaxed/simple;
	bh=maoiZEqfCuHXMMG5JNWWjXtFMpNqlPv902s6wygwmVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc8kY6r32lwrbMe3sXvuykQf0TIBj/hVEq/QfjdfEC1HaEiFpeQma+z/3PBIugqQfIvX532gnadV7jW6zHX3GABCO2DuTHJzFVlznew7uooGuKAcFLtoORKhs6al3iTc6x9na3eKgGditVMi/0iElNCG8Qf3SPGNSGdfazxBVLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5MHzyKZ; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5MHzyKZ"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff65d88103so6400379a91.2;
        Tue, 18 Mar 2025 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742307841; x=1742912641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v9NUYvwPjZMLhULxfg8LZIqxczu/kF5avfqxLvT4naM=;
        b=F5MHzyKZDoxE3u7EhwWChWva72F1717Xz6rG7CLhhrr4jIZlCcLnkJKM8rJEGsYk4l
         PDvJeuJoKsS1CStjNb/JksylgiYv4+4kltNHAyKP1KDuFdojJuezI8ncG/Yrioulf0xe
         f0zc9YPoRLqs67QyJ7cdEbuRw7N+jwaLSt2gzJJ9CzcjFesP8+HwjzNHkBZ+kSLn3hdX
         gGf5IICzAb3VziImegqAqkqL6OApDyLTI1Y5yWJ4ilBuFtPuDBkKo1vnWrt3sFzGpb/2
         ISyjnGmBb1xPIrl4zceVNO63mx+gbKkVRbDUo81VPuulplrwPM2QZVKi8UJBgilWb+Zd
         USTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742307841; x=1742912641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v9NUYvwPjZMLhULxfg8LZIqxczu/kF5avfqxLvT4naM=;
        b=F5Hl6CteuuS12XRpmUhq48rD3+aytsH4aHPcf/X4QvJC84T3K8AzRTobAsUJjGvKAk
         +c8cP156tHZpxVVjabHW1SBmLoy8bS5pVlmfh5fnsGeXqArZkcadLfU9kqshIMusVObO
         Pw93FDJycf1+jsA5+j6YIwGbkHGMYc04joA/5BBlGkMzgAO8hzCxe6PpSwB+EObHYO9C
         daaDBjc8n1Mi1Qn4kyTSrhgM1SbOQS0jSH2MYfnb8zKtdk4bRllng/a3Jg3bI1rjdkW8
         qXIZJ66AdMzP4cdaMWXgkxBtdxbPb9ZzBjmXn8CSyvrMwPQkqJmcwOWKecMrwdVIcdZ8
         rgnA==
X-Forwarded-Encrypted: i=1; AJvYcCU6e3B+sADCN9HdpymI+0tIOEs2yVsZ+YvThFyDgvkM2f9hpcSWoAP9kALLQh0ibcHCHvifb+qKuRYWcBoAFDu1VyZj@vger.kernel.org, AJvYcCV727B9sw2Kwr36oylhH42UTBIN8xBlGX714sHodtRh/pGuaQzNGtE4Ck/sL7aI7oR8SALJCajAkIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXjU5A82hcJpCOKndx0PiC/eh9+37FepjJfEmgzo/BAko9VB8
	aC5eLVVGLFp46g2K8jX/MgctASBfOmfo4hTHkMQqOLgTXfH2KXmv
X-Gm-Gg: ASbGncvIpfaShvijqzD0q+NEGx5W4pYhpW1HZKtR4B6rikCtMOD3mhS+Eu2cWrmiWVp
	e8WxsTln9ypatKN6nEFU7xBx5Sf/Bi+V0YNBVtrUBF34UzMx+DypYcpe3UhN9833W93Wc4lHqE0
	3MYsR8f/Ow+DBaxtMPYCVIsGT4iTDsEWtQQ8VMQj8FBNgDwGf3rcUj4V0q/ZsRaMtFsQyihb3Ml
	Z1XejjIwA62NK3g6VVG9hHFqkTkZiB6I/qqnMh9BHMP7pGoHyiWLO/Vd+kJia/1cHUYt5LnmyOH
	LdzvfFkKEdWKApEhJg6KtAJzsAYL39PX8A5P2+P1cO27
X-Google-Smtp-Source: AGHT+IFJWF3YZCH+W8N53QYOTLC9tI2x6C4gSNzY3u42eVEztBxaBPF7vbmS5YZFQy8xjulFdDoPTw==
X-Received: by 2002:a05:6a21:b90:b0:1f5:8c05:e8ee with SMTP id adf61e73a8af0-1f5c1216210mr23213080637.11.1742307840620;
        Tue, 18 Mar 2025 07:24:00 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7371169593csm9571411b3a.128.2025.03.18.07.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:23:59 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1007F420A74B; Tue, 18 Mar 2025 21:23:57 +0700 (WIB)
Date: Tue, 18 Mar 2025 21:23:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Purva Yeshi <purvayeshi550@gmail.com>, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 2/2] docs: tracing: Refactor index.rst for clarity
Message-ID: <Z9mB_ZXp2bdXh0YN@archie.me>
References: <20250318113230.24950-1-purvayeshi550@gmail.com>
 <20250318113230.24950-2-purvayeshi550@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cuhFiq444qP6XxVp"
Content-Disposition: inline
In-Reply-To: <20250318113230.24950-2-purvayeshi550@gmail.com>


--cuhFiq444qP6XxVp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 05:02:30PM +0530, Purva Yeshi wrote:
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index fecc4adf7..5ddd47ee7 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -1,39 +1,103 @@
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> -Linux Tracing Technologies
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Linux Tracing Technologies Guide
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Tracing in the Linux kernel is a powerful mechanism that allows
> +developers and system administrators to analyze and debug system
> +behavior. This guide provides documentation on various tracing
> +frameworks and tools available in the Linux kernel.
> +
> +Introduction to Tracing
> +-----------------------
> +
> +This section provides an overview of Linux tracing mechanisms
> +and debugging approaches.
> =20
>  .. toctree::
>     :maxdepth: 1
> =20
> -   ftrace-design
> +   debugging
> +   tracepoints
>     tracepoint-analysis
> +   ring-buffer-map
> +
> +Core Tracing Frameworks
> +-----------------------
> +
> +The following are the primary tracing frameworks integrated into
> +the Linux kernel.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     ftrace
> +   ftrace-design
>     ftrace-uses
> -   fprobe
>     kprobes
>     kprobetrace
>     uprobetracer
>     fprobetrace
> -   tracepoints
> +   fprobe
> +   ring-buffer-design
> +
> +Event Tracing and Analysis
> +--------------------------
> +
> +A detailed explanation of event tracing mechanisms and their
> +applications.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     events
>     events-kmem
>     events-power
>     events-nmi
>     events-msr
> -   mmiotrace
> +   boottime-trace
>     histogram
>     histogram-design
> -   boottime-trace
> -   debugging
> -   hwlat_detector
> -   osnoise-tracer
> -   timerlat-tracer
> +
> +Hardware and Performance Tracing
> +--------------------------------
> +
> +This section covers tracing features that monitor hardware
> +interactions and system performance.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
>     intel_th
> -   ring-buffer-design
> -   ring-buffer-map
>     stm
>     sys-t
>     coresight/index
> -   user_events
>     rv/index
>     hisi-ptt
> +   mmiotrace
> +   hwlat_detector
> +   osnoise-tracer
> +   timerlat-tracer
> +
> +User-Space Tracing
> +------------------
> +
> +These tools allow tracing user-space applications and
> +interactions.
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   user_events
> +
> +Additional Resources
> +--------------------
> +
> +For more details, refer to the respective documentation of each
> +tracing tool and framework.
> +
> +.. only:: subproject and html
> +
> +   Indices
> +   =3D=3D=3D=3D=3D=3D=3D
> +
> +   * :ref:`genindex`
> \ No newline at end of file

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cuhFiq444qP6XxVp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ9mB/QAKCRD2uYlJVVFO
o82/AQC6St6NAWq8B5z4Zw7q1LUj0robzpjBQS3eWY72NT5cRAD/azaSf3VmAAlY
zOdVCBMuKWxztlcZmhT4DNJkt06SkAo=
=biNI
-----END PGP SIGNATURE-----

--cuhFiq444qP6XxVp--
