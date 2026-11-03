Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737182;
	b=U65l9KppjEKzMSPYjLjtVggEDxnKZFAgjW37EFtycUXpjhCzB9anegomGGsUMWjcVorn
	 4ni1tZj0uNorHLdiLQu15FAHLqGr6rt4MVxa/pisAPHLB1YwgcXeCmObDPqZa+hNQvYaY
	 RKz08Fyf5s9B3R9QApHPFRuiIzDEfMVklD3qddytERPBJbvkkjfx8SF9eit+O9I7wUdR2
	 pma/LmDJBXHJmfy4sSdExUQovsQqdIg8i2fKvn3BScaMiQUnxMwQ3VtQhVwlJlPesEd4o
	 valqgHG3rapwquh6zSeKJQnygBzL+ClAcJB8IsvfHMBkModGsQdlG/D+DrL5Vb97U3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737182;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=O4Fkb/MF3t7h+MTx6P2bTkcLrdVzYJ2bsnvOwo6miVM=;
	b=FPoKlS1W2iH/duScFlwakeQ2iRwj6/lhlwXVZdmhgKCMi8sd8gmMGHOdzG3e5FQgCB0g
	 QIUfOXXnzZ24XxSVU6hFv4kF5KLsTkLqllVepNm2wNMS+XHEWiToP+9HrceVswMgk5AKx
	 wKVib7LEeI4NLmGP8HCbGmwk0M7v7Fxf/bdURdxrpHDI+wHMqisPLTq2r25zZK94ICkN9
	 LD2dMwyPWG88i72uAFysA0jrccmiyBAVqJOK2+Fdkjy8/w4bSoHY6mUkw9bZ9Sew5xGEp
	 vlbR8o1mVgEwhqtHWjpMp4JejlsvF25pUVx7ydwHmW4ArSxqaw8UUUJNMKczoENWiGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=u3vFUk00;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F092E606A324
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 20:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F092E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=u3vFUk00
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D960AA8138;
	Tue,  3 Nov 2026 20:19:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 4592D17;
	Tue,  3 Nov 2026 20:19:32 +0000 (UTC)
Date: Tue, 3 Nov 2026 15:19:30 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Linux Trace Kernel"
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] tracefs: Add read-only eventfs filesystem at
 /sys/kernel/events
Message-ID: <20261103151930.47198f74@gandalf.local.home>
In-Reply-To: <sashiko-outbox-195864@kernel.org>
References: <20261103133517.6e54a8db@gandalf.local.home>
	<sashiko-outbox-195864@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 4592D17
X-Stat-Signature: scsh8bt4afu9iz4cjq3u6mht4wceuqdz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+le/yK7szpGL6ARxP0T97SZIN6HBTJI6I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=O4Fkb/MF3t7h+MTx6P2bTkcLrdVzYJ2bsnvOwo6miVM=; b=u3vFUk00m33eS49P21UzS/v96klWBLl/lLLMnvYgn8iUqOLJG9xMi7UycPHK49Pchzf6O6z6YIDYZgXzD3iDLXib/jsRcVI5SToI6+4BXdaPnFK9uTCJQXDAbtdz6WUnmjzKPh6FBrG8k2oHMvJsaIXAVxGhkDMaJuDmxcbkQPw=
X-HE-Tag: 1793737172-981644
X-HE-Meta: U2FsdGVkX182+p3oDgRypao26umnLca03n8NsJzueH6nUhqRRCuHwJnVxBkNcjNlhJUhjdqtYuCJwSPvYZCY0eGYPrXY6ZtOgxnBKtmQF7rVuWPOezyPw/WtxtQuQCRjv2dTmoz1KMA6kFHIoqEPak/+k2jt/FWvfoSSGP+EHvQdEj+IOYHl5F/kiPSgBQwAs4YmEYkcRwhekeQOk+M6d7OL67GfF/2jr9v1oafqoau8MfaqV2l9JnDMjCx3jjlQY6SOZCOlLQz3OK95tKwgobvlZlD5bmaCM3zi0D0vSUObGdsaCm8Xkh4UoP9INrvAuPG/33nvGUj1s4blijk+AXNFF+lx0O1u

