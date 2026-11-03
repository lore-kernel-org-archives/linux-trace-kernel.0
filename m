Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747674;
	b=bS8TUCjjtKYcdW6sEJOFGd1Y/O6t+ljRGtHy88QFrrDL25WzJ9VhADbX0yJRTLU1ZiAP
	 SzIBYRFPR1LcIx+GjXjakbXbmlZqnJF2yuxcftjGds8GeW00HzSC1+BktSgwYjgbRJ4UM
	 JaagEQqDFfEx75Ja2UjY0RFKIr/XA3BeiMUujeffUIyxrz1ifMczYjIC2SI6yhHW2hUD2
	 ldR2m5PLLXziUhRS2xClAR3ieynrelTgHgQltpz17r64LmrbRioVA38Ee7L8XvTldfS0W
	 zRP9TVKmspc/Onf5EgeqyRPqtXvgF1w+x/yP7V9ioSW/HncWjjouqymt4QKF6FZEhuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4vjt/iU6IXHmgswsCWZh2fTemPKoHbrUBZU2mjulZzU=;
	b=bPDQ7l/s7RDsrFn5rumUUs2i6hQlFt7niqCcURE2gYyN2kEvg+MGi9lJakXd8ptGcwod
	 IdlPP8GTOSU7WpXFUjxpC5x25JXgta7cXl2+AlX/ZPJc+w+8z8wygje5zZvqkng97zfJp
	 KPH8dYQBD/zgUQEwZz5FbRwM1EQR5CCpgGYmL8bLx3yUQLhO3QIlZAXon+Oywf0H75Yz6
	 DHh11RzAdEDzdEm8thoGhn37xroQAAhja/j6En/Dr8oaGO6+Aaj7iqHPY8xbfhc9t5WVH
	 RvmIAj+s9yTUZefLErvQx1l6C0ZoN7qm5b15UgjXeLWpTP7UfDq188/3tGjpVTFgdLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVEHsH5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073EE606A31B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 23:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVEHsH5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CD751F000C1;
	Tue,  3 Nov 2026 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793747673;
	bh=4vjt/iU6IXHmgswsCWZh2fTemPKoHbrUBZU2mjulZzU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CVEHsH5tncaA+/iPk6rwbVfiWYIwzxsez49plYAdqGItt9qqC+JB3Yjxzu+Xopwlz
	 NA53E35GSm8UsIQ1mjrZiYCawJ+Jqq3pYwra85nUcA4c3ozmeaD7TyBR6SFde9x46a
	 zqHYtyEN8mJjuOKEmAf5ny3oOBWABlqUO2V/lmfjj5rS1MfrKnQebphPP6gBpkOr8S
	 7xZ7I62MSg00oaZs5o0fgsjZEVn/ZjES99TjKdUByNoraY3SVtMckSmHy1dsq9aUqL
	 SQuIbJOrTTM8BaiG5FZt1BbS8gphHxh5TXmihgakI/1e063zoeiI9zLgGVtIzIIOw8
	 FJ48XW1qju+KQ==
Message-ID: <sashiko-outbox-196186@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261103175534.6bd94b13@gandalf.local.home>
References: <20261103175534.6bd94b13@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 23:14:33 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] tracefs: mismatched kernel-doc function name for __eventfs_root_loo=
kup()
--

commit a184dfa06e9d76ab752cc43b8175907e50ee86f0
Author: Anubhav Shelat <ashelat@redhat.com>

tracefs: Add read-only eventfs filesystem at /sys/kernel/events

This commit introduces a read-only eventfs pseudo-filesystem mounted at
/sys/kernel/events that exposes trace event format and id files to
unprivileged users by reusing the existing eventfs_inode lazy-lookup
infrastructure.

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6e3513b13cfa2..8875b0241453b 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c

[ ... ]

> @@ -521,14 +647,16 @@ lookup_file_dentry(struct dentry *dentry,
>   * @dir: in which a lookup is being done
>   * @dentry: file/dir dentry
>   * @flags: Just passed to simple_lookup()
> + * @ro: Denote if this is from a read-only eventfs
>   *
>   * Used to create dynamic file/dir with-in @dir, search with-in @ei
>   * list, if @dentry found go ahead and create the file/dir
>   */
> =20
> -static struct dentry *eventfs_root_lookup(struct inode *dir,
> -					  struct dentry *dentry,
> -					  unsigned int flags)
> +static struct dentry *__eventfs_root_lookup(struct inode *dir,
> +					    struct dentry *dentry,
> +					    unsigned int flags,
> +					    bool ro)

[Severity: Low]
As reported by Sashiko on v5 [1], this isn't a bug, but since
eventfs_root_lookup() in fs/tracefs/event_inode.c was renamed to
__eventfs_root_lookup(), should the function name in the kernel-doc comment
header above it also be updated to __eventfs_root_lookup to avoid a W=3D1
kernel-doc prototype mismatch warning?

[1] https://lore.kernel.org/r/sashiko-outbox-195864@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103175534.6bd9=
4b13@gandalf.local.home?part=3D1
