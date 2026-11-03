Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793731881;
	b=iA4UGje6nhKUNJPZFDo5NjotK0B0BcOyGMSA+DFH18jm00M7NOmdLBP5RjahBA5JQymd
	 3OIGcTpay5bhJ++dXWpftIjzXfQDBr7rI7Fbj6nx+7Wn8Zx3ZB6X+0uITKqVnR8Mi2k/o
	 Lv/xMIaQskzxhkPAjQ+uKBCoM4Mt4wZPcyU1gjv2Zu577+vxuEURKa/ahdbHMt1IpqHq8
	 0hkMnMCG0bG2biQJS3FOBvQHIqNU4ImV///kEm87wxYUN0sZqhTKI3pzDWRCmuMS6rVcP
	 L0q4FJu/kXgXDu8MlUgQ+PvVPe1UN8U1QsC+1yA+h2V05htLLB8i0fdCI/+zyitAa1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793731881;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7R7w0SiHikbEXLW0o3Xe2zM8x44XPoNu8WiKjw2opBE=;
	b=gh5Td1Tf80nn1Ut2wW8v8SpHc7ESkTI0JjP/aaxvvtgPxKwY7GmfSnecItBMlrJL2QyL
	 U2tbbPXx2dCfOiaMavbFywSMLoo+Vs2DWN4jJt9at+ETVUALCis93oPTLhNO2lVnBtKaY
	 xvOEUICeNAALlTKOCGcYMls75B3M/2hWKBOeFhUPwVYHN3bn/2KRZN/k141tEeyNohLGZ
	 noQRB6ekmcfFELG/onnTTD8yoPotgiFzc8WtGo1DNYuir3GPS0aY2gwRu0JYA8FjKH2bL
	 7TZQ6TBdQXmaPnSib3+1Jdbt+NZ8IpbDhd2TB856LCu9vKRg4C1dANbUHoMSikWuJMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CV4t4Fn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3C5606A326
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 18:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CV4t4Fn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631861F0093A;
	Tue,  3 Nov 2026 18:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793731880;
	bh=7R7w0SiHikbEXLW0o3Xe2zM8x44XPoNu8WiKjw2opBE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=CV4t4Fn9py0eFKZcUSPMoIuk0/+O2mK7yhQh0bHWBkiFGHGsOEU9H7qxCFrH4ML5i
	 NCj/z853lRlKUIX1FIbS84/SSVExmXOvR0/5QrrjxSEBXKoEYAUgqbgxd2MzNApmOz
	 HIUM3CojndHnI5K8rithpG3WP5/qK8NWHEP1UdwvkejQM4p6TBohLSUmY+JR1G7ung
	 ZpkaA8cXXvhjfM7uRYfZATQ1BSAEeI76/yPLWCiDWUsTxuyoSbSTUqtC1GjvooAvt5
	 SKE0sNlC3pu2jRqHWanX5xNejCn4IFXHWT12NrIZncUNHVVoZE9SM0IYjQq4elZmkR
	 8VofoEGnlXmzQ==
Message-ID: <sashiko-outbox-195864@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steven Rostedt" <rostedt@goodmis.org>, "Linux Trace Kernel" <linux-trace-kernel@vger.kernel.org>
In-Reply-To: <20261103133517.6e54a8db@gandalf.local.home>
References: <20261103133517.6e54a8db@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 18:51:19 +0000
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
- [Medium] tracefs: tracefs_apply_options() overwrites eventfs_ro inode own=
ership
- [Medium] tracefs: eventfs_ro_fill_super() sets i_nlink to 2 on dynamic ev=
entfs root
- [Low] tracefs: mismatched kernel-doc function name for __eventfs_root_loo=
kup()
--

commit 8a085766e708c607f0750dab297b23f146dfe8b9
Author: Anubhav Shelat <ashelat@redhat.com>

tracefs: Add read-only eventfs filesystem at /sys/kernel/events

This commit introduces a read-only eventfs pseudo-filesystem mounted at
/sys/kernel/events that exposes trace event format and id files with mode
0444 to unprivileged users. It reuses the existing eventfs_inode
lazy-lookup infrastructure and tracefs inode allocator on a separate
read-only superblock.

> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 6e3513b13cfa2..43ae382cfbbfc 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -16,14 +16,96 @@
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
> +
> +	inode->i_ino =3D 1;
> +	inode->i_mode =3D S_IFDIR | 0555;
> +	simple_inode_init_ts(inode);
> +	inode->i_op =3D &simple_dir_inode_operations;
> +	inode->i_fop =3D &simple_dir_operations;
> +	set_nlink(inode, 2);

[Severity: Medium]
Should the root inode keep i_nlink at 1 rather than calling
set_nlink(inode, 2) in eventfs_ro_fill_super()?

When eventfs_create_events_ro_copy() later configures this root inode as the
top-level eventfs directory with eventfs_ro_dir_inode_operations and
eventfs_ro_file_operations, its subsystem subdirectories are created
dynamically on demand in lookup_dir_entry() without incrementing the parent
directory link count.

As noted in eventfs_create_events_dir(), eventfs directories keep i_nlink =
=3D=3D 1
so userspace tools do not trust the link count:

    /*
     * Keep all eventfs directories with i_nlink =3D=3D 1.
     * Due to the dynamic nature of the dentry creations and not
     * wanting to add a pointer to the parent eventfs_inode in the
     * eventfs_inode structure, keeping the i_nlink in sync with the
     * number of directories would cause too much complexity for
     * something not worth much. Keeping directory links at 1
     * tells userspace not to trust the link number.
     */