On Tue, 03 Nov 2026 18:51:19 +0000
sashiko-bot@kernel.org wrote:

> > +	inode->i_ino = 1;
> > +	inode->i_mode = S_IFDIR | 0555;
> > +	simple_inode_init_ts(inode);
> > +	inode->i_op = &simple_dir_inode_operations;
> > +	inode->i_fop = &simple_dir_operations;
> > +	set_nlink(inode, 2);  
> 
> [Severity: Medium]
> Should the root inode keep i_nlink at 1 rather than calling
> set_nlink(inode, 2) in eventfs_ro_fill_super()?
> 
> When eventfs_create_events_ro_copy() later configures this root inode as the
> top-level eventfs directory with eventfs_ro_dir_inode_operations and
> eventfs_ro_file_operations, its subsystem subdirectories are created
> dynamically on demand in lookup_dir_entry() without incrementing the parent
> directory link count.
> 
> As noted in eventfs_create_events_dir(), eventfs directories keep i_nlink == 1
> so userspace tools do not trust the link count:
> 
>     /*
>      * Keep all eventfs directories with i_nlink == 1.
>      * Due to the dynamic nature of the dentry creations and not
>      * wanting to add a pointer to the parent eventfs_inode in the
>      * eventfs_inode structure, keeping the i_nlink in sync with the
>      * number of directories would cause too much complexity for
>      * something not worth much. Keeping directory links at 1
>      * tells userspace not to trust the link number.
>      */
> 
> With i_nlink set to 2 on /sys/kernel/events, won't userspace directory
> traversal tools such as find and fts assume the directory has no
> subdirectories (st_nlink == 2) and skip recursing into the event subsystem
> directories?

Good point. Will update.

