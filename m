Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794754079;
	b=ZncEb0XKy34O2hJmaJtCSabgUZsyNl6a1Ea1imNsij/STJotqcYhc5hJqWV2GXjARq6B
	 r6MtqvehmobqzzVP0swxcv1IVscegef77WPfK/sxmSZNyrgmz9XYmiv6tNyKJnLHV4q6J
	 XTm1hESWghYaIlo9es5LJG4HNb847pXGSY7yfO3mu8vCVvhxUtiZShASP5W+z1J/aPH5/
	 YWVlyYvk8luQnVFp7PfsshQNuemwq8RA0yv8pYomVddayNmSBPeryLXfMhK8DKSbuFzmi
	 YLm1wWMTqrzhCuMxRRZpBu/xwFw4Ofh4L04ibOc7d0V0uw8Wvb865N1Iq6vlLAsKLsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794754079;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
	b=jrx7kQc+oyftucsfyCMBAHs8MnJ73pYGGmSOyg3v9sM7pVmYhQoA2XmO++Fubz1NmqnR
	 CCyo4mA0PQoqy0wkV41Ns9BQErWUxaqWHsypfXfyyVwmjs1GNugsVIPlCjBIX7sWYJjQ8
	 cjgZOfDK09ulTfgmRZ6WFySE77W0askk/QXWUo1UHEX+274lqcF3qc6DjuZR2mWTPXO1M
	 m5bl0/9aFOIryweD/z0L2czFqgjmmzGZHqrBaGKxo8B1THIzQDsjJsfF4+ZEtiV3Uvx39
	 Ga/2ySq/OcWu0TdPPx9pdkx1mlUUx3ob/hK9Gyzb0056yyPxFr0J2gqRs6KaOxCIRNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE44606A327
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 14:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BE44606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vdeJy6VC
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso5977797a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 06:47:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794754076; cv=none;
        d=google.com; s=arc-20260327;
        b=P4XNp4nGXT5+GTVhOtWtNCO/LlgK5lEHARnmm5InUjwWs2EnwSP0cX+eawS2i6nD0O
         88howdXKUOdFoVIR/Qz1wKFXJ2smD1tEqIl0WABueD2TlnQPU3oYW1rlTg1bWJ/i0dpD
         rNAS7O02U/xEJhde6LnFtPMxgKQ823+Ihpi/KJ2VIrLd4f/gDMUP4TeuioQSHtaQZolM
         To7f0UDZGgB7AWUohWfWQTT6FQ2HYnwXJ4mPLY894rLEtWj3R0gFwq4EcW4eKPORNhP7
         hYBqH/+gcZX1wNAboDfCkWhusuwi0xooJAlfBfefdvvkoCG4/Do0ow1zyhKZMiWHg9Iq
         641A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        fh=TAHvD1ztZBi2qRK4bo5PpJRcmu1y0TgYPUCimrusnFM=;
        b=JpJXj4qLLudcOsRWnnO3p5kdsGbaXtAvgipAPsaGB6r1XjAkcE0afdv9JFIMKyTg9E
         8p6yhEqaAFwcHalJR2O+NYQ9xzQDvCHZ5fYSeS/MxpXbDp/5+F+AFaJVo+8XkKM/vYlv
         TcqJHqc28D1iQSNAME1aa8eWTsjDCDDm7J3QRXbAYYI0+mhyLrC0oa63C428RWhquvK9
         ZGbE2h+0naqrYhafiH0CXhqexh/jCef5S0sHOEryKZ+YFOq4YUqfiE5Rdq1jExVZvvUa
         v/138as5CoFb7Uxj1ycMGwEb9pPEjVfuSV6AWer6wiUbN3EfxeUD8xNbXe77Ssm9jRXu
         WfnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794754076; x=1795358876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=vdeJy6VCk2IGRpnrLWlGo4pWLhKneS7IPoBk81bLTW0iD2g50lPI0We72sIkSM0SV6
         cyTbNZB4O3d6VzvDDG9DPV5xAXhxmw4YkAyPQvdWI1M8aVPLRajltXh2AQAOKJY1EPeA
         J/3fQzDOEdKdl4Og0NnAs1e+UKlTuJcD65e+vWcNglfpyVM0bRYj3j545Ccvj/p07kIf
         RJxqw4iAkOZDz6lvhqxGAdC4rSJXKnOPRkFB2PlSiergeTKJSozBYsIqbEfROUxsRiwA
         +nC6LR2BKa2t52tGscFSOG6fqqncSzV6SKT9uOygWHxo9fsmCNg/KFWBsER32dA/LqAU
         Q4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794754076; x=1795358876;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x7HykaAJlgnOpmpM8XJHQMzZjK2dm2wSOUdGIuC/Jng=;
        b=xYcr2X8m05nF9UQPzISpKLRVvjCIq+XiMOn2uAyqsxmFif5KaSB4vlcphgMaf5PFFH
         t0sdfLrA29NPerXn+rgBJ5FU6Fzje9BLdEjz7zDeAi1F6BGE0vVK0x1bgN+c2DQ/VnCp
         CsvaQAdd4PIUtN+b4s3IMs0BeXl+JwvFoGCkT1B8PwvcDcMrxKXfZGQv6NDz9/mKhWfZ
         m6JlaqGcsxR6Suu086u2jOuNL5mlTO4eJT+IW+ae9bifUcGqs6Tg9BR3YmLQJOkkuuMr
         NNKt0VCKJIp/Ch8mS1TBexa1aVYQeHX94GE/LRA1AlS88YbzBWqgC+IDn4XX98RKr9lv
         Pjrg==
