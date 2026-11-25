Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610995;
	b=AjBD4q23fHWJcgaG8Ap+qpY271ucyL2MhVaHH3YGRtXhwPVToCTg79AqLm8VfBFwWxU5
	 w4TFXvE4s5Cyc5gmdu8NWd9tR5UZyY0Mf1wekoKtaOEbjsp6MnL/S3qEzEjv60PQo9Jzr
	 JKcrC7QzU2DPg1rkHR37Tr7DaUAN/rMrhLHd0YfR1kRBpz3di4dahstXKT7sZS/ySPBP3
	 ZDxctuhW3Y4mPHrcwKa1tC0jWQqJPTVl9a4mtW1XoY1NGmhran6FDR5lws1r5Huvorci5
	 9DhGLgRUirYyikxvR/NgbeYPzQYNpPT1WnWlkJ9buU0kkp7Yle1NtlSmeFST/lmmQbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
	b=AxfqaijBpn+49FF2/rnq6dWOwFbR5+eFynbWp4u+Y+2I8OAqK5Hvn9qCMb3nP4xrT3DV
	 yT3lsuwpEYyF4VyIzejpCLdflK6u23sMTpj8QmHTcPXktqkyYa5nqOQKmwqF88LOmh4tU
	 ARoiKvqWLtYwO0SxQdfjIcPsTY9cQy/uJ7c7WeCS9YSQIZ1pG+mVjk6iG0gyIu4r3fWz3
	 zdGXKd2eQU3J69kxptFk2A0c3ywaVSQLRwm59lFbbOH4S+qP+o8LBOeU9TIGsLPH1L9JP
	 ADVtjXNNylVFTVzRoCiX2V68YneV4t1quEz+RqAiIKBnD1FjkW8yJArjvCDI73g+TGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEF8606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 12:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CEF8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ijrvPjrs
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so46037665e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 04:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795610993; x=1796215793; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=ijrvPjrs4XPMGxLv2/cLDzYf1DTkp26koBrs+YwuqX5elYJruc4hClaOIjF62Q3+YN
         LRHIUBC22PWGF/rAGALu7SoOt5zqUHESVTCa5vHMQJoFy4B5gkLHeV5hugIirMLPKc1z
         lwkIjSkykztPQpKhyKTDraxT5P3oaH7NzwApTcr02ARr2hT5KerzhwRvxghSP1A3P/Bp
         EtgDED95aoU7Ek6mxljMaLWO6Bx5amJKRdXl3ABZkqxCYsSCC5SlDmTZNR4DGfcavrRk
         HtSpSZ/UepV+pwNgpwEHfsqbflJPpiVU5KOF/FpJhp5lP9+HVdK4ulKpQ0NMqA1E55T/
         7WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795610993; x=1796215793;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Le4AwFe0WXouABp9DXzuQtZ3ZnCfLcbkB8kE/IdX7wA=;
        b=NSGQS13aVDmJhb3ofnR5PxQa4sk4hRanIcMq05YQlL4ptPAQZ3Z55fYkGf3ta092bH
         a9UC5IQjdy0+dWKfDkD1G2LJZXJ02xtBA/NsjcfE0rc2GQ+BhKLh7NyGpVriT2QXZOlA
         SHDtpLCAqEl9RxRUAwsbcDdkuqvsb6vWi+lEdZYc+5yCoilmUn6o8xjpdnwb/WA1Jwqz
         TyK8d9DnHbZQssviLGzdRHkGw6+2CrFLqkY4CqjlER0MK7PqfEBwZSI3dcenpThvdxE1
         w16W1zt5cYO74TVRRVg/eb7jJMQ5Z5R6mqC7FBA3ipddE0GCVwkdvO2YQRjatu3dzlJp
         ZIGQ==
X-Forwarded-Encrypted: i=1; AL+hErEwZgG0TwBVYV9+1c8yDESKuZngkaGlD2xUVrxF+a6jvRswEUklQJ7lbWNcAe//FEGg3FI3ZtNYS0FzKdvhpPUs7XY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xmWHe4WDB3qlFtM/UiYZhf2r1lNSTuN5UN/FQ3Km4gXx7M/lK
	LpwcDV6FlkD+0YW1LEwW4t4fOFZXtDsoYuRVzbNyf1ESABH7pIxuaTELGt+5wZKSacAc
