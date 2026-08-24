Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106133A1D01
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560084; cv=none; b=jOGtbl3caVxZMGBJ1YAKEtoeb14A60/+bLZWC26TTRM3REtkpx19e0rH2PNhDG9G3NpGhtoAAjeHGsMOA5VFREr3lKmFBNJlm1ECBP8d6J6auOXDiOuJOv523CMocUmxGJqa6+fztQT2t3QAxogGfVugo+gh+6hAOOM16wiW9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560084; c=relaxed/simple;
	bh=YOphZ65KQfi8Y0davdTNQfU8hQc5+kVCArZc0hlmkIw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pPXSr+5cOjR1RowdfZJpPWABcwIpqOVwPy8oa3NDb4LdyX39LlrS8DrO/Ex4r8XXj4mGbJzxKbDnoUz7jIvjVUAb5ReyNvvH/r+Ud7ukWbLA5u4xRKjMMoNKNYcm+7Bc538AIRz127oCDkWJcDlewa7pRqPBSbYKmz1T5HhmvUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Di0TOoIC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Di0TOoIC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8011F000E9;
	Mon, 24 Aug 2026 08:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787560081;
	bh=aSQGCOvrs7RkeTvXeE5mywi6eUFTagWF9kxlY2qHMXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Di0TOoICAvevZ0upZ6BS1NqoVREr1CKA3z2YpTPmTWXSNQZTo/Jvvr5CJdCSI9SCb
	 kSDvUPEMvVCM8TKvKlW84N3bhtpPVXx6o3dpwgvTCco1jJqnFxqKOZX8NJlcC4txVg
	 eF3Ib31pBcGAsg8AnsNqWb5veoYSyWJBIO1ACgmGB9xGuZYqhwLP8h1vsGHpxOKFpu
	 pctF5EgzFfLG6NPsVa/9kxkol8/S7mYmXFoXPH8t7daoehw0saQpSq6Y7u76c9SLMM
	 8s5Hr4mH7BkoctOdLKDwz1L8MWqIB5jfnZePc//ocDbFucxH+YdrolJDtUjcRgQRnU
	 Tu+zoEOYtrVng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] verification/rvgen: Use .old instead of .bak for kunit
 backup files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260824081519.81103-2-gmonaco@redhat.com>
References: <20260824081519.81103-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:28:00 +0000
Message-Id: <20260824082801.1D8011F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `rvgen kunit` tool generates `.old` backup files which are n=
ot cleaned up by `make distclean`, polluting the user's working directory.
--

--- Patch [1]: [PATCH] verification/rvgen: Use .old instead of .bak for kun=
it backup files ---
commit 293b444e4dfea5692931faee1bc9c58a549085d8
Author: Gabriele Monaco <gmonaco@redhat.com>

verification/rvgen: Use .old instead of .bak for kunit backup files

The rvgen kunit command generates .bak backup files and these can be
checked in for selftests (make check). Clean targets like make disclean
remove such files, leaving the tree dirty. Switch to .old to preserve a
clean tree after make disclean.

Closes: https://lore.kernel.org/lkml/aosuwKH5GOEo0xTN@google.com

> diff --git a/tools/verification/rvgen/rvgen/kunit.py b/tools/verification=
/rvgen/rvgen/kunit.py
> index ed2082d7d3bc4..85973f918c9b5 100644
> --- a/tools/verification/rvgen/rvgen/kunit.py
> +++ b/tools/verification/rvgen/rvgen/kunit.py
[ ... ]
> @@ -173,7 +173,7 @@ EXPORT_SYMBOL_IF_KUNIT({struct_name});
>              for path in (header_file_path, kunit_c_file_path):
>                  if path.exists():
>                      try:
> -                        path.rename(path.with_suffix(path.suffix + ".bak=
"))
> +                        path.rename(path.with_suffix(path.suffix + ".old=
"))

[Severity: Medium]
Will this regression leave users' working directories polluted with .old
backup files that aren't cleaned up by the top-level make distclean target?

The kernel's global Makefile explicitly cleans *.bak files during
distclean, but ignores *.old files.

When a user runs rvgen kunit in a directory with existing kunit files and
accepts the backup prompt, print_files() will generate these .old files.
Since they are no longer .bak files, is it expected that they will persist
after running make distclean?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824081519.8110=
3-2-gmonaco@redhat.com?part=3D1
