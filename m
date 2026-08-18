Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DF37FF70
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Aug 2026 02:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018482; cv=none; b=kWpIHy10q/CzIarzRuxyiBRRGiQRb0jUjrS47MaHxcYsg0fjzrJu0G/aTnQstNVLIwhf8Ra8ddkJrlzOCaWw1yn1jP+qGhwqBa7xuS7utYNYHC0nNHKQbdUfuS7L4kUnIzVI87FIm/uta3NnP4t+0Rpua+2L1wGdpMMZVYUwjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018482; c=relaxed/simple;
	bh=dG0HbUQl1MRCTT0hGIumW5vizwwuIZNXTeL3sOvoySM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eZWpgKZ3gHfHLUDj+zC5sshasTqGYcoZ88RQylOYl1gmqwYxHU5hSybaPUXin5LgkLXnNkbzL6+d35uw9+/5xng6s8kjbGZrDaQYfPTsThk+ii3W+xy+7S2EaONy9kGxeeqx2EYw+yoj1cQopHrh3rgbKS80ATsCXjreA6xOD3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3MLWeGw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3MLWeGw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF141F000E9;
	Tue, 18 Aug 2026 02:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787018479;
	bh=Io0TUV4tUpoY2w2OS7DnXuKk9hnwaan/rWPsJQ+mm0E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G3MLWeGwJvMYxeSrqHbAB+0m8Iav5NKGV7JWUZBYDiS9JAZwFJdBDGNRT+XwLYDHO
	 Yrhwyl+Wo7IppkhKm+drDVoYpP3Zq5dyTcUSCObSknxYWV6kIz5HLEq4AbolIalyWR
	 9EtB/FwnqhhvXLT6RW7WPKwevp8jaexfBAh/GEFi6n4A4r5znNs00dyODKZ3RJwpqP
	 2vQF4RjFOGtC5jgvZJ7LwCZI5tFhWymzGW3PJo4MhC0+JbRL/t1zHGEsb13Es23Ayw
	 W/TyWjup5ghtC6gkpYbY6ZGr4VAIqnoTUBpNGEGtq2thAQIAcFUZhfSxEor3VOD+/q
	 wyCp7Rt4023EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled
 knob
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bradley Morgan" <include@grrlz.net>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260818014920.23870-1-include@grrlz.net>
References: <20260818014920.23870-1-include@grrlz.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 02:01:18 +0000
Message-Id: <20260818020119.2DF141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The 'enabled' debugfs file is created using `debugfs_create_file()`=
 instead of `debugfs_create_file_unsafe()` with a `DEFINE_DEBUGFS_ATTRIBUTE=
` struct, leading to redundant proxying and overhead.
--

--- Patch [1]: [PATCH] kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enable=
d knob ---
commit f5babbd146ccf4194f28506d04f5cbfb2c40150a
Author: Bradley Morgan <include@grrlz.net>

    kprobes: use DEFINE_DEBUGFS_ATTRIBUTE for the enabled knob

This commit replaces the custom read/write handlers for the debugfs enabled
file with the standard DEFINE_DEBUGFS_ATTRIBUTE macro. It simplifies the
implementation and accepts integer inputs rather than characters.

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index ca9d834d0b843..10bcc2a0926a6 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2962,47 +2962,22 @@ static int disarm_all_kprobes(void)

[ ... ]

> -static const struct file_operations fops_kp =3D {
> -	.read =3D         read_enabled_file_bool,
> -	.write =3D        write_enabled_file_bool,
> -	.llseek =3D	default_llseek,
> -};
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_kp, kprobes_enabled_get,
> +			 kprobes_enabled_set, "%llu\n");
> =20
>  static int __init debugfs_kprobe_init(void)
>  {

[Severity: Low]
Will this lead to double-proxying for the debugfs file?

Since DEFINE_DEBUGFS_ATTRIBUTE natively provides debugfs_attr_read and
debugfs_attr_write operations that already include debugfs_file_get() and
debugfs_file_put() protection, passing fops_kp to debugfs_create_file()
in debugfs_kprobe_init() will cause the debugfs core to wrap it again:

kernel/kprobes.c:debugfs_kprobe_init() {
    ...
	debugfs_create_file("enabled", 0600, dir, NULL, &fops_kp);
    ...
}

Could this use debugfs_create_file_unsafe() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818014920.2387=
0-1-include@grrlz.net?part=3D1