With i_nlink set to 2 on /sys/kernel/events, won't userspace directory
traversal tools such as find and fts assume the directory has no
subdirectories (st_nlink =3D=3D 2) and skip recursing into the event subsys=
tem
directories?

[ ... ]

> @@ -308,12 +404,17 @@ void eventfs_remount(struct tracefs_inode *ti, bool=
 update_uid, bool update_gid)
>  }
> =20
>  static void update_inode_attr(struct inode *inode, umode_t mode,
> -			      struct eventfs_attr *attr, struct eventfs_root_inode *rei)
> +			      struct eventfs_attr *attr, struct eventfs_root_inode *rei,
> +			      bool ro)
>  {
> +	inode->i_mode =3D mode;
> +
> +	/* The read-only version does not allow updates to owership or permissi=
ons */
> +	if (ro)
> +		return;
> +
>  	if (attr && attr->mode & EVENTFS_SAVE_MODE)
>  		inode->i_mode =3D attr->mode & EVENTFS_MODE_MASK;
> -	else
> -		inode->i_mode =3D mode;
> =20
>  	if (attr && attr->mode & EVENTFS_SAVE_UID)
>  		inode->i_uid =3D attr->uid;

[ ... ]

> @@ -407,22 +512,28 @@ static struct dentry *lookup_file(struct eventfs_in=
ode *parent_ei,
>   * @dentry: the directory to look up
>   * @pei: Pointer to the parent eventfs_inode if available
>   * @ei: the eventfs_inode that represents the directory to create
> + * @ro: boolean to denote if this lookup is for the read-only version
>   *
>   * This function will look up a dentry for a directory represented by
>   * a eventfs_inode.
>   */
>  static struct dentry *lookup_dir_entry(struct dentry *dentry,
> -	struct eventfs_inode *pei, struct eventfs_inode *ei)
> +	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
>  {
>  	struct inode *inode;
>  	umode_t mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> =20
> -	inode =3D eventfs_get_inode(dentry, &ei->attr, mode, ei);
> +	inode =3D eventfs_get_inode(dentry, &ei->attr, mode, ei, ro);
>  	if (unlikely(!inode))
>  		return ERR_PTR(-ENOMEM);
> =20
> -	inode->i_op =3D &eventfs_dir_inode_operations;
> -	inode->i_fop =3D &eventfs_file_operations;
> +	if (ro) {
> +		inode->i_op =3D &eventfs_ro_dir_inode_operations;
> +		inode->i_fop =3D &eventfs_ro_file_operations;
> +	} else {
> +		inode->i_op =3D &eventfs_dir_inode_operations;
> +		inode->i_fop =3D &eventfs_file_operations;
> +	}

[ ... ]

> @@ -521,14 +640,16 @@ lookup_file_dentry(struct dentry *dentry,
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
This isn't a bug, but since eventfs_root_lookup() was renamed to
__eventfs_root_lookup(), should the function name in the kernel-doc comment
header above it also be updated to __eventfs_root_lookup to avoid a W=3D1
kernel-doc warning?

[ ... ]

> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index f3d6188a3b7b2..dafa0d587f04c 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -423,6 +423,14 @@ static const struct super_operations tracefs_super_o=
perations =3D {
>  	.show_options	=3D tracefs_show_options,
>  };
> =20
> +const struct super_operations eventfs_ro_super_operations =3D {
> +	.alloc_inode    =3D tracefs_alloc_inode,
> +	.free_inode     =3D tracefs_free_inode,
> +	.destroy_inode  =3D tracefs_destroy_inode,
> +	.drop_inode     =3D tracefs_drop_inode,
> +	.statfs		=3D simple_statfs,
> +};

[Severity: Medium]
As reported by Sashiko on v4 [1], because eventfs_ro_super_operations uses
tracefs_alloc_inode, all inodes allocated on the read-only eventfs
superblock (including the pinned root inode configured by
eventfs_create_events_ro_copy() and any cached subdirectories or files) are
linked into the global tracefs_inodes list.

While update_inode_attr() now returns early when ro is true during lookup,
when tracefs is mounted or remounted with uid=3D or gid=3D options,
tracefs_apply_options() still walks the global tracefs_inodes list without
checking if the inode belongs to the tracefs superblock:

fs/tracefs/inode.c:tracefs_apply_options() {
    ...
	list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
		if (update_uid) {
			ti->flags &=3D ~TRACEFS_UID_PERM_SET;
			ti->vfs_inode.i_uid =3D fsi->uid;
		}

		if (update_gid) {
			ti->flags &=3D ~TRACEFS_GID_PERM_SET;
			ti->vfs_inode.i_gid =3D fsi->gid;
		}

		if (ti->flags & TRACEFS_EVENT_INODE)
			eventfs_remount(ti, update_uid, update_gid);
	}
    ...
}

Won't mounting or remounting tracefs with uid=3D or gid=3D overwrite i_uid =
and
i_gid on the pinned /sys/kernel/events root inode and all currently cached
eventfs_ro inodes, as well as invoke eventfs_remount() a second time on the
shared eventfs_inode via the eventfs_ro root inode?

Also, in lookup_dir_entry(), mode is initialized to:

	umode_t mode =3D S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;

When ro is true, should lookup_dir_entry() clear S_IWUSR (or use 0555 to
match the root inode in eventfs_ro_fill_super()) so subdirectories in the
read-only eventfs mount do not report 0755 permissions?

[1] https://lore.kernel.org/r/sashiko-outbox-194145@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103133517.6e54=
a8db@gandalf.local.home?part=3D1
