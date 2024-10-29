Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD932040A1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Oct 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730237633; cv=none; b=d1GjQRh/D2qEyHxbqxvsbE+Qt6Wl+vY8VfX4LC9h/2mhDkpkoi1aPZSnxGLs+2Q0I9RqVNln2g0WVOjtwbFa1SFZYawVGKCBxJF6P/sjiDopSNHfohF2dImHmvDleN8qdwGbBPwTW1vu/N5h6XGBbi0mz0cefZh729b2xtqFXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730237633; c=relaxed/simple;
	bh=h+puN0fhqWblaJnsZw9q5nmFY1+4n5wVKrQtRnvjDf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNZfe6ZE9DpIuAZ217FqNuQFvvPTZZ9J3H8lCYPPL2CvSwDQbbZSrH7Ct0Uh7fBn0wqxFKh0enzB/oFr2cPwb62PABhsvYxy/v2t2yMaqsTDoJat+YUCX7RoLG+U9URVN/E5wd/5Ym6lqq9cFbzPZvajgxU+j9sfRwuHO0j+LjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BNyoF1wb; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNyoF1wb"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539e681ba70so4477e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Oct 2024 14:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730237628; x=1730842428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZLCevXoJGaR8oKfiYoaHQvhcyK6u+L88OrvNrE2LLbA=;
        b=BNyoF1wbleE66/xgDAqCHqo/h2UJFNBJFEtgQ0Y0U+U3hnkqC5hmrEkBLvedVdJ9mS
         Z111GU336U8LhEXvlpeUSDXN5x1V+8d+rdCczsKwbpezkrrOh6tiYaHwR3mhjfRO+B90
         S55osjzp9wwFOz37FCedyhXKS+VJbeGlG0bm5AS7SGYoe9ZpVylPs2f7acusUsKK+0o5
         6/Mo5Y6BQPeoYuXFTDei0n+cU5pfTJjxfx067qSxz5G6lSbxYvx5XdomKt8U+JI8tXgI
         nT10QYvhgOLe4GjJCzzUWlTk5j6e17Bjrv7hllxCva3xruEChdpwjIJ/iGFtFQR/9L3g
         Bptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730237628; x=1730842428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLCevXoJGaR8oKfiYoaHQvhcyK6u+L88OrvNrE2LLbA=;
        b=MKpeAW2YZt6lm0ED8X+jNPx8U34jRJUdO799sR6V/CpcE8iPRJJkdwTSwJrvh3pHog
         4a5Eiq9TRF0MbyJJJq8wZ4a1wYqe0ymIa7Jp/zP6BD3h15VgxF1fX3+ecQxJEVY+uD1K
         jtqgWxCuCV4Dx8XEtAjmpXZbBQ8W0t4vGS6tej7ybjNf6YhiKzOCWPvxRXPP+r/Xp0ml
         f4JdsobI89NojFTBB/HFATaHMBWdpxQdS4hqqhpu1TlS7G9kWhDdKhZKu5GA3XlylaKj
         L7qzGqvb8RGT4P6ZHfQ/Gqn5riJla2jysy1bKywMkqzvL7oqSl06VdR1WZ2OheWjBBUV
         fZ8g==
X-Forwarded-Encrypted: i=1; AJvYcCXlSaH+csNr0BzexNYDVFOqaAzDeV/mCSThAy0Lvv4nRnUdnu9oWHHWK2kxOBCGnBUGb3ni5fqVLIHty4yATgvyLj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGeymxnh0joKRPyBZ79tgMHnCE6JHbGWJl72OUdIoqIFErM96M
	I2R3U16DvuvANw58FfnKZkLROZa18qhMzdrfSBXlz8w5JTL8BoQvMk43wpB/Mvlfiqb7SjBroY8
	kzXGQ2ufsZVZXAP5Vf7stnUPwsufh8W5F5SJf
X-Gm-Gg: ASbGncvQ1GoASKoqBwsAz3PVpfrLcI8ffjWmI1H8Jey5F2fAA8s4T/Yp+cbAINDoBkM
	huxGkKQ92P9zoAWURELF8RrU6eWBUa1qJQdcnGxAWpA5DtRHMUkhNuU9BvZXsvw==
X-Google-Smtp-Source: AGHT+IGYEgSe/xaLttCW468YzyVt+PJSqrl2F1hKgdaEVJVyCsWJcWbraB6StYd3H9kULin2IaXyAhjjioQjPAzPjxY=
X-Received: by 2002:a05:6512:138c:b0:539:d0c4:5b53 with SMTP id
 2adb3069b0e04-53b480a3611mr660213e87.4.1730237627739; Tue, 29 Oct 2024
 14:33:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-4-kaleshsingh@google.com> <bbbbaa42-444f-4973-b749-7c56b937ae5f@redhat.com>
In-Reply-To: <bbbbaa42-444f-4973-b749-7c56b937ae5f@redhat.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 29 Oct 2024 14:33:35 -0700
Message-ID: <CAC_TJveyKz5be6tVr9J_P32g2cVWAOs2eaQVi4Yrx6ATfb==nQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing: Fix tracefs gid mount option
To: Eric Sandeen <sandeen@redhat.com>
Cc: dhowells@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	surenb@google.com, jyescas@google.com, kernel-team@android.com, 
	android-mm@google.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Shuah Khan <shuah@kernel.org>, Ali Zahraee <ahzahraee@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 8:00=E2=80=AFPM Eric Sandeen <sandeen@redhat.com> w=
