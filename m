Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B91D522
	for <linux-trace-kernel@vger.kernel.org>; Sat,  9 Dec 2023 14:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F8FC433C8;
	Sat,  9 Dec 2023 14:49:26 +0000 (UTC)
Date: Sat, 9 Dec 2023 09:49:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: trace_event names with more than NAME_MAX chars
Message-ID: <20231209094924.3996dfb8@rorschach.local.home>
In-Reply-To: <20231208183601.GA46-beaub@linux.microsoft.com>
References: <20231208183601.GA46-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 18:36:01 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> While developing some unrelated features I happened to create a
> trace_event that was more than NAME_MAX (255) characters. When this
> happened the creation worked, but tracefs would hang any task that tried
> to list the directory of the trace_event or remove it.
> 
> I followed the code down to the reason being eventfs would call
> simple_lookup(), and if it failed, it would still try to create the
> dentry. In this case DCACHE_PAR_LOOKUP would get set and never cleared.
> This caused d_wait_lookup() to loop forever, since that flag is used in
> d_in_lookup().
> 
> Both tracefs and eventfs use simple_lookup() and it fails for
> dentries that exceed NAME_MAX. Should we even allow trace_events to
> be created that exceed this limit? Or should tracefs/eventfs allow
> this but somehow represent these differently?

Yeah I think it's easiest to just prevent dentries from exceeding
NAME_MAX, and yes the patch below should be added. Care to send a real
patch?

Thanks,

-- Steve


> 
> I have a fix that appears to work for myself, but unsure if there are
> other locations (attached at the end of this mail).
> 
> Thanks,
> -Beau
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index f8a594a50ae6..d2c06ba26db4 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -561,6 +561,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>                 if (strcmp(ei_child->name, name) != 0)
>                         continue;
>                 ret = simple_lookup(dir, dentry, flags);
> +               if (IS_ERR(ret))
> +                       goto out;
>                 create_dir_dentry(ei, ei_child, ei_dentry, true);
>                 created = true;
>                 break;
> @@ -583,6 +585,8 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>                         if (r <= 0)
>                                 continue;
>                         ret = simple_lookup(dir, dentry, flags);
> +                       if (IS_ERR(ret))
> +                               goto out;
>                         create_file_dentry(ei, i, ei_dentry, name, mode, cdata,
>                                            fops, true);
>                         break;

