Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA19BA3D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217569; cv=none; b=IeHjZrX7r5W0M2gcrtqy247OB6+Forc37yRUdtoWJLrsg1poI16ZIIsGFa7foz3ES9C+dvb8Ai92lmPpmFPVKYy7pWFYcKTTHfuWAjnSUdINWCZg/I5vDWR8QATLvU1rEy+JL96XkpYuZgkF7o6dM/lRS6ZiyOln9YBfAKT3iNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217569; c=relaxed/simple;
	bh=pwGF+QBqLq0hkEaoHTDy75ZINnEsB4vTqueQM9QcEC4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gjLxlSDa7kPQdGCTwwTmTtJE6RNlZUUHIHVRlhZVZssu//GC6bSiFbFLQNhgSQDG4BXte9rj7YAqUGJJwAQIVkHHH4JeXRMHF26D1aH+G9hZslkehofRrF7f1ZMFtKUs/71QxtYl3DmdHRAXxfDt2L+P78/Gw0lOtkRw+Td2Tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7nZwa3o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7nZwa3o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEDC1F000E9;
	Thu, 20 Aug 2026 09:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787217565;
	bh=OIjWvE1OX5KWve7gD6rCUG1ryDkn+bLZoBfL3aq/X4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d7nZwa3oIsRUdKEJ5bua08Fl++AXqj4vtcZlzkdBS6Md8DLYLBvQ4V+DB9+btmfho
	 k4IaxXdW85e4enhrugDF4WJhLHXRiOMyDHEL0Ios7WT9HTJ+/K4Mm/nDusOBc4fHX8
	 bfoCUvQ29hskW7/wZcbYY1mWlOXCUhaYcf9nPHF4aH/vt8Xb2KZzk31E7vdfVXNvVZ
	 HlTSvy/mUUI5r/uAidLcBrwAKqMrt9QxS/q1dL0b/3o5aFf16H/bpWfvtHMy7oFjbm
	 FRVXEUbcUry9ebaiGy1R4NElaiW4miyMyeDtRnAbNup04EfWkTJdGDRx1SoNbG6afY
	 geyiKY4YQQ2Qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] ntfs3: add file I/O tracepoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Baolin Liu" <liubaolin12138@163.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260820090504.950475-8-liubaolin12138@163.com>
References: <20260820090504.950475-1-liubaolin12138@163.com>
 <20260820090504.950475-8-liubaolin12138@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 09:19:25 +0000
Message-Id: <20260820091925.8DEDC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Tracepoint truncates the 64-bit inode number to 32 bits on 32-bi=
t architectures.
--

--- Patch [7]: [PATCH v4 7/7] ntfs3: add file I/O tracepoints ---
commit 49c2384143cc4908780b467e9d3b31597d86cf97
Author: Baolin Liu <liubaolin@kylinos.cn>

ntfs3: add file I/O tracepoints

This commit adds trace events for ntfs_file_read_iter() and
ntfs_file_write_iter() to help observe file read and write activity.

> diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
> index e0c0c44ce318f..7503000689840 100644
> --- a/include/trace/events/ntfs3.h
> +++ b/include/trace/events/ntfs3.h
[ ... ]
> +DECLARE_EVENT_CLASS(ntfs3_file_class,
> +	TP_PROTO(struct kiocb *iocb, struct iov_iter *iter),
> +	TP_ARGS(iocb, iter),
> +	TP_STRUCT__entry(
> +		__field(loff_t, size)
> +		__field(loff_t, offset)
> +		__field(size_t, count)
> +		__field(unsigned long, ino)

[Severity: Medium]
Does this truncate the 64-bit inode number to 32 bits on 32-bit architectur=
es?

NTFS uses 48-bit MFT references that frequently exceed 32 bits, and
`inode->i_ino` is defined as a 64-bit `u64` in the VFS. Using `unsigned lon=
g`
here will silently truncate high inode numbers on 32-bit systems.

If this field is updated to `u64`, the `TP_printk` format string would also
need to be updated to use `%llu` instead of `%lu`.

> +		__field(dev_t, dev)
> +	),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820090504.9504=
75-1-liubaolin12138@163.com?part=3D7
