Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739323;
	b=u/aQnlEVbgthjqajKcyNLO+nPBTXpDaHf1fh0jfe7157/p2f+w0Zh18IY0Xmwe/kgsnl
	 gi98AczD0W6ZQDXIs6/gHt4U8pcxXcqzG25qEMI+K9IALUHX2MTuzxqPfFcfXcSxlxcHz
	 QdIbeK/9bV47lPMx78djwaOBJ0Bbj3ffIgFcG4Tf8k5vbulV7FpPOG0qaGLn65doJtYeD
	 xu2Rnini2aaY4k1gazrYb9OLijzwywdbvP47V5GaJq2MMb7MH9Bs2FTP40axPUrO6HNNL
	 k3qr4dHUZRon3Oha5NXW9o27a+IOlA15sfQkxUfqHxAgbTx1e8gEiVNf4dO/tUCP1dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P5TLIKaTdJ4/3oCFCGCRgKHBCxpfqCAzCkWdFGsuIOI=;
	b=Qgka8AuQ3lntwGp+yM+NvHU4dUQJ2ZKb44+sNvllJ+nXuwyz8lDFogdVvXM0zEMDOJhW
	 TTPo3aTKFaG9c4tUGFHGR+cjwcZ8viOdi4okY4aJpChOtKTGEwO+K1QDJMhNwGvlc+/ZW
	 eudqee1EHuoPGSXSA6PIktwxyzqUWi9KQBv5KRZgYYlC9bfreTelHwPBztPaBkSNJkTeF
	 Lje2ctFAlWTNRQ8K/2BtXhhYPjEwh+aihTsXA3QFmY1YtMDs138ML0c/74xsOsHVGemO2
	 usrtNJKbh+r+F8z/9U4fi8XGLLIiviAarQO3xg8du4PwJr+FHjZ44YJlnskGsKcxExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aQU/cIpr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A9606A329
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aQU/cIpr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346E31F000C1;
	Tue,  3 Nov 2026 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793739323;
	bh=P5TLIKaTdJ4/3oCFCGCRgKHBCxpfqCAzCkWdFGsuIOI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aQU/cIprTTQkMe6Lza2XZW0MBgg5S+BhdmLrLmo5I8lq72bgj6uy7IkEm9xDzpOSz
	 tvHzkg5u1ThCijfcBvQCIyjelrwZJUjhWh9OFVdPd3/Sp8i9iBWkrcewr6/1Mk9CFM
	 E7SPqwYcEo9xBD7AfGUaM0suG+j9QxE2GJWW3xHXtZ2jbHfj+mYmXqqy6oQJyC/QoO
	 Kp21VIZ3tScUNICoe7EeVDhrafQOSM1ZZbqggyfbckMAO9RzyMUXCsPEI4rq5DWc8t
	 ZQgC7YhENatLhf34TjxSRNL+PlLiQXjI2phKThH10myTkVQkVe2C80VShhXqQGLOZt
	 hFLpy0wSSmHHQ==
Message-ID: <sashiko-outbox-196018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261103154159.1467e7b5@gandalf.local.home>
References: <20261103154159.1467e7b5@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 20:55:22 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] tracefs: bitwise OR in tracefs_apply_options() skips all inodes =
on remount
- [Medium] tracefs: missing TRACEFS_RO_EVENT_INODE on eventfs root inode
- [Low] tracefs: mismatched kernel-doc function name for __eventfs_root_loo=
kup()
--

commit 922a8b2dbffd8c4ebf41d8e11ee0a6caecad79c2
Author: Anubhav Shelat <ashelat@redhat.com>

tracefs: Add read-only eventfs filesystem at /sys/kernel/events

This commit introduces a read-only eventfs pseudo-filesystem mounted at
/sys/kernel/events that reuses the eventfs_inode lazy-lookup infrastructure
to expose trace event format and id files to unprivileged users.

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6e3513b13cfa2..14a71dacf0c16 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c

[ ... ]

