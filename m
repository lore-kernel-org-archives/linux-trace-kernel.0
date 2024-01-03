Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11321C687
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fgZTsHjL"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cd0d05838fso22363831fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704305546; x=1704910346; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/OAdStb2L8zryYFpyn7IXiVtaAM2rtXpmPffWXoWPII=;
        b=fgZTsHjLIsPDQ3V2KPLBVak528BiwFoDkh6h+7/Kg+GD9QEOT92Pf78MQv+xNCNJcr
         GMvdQMnkkGhTPPL1AW26pjgqB/hNDRKeKEu17HUobH8zt9QhUZrp3MlgcymsRughFhb8
         jpYi04ftQOzYzbqTC1GLUiFzfjrdc+UoVF47E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704305546; x=1704910346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OAdStb2L8zryYFpyn7IXiVtaAM2rtXpmPffWXoWPII=;
        b=P3orONWCDIjLLJpBHsUA76ZSF1gTVdVFZc8vnHzERa/QX/74Oea8zdzaZRUafHIuBE
         KvrqJIeF3BromPp7yqPbeRJm6tthppfBPz7I7+3C8V865+Cn5GFEmcFuWrRYBCjG2n/4
         zEaADiIJJfLhbCm4AC2x4HiXAbJaG6VVoqxdMiGesWqStfjoqwVNT2JTs7iC7Om4JRA7
         AbnGWta6hgYbkCVruomVdbT70QVcwyCWPizXaNovXUbyhL2H24SqUqr+XbTCti1ERBuZ
         fQN/gGH9//UFh88v2mv2G2O0orIw725v/6tXsLHKwgRofAnXUkxvEkTnNMJ2STlraMiG
         QwtQ==
X-Gm-Message-State: AOJu0YzvEs1LPAl4aHBy0riqsoxyWheyBAiZVc+GRiMstRtbVJlH8sFr
	E6uYrrLyegOU0dog17ICgI/U9CzreuTRvTBZ6piaEua57G3+xVY0
X-Google-Smtp-Source: AGHT+IHJnvlqefsfuM/03VqQl4iOqfz8A+ZRVuwcTYnTZIQF4hEbbOABMIqxXBSRMHCj7V9ucWWOPA==
X-Received: by 2002:a2e:8686:0:b0:2cc:843a:eca2 with SMTP id l6-20020a2e8686000000b002cc843aeca2mr7270139lji.20.1704305546574;
        Wed, 03 Jan 2024 10:12:26 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7de89000000b00555ad8fa1a5sm8001925edv.53.2024.01.03.10.12.25
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 10:12:26 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55642663ac4so3034948a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:12:25 -0800 (PST)
X-Received: by 2002:a17:906:5a5c:b0:a23:6708:cdd0 with SMTP id
 my28-20020a1709065a5c00b00a236708cdd0mr6801033ejc.88.1704305545696; Wed, 03
 Jan 2024 10:12:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home>
In-Reply-To: <20240103102553.17a19cea@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 10:12:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
Message-ID: <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 07:24, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Instead, just have eventfs have its own iterate_shared callback function
> that will fill in the dent entries. This simplifies the code quite a bit.

Much better. Now eventfs looks more like a real filesystem, and less
like an eldritch horror monster that is parts of dcache tackled onto a
pseudo-filesystem.

However, one request, and one nit:

> Also, remove the "lookup" parameter to the create_file/dir_dentry() and
> always have it return a dentry that has its ref count incremented, and
> have the caller call the dput. This simplifies that code as well.

Can you please do that as a separate patch, where the first patch just
cleans up the directory iteration, and the second patch then goes "now
there are no more callers that have the 'lookup' argument set to
false".

Because as-is, the patch is kind of two things mixed up.

The small nit is this:

> +static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  {
> +       /*
> +        * Need to create the dentries and inodes to have a consistent
> +        * inode number.
> +        */
>         list_for_each_entry_srcu(ei_child, &ei->children, list,
>                                  srcu_read_lock_held(&eventfs_srcu)) {
> -               d = create_dir_dentry(ei, ei_child, parent, false);
> -               if (d) {
> -                       ret = add_dentries(&dentries, d, cnt);
> -                       if (ret < 0)
> -                               break;
> -                       cnt++;
> +
> +               if (ei_child->is_freed)
> +                       continue;
> +
> +               name = ei_child->name;
> +
> +               dentry = create_dir_dentry(ei, ei_child, ei_dentry);
> +               if (!dentry)
> +                       goto out;
> +               ino = dentry->d_inode->i_ino;
> +               dput(dentry);
> +
> +               if (c > 0) {
> +                       c--;
> +                       continue;
>                 }

Just move this "is the position before this name" up to the top of the
loop. Even above the "is_freed" part.

Let's just always count all the entries in the child list.

And same for the ei->nr_entries loop:

>         for (i = 0; i < ei->nr_entries; i++) {

where there's no point in creating that dentry just to look up the
inode number, only to then decide "Oh, we already iterated past this
part, so let's not do anything with it".

This wouldn't seem to matter much with a big enough getdents buffer
(which is the normal user level behavior), but it actually does,
because we don't keep track of "we have read to the end of the
directory".

So every readdir ends up effectively doing getdents at least twice:
once to read the directory entries, and then once to just be told
"that was all".

End result: you should strive very hard to *not* waste time on the
directory entries that have already been read, and are less than
'ctx->pos'.

             Linus
