Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BD63F410D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 09:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217471; cv=none; b=Yxotq9pLxi0D5m3wAomBuqprTip8BEWCtLkwWALADHyop72aiZI2yR2Z53KekjOyEY7ixnf714tg/3G1nF1/xt2mbxxSJDxFjsKe359AeYUW7OYez/sfrYWbV7imWbcRFeQF+Bc6MrLamvnTpxuPr39vATrdWy+S/UJ66kAcVPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217471; c=relaxed/simple;
	bh=ifeEOiJpWJOAjtIFOt/5NGuRgBavWXoUWiPhcPYRz9I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MXvi51j0AJBZfd/I+rBbJOj1CFdaCWKqRU9ysg1BF3wF+US8PFlsU81ASdZ8pTqhZSvQ9KYheTh+BIa/L4F5yG2+jkQ5sUZAt9WrMwuH5Kd1D2nSbASYS7vMAyZMNWn1K4tC7b4dTRVBPoC562QJv28B9J3xZpDVqmsbYSLwJiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLVj2Bmi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLVj2Bmi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2191F00A3E;
	Thu, 20 Aug 2026 09:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787217469;
	bh=a0SxM9DHWvkTLVcbdjc396sSpQcef9PBPqXQpsy5W+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLVj2BminKs/1broNVY6z+EILkL297PgJM9kd0jBH7coz0RlGmDaQdOsXDPqGZFDi
	 JqazoJME6XdPYnxe2M2KybgkbBHlmmLe/vQ9RLPRGVTWGo91jtrKpmXlJXBXJfoywe
	 byAFcezeDE7YgO3DkY2jlwH4mHz4ehdD100Sgirs/CCgUKA4r+IXvZsFGrkBLHSjQd
	 Tp7fY0IZa7H+Im0lXeREF5WAcGhoVrOlpXWYTiiPdCGU/nr/fJNcJ0i07nxwd/TmUS
	 UxjlWYh8nCQq8raSZrkF2c4MT+w1hGgQgn5eZ2RyYu52MErN8Wf9CeO7aV2Doy2tLA
	 /SiijBnQ8vHfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] ntfs3: add directory index tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baolin Liu" <liubaolin12138@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260820090504.950475-5-liubaolin12138@163.com>
References: <20260820090504.950475-1-liubaolin12138@163.com>
 <20260820090504.950475-5-liubaolin12138@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:17:48 +0000
Message-Id: <20260820091748.EE2191F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] Tracepoints silently truncate 64-bit inode numbers on 32-bit platfo=
rms.

Pre-existing issues:
- [High] Pre-existing memory leaks of `struct ntfs_fnd` objects in the erro=
r paths of index modification functions.
--

--- Patch [4]: [PATCH v4 4/7] ntfs3: add directory index tracepoints ---
commit c766c411cdb54b2e6d2b021851b232bc13e68d08
Author: Baolin Liu <liubaolin@kylinos.cn>

ntfs3: add directory index tracepoints

Add ntfs3 tracepoints for directory index operations.

This adds trace events for dir_search_u(), indx_find(),
indx_insert_entry(), and indx_delete_entry() to help observe
directory index lookup, insert, and delete activity.

> diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
> index 2b439ac043563..d4ca7b1bb5249 100644
> --- a/fs/ntfs3/index.c
> +++ b/fs/ntfs3/index.c

[ ... ]