rote:
>
> On 10/28/24 4:43 PM, Kalesh Singh wrote:
> > Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> > tracefs to use the new mount APIs caused mounting with the gid=3D<gid>
> > option to not take effect.
>
> Or any other mount options. I'm sure this isn't unique to gid, right?
> So, might want to fix the commit title.

Hi Eric,

You are right, they same applies to any of the mount options. I'll
update the commit text for v2.

>
> > The tracefs superblock can be updated from multiple paths:
> >     - on fs_initcall() to init_trace_printk_function_export()
> >     - form a work queue to initialize eventfs
> >       tracer_init_tracefs_work_func()
> >     - fsconfig() syscall to mount of remount sysfs
> >
> > The tracefs super block root inode gets created early on in
> > init_trace_printk_function_export().
> >
> > With the new mount API tracefs effectively uses get_tree_single() inste=
ad
> > of the old API mount_single().
> >
> > Previously, mount_single() ensured that the options are alway applied t=
o
> > the superblock root inode:
> >     (1) If the root inode didn't exist, called fill_super() to create i=
t
> >         and apply the options.
> >     (2) If the root inode exists, called reconfigure_single() which
> >         effectively called tracefs_apply_options() to parse and apply
> >         options to the subperblock's fs_info and inode and remount
> >         eventfs (if necessary)
> >
> > On the other hand, get_tree_single() effectively calls vfs_get_super()
> > which:
> >     (3) If the root inode doesn't exists calls fill_super() to create i=
t
> >         and apply the options.
> >     (4) If the root inode already exists, updates the fs_context root
> >         with the superblock's root inode.
>
> I'm honestly a little lost here, but given the differences between mount_=
single()
> and get_tree_single() - are other get_tree_single() users similarly broke=
n?
>

I'm not sure if other filesystems are broken in the same way. The
issue happened for tracefs due to the fact that the sb root is created
before  calling mount -- from init_trace_printk_function_export(). If
there are other filesystems that have similar early initialization
(before mount) they may be broken as well.

> Should get_tree_single() just be calling reconfigure_single() internally =
like
> mount_single() did? The comment in reconfigure_single() confuses me.
>
> > (4) above is always the case for tracefs mounts, since the super block'=
s
> > root inode will already be created by init_trace_printk_function_export=
().
>
> this reminds me a little of
>
> commit a6097180d884ddab769fb25588ea8598589c218c
> Author: NeilBrown <neilb@suse.de>
> Date:   Mon Jan 17 09:07:26 2022 +1100
>
>     devtmpfs regression fix: reconfigure on each mount
>

Interesting, yes it seems like the same root cause. i.e. devtmpfs sb
root is created early on from  kernel_init() .... --> driver_init()
---> devtmpfs_init() which setups up the root inode for devtmpfs in
shmem_get_tree() ... -> vfs_get_super(); which is the case (4),
meaning that it would have ignored the options on mount for the same
reason: the superblock root indoe already exists.

I'm not very familiar with the filesystem area. If this is a common
scenario, maybe there needs to be a separate API to handle this case?


> > This means that the gid mount option gets ignored:
> >     - Since it isn't applied to the super block's root inode, it doesn'=
t
> >       get inherited by the children.
> >     - Since eventfs is initialized from form a separate work queue and
> >       before call to mount with the options, and it doesn't get remount=
ed
> >       for mount.
> >
> > Ensure that the mount options are applied to the super block and eventf=
s
> > is remounted to respect the new mount options.
> >
> > [1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redh=
at.com/
> >
> > Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> > Cc: David Howells <dhowells@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  fs/tracefs/inode.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index 1748dff58c3b..cfc614c638da 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *f=
c)
> >       struct tracefs_fs_info *sb_opts =3D sb->s_fs_info;
> >       struct tracefs_fs_info *new_opts =3D fc->s_fs_info;
> >
> > +     if (!new_opts)
> > +             return 0;
>
> Can this really happen?

From init_trace_printk_function_export() the first time the super
block is allocated and added to file_system_type->fs_supers;
fc->s_fs_info is reset to NULL. [1]. I think that is ok since the
fs_info would have already been copied to the super block. [2]


See sget_fc():

[1] https://github.com/torvalds/linux/blob/v6.12-rc4/fs/super.c#L774
[2] https://github.com/torvalds/linux/blob/v6.12-rc4/fs/super.c#L766


--Kalesh
>
> > +
> >       sync_filesystem(sb);
> >       /* structure copy of new mount options to sb */
> >       *sb_opts =3D *new_opts;
>
> FWIW doing this as a structure copy was probably a terrible choice on my =
part. :(
>
> > @@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block =
*sb, struct fs_context *fc)
> >       sb->s_op =3D &tracefs_super_operations;
> >       sb->s_d_op =3D &tracefs_dentry_operations;
> >
> > -     tracefs_apply_options(sb, false);
> > -
> >       return 0;
> >  }
> >
> >  static int tracefs_get_tree(struct fs_context *fc)
> >  {
> > -     return get_tree_single(fc, tracefs_fill_super);
> > +     int err =3D get_tree_single(fc, tracefs_fill_super);
> > +
> > +     if (err)
> > +             return err;
> > +
> > +     return tracefs_reconfigure(fc);
> >  }
> >
> >  static void tracefs_free_fc(struct fs_context *fc)
>