> @@ -506,14 +625,21 @@ static struct dentry *
>  lookup_file_dentry(struct dentry *dentry,
>  		   struct eventfs_inode *ei, int idx,
>  		   umode_t mode, void *data,
> -		   const struct file_operations *fops)
> +		   const struct file_operations *fops, bool ro)
>  {
>  	struct eventfs_attr *attr =3D NULL;
> =20
> -	if (ei->entry_attrs)
> +	/*
> +	 * Read-only files gives all users read access,
> +	 * but also should make sure this is not writable.
> +	 * Read-only also does not allow modified attributes.
> +	 */
> +	if (ro)
> +		mode =3D (mode & ~0222) | 0444;
> +	else if (ei->entry_attrs)
>  		attr =3D &ei->entry_attrs[idx];
> =20
> -	return lookup_file(ei, dentry, mode, attr, data, fops);
> +	return lookup_file(ei, dentry, mode, attr, data, fops, ro);
>  }
> =20
>  /**
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
eventfs_root_lookup() was renamed to __eventfs_root_lookup(), should the
function name in the kernel-doc comment header above it also be updated to
__eventfs_root_lookup to avoid a W=3D1 kernel-doc warning?

[ ... ]

> @@ -837,6 +995,48 @@ struct eventfs_inode *eventfs_create_events_dir(cons=
t char *name, struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
> =20
> +/**
> + * eventfs_create_events_ro_copy - create a read-only events directory
> + * @ei: The eventfs_inode to use to create a read-only copy from
> + *
> + * This function configures the eventfs filesystem root as a read-only
> + * trace event directory using the existing eventfs_inode lazy-lookup
> + * infrastructure.
> + */
> +int eventfs_create_events_ro_copy(struct eventfs_inode *ei)
> +{
> +	static struct dentry *dentry;
> +	struct tracefs_inode *ti;
> +	struct inode *inode;
> +	int ret;
> +
> +	/* Can only be called once. */
> +	if (dentry)
> +		return -EBUSY;
> +
> +	/* Reference acquired but never freed */
> +	dentry =3D eventfs_ro_get_root();
> +	if (IS_ERR(dentry)) {
> +		ret =3D PTR_ERR(dentry);
> +		dentry =3D NULL;
> +		return ret;
> +	}
> +
> +	inode =3D d_inode(dentry);
> +
> +	ti =3D get_tracefs(inode);
> +	ti->flags |=3D TRACEFS_EVENT_INODE;
> +	ti->private =3D ei;

[Severity: Medium]
As reported by Sashiko on v4 [2], should eventfs_create_events_ro_copy()
also set TRACEFS_RO_EVENT_INODE in ti->flags on the root inode?

In eventfs_ro_fill_super(), the root inode is allocated via new_inode(sb),
which calls tracefs_alloc_inode() and places the root tracefs_inode on the
global tracefs_inodes list. Because TRACEFS_RO_EVENT_INODE is only set on
child inodes in eventfs_get_inode(), remounting tracefs with uid=3D or gid=
=3D
mount options (once the bitwise check in tracefs_apply_options() is fixed)
will still match the pinned /sys/kernel/events root inode, overwrite its
i_uid and i_gid, and redundantly call eventfs_remount() on the global
events tree.

> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index f3d6188a3b7b2..f895ee9ed4540 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -341,6 +341,14 @@ static int tracefs_apply_options(struct super_block =
*sb, bool remount)
>  		srcu_idx =3D eventfs_remount_lock();
>  		rcu_read_lock();
>  		list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
> +
> +			/*
> +			 * Ignore read-only eventfs inodes as they are not
> +			 * part of tracefs.
> +			 */
> +			if (ti->flags | TRACEFS_RO_EVENT_INODE)
> +				continue;

[Severity: Medium]
Should this check in tracefs_apply_options() use a bitwise AND (&) instead
of a bitwise OR (|)?

Because TRACEFS_RO_EVENT_INODE is non-zero, (ti->flags |
TRACEFS_RO_EVENT_INODE) always evaluates to true, causing the loop to skip
every inode in tracefs_inodes when tracefs is remounted with uid=3D or gid=
=3D
options.

[1] https://lore.kernel.org/r/sashiko-outbox-195864@kernel.org
[2] https://lore.kernel.org/r/sashiko-outbox-194145@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103154159.1467=
e7b5@gandalf.local.home?part=3D1
