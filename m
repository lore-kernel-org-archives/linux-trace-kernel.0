Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005D3E9C3C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217583; cv=none; b=mZhDhNZl9rmY5uDuIOj99z+eaGm9n7PCP45tstrQNUOg8WmUolMvBXK1RWrDorCIW4xYfE7ALxEJc9RbJYLd7tXTduXgNThD6LM70k3RTVHThU9WY/3FV0W7pBseeF9X5Xk3iEj/xFW5sZgHKDKagsLEVfmKirXiolD4U1DOgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217583; c=relaxed/simple;
	bh=l7mO8WCq+r15xY5fEYahIQDD1W+P6ogz9Q4ZsQXHh/A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WHYDhdqkiRV3akxoxCu38CAQBZ+EJPZGyT9bSuI0AbJW+FfsnEufqgcxYCoUwJNBZh+F18WypCvyhQycBzIC5mKgPjl1ezH3prenHhPeyDmJ751DFRjyoYx1pmrsYya1lXD/2dSAwFY+ORTtdEqnNz5hbAEVclADniB6usSkdBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM91lxXD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM91lxXD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABC11F000E9;
	Thu, 20 Aug 2026 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787217581;
	bh=YMAUs4xdTpnBqpp4S6OcmHFFa6g25kNeVmgH8ag7r2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LM91lxXD9juqnMrZCRy0yZkBrjJQONboChx32ZrXKlVQ63ZieJtBZmLW7qaTTWDkI
	 jxYsVAwssGMgSGi6oeciv8OjTegcMRBtyWrj7t2003yjgdpkcsHi2lK5D1/mSQFE1m
	 AYoJ50XLLT0KS2v4BTD6Ah+8wOcRewnY0WfxCapFKUE+WyuffIL6prBuFCdzCUsdYE
	 3gbnGSEcbekmVDe4X+rJSCihEhwMgcLCyqh8zY1hsFGGAevG1HI1turSf2INKIwJon
	 JFu9ZBR3AJk5YSW54u33EtWSUjiwUr+uM78Hqqo1Of2GDpb+CSbPnZJUP9PTPqC8Jt
	 nx0InMLIhQZYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/7] ntfs3: add iomap tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baolin Liu" <liubaolin12138@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260820090504.950475-7-liubaolin12138@163.com>
References: <20260820090504.950475-1-liubaolin12138@163.com>
 <20260820090504.950475-7-liubaolin12138@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:19:40 +0000
Message-Id: <20260820091941.3ABC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Data truncation of 64-bit inode number to 32-bit unsigned long in t=
race events on 32-bit architectures.
--

--- Patch [6]: [PATCH v4 6/7] ntfs3: add iomap tracepoints ---
commit 6e265a35dba7936f19ebddff3d05806b6ce60f0a
Author: Baolin Liu <liubaolin@kylinos.cn>

ntfs3: add iomap tracepoints

This commit adds trace events for ntfs_iomap_begin() and ntfs_iomap_end()
to help observe iomap mapping activity.

> diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
> index e39765bc062f1..e0c0c44ce318f 100644
> --- a/include/trace/events/ntfs3.h
> +++ b/include/trace/events/ntfs3.h
[ ... ]
> +TRACE_EVENT(ntfs3_iomap_begin,
> +	TP_PROTO(struct inode *inode, loff_t offset, loff_t length,
> +		 unsigned int flags),
> +	TP_ARGS(inode, offset, length, flags),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, ino)

[Severity: Low]
Is unsigned long wide enough for the inode number here? In struct inode,
i_ino is defined as a u64. On 32-bit architectures, won't assigning
inode->i_ino to an unsigned long silently truncate high inode numbers?
Could this be changed to use u64 instead?

> +		__field(loff_t, offset)
> +		__field(loff_t, length)
> +		__field(dev_t, dev)
> +		__field(unsigned int, flags)
> +	),
> +	TP_fast_assign(
> +		__entry->ino =3D inode->i_ino;
[ ... ]
> +TRACE_EVENT(ntfs3_iomap_end,
> +	TP_PROTO(struct inode *inode, loff_t pos, loff_t length,
> +		 ssize_t written, unsigned int flags),
> +	TP_ARGS(inode, pos, length, written, flags),
> +	TP_STRUCT__entry(
> +		__field(unsigned long, ino)

[Severity: Low]
Does this field also risk truncating the u64 inode->i_ino when running on
32-bit architectures?

> +		__field(loff_t, pos)
> +		__field(loff_t, length)
> +		__field(ssize_t, written)
> +		__field(dev_t, dev)
> +		__field(unsigned int, flags)
> +	),
> +	TP_fast_assign(
> +		__entry->ino =3D inode->i_ino;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820090504.9504=
75-1-liubaolin12138@163.com?part=3D6
