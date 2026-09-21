Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B07503BF3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 21:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026563; cv=none; b=ZQGkUsDUM8aC3acZvhmF3zlusTgzPD5pr8b9TIaBpYF3+S78v4exqyhcsoLu30tQEcnH8//Z52PtehMRwoZP36S2ZyszXzN7Snm7/l72Y6+/rqPAwmlehSRR+WD/9sUp4IESb3vokLyi0jxXPqoQZwbOnLhYcgAOPDy4hUbBv+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026563; c=relaxed/simple;
	bh=7yizJDGthNwZ7FKc3pzoGYg1087qkfktjgHdeDS3pQQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e4OoqzblL7lmO0F5Hyzl+4valJHSAO2GMVO/8uEAPgoLHUWdqDzO4sSMJLn9tlnEAXzFBfqY7bp6PNvVGZ8JNbdnvY9vQzAB10q8rwDMvAHLKJ1bhwldqFpu30ylbBQUlLvNlf8uOkWuYAvhiHPLfTldlTHcCh5Jy3d/wU7CKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+wNYE69; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+wNYE69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01F291F000FF;
	Mon, 21 Sep 2026 21:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790026562;
	bh=8dA8PAHgKasWIyPocVHJiz56NSBpoVug4ivzXrLAHXE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S+wNYE69A0m2rS44o52SyzYQBmbRFpRj1rvhinW3bdz/R9li2lcFTbGLFGIwWfB0u
	 Ek9s2W1bM0B6LZ/+r0Es4Ty6SbiHEpugPxq+O52joDONmI2M7HT0rX93NlCF3iGiRz
	 rm3kc8bxNetrpPspqEraOLIEXuWWY5g1rihxgtG8DWULOxRZ+azQYO4kjesL15cY52
	 9wGij11JFQJzat5wbt7dvTh0RFt9rSs9SOufQZF1FGykBW/M31kW6JDsYreLo6s3lv
	 AAzL3SSmkmBgv4M7NbQNnFnyWuIeavreDxA2hC87bhL75uM40CzI/QWTFICtKw84Bs
	 dPLEx6Ekiikvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] alloc_tag: extend allocinfo_filter to support
 tracing queries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhishek Bapat" <abhishekbapat@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <c429b37092a4cb33535965163072a63adf57d8e9.1790025465.git.abhishekbapat@google.com>
References: <cover.1790025465.git.abhishekbapat@google.com>
 <c429b37092a4cb33535965163072a63adf57d8e9.1790025465.git.abhishekbapat@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:36:01 +0000
Message-Id: <20260921213602.01F291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] uapi: ALLOCINFO_IOC_GET_AT ioctl ABI breakage due to struct si=
ze increase
--

commit e19f22c2c2fb6885ec1ef8ea1659cf1ff9f8e3ae
Author: Abhishek Bapat <abhishekbapat@google.com>

alloc_tag: extend allocinfo_filter to support tracing queries

The commit extends the allocinfo filtering system to allow filtering by tra=
cing
state. It adds a trace_on property to struct allocinfo_counter and a tracing
property to struct allocinfo_filter.

> diff --git a/include/uapi/linux/alloc_tag.h b/include/uapi/linux/alloc_ta=
g.h
> index 069ab8341e87b..e65c32afceee2 100644
> --- a/include/uapi/linux/alloc_tag.h
> +++ b/include/uapi/linux/alloc_tag.h
[ ... ]
> @@ -75,6 +78,7 @@ struct allocinfo_filter {
>  	__u64 max_size;
>  	/* filter criteria only; see allocinfo_counter.accurate for actual accu=
racy */
>  	__u64 inaccurate;
> +	__u64 tracing;
>  };

[Severity: Critical]
Does adding __u64 tracing here cause an ioctl ABI regression for existing
userspace applications?

Since struct allocinfo_filter is embedded in struct allocinfo_get_at, adding
this field increases the size of struct allocinfo_get_at by 8 bytes.

The ioctl command ALLOCINFO_IOC_GET_AT is defined using _IOWR() which
incorporates the size of struct allocinfo_get_at into the command number:

include/uapi/linux/alloc_tag.h:
#define ALLOCINFO_IOC_GET_AT \
        _IOWR(ALLOCINFO_IOC_BASE, _ALLOCINFO_IOC_GET_AT, struct allocinfo_g=
et_at)

When older userspace tools send the previous ioctl command number, will it
fail to match the new ALLOCINFO_IOC_GET_AT value in the switch statement
in allocinfo_ioctl():

mm/alloc_tag.c:allocinfo_ioctl() {
	switch (cmd) {
[ ... ]
	case ALLOCINFO_IOC_GET_AT:
		ret =3D allocinfo_ioctl_get_at(file->private_data, arg);
		break;
[ ... ]
	default:
		ret =3D -ENOIOCTLCMD;
		break;
	}
}

and cause requests to fall through to the default handler?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790025465.gi=
t.abhishekbapat@google.com?part=3D3
