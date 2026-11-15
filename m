Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754132;
	b=cFFrP9a8XIRrk21pGUGJnQu4WY5LyewRMwjxc6G9bP61opEUtIUUauKfN9+WhTVYG24h
	 0e9pSiiiY3XMhKczRrK7s3QbAOOIAI0BzDovRd46fCEcnmpmFgWdSR7eBzjf5vam6si0i
	 BblztSCnzqT3GFxyM9aM19UP1HIaMBHOCXqx/EXnxf97B4R/FPIhcCky75XC8NifQKHVE
	 bduNUpbA8BUTrFmJljKT11nT8IVDjVXQ33Nn3oT7RteduxCPDDC1vp0ueOTSZVsbg4S46
	 mQ5TZBD2g9PnGwEITEm9DClAp0ayYVedLyYh9EgfhtQm6OT+0lLM+TR7ZZG6A2UNIlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
	b=DKA2gD+eJjo0JV9cZiZyKPg3J2+OFxgLCu9LPzcPubqxZjXd1BT5kaKhCP96r1xrN7Mb
	 o3qW3kjz0G/OYQJbo5X+6TPL9gE+UzMtBsQ6iALy8rLj8HjsPwEs/EDF45gBk9tWTK4or
	 VCbhMI4DVvEFnA9nSLyxjg8LO4wvZGINVW2F1lX6M9EIeAw9+mbBYb6vIkKe/1nONmTA/
	 OBrYMnR2A9U2W/hiErnpGv7BB3eRnXnFNTa2XyNZbiF2ImrY2LIxrvmhdJB1s2vQBYESA
	 MvW7L/eueDDQPCoG/amkrd422Eqfr0aj1hSM0OvSJaS88Pt3xTVEG6SxsGHRMYDTnmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="w5g/XQ3c";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A97606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 14:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A97606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5g/XQ3c
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b633ddfad6so4154489a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 06:48:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754131; cv=none;
        d=google.com; s=arc-20260327;
        b=YWrDfQOpLUfXZF1jJ6LO4JCWTk5mhbsP1Ra65sSauiuZJykzUevF6KSlzfqAXZ+r6T
         tPbyd+PT+BZ3cmr+rjvdNZ6Rmt/Xu1XUnRHQSMQMR6GUbaRzcCX2bTRARDH6ejZH9KCY
         HFeIWgHDotVCp/YVqU55CTXzL6J6sHH/EyvFKfQnUKQf6a5xY582S5KGyEncOn3K/SsG
         XE/kOwpAbg0kqAmDtUKNJbWqE/z0gtb6o8o0AXBUKYeNPnEukkOVdQ7hMtjX16dJSJAj
         XIIVvmu4PJJq+R6RwP8N1gsHv8E7WqGoJsA/4bLigJ4gnnx/rSdKTkFhaik132wtnGxj
         qBtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        fh=C5BMXxuXBJBDJnvLxngdoLz+fGUoUupG8EoJ7jX9yEU=;
        b=gDLRs6qccDW3H2QTlrKOXXcJROgpvbEcAelS46HMddWwmpqUvLc6up5+xbXGwC2urr
         MN3HdIgr4m18A5WdRk1NryAV1PtrvU3a4z/4sKPRfVwLq+DHr+ZVCNNMfiLL2lxuhTo0
         HcOHF6srGfg/8c2vfZdiH8m/wBNHqVGJSPauocTAY1ts2XGuNq0Nb0qPkeEwZrrmwRbu
         SNx/L2r7NosQIolRuNlnsVQpeC1pnJ7kctV03994LYH1KLslqDx4F1JEta+c5WDaKsNf
         +mb7skKySJ9OhhGvMiHgYdts6re5cK+C7mTgljz0waOKCiWWotwh0QT3n7eZdM8j/b/J
         JCNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754131; x=1795358931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=w5g/XQ3c9k+Vmzjr8H8faYY5EnV44gyfCeTqkUEnB7IDVxBorehzGxTmotRUcFMd2k
         yEd9UzOdm44dKGOB9vhvuqA14zDF0izirGlMHcIkPmvfAWV6oC7EWoZSr/n7pMgjOayy
         4XbbykfX2tOLXKQEY71fD4ubWMAf5smyh0PUCbn4ouKSDid+wdpti8tnvMNzC9U0omm7
         PfP/4oysMFjcZt/QSyQgeX6xWgKvlNh0WDaR4PRzqjFkBPghAucojPZwp0HxO1dsPk5w
         0TrSxGukXHJtQczzx+u36Zh+VEpUmtRmnvhCaIPp54UmNZzIkin7PEC6+n43usjPmyxQ
         Zqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754131; x=1795358931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4gZYNSTU3nUDa0BlNRCYypUaVksPX6JgKJOOi2udkU=;
        b=jFqgusKwu6hBndKQRkhYcAHtkT5QPT0xzgUFah0WNDuQ0aQVvLfThrXN6n5VyAh7Fb
         Y8m3SSlqan8PGJ0aLm1o3M4O5h+hppYMSg14rAdriEfT6qKuk372fv+RTwK935BvBprv
         Sa3bSTsHQMuUYGLg7I9MtvNV5/qix0spr6PO5NDUJgSLfj1CF6dMKuYdyOVln0QpXWxS
         f6X/K3SIaSlRcGwIsjp46lALqhTkkvp6W5q3gHHqKoY5WEljgZnv1+U15nT26gssmSWp
         bIP+a1ZcRi3IUzLeUYzIFH9/zwwuPNVisabOSJ1Asdb7pRf+ASZv5IUwStzYWTRQflEh
         V/tg==
