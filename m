Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743072;
	b=G03XkTZwSPMpff2/MberwV8xwFljgcxcUG/U1U+HFvG+o98+6315LdkelYkne8TeyVgT
	 TnDUSBXnc5bKWwrTG15R7oAcMOQN1ttI4Z0OvmTxumhX5CXXscp5YMT4gwVxXlg6VNRAx
	 1lMLg4k5IlrhrMz5rR0gZRR8nnXAkNSj2ZOzHELofsbQPQ5MJ/GUAM3W/35OhH4aOQd91
	 Qv2H0aoi9MwE6yRN5ibrVLx9r9Q55FrshV0JVVbmiuHQWxMR+Ia2eGZMkEguY9/lPecww
	 yr1x5CVJa4jthfD7cXtcqHmrAns3CjkSN6UeI+ms9VyPbYAii/wjQRoe2OmKOWY0F0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743072;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cM0U+udOho3z8KX+QMg8sc+lLgbXRq7ebDZ2VXtvL2E=;
	b=ZzzezyRzSQDMnUG/kHYZuHIzlssH+nIxy3us3ef9LaPX4UuLjjmW/Z3SOBvYXz2QCJVW
	 j1PMobnOnCHFwnL4dWW8/Y3gu/3lAc40mrpl4Sg+39nJvIzD88Qo+mIkoTiyENrPFvxnC
	 wVjFlLWqHq2jf8HcalhgEzs08axmut8ZeM4znpCLkTu9Xn56Q+JOs2YxzkCuIuvf1yLgo
	 +UUHdMGWJ/481VFJr4/IuIrQrhnh/QOYH+oYplR56XkBiEPRpTxU1aG7+W6q4zKezBdq0
	 dMVpZUr9s+MgFaAv0UfpcvWt59dVyNvxSkVWwIs2ys/7aOY1sx85QhhvowBmpvGfkTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esz9ALG6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3A606A329
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 21:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esz9ALG6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707AB1F00A1B;
	Tue,  3 Nov 2026 21:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793743071;
	bh=cM0U+udOho3z8KX+QMg8sc+lLgbXRq7ebDZ2VXtvL2E=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=esz9ALG6iKa/jEuZ4Lv/5MMkHV0aqGaGZNieq54nndDdaHitKzX3xEHFd/Np8L2ru
	 SDav+uOYnVZcFeDrWQQhLvoTFWEyb3u+NhbMkQDYTvTsJTh2lGk/1QTDeM9azf7/0T
	 MZepX9aY6uNG1gGPNzP9lo8Au8O+FUHHivLefJNmrNl+IO+NB+LZcu/Zog4ZR9tgN+
	 Bms9YR2ekaWStlAXpVtyqafr9aFXijE/dLOLHLygXKrK8frRPccXYOLqmQ2g20LhWU
	 DjNPYxW5LuytEb3mmfWWZ8x2DJYNygfP5qLA6+v8I7UVd/LM+qUicDH+mvTolwbOdb
	 /VjYHKqiGn9DA==
Message-ID: <sashiko-outbox-196087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261103163803.77170132@gandalf.local.home>
References: <20261103163803.77170132@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 21:57:51 +0000
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
- [Medium] tracefs: missing TRACEFS_RO_EVENT_INODE on root in eventfs_ro_fi=
ll_super()
- [Medium] tracefs: stale TRACEFS_RO_EVENT_INODE retained on slab reuse
- [Low] tracefs: kernel-doc function name mismatch on __eventfs_root_lookup=
()
--

commit fbf6ad09ba162cb7562d4fb9830616b2ca868703
Author: Anubhav Shelat <ashelat@redhat.com>

tracefs: Add read-only eventfs filesystem at /sys/kernel/events

