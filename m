Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F191A70F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lKZE3AaI"
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F210B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:03:43 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-4584e93ca8bso2062094137.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 14:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698699822; x=1699304622; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=crwNbqxR7nPOodoWp7WUIXqNMkXcMnjDYt1yU/ik8o4=;
        b=lKZE3AaITXAyrxY3lwszx2239avcI3TT1dr+PD6c4bQ3H0mQnLwrbIQ8QnYCoRdB2z
         yCVQ6Z5AgsmFmiBoDWrX4p8FuWcmefM+h5Y0s9DNUzm/GfxGry/3jOEsTPoj8XRWgaqX
         xMb8SSqqiUX6BNjmJSQqa+1q30IMPHxziX1Tv6l0k9Yz79a5u/2QPwEiZ2Tt2NQrpNHl
         LqJkdPWwI4uFP7f7f50sfiugrT2DJqhZJkKmcD1nGHcLm2MMkv8XJcoh/lXpkeW3FcbD
         1isgpp0G++iS0l3KnMdBjsZr8GGmUSnDhu9J1Ed0TKCNlOWCSgU+c6qe+KBM2aiTt09f
         4BYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698699822; x=1699304622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crwNbqxR7nPOodoWp7WUIXqNMkXcMnjDYt1yU/ik8o4=;
        b=O5NRJEiSS8VkPc934cNcSkt4gk/2IE0o52ohpJxg3ruC9meKxAK6C5H2GQqdWC4RV1
         7B/qxrJozVah3JpoKs20iQdGIusSC+pI6STMvH8/EnX72Ky2JKA2e3f4nvV1qUbRjj5i
         XSrrPLX7VwrUQyOxoObVKjY3HkaQ3dYiEUYUu0TWRuq5bxUbTA0rBywiXD8sPfiK47RB
         Vhf5gH1A+GzcYNPzDnTROUzb8NXQEu38vjophku8nDuBaI4me7zUiCUvDYJZ+L24fxOw
         kdRw/V+L/3WV8+iox+0RG0kJPInCXpEpFNjxRpCB0ah4QdmcAa7J0/8G95k3atMIwAA1
         yUwA==
X-Gm-Message-State: AOJu0YyYF+7NO17XlD7KcrfsmPvz2EJtk6kVrMq0xvpr+r2Wf+uD3fj+
	eXeT+I/6kesIlvsYJ3glt4exOqyj7Ta8+8J1c+77/2JpeYzefkJY/E5t0A==
X-Google-Smtp-Source: AGHT+IE27AtGQAnI6mD9u8wH2PTCU0NScHW3t3xIQ53Au2GwdiVTo0h7dvbMpnuD1si3WLIMeYny0lkRKxY1fVBW5Hs=
X-Received: by 2002:a67:c295:0:b0:458:11dd:87aa with SMTP id
 k21-20020a67c295000000b0045811dd87aamr10199144vsj.22.1698699822074; Mon, 30
 Oct 2023 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028164650.4f5ea18a@rorschach.local.home> <CA+G9fYsL=wK_rn8ovCHtn6QXrvzv0a67oj9U3u6r9i-dxjsqwQ@mail.gmail.com>
 <20231029091408.0179cee4@rorschach.local.home> <CA+G9fYu9GOEbD=rR5eMR-=HJ8H6rMsbzDC2ZY5=Y50WpWAE7_Q@mail.gmail.com>
 <20231030104127.6f32c932@gandalf.local.home>
In-Reply-To: <20231030104127.6f32c932@gandalf.local.home>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 31 Oct 2023 02:33:29 +0530
Message-ID: <CA+G9fYuTGmjQZM4x28yWREnKVd7Q0iNt4mSoCZa0L62MgUEV3w@mail.gmail.com>
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing ei->dentry
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
	"Naresh Kamboju <naresh.kamboju@linaro.org>, Beau Belgrave <beaub@linux.microsoft.com>, Ajay Kaher <akaher@vmware.com>, Andrew Morton" <akpm@linux-foundation.org>, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Oct 2023 at 20:11, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 30 Oct 2023 12:37:08 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> >
> > I have tested the linux-trace.git trace/core and run selftests ftrace
> > the reported kernel panic [1] & [2] has been fixed but found
>
> Good to know. Can I add "Tested-by" from you for that bug fix?

Please add,
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>

>
> > "general protection fault"  at  kernel/trace/trace_events.c:2439.
>
> Can you test with the below patch?

Applied this patch on top of linux-trace.git trace/core and test passed.
All the reported issues have been resolved.

>
> Also, can I ask what are you testing this on that makes it trigger so
> easily? As I'm not able to trigger these in my tests, even though they are
> indeed bugs.

I use following build artifacts and running selftests: ftrace: ftracetest-ktap

   kernel:
      url:
        https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/bzImage
    modules:
      url:
        https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/modules.tar.xz
      compression: xz
    nfsrootfs:
      url: https://storage.tuxboot.com/debian/bookworm/amd64/rootfs.tar.xz
 kselftest:
          url:
            https://storage.tuxsuite.com/public/linaro/naresh/builds/2XT84xYJIMmKApmqOOtKhnLdCyz/kselftest.tar.xz


Steps to test:
==========

1) Boot x86 machine with above bzImage, modules, rootfs and
copy kselftest.tar.xz from above url and unzip.
2) cd /opt/kselftests/default-in-kernel/ftrace
3) ./run_kselftest.sh  -c ftrace


# selftests: ftrace: ftracetest-ktap
# unlink: cannot unlink
'/opt/kselftests/default-in-kernel/ftrace/logs/latest': No such file
or directory
# TAP version 13
# 1..129
# ok 1 Basic trace file check
...
# # Totals: pass:126 faii:0 xfail:1 xpass:0 skip:1 error:1


Test logs:
https://lkft.validation.linaro.org/scheduler/job/6985018#L4742




>
> -- Steve
>
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 7ad7496bd597..7a0b54ddda24 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -609,7 +609,13 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>                 entry = &ei->entries[i];
>                 if (strcmp(name, entry->name) == 0) {
>                         void *cdata = data;
> -                       r = entry->callback(name, &mode, &cdata, &fops);
> +                       mutex_lock(&eventfs_mutex);
> +                       /* If ei->is_freed, then the event itself may be too */
> +                       if (!ei->is_freed)
> +                               r = entry->callback(name, &mode, &cdata, &fops);
> +                       else
> +                               r = -1;
> +                       mutex_unlock(&eventfs_mutex);
>                         if (r <= 0)
>                                 continue;
>                         ret = simple_lookup(dir, dentry, flags);
> @@ -743,7 +749,13 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
>                 void *cdata = data;
>                 entry = &ei->entries[i];
>                 name = entry->name;
> -               r = entry->callback(name, &mode, &cdata, &fops);
> +               mutex_lock(&eventfs_mutex);
> +               /* If ei->is_freed, then the event itself may be too */
> +               if (!ei->is_freed)
> +                       r = entry->callback(name, &mode, &cdata, &fops);
> +               else
> +                       r = -1;
> +               mutex_unlock(&eventfs_mutex);
>                 if (r <= 0)
>                         continue;
>                 d = create_file_dentry(ei, i, parent, name, mode, cdata, fops, false);