X-Forwarded-Encrypted: i=1; AL+hErEUsm2+6iDXP9b6/9dVyGY1rCrno0huV0d7kY/b6v3JVNFbkuJDwx0ZKOyW7nQuPPk75jAFR6H3vQ3jLbZJneFmjSM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Zw65OKu4cNRUQRZ4gyN/7vVhQ1FQQM+NBQJKx9y92Uq92J1m3
	74drZrLt5JI/SYCXuOHOUs338/QlFCjag1dwKimI5LYCJdgUuHGFu413MiuqNBJ/6gh86vM+6Fy
	dTSKBmgJ0h4A5R9Oei/YubB5nO0uwDNk=
X-Gm-Gg: AYBFou0h230SkAdeAbtDr+hNhudGMBrW2GYWTH/bS3Jqot81ZUKOiCqa9a3Umy8HpQx
	ZzRdTnHkUC28WM1a4aqZQzTBAZX1jDnq0UQs/2kRPVBcT8SJtNZJXB//WZn6r5JaP9U9j5bjHrC
	92RU+g9ld8jLG+TnH7cSKyPEngWnpW0B7K/aviqVS9AmQhX8jj85uCcoGqJuJFBqUF29n3rIP2D
	GL6gZrgI06HM1HfsU2OOa1/QJHCYAjZm61QH3yfkcY6ii+vRJ5JMAM3LVZBQ3OhV9VyeLrmnDb3
	zc1T4X0vuX2sFwoAQR43nednruLI3BWf5y8/Goi2fmEcT1uj06bCCXNqDABsp4hp8uEzRDMNEWB
	amZA9i1aFLGuqFAjFK2LmQHZo+OG2s+3BCSYfvaE/FGAwMBHBCzz7Z7lW7cv9Nwn4477+Iw==
X-Received: by 2002:a05:6402:1d4c:b0:6b7:e12e:7f1f with SMTP id
 4fb4d7f45d1cf-6b7e12e824fmr3426650a12.10.1794754076394; Sun, 15 Nov 2026
 06:47:56 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115-work-ovl-d_real-v1-0-ca155efbcb2e@kernel.org> <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