This commit adds a read-only eventfs pseudo-filesystem mounted at
/sys/kernel/events that exposes trace event format and id files with mode
0444 to unprivileged users, reusing the existing eventfs_inode lazy-lookup
infrastructure and tracefs inode allocator.

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6e3513b13cfa2..b7c3ce3f0d14d 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -16,14 +16,100 @@
>   */
>  #include <linux/fsnotify.h>
>  #include <linux/fs.h>
> +#include <linux/fs_context.h>
>  #include <linux/namei.h>
>  #include <linux/workqueue.h>
>  #include <linux/security.h>
>  #include <linux/tracefs.h>
> +#include <linux/magic.h>
>  #include <linux/kref.h>
>  #include <linux/delay.h>
>  #include "internal.h"
> =20
> +static struct vfsmount *eventfs_ro_mount;
> +static int eventfs_ro_mount_count;
> +
> +static int eventfs_ro_fill_super(struct super_block *sb, struct fs_conte=
xt *fc)
> +{
> +	struct inode *inode;
> +	struct dentry *root;
> +
> +	sb->s_blocksize =3D PAGE_SIZE;
> +	sb->s_blocksize_bits =3D PAGE_SHIFT;
> +	sb->s_magic =3D EVENTFS_SUPER_MAGIC;
> +	sb->s_op =3D &eventfs_ro_super_operations;
> +	sb->s_time_gran =3D 1;
> +	sb->s_flags |=3D SB_RDONLY;
> +
> +	inode =3D new_inode(sb);
> +	if (!inode)
> +		return -ENOMEM;

[Severity: Medium]
As reported by Sashiko on v4 [1], in eventfs_ro_fill_super(), new_inode(sb)
invokes tracefs_alloc_inode() via eventfs_ro_super_operations and links the
root tracefs_inode onto the global tracefs_inodes list without setting
TRACEFS_RO_EVENT_INODE.

TRACEFS_RO_EVENT_INODE is only set on the root inode later in
eventfs_create_events_ro_copy(). However, if LOCKDOWN_TRACEFS is active at
boot, create_event_toplevel_files() returns -EPERM before calling
eventfs_create_events_ro_copy():

    e_events =3D eventfs_create_events_dir("events", parent, events_entries,
                                         nr_entries, tr);
    ...
    /* Lockdown causes e_events to be NULL*/
    if (!e_events)
        return -EPERM;

If eventfs is mounted by userspace (or in the window during
eventfs_ro_get_root() before eventfs_create_events_ro_copy() sets
ti->flags), can a tracefs remount with uid=3D or gid=3D options walk
tracefs_inodes in tracefs_apply_options() and overwrite i_uid and i_gid on
the read-only eventfs root inode?

Should TRACEFS_RO_EVENT_INODE be set on get_tracefs(inode)->flags directly =
in
eventfs_ro_fill_super() when the root inode is allocated?

[ ... ]

> @@ -327,7 +432,7 @@ static void update_inode_attr(struct inode *inode, um=
ode_t mode,
>  }
> =20
>  static struct inode *eventfs_get_inode(struct dentry *dentry, struct eve=
ntfs_attr *attr,
> -				       umode_t mode,  struct eventfs_inode *ei)
> +				       umode_t mode,  struct eventfs_inode *ei, bool ro)
>  {
>  	struct eventfs_root_inode *rei;
>  	struct eventfs_inode *pei;
> @@ -342,6 +447,9 @@ static struct inode *eventfs_get_inode(struct dentry =
*dentry, struct eventfs_att
>  	ti->private =3D ei;
>  	ti->flags |=3D TRACEFS_EVENT_INODE;
> =20
> +	if (ro)
> +		ti->flags |=3D TRACEFS_RO_EVENT_INODE;

[Severity: Medium]
When a read-only eventfs inode is evicted and its struct tracefs_inode slab
object is later reused for a normal tracefs inode, does the stale
TRACEFS_RO_EVENT_INODE flag remain set in ti->flags?

Because eventfs_ro_super_operations shares tracefs_inode_cachep, an evicted
read-only eventfs inode goes through tracefs_drop_inode(), which only clears
TRACEFS_EVENT_INODE:

    static int tracefs_drop_inode(struct inode *inode)
    {
        struct tracefs_inode *ti =3D get_tracefs(inode);
        ...
        ti->flags &=3D ~TRACEFS_EVENT_INODE;

        return 1;
    }

The slab constructor init_once() only runs when a new slab is allocated, not
when a freed object is reallocated by tracefs_alloc_inode() via
alloc_inode_sb(), and neither tracefs_alloc_inode() nor callers such as
tracefs_create_file(), __create_dir(), eventfs_create_events_dir(), or
eventfs_get_inode(..., ro=3Dfalse) reset ti->flags.

If a slab object previously used for a read-only eventfs inode is reused for
a tracefs inode (or the tracefs events directory inode), won't
tracefs_apply_options() see the stale TRACEFS_RO_EVENT_INODE bit and skip
updating its uid/gid and calling eventfs_remount()?

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
As reported by Sashiko on v5 [2], this isn't a bug, but since
eventfs_root_lookup() was renamed to __eventfs_root_lookup(), should the
function name in the kernel-doc comment header above it also be updated to
__eventfs_root_lookup to avoid a W=3D1 kernel-doc warning?

[1] https://lore.kernel.org/r/sashiko-outbox-194145@kernel.org
[2] https://lore.kernel.org/r/sashiko-outbox-195864@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103163803.7717=
0132@gandalf.local.home?part=3D1