X-Gm-Gg: AZFdTZfcMMeErDs9qG5VxXOMIKU/5IW28sSyi3P2ZM83wtcFrVSEpaIPdOBV/e1X9p1
	e6G66esk6P+W5FWD5DY2mhdJJSJTVW3NL8LC+M9BXp5izZ1TKyI78DQ8UO0D1nBuAKJIRTgB15A
	6HJqq1mXg3kRJAuOw8aLCECNFNLGAk2epomF7b8BD5URLC01UwGRZCUSWUsCuSE+WvIz4+ZmOgZ
	OZkm2wAit5o+bygGHwwUtYQqAFts/Gk7RNsJGu2O7lZmsWCVrEQ07Ehqz9OoOotPIUE3JplOJCN
	Qf8h2eORU53o0JwNxId+iQOVTe8PoObq1M4SJBa7WftuGJlYmNPNJfN8qXFSOTXDFWP7e9FMq7i
	Z02Ctth0cFukGtCtmhfiov/PGtsxdXdpV0EQzNL652unHvXiDwZV/FVjXgkXsdaNRQL+0PrznxP
	vjgsKH0BOJjkFnv5Ow8qYE7Jsk9JVtg906afbf5WM0eQM6yfhdK3Ue+1xaPwTk+g/BVbO5hLqi0
	mOWNnSzHCJLsvGk92sDbJ6oq5noku/KDgxMNuefNTeUUV6eb1uS6L64YgcOFNOQLfKpSwGUmkk9
	BnTNULjh5TyvaT7VQn7p5aJ8WJlSKklSFWkDw44CTjJV3P8dGAWMbRiq+lBlMsTLBAioidBIKvi
	uTZo6KgXPvCi4RPU0r6yr3JTypVsPLjOBxuLJKrkKSCG1gumQQrhpug==
X-Received: by 2002:a05:600c:a11:b0:4a2:e0c:2b0a with SMTP id 5b1f17b1804b1-4bb888120famr364999585e9.16.1795610993400;
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Received: from ?IPv6:2003:cf:572c:2800:c235:97b:8b16:8928? (p200300cf572c2800c235097b8b168928.dip0.t-ipconnect.de. [2003:cf:572c:2800:c235:97b:8b16:8928])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm710678895e9.13.2026.11.25.04.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:49:53 -0800 (PST)
Message-ID: <34297f66e07c1a64d81205c7669801738676f356.camel@amutable.com>
Subject: Re: [PATCH v2 11/13] fs: remove d_real_inode()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, Amir Goldstein
 <amir73il@gmail.com>, 	linux-fsdevel@vger.kernel.org
Cc: Chris Down <chris@chrisdown.name>, Miklos Szeredi <mszeredi@redhat.com>,
 	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, 	linux-trace-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, 	linux-security-module@vger.kernel.org,
 linux-mm@kvack.org
Date: Wed, 25 Nov 2026 13:49:52 +0100
In-Reply-To: <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
References: <20261116-work-ovl-d_real-v2-0-90564c4ae347@kernel.org>
	 <20261116-work-ovl-d_real-v2-11-90564c4ae347@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Mon, 2026-11-16 at 10:44 +0100, Christian Brauner wrote:
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build
> instead
> of passing an ERR_PTR() from d_real() to d_inode().
>=20
> Add a porting.rst entry.
>=20
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> =C2=A0Documentation/filesystems/porting.rst | 10 ++++++++++
> =C2=A0include/linux/dcache.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 -------------
> =C2=A02 files changed, 10 insertions(+), 13 deletions(-)
>=20
> diff --git a/Documentation/filesystems/porting.rst
> b/Documentation/filesystems/porting.rst
> index c38f5df755bb5..aa0fc43907017 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *.
> mnt_idmap() and file_mnt_idmap()
> =C2=A0return one. The idmapping is immutable so nothing should have
> modified it
> =C2=A0anyway. References are taken and dropped via mnt_idmap_get() and
> =C2=A0mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and
> returns an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a
> metacopy file
> +in a data-only layer. Use d_real_data_inode(), which returns the
> inode hosting
> +the data or an ERR_PTR(), and handle the error. Use
> d_real_metadata_inode() for
> +the inode hosting the metadata and handle its errors as well.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index fd8853622f250..fe1aa8fea0c7a 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct
> dentry *dentry, enum d_real_type type
> =C2=A0		return dentry;
> =C2=A0}
> =C2=A0
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real
> inode.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry
> *dentry)
> -{
> -	/* This usage of d_real() results in const dentry */
> -	return d_inode(d_real((struct dentry *) dentry,
> D_REAL_DATA));
> -}
> -
> =C2=A0/**
> =C2=A0 * d_real_data_inode - Return the real inode hosting the data
> =C2=A0 * @dentry: The dentry to query