X-Forwarded-Encrypted: i=1; AL+hErH/2DHMspsN3lSc23tqjkp7q8bOwuzIpus5yWRk5Q0Msu6Ugk96OhGWzprqwcKszVispI9yTM+FZlYQOi+5ZIVDtrU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nJgHP8vSHKdZOo4VhMaE69y1i1+gEWXun/m/prtB2JvRw1ynN
	G+/ECI3lWui4flyakpZTvNjdvqpSPm7O8r20T+SuiJ4AyVVhgSw+RdyxYb4SIPwxUAVFRHTQDho
	BgHfZ06cxgzuG2pqvCeKr6U+KE1PYEV4=
X-Gm-Gg: AYBFou1Yz/0SABrON9k9oJlEItd1Tp0zMa4rMJIkiB5iFsqrCd8so6adi/NNMOsPTQX
	RxAVNFHxV2OAhnP7Z8eZOYf/IgaMH68h1Xb9us/UR2Y2vxfKnJ4n8LO5/fGytddOBq9laD7dYTz
	99lZQHw+xstE2fVEfdItEtWSPddq4P1Y1BIEcmBbtsJhzSr96aA9PFd7cw6L2VKjrFVHDkXcDF/
	QKy+pnXDO/5iD1QEH4zX29vwbZxxKI8Uyx8sZWPYdNLgtZJEKYZ9xIsTjpkV7Vf+m00l6/08Lnk
	wXfN8uswYkBQKasXfSoCjH4B2LFyP3Va6TeaCRU1v2WO/zAguAB/jVUxc9Bzkt9GodpRhH+rkP/
	+0lLBCsRnOk+jvE574Z5zk+NVNLQYxJ7gRITjIG5H+CvevSsaYnAli1n17qoe88WgHs2k4g==
X-Received: by 2002:a05:6402:1944:b0:6b6:edd7:790c with SMTP id
 4fb4d7f45d1cf-6b7c0d2c969mr5932123a12.45.1794754130672; Sun, 15 Nov 2026
 06:48:50 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-11-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:48:39 +0100
X-Gm-Features: AclHuK_loWLpZnEsR5-ArAPNE_f3U8cZmm7GbEpqPveHBdFtxvcWfTtvtccYOKk
Message-ID: <CAOQ4uxgiwKsadtv1Me3ZkSsTawjNey3wDDWVAnx6U0+Oe+uoQg@mail.gmail.com>
Subject: Re: [PATCH 11/13] fs: remove d_real_inode()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Chris Down <chris@chrisdown.name>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 3:02=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> All callers have been converted to d_real_data_inode() or
> d_real_metadata_inode(). Remove d_real_inode() so that any user we
> missed, or one that gets added in another tree, fails to build instead
> of passing an ERR_PTR() from d_real() to d_inode().
>
> Add a porting.rst entry.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  Documentation/filesystems/porting.rst | 10 ++++++++++
>  include/linux/dcache.h                | 13 -------------
>  2 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesy=
stems/porting.rst
> index c38f5df755bb5..28a24b702f2a6 100644
> --- a/Documentation/filesystems/porting.rst
> +++ b/Documentation/filesystems/porting.rst
> @@ -1422,3 +1422,13 @@ helpers take a const struct mnt_idmap *. mnt_idmap=
() and file_mnt_idmap()
>  return one. The idmapping is immutable so nothing should have modified i=
t
>  anyway. References are taken and dropped via mnt_idmap_get() and
>  mnt_idmap_put() as before, both accept a const pointer.
> +
> +---
> +
> +**mandatory**
> +
> +d_real_inode() is gone. d_real() can fail for D_REAL_DATA now and return=
s an
> +ERR_PTR() then, e.g., when overlayfs can't look up the data of a metacop=
y file
> +in a data-only layer. Use d_real_data_inode(), which returns the inode h=
osting
> +the data or an ERR_PTR(), and handle the error. Use d_real_metadata_inod=
e() for
> +the inode hosting the metadata. That one never fails.
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 5b3b34d271bd0..2b15179e9baf9 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -654,19 +654,6 @@ static inline struct dentry *d_real(struct dentry *d=
entry, enum d_real_type type
>                 return dentry;
>  }
>
> -/**
> - * d_real_inode - Return the real inode hosting the data
> - * @dentry: The dentry to query
> - *
> - * If dentry is on a union/overlay, then return the underlying, real ino=
de.
> - * Otherwise return d_inode().
> - */
> -static inline struct inode *d_real_inode(const struct dentry *dentry)
> -{
> -       /* This usage of d_real() results in const dentry */
> -       return d_inode(d_real((struct dentry *) dentry, D_REAL_DATA));
> -}
> -
>  /**
>   * d_real_data_inode - Return the real inode hosting the data
>   * @dentry: The dentry to query
>
> --
> 2.53.0
>