In-Reply-To: <20261115-work-ovl-d_real-v1-10-ca155efbcb2e@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 15:47:45 +0100
X-Gm-Features: AclHuK_at8qVhKBNN0WXPGQ7F2lmyjSQgMjlfNE9nQtuQriTEXeBZE7dwGmSTD8
Message-ID: <CAOQ4uxggW+UifxBJDY8fAb+g5EWrsD+rELwXa1ngZ_5X_OZx0g@mail.gmail.com>
Subject: Re: [PATCH 10/13] ovl: return the error from the lazy lowerdata
 lookup in ovl_d_real()
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
> All callers have been converted to d_real_data_inode() and handle an
> error now. So return the error from ovl_verify_lowerdata() just like
> ovl_open() does. The lowerdata dentry missing after a successful
> ovl_verify_lowerdata() would be an overlayfs bug, so keep warning about
> that but return -EIO like ovl_open() does when it has no real path.
> D_REAL_METADATA never looks anything up and still can't fail.
>
> Update the comment in ovl_d_real() and the documentation of d_real() in
> dcache.h and vfs.rst accordingly.
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice!
Thanks for cleaning up this mess.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  Documentation/filesystems/vfs.rst |  6 ++++++
>  fs/overlayfs/super.c              | 17 +++++++++--------
>  include/linux/dcache.h            |  6 ++++++
>  3 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystem=
s/vfs.rst
> index 1824462a43711..6953f399672f3 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -1374,6 +1374,12 @@ defined:
>         for returning the real underlying dentry that refers to the inode
>         hosting the file's data or metadata respectively.
>
> +       For D_REAL_DATA the filesystem may have to look up the data first=
,
> +       e.g., for a file that was never opened.  If that fails an ERR_PTR=
()
> +       is returned and callers must handle it.  D_REAL_METADATA must not
> +       fail.  Most callers should use d_real_data_inode() or
> +       d_real_metadata_inode() instead of calling d_real() directly.
> +
>         For non-regular files, the 'dentry' argument is returned.
>
>  ``d_unalias_trylock``
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 1985b553a47b7..39d4d57dec230 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -42,7 +42,7 @@ static struct dentry *ovl_d_real(struct dentry *dentry,=
 enum d_real_type type)
>         }
>
>         if (!d_is_reg(dentry)) {
> -               /* d_real_inode() is only relevant for regular files */
> +               /* d_real() is only relevant for regular files */
>                 return dentry;
>         }
>
> @@ -57,17 +57,18 @@ static struct dentry *ovl_d_real(struct dentry *dentr=
y, enum d_real_type type)
>         }
>
>         /*
> -        * Best effort lazy lookup of lowerdata for D_REAL_DATA case to r=
eturn
> -        * the real lowerdata dentry. Callers may ask for files that were=
 never
> -        * opened, e.g. for uprobes or O_PATH files, so the lookup can fa=
il
> -        * here. Return the overlayfs dentry then.
> +        * Lazy lookup of lowerdata for the D_REAL_DATA case to return th=
e real
> +        * lowerdata dentry. Callers may ask for files that were never op=
ened,
> +        * e.g., for uprobes or O_PATH files, and the lookup or the verit=
y
> +        * validation can fail. Return the error then, just like ovl_open=
()
> +        * would. Callers of d_real() have to deal with that.
>          */
>         err =3D ovl_verify_lowerdata(dentry);
>         if (err)
> -               return dentry;
> +               return ERR_PTR(err);
>         lower =3D ovl_dentry_lowerdata(dentry);
> -       if (!lower)
> -               goto bug;
> +       if (WARN_ON_ONCE(!lower))
> +               return ERR_PTR(-EIO);
>
>  real_lower:
>         /* Handle recursion into stacked lower fs */
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 674bc50b81827..5b3b34d271bd0 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -638,7 +638,13 @@ static inline struct inode *d_backing_inode(const st=
ruct dentry *upper)
>   * If dentry is on a union/overlay, then return the underlying, real den=
try.
>   * Otherwise return the dentry itself.
>   *
> + * For D_REAL_DATA the union/overlay may have to look up the data first.=
 This
> + * can sleep and it can fail. D_REAL_METADATA never fails.
> + *
>   * See also: Documentation/filesystems/vfs.rst
> + *
> + * Return: The real dentry, or an ERR_PTR() for D_REAL_DATA if the data =
can't
> + * be resolved.
>   */
>  static inline struct dentry *d_real(struct dentry *dentry, enum d_real_t=
ype type)
>  {
>
> --
> 2.53.0
>
