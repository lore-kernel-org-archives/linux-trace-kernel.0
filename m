Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9C74C8FE3;
	Wed, 29 Jul 2026 18:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785349554; cv=none; b=Gmgg/Gz27YA6PUPPIKYWbzL/LRjbmu/owIDASYDJm9emmL57UCTJlDFlsUEdj2NIbz6PEvUYsAIV5AX8o2sPV0ShSVWq5gEKF4VjItqNxIxoRi1v71bEcAc7oQmma9feo0pkqUrrjlej62kYQxmo9ZF2rP7m1IJZYEERX9siACg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785349554; c=relaxed/simple;
	bh=gZn8M6iN6qVLvcFu0jl/ynWIAVW1eVZ8xMa8AGW0qgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+VZDarXqUveTXdjwCE2XPfKglk0IHa/Dmv/iOd/TXmpJoFNm24x+CgFmXO+PRif5oNJ8BVTevxbhjXPo2JbXWcMzuV/ttblsDeM6C7wpLlfLXwGqxApbwBiMuS1ghS/ic9Of7WIbSdY0h7NVekHe2tUcqNI4QcjVGB9lXc1fMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 02DD01C0AE2;
	Wed, 29 Jul 2026 18:25:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 02BFA20025;
	Wed, 29 Jul 2026 18:25:46 +0000 (UTC)
Date: Wed, 29 Jul 2026 14:26:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Baolin Liu <liubaolin12138@163.com>
Cc: almaz.alexandrovich@paragon-software.com, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 ntfs3@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
 liubaolin12138@gmail.com, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2 v2 2/7] ntfs3: add namei tracepoints
Message-ID: <20260729142622.73d7ef18@gandalf.local.home>
In-Reply-To: <20260728094426.749482-3-liubaolin12138@163.com>
References: <20260728094426.749482-1-liubaolin12138@163.com>
	<20260728094426.749482-3-liubaolin12138@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 02BFA20025
X-Stat-Signature: njo39d879d3ik3y5s57zorda9h9rjm5j
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gcG7z8+xe5CuRgGFrOaYPY1PVKe37xwY=
X-HE-Tag: 1785349546-384304
X-HE-Meta: U2FsdGVkX18AnuatEIIupAkEe65+nsGYSVe80nIsYwDv0eFlMvWG2VbM8gZmqo6RBi4cDGTSJVhjgKmfNQxHSAflr0yAfzDNrYIYLshzXtawPhj0EdPZEWiW5BV1rLbUSsZpbWlZpf+XsB78ZeIi2EQIaXzPllNfsLxiIJgbykUmsAug/tDV/LOLUCpACyqRyf1BmW7Q86BCm7HL+xSz9QD3UcKZvK7x5vjK8qLXk4S/qJvXRimuvM7041qjTQ+AKrkynL1h19Nbd29x48PmQiK2FTIOTuWqKxr4FFIe5hNrwyYHVU82yXkdaz0sLkWP3BbAzg+xrKwUp6vkVT4KeOX+QLGsRNIq

On Tue, 28 Jul 2026 17:44:21 +0800
Baolin Liu <liubaolin12138@163.com> wrote:

> diff --git a/include/trace/events/ntfs3.h b/include/trace/events/ntfs3.h
> index d00f66e42ba8..041455edec76 100644
> --- a/include/trace/events/ntfs3.h
> +++ b/include/trace/events/ntfs3.h
> @@ -80,6 +80,50 @@ TRACE_EVENT(ntfs3_log_replay,
>  		  __entry->size, __entry->initialized, __entry->err)
>  );
>  
> +TRACE_EVENT(ntfs3_lookup,
> +	TP_PROTO(struct inode *dir, struct dentry *dentry),
> +	TP_ARGS(dir, dentry),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)

dev_t is 4 bytes, you should move it after parent_ino as on 64 bit
machines, it will waste 4 bytes of space here.

> +		__field(unsigned long, parent_ino)
> +		__string(name, dentry->d_name.name)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = dir->i_sb->s_dev;
> +		__entry->parent_ino = dir->i_ino;
> +		__assign_str(name);
> +	),
> +	TP_printk("dev=(%d,%d) parent=%lu name=%s",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->parent_ino, __get_str(name))
> +);
> +
> +TRACE_EVENT(ntfs3_rename,
> +	TP_PROTO(struct inode *dir, struct dentry *dentry,
> +		 struct inode *new_dir, struct dentry *new_dentry),
> +	TP_ARGS(dir, dentry, new_dir, new_dentry),
> +	TP_STRUCT__entry(
> +		__field(dev_t, dev)

Same here.

In fact, you should audit the rest of your tracepoints to see where you can
make the sizes more condensed.

~# cat /sys/kernel/tracing/events/ntfs3/ntfs3_rename/format 
name: ntfs3_rename
ID: 1923
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:dev_t dev;        offset:8;       size:4; signed:0;
        field:unsigned long dir_ino;    offset:16;      size:8; signed:0;
        field:unsigned long new_dir_ino;        offset:24;      size:8; signed:0;
        field:unsigned long ino;        offset:32;      size:8; signed:0;
        field:__data_loc char[] old_name;       offset:40;      size:4; signed:0;
        field:__data_loc char[] new_name;       offset:44;      size:4; signed:0;


Notice that dev is at offset 8 and size 4, where as dir_ino is at offset
16. That means there's 4 bytes between dev and dir_ino.

Please look at your other trace events and see if there are other gaps you
can close. I'm not going to audit all your tracepoints.

Note that __string() is a 4 byte meta data, so have them act like 4 byte
fields.

-- Steve



> +		__field(unsigned long, dir_ino)
> +		__field(unsigned long, new_dir_ino)
> +		__field(unsigned long, ino)
> +		__string(old_name, dentry->d_name.name)
> +		__string(new_name, new_dentry->d_name.name)
> +	),
> +	TP_fast_assign(
> +		__entry->dev = dir->i_sb->s_dev;
> +		__entry->dir_ino = dir->i_ino;
> +		__entry->new_dir_ino = new_dir->i_ino;
> +		__entry->ino = d_inode(dentry)->i_ino;
> +		__assign_str(old_name);
> +		__assign_str(new_name);
> +	),
> +	TP_printk("dev=(%d,%d) dir=%lu new_dir=%lu ino=%lu old=%s new=%s",
> +		  MAJOR(__entry->dev), MINOR(__entry->dev),
> +		  __entry->dir_ino, __entry->new_dir_ino, __entry->ino,
> +		  __get_str(old_name), __get_str(new_name))
> +);
> +
>  #endif /* _TRACE_NTFS3_H */
>  