> @@ -2051,6 +2054,9 @@ int indx_insert_entry(struct ntfs_index *indx, stru=
ct ntfs_inode *ni,
>  		return -EINVAL;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does this direct return in
indx_insert_entry() leak the fnd_a memory?

Earlier in this function, memory is allocated:

	if (!fnd) {
		fnd_a =3D fnd_get();
...

And then later when checking the collation rule:

	cmp =3D get_cmp_func(root);
	if (unlikely(!cmp)) {
		WARN_ON_ONCE(1);
		return -EINVAL;
	}

If get_cmp_func() returns NULL due to an unrecognized collation rule, shoul=
dn't
this jump to the `out` label so that fnd_a can be properly freed?

> =20
> +	trace_ntfs3_indx_insert_entry(&ni->vfs_inode, indx->type,
> +				      le16_to_cpu(new_de->key_size), undo);
> +
>  	if (fnd_is_empty(fnd)) {

[ ... ]

> @@ -2409,6 +2415,8 @@ int indx_delete_entry(struct ntfs_index *indx, stru=
ct ntfs_inode *ni,
>  		return -EINVAL;
>  	}

[Severity: High]
This is a pre-existing issue, but does this direct return in
indx_delete_entry() leak both the fnd and fnd2 memory?

Similar to indx_insert_entry(), this function allocates memory:

	fnd =3D fnd_get();
...
	fnd2 =3D fnd_get();

Then if get_cmp_func() returns NULL:

	cmp =3D get_cmp_func(root);
	if (unlikely(!cmp)) {
		WARN_ON_ONCE(1);
		return -EINVAL;
	}

Shouldn't this go to the `out` label to clean up the memory instead of
returning directly?

> =20
> +	trace_ntfs3_indx_delete_entry(&ni->vfs_inode, indx->type, key_len);
> +
>  	/* Locate the entry to remove. */
>  	err =3D indx_find(indx, ni, root, key, key_len, ctx, &diff, &e, fnd);

> diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
> index 67a2bde0266df..4ac05ed29e49d 100644
> --- a/include/trace/events/ntfs3.h
> +++ b/include/trace/events/ntfs3.h

[ ... ]

> @@ -142,6 +142,87 @@ TRACE_EVENT(ntfs3_create_inode,
>  		  __entry->parent_ino, __get_str(name))
>  );
> =20
> +TRACE_EVENT(ntfs3_dir_search_u,
> +	TP_PROTO(struct inode *dir, unsigned int name_len),
> +	TP_ARGS(dir, name_len),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, dir_ino)

[Severity: Low]
Since the i_ino field in struct inode is a u64, will declaring this field as
unsigned long truncate 64-bit inode numbers on 32-bit architectures?

> +		__field(dev_t, dev)
> +		__field(unsigned int, name_len)
> +	),
> +	TP_fast_assign(
> +		__entry->dir_ino =3D dir->i_ino;
> +		__entry->dev =3D dir->i_sb->s_dev;
> +		__entry->name_len =3D name_len;
> +	),
> +	TP_printk("dev=3D(%d,%d) dir=3D%lu name_len=3D%u",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->dir_ino, __entry->name_len)
> +);
> +
> +TRACE_EVENT(ntfs3_indx_find,
> +	TP_PROTO(struct inode *inode, u8 type, size_t key_len),
> +	TP_ARGS(inode, type, key_len),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, ino)

[Severity: Low]
Will this also truncate 64-bit inode numbers on 32-bit architectures?

> +		__field(size_t, key_len)
> +		__field(dev_t, dev)
> +		__field(u8, type)
> +	),
> +	TP_fast_assign(
> +		__entry->ino =3D inode->i_ino;
> +		__entry->key_len =3D key_len;
> +		__entry->dev =3D inode->i_sb->s_dev;
> +		__entry->type =3D type;
> +	),
> +	TP_printk("dev=3D(%d,%d) ino=3D%lu type=3D%u key_len=3D%zu",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino, __entry->type, __entry->key_len)
> +);
> +
> +TRACE_EVENT(ntfs3_indx_insert_entry,
> +	TP_PROTO(struct inode *inode, u8 type, u16 key_len, bool undo),
> +	TP_ARGS(inode, type, key_len, undo),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, ino)

[Severity: Low]
Will this also truncate 64-bit inode numbers on 32-bit architectures?

> +		__field(dev_t, dev)
> +		__field(u16, key_len)
> +		__field(u8, type)
> +		__field(bool, undo)
> +	),
> +	TP_fast_assign(
> +		__entry->ino =3D inode->i_ino;
> +		__entry->dev =3D inode->i_sb->s_dev;
> +		__entry->key_len =3D key_len;
> +		__entry->type =3D type;
> +		__entry->undo =3D undo;
> +	),
> +	TP_printk("dev=3D(%d,%d) ino=3D%lu type=3D%u key_len=3D%u undo=3D%d",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->ino, __entry->type, __entry->key_len,
> +		  __entry->undo)
> +);
> +
> +TRACE_EVENT(ntfs3_indx_delete_entry,
> +	TP_PROTO(struct inode *inode, u8 type, u32 key_len),
> +	TP_ARGS(inode, type, key_len),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, ino)

[Severity: Low]
Will this also truncate 64-bit inode numbers on 32-bit architectures?

> +		__field(u32, key_len)
> +		__field(dev_t, dev)
> +		__field(u8, type)
> +	),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820090504.9504=
75-1-liubaolin12138@163.com?part=3D4
