Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D84247285;
	Wed, 28 May 2025 14:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441539; cv=none; b=M9eRxxP2BX+ALaK+USdefzv14JpOTtcs+MCYXw1tRL5Mg/AvAU0CO6eZyuXFUPc8I7Esfs1wDHsGoU6Xvqyc4NjhnQE0a53oQxHkTb3bGahiIfG6dcVejD/LrUAwpL/XB4YJiufIkR7P9CH2ID8Jr3yXA3IhYe1N9UwmfbEKzKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441539; c=relaxed/simple;
	bh=oG4ypAGdLjwXhX+tqp2oG4fyMx5KH/HkGNDMrgscEHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh/kPGSba93b8+9RuXTT8qkDOseTbxIBfUNPfog5wCVz5FM99Bvgz0hi0kF8ycn3ntU6AEJVrslH6r41zBP4H6y9XnXxJb3zrIDUZDBPgtnurn2ll30DINGX2TdEzAofnbYwpUQijX4hGo+7r+tJxfYl2ziYKP+AwF9H97AYf28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA4AC4CEE3;
	Wed, 28 May 2025 14:12:18 +0000 (UTC)
Date: Wed, 28 May 2025 10:13:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: yebin <yebin@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 mark.rutland@arm.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, yebin10@huawei.com
Subject: Re: [PATCH 1/2] ftrace: fix UAF when lookup kallsym after ftrace
 disabled
Message-ID: <20250528101318.5ee12329@gandalf.local.home>
In-Reply-To: <68370E1D.3070802@huaweicloud.com>
References: <20250523083945.3390587-1-yebin@huaweicloud.com>
	<20250523083945.3390587-2-yebin@huaweicloud.com>
	<20250523135452.626d8dcd@gandalf.local.home>
	<6833C4F1.3030300@huaweicloud.com>
	<20250527094131.1f4a92ab@gandalf.local.home>
	<68370E1D.3070802@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 May 2025 21:22:37 +0800
yebin <yebin@huaweicloud.com> wrote:

> This problem can be solved by releasing the 'mod_map' resource when the 
> module is unloaded. Freeing up these resources is just an address that 
> cannot be translated into symbols, and there are no worse consequences.

OK, I'm fine with releasing the mod_map resource without doing the text
modifications.

> 
> > Again, the only solution to a ftrace_disable being set is a full reboot.
> >  
> We can't ask users to know such specialized details of the 
> implementation, which are unclear even to developers unfamiliar with the 
> ftrace module. Users can accept planned reboot system recovery, but 
> should not accept casual operations and the system crashes.All we can do 
> is do a good job of protection, give users more tolerance.Perhaps a 
> system that is dead but won't lie down is also a very undesirable 
> situation.However, ftrace is used to collect information and locate 
> faults. Even if it does not work, it does not affect services.In the 
> production environment, the most afraid of using ftrace suddenly crashes 
> the system.Therefore, the robustness of the tool itself is very important.

Preventing ftrace from crashing the system is the reason ftrace_disabled is
set and stops it from doing any more damage.

If you are worried about users not knowing that a reboot is necessary, we
could always add the "Dazed and confused, but trying to continue" message
that could also recommend a reboot.

> > -- Steve
> >  
> 
> I reworked the two patches, and the changes to the existing process 
> should be minimal. I don't know if I can get your approval. If you 
> agree, I'll post another V3 version.
> 
> PATCH[1/2]:
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 51580e54677f..b3436d86e470 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7438,9 +7438,10 @@ void ftrace_release_mod(struct module *mod)
> 
>          mutex_lock(&ftrace_lock);
> 
> -       if (ftrace_disabled)
> -               goto out_unlock;
> -
> +       /*
> +        * To avoid the UAF problem after the module is unloaded, the
> +        * 'mod_map' resource needs to be released unconditionally.
> +        */
>          list_for_each_entry_safe(mod_map, n, &ftrace_mod_maps, list) {
>                  if (mod_map->mod == mod) {
>                          list_del_rcu(&mod_map->list);
> @@ -7451,6 +7452,9 @@ void ftrace_release_mod(struct module *mod)
>                  }
>          }
> 
> +       if (ftrace_disabled)
> +               goto out_unlock;
> +
>          /*
>           * Each module has its own ftrace_pages, remove
>           * them from the list.

Yes, this is more appropriate.

Thanks,

-- Steve

> 
> PATCH[2/2]:
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index a3d4dfad0cbc..51580e54677f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7629,6 +7629,9 @@ allocate_ftrace_mod_map(struct module *mod,
>   {
>          struct ftrace_mod_map *mod_map;
> 
> +       if (ftrace_disabled)
> +               return NULL;
> +
>          mod_map = kmalloc(sizeof(*mod_map), GFP_KERNEL);
>          if (!mod_map)
>                  return NULL;