> 
> [ ... ]
> 
> > @@ -308,12 +404,17 @@ void eventfs_remount(struct tracefs_inode *ti, bool update_uid, bool update_gid)
> >  }
> >  
> >  static void update_inode_attr(struct inode *inode, umode_t mode,
> > -			      struct eventfs_attr *attr, struct eventfs_root_inode *rei)
> > +			      struct eventfs_attr *attr, struct eventfs_root_inode *rei,
> > +			      bool ro)
> >  {
> > +	inode->i_mode = mode;
> > +
> > +	/* The read-only version does not allow updates to owership or permissions */
> > +	if (ro)
> > +		return;
> > +
> >  	if (attr && attr->mode & EVENTFS_SAVE_MODE)
> >  		inode->i_mode = attr->mode & EVENTFS_MODE_MASK;
> > -	else
> > -		inode->i_mode = mode;
> >  
> >  	if (attr && attr->mode & EVENTFS_SAVE_UID)
> >  		inode->i_uid = attr->uid;  
> 
> [ ... ]
> 
> > @@ -407,22 +512,28 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
> >   * @dentry: the directory to look up
> >   * @pei: Pointer to the parent eventfs_inode if available
> >   * @ei: the eventfs_inode that represents the directory to create
> > + * @ro: boolean to denote if this lookup is for the read-only version
> >   *
> >   * This function will look up a dentry for a directory represented by
> >   * a eventfs_inode.
> >   */
> >  static struct dentry *lookup_dir_entry(struct dentry *dentry,
> > -	struct eventfs_inode *pei, struct eventfs_inode *ei)
> > +	struct eventfs_inode *pei, struct eventfs_inode *ei, bool ro)
> >  {
> >  	struct inode *inode;
> >  	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> >  
> > -	inode = eventfs_get_inode(dentry, &ei->attr, mode, ei);
> > +	inode = eventfs_get_inode(dentry, &ei->attr, mode, ei, ro);
> >  	if (unlikely(!inode))
> >  		return ERR_PTR(-ENOMEM);
> >  
> > -	inode->i_op = &eventfs_dir_inode_operations;
> > -	inode->i_fop = &eventfs_file_operations;
> > +	if (ro) {
> > +		inode->i_op = &eventfs_ro_dir_inode_operations;
> > +		inode->i_fop = &eventfs_ro_file_operations;
> > +	} else {
> > +		inode->i_op = &eventfs_dir_inode_operations;
> > +		inode->i_fop = &eventfs_file_operations;
> > +	}  
> 
> [ ... ]
> 
> > @@ -521,14 +640,16 @@ lookup_file_dentry(struct dentry *dentry,
> >   * @dir: in which a lookup is being done
> >   * @dentry: file/dir dentry
> >   * @flags: Just passed to simple_lookup()
> > + * @ro: Denote if this is from a read-only eventfs
> >   *
> >   * Used to create dynamic file/dir with-in @dir, search with-in @ei
> >   * list, if @dentry found go ahead and create the file/dir
> >   */
> >  
> > -static struct dentry *eventfs_root_lookup(struct inode *dir,
> > -					  struct dentry *dentry,
> > -					  unsigned int flags)
> > +static struct dentry *__eventfs_root_lookup(struct inode *dir,
> > +					    struct dentry *dentry,
> > +					    unsigned int flags,
> > +					    bool ro)  
> 
> [Severity: Low]
> This isn't a bug, but since eventfs_root_lookup() was renamed to
> __eventfs_root_lookup(), should the function name in the kernel-doc comment
> header above it also be updated to __eventfs_root_lookup to avoid a W=1
> kernel-doc warning?

Hmm, I rather keep it as is. Yeah, W=1 may warn, but it's still the first
function. Maybe I'll update this later as a cleanup.


> 
> [ ... ]
> 
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index f3d6188a3b7b2..dafa0d587f04c 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -423,6 +423,14 @@ static const struct super_operations tracefs_super_operations = {
> >  	.show_options	= tracefs_show_options,
> >  };
> >  
> > +const struct super_operations eventfs_ro_super_operations = {
> > +	.alloc_inode    = tracefs_alloc_inode,
> > +	.free_inode     = tracefs_free_inode,
> > +	.destroy_inode  = tracefs_destroy_inode,
> > +	.drop_inode     = tracefs_drop_inode,
> > +	.statfs		= simple_statfs,
> > +};  
> 
> [Severity: Medium]
> As reported by Sashiko on v4 [1], because eventfs_ro_super_operations uses
> tracefs_alloc_inode, all inodes allocated on the read-only eventfs
> superblock (including the pinned root inode configured by
> eventfs_create_events_ro_copy() and any cached subdirectories or files) are
> linked into the global tracefs_inodes list.
> 
> While update_inode_attr() now returns early when ro is true during lookup,
> when tracefs is mounted or remounted with uid= or gid= options,
> tracefs_apply_options() still walks the global tracefs_inodes list without
> checking if the inode belongs to the tracefs superblock:
> 
> fs/tracefs/inode.c:tracefs_apply_options() {
>     ...
> 	list_for_each_entry_rcu(ti, &tracefs_inodes, list) {
> 		if (update_uid) {
> 			ti->flags &= ~TRACEFS_UID_PERM_SET;
> 			ti->vfs_inode.i_uid = fsi->uid;
> 		}
> 
> 		if (update_gid) {
> 			ti->flags &= ~TRACEFS_GID_PERM_SET;
> 			ti->vfs_inode.i_gid = fsi->gid;
> 		}
> 
> 		if (ti->flags & TRACEFS_EVENT_INODE)
> 			eventfs_remount(ti, update_uid, update_gid);
> 	}
>     ...
> }
> 
> Won't mounting or remounting tracefs with uid= or gid= overwrite i_uid and
> i_gid on the pinned /sys/kernel/events root inode and all currently cached
> eventfs_ro inodes, as well as invoke eventfs_remount() a second time on the
> shared eventfs_inode via the eventfs_ro root inode?

OK, I'll add a flag to skip read-only event inodes.

> 
> Also, in lookup_dir_entry(), mode is initialized to:
> 
> 	umode_t mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;
> 
> When ro is true, should lookup_dir_entry() clear S_IWUSR (or use 0555 to
> match the root inode in eventfs_ro_fill_super()) so subdirectories in the
> read-only eventfs mount do not report 0755 permissions?

Honestly, all of tracefs directories should be read only except for the
instances directory. I may update that as a separate patch.

-- Steve

