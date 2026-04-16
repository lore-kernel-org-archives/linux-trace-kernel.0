Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78239A07D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367506; cv=pass; b=nvRRdjBRQbaMvj/O/kJOP3XYe3Rg1bwgXSs2gEz1brnac75loJIFcx0bbmwVPDiKcw1x2tRLNPYpwBgIzCRyIdKPu4UkL3ELJ+/h2AuODImnsIqLSmd6o7D4/fW+tlySPUS3C2DT+3Fcs7TyUwu3oWH3zs9wBKuMHWUDmygJEyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367506; c=relaxed/simple;
	bh=YTWAuUgodP4x0SGZZNXpfJHoOQ/Al8dOyWsalMJbeKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jm2CyEBc3TvhuJgA8/qFLihna9idTU2ql257CAyX/egM6uAMHgUIF56mTFFCOqEcyWyh3NCoPPBn62rSladAVHYs7qQmwFaFTY4CsEEmpXACYWAYGUbMqH7quUmiFbGL83bmHw8ohr0OrIswVzLePrfheWOvhabqt9gvHP6ENQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuvgudHs; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuvgudHs"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9d6c8871c7so1293705666b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Apr 2026 12:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776367496; cv=none;
        d=google.com; s=arc-20240605;
        b=AFGNI5F36uCGcz93H276G12zDWpFLZhE+eKyW/mR1bEZ4DDKkjXGj3+wOhfKKwvfhJ
         y08GTVw8KB4NG6UCca+1IEzvzj/I9G76yGAZxcxk5Lr6dnvusteIbe9YC/1nlRv8SxfI
         z3DSArZBm6YsHex/p2TsXWzVOqVT1cM35KInhFIS88ae9APXXwbVC4PwIlzScNWrL4ii
         6A4fm9wddMg5nmv/kldch5bAa1rhsF7KJTgtjMk17nujQ+/xLAs1PFKV2NxuYa9OgC6L
         Qu83Tgy6l2klVtBme9TekzaQV0BgElsHZaT5XpNtOiEjRXTE+mCmB9VvNpO5NMuZz8fM
         sYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        fh=KWtDTExJdGGP1yfF54H8OYWmftEmoDyjRHn/2tcsfS4=;
        b=ZwYcu05GgWtVIymELX+Sslx82MXVTsxrLLjTRkq8fTCWhEj2Bl62Pus1cyMH/sr8VZ
         KFubRCHqCUAS3bw9+nA7EfY9zyYMY71/xBFfrRRwQ7Tr3f4S6YoKFqqusuIW5vsBKYq2
         hzGX0D7F6/f3+cNfTfX6dZx8FGJ8azaSCI3YOPro9K2RjTYDtpHxJKiILbqdvihXPt0s
         VilF+kqBYZEgG8xo3uWhaZH+wk7vxrWJ2+mhiG3eftrkYyYm/STV4CT+OrpilLRVJNMq
         XmanrGnWbcoUqOjDxrzvmZfn6Xe0nJS7JPP5JcMfsIVmLq8j3F/w1hY08W+xkap5zn/Y
         pnnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776367496; x=1776972296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        b=IuvgudHss3pf9xta9CoHzbNM/KkqwvVlbZG1ujAPlUvsEERquMRMCcNKuZB4ePTAM5
         7NtHkTfv5kJNgOXozHtBzx6BeOftPECAFzrLC/Kx+7C6Z+aMX16BAnXG4S26OUfk3WGg
         CWZQvHirIm8BMV/eAS7dQVd+snAopqjN+dWq8LBfZchgH0SFAJBxKZ7twV1lroXi7RqL
         6seCdSS2mS6a+aqyWvZotzTjBpSsVqzQV/ddt5/cyYwOEsyfwdY8ZTvZnZXvtx6xF+FO
         5LV2B5eGbqXEDNgAZKrrj0OIGOZ6Vfb9iUPXy8OI0AkX/Cx2xeQJhF/vFCWfKeI7U4O9
         g8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367496; x=1776972296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9K3ysuZXV4OKgvP6Hz+tr/FztQIKDGUmUgbaHLYQ4fs=;
        b=CIjbb5F7S1d7rsBnEXs7y0sXd/tSSseN8IxQjgS7klBoEnvIV31h/anNKCleVGPx4Z
         FGN9TPHQaBwaIxIWxgjj1nXa79WS8fF+9iJV5aZHQO/8ZvaO+EOjl0DiVKzSw2iRsuaO
         kiBRNSkKCLnilXQbr6I0ZhD5kXKkLhJ2vE55Ca0ajkM+cneqACEBWW02Q6QDtwtsTiv3
         8Spd/iAlHSH8po18EMwNuF59S+2Yuq/pENdWbkBNRcf1cbsaZ/3hncA333bnpfCcchNW
         nHTcPwiAc+Cxrf3Z7uEf4TeXtCWwZBFo5ufnHK1K5hO1DzCXG3wkV+lcCnSfXPlb/Swf
         TZ5w==
X-Forwarded-Encrypted: i=1; AFNElJ/M2tSZVlRQJUM9nGibKgcKESjf2UC8lFXSsnHfThq/MPWxHJAdWAbL5X23jiZyXSpPCx6Xkd83mM7hUxGzyAvbxl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1JE4LgSKlAyVHteZ7XEZb6f6zFR88M3DEr1nNjSzxg8lCI4zI
	4VFsKnYBOlCOy1RGcD0jyc3GVPF7Fn3k2BvR5+ASgAt/ZXQaNDnLB3NR2WOStUKOeOAD+kGrofM
	GUYFIRqycoj6uzJkCE0VyF/KuG3hzgQU=
X-Gm-Gg: AeBDietYPJbmwdhaVDQjaXzFuf8aCACEhRSuLDSS3nCCnQtlFL8igJY/AaZTAWyBplC
	PKrOhIxZ/IVrnJD5rijnU8lsFWgjqBUvrP43LvyN1Lqljvz99cCvwvCEeaCrHJjaaBYZZsEJ6E6
	CIDk2cbcMSCvuIm61+d4V4SlXSnEjK0xYWonnRcoN1Aq5fSeVB9sVQooZNj6pUNYgJZW6tvyEbu
	hO9p0MmANv18raCrxV7MpOBoNoYCd2SxutBWA9MWRqFT4+trOyQWc13JLOrthOL8kN0ANLRvigN
	FFb4EhqFODY01olpX07jF2dkl00bXzUPHrQ4RhCk4evcvdQ3kTh1ldrG3BeF2N4=
X-Received: by 2002:a17:907:c002:b0:b9c:34f8:b969 with SMTP id
 a640c23a62f3a-ba3dd6a4727mr34562766b.49.1776367495571; Thu, 16 Apr 2026
 12:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416-dir-deleg-v2-0-851426a550f6@kernel.org> <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
In-Reply-To: <20260416-dir-deleg-v2-7-851426a550f6@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 16 Apr 2026 21:24:44 +0200
X-Gm-Features: AQROBzDkNbo1A8vs3cuxkYPYXRSUZziZymY7H6-6on9ynU_2C3mPiqqxTu3HE2k
Message-ID: <CAOQ4uxg2jHxCi77A1DGtopjZHsTNg4etdboW2GjL85N3uc_KqQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/28] fsnotify: add FSNOTIFY_EVENT_RENAME data type
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Alexander Aring <alex.aring@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Calum Mackay <calum.mackay@oracle.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:35=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> Add a new fsnotify_rename_data struct and FSNOTIFY_EVENT_RENAME data
> type that carries both the moved dentry and the inode that was
> overwritten by the rename (if any).
>
> Update fsnotify_data_inode(), fsnotify_data_dentry(), and
> fsnotify_data_sb() to handle the new type, and add a new
> fsnotify_data_rename_target() helper for extracting the overwritten
> target inode.
>
> Update fsnotify_move() to use the new data type for FS_RENAME and
> FS_MOVED_TO events, passing the overwritten target inode through the
> event data. FS_MOVED_FROM is unchanged since the source directory
> doesn't need overwrite information.
>
> This is done so that fsnotify consumers like nfsd can atomically
> observe the overwritten file when a rename replaces an existing entry,
> without needing a separate FS_DELETE event.
>
> Assisted-by: Claude (Anthropic Claude Code)
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  include/linux/fsnotify.h         |  8 ++++++--
>  include/linux/fsnotify_backend.h | 20 ++++++++++++++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)

It is strange to me that the NFS protocol needs to report the overwritten
node in the same event of the rename, but oh well, fine by me.

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 079c18bcdbde..bda798bc67bc 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -257,6 +257,10 @@ static inline void fsnotify_move(struct inode *old_d=
ir, struct inode *new_dir,
>         __u32 new_dir_mask =3D FS_MOVED_TO;
>         __u32 rename_mask =3D FS_RENAME;
>         const struct qstr *new_name =3D &moved->d_name;
> +       struct fsnotify_rename_data rd =3D {
> +               .moved =3D moved,
> +               .target =3D target,
> +       };
>
>         if (isdir) {
>                 old_dir_mask |=3D FS_ISDIR;
> @@ -265,12 +269,12 @@ static inline void fsnotify_move(struct inode *old_=
dir, struct inode *new_dir,
>         }
>
>         /* Event with information about both old and new parent+name */
> -       fsnotify_name(rename_mask, moved, FSNOTIFY_EVENT_DENTRY,
> +       fsnotify_name(rename_mask, &rd, FSNOTIFY_EVENT_RENAME,
>                       old_dir, old_name, 0);
>
>         fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
>                       old_dir, old_name, fs_cookie);
> -       fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
> +       fsnotify_name(new_dir_mask, &rd, FSNOTIFY_EVENT_RENAME,
>                       new_dir, new_name, fs_cookie);
>
>         if (target)
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 66e185bd1b1b..f8c8fb7f34ae 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -311,6 +311,7 @@ enum fsnotify_data_type {
>         FSNOTIFY_EVENT_DENTRY,
>         FSNOTIFY_EVENT_MNT,
>         FSNOTIFY_EVENT_ERROR,
> +       FSNOTIFY_EVENT_RENAME,
>  };
>
>  struct fs_error_report {
> @@ -335,6 +336,11 @@ struct fsnotify_mnt {
>         u64 mnt_id;
>  };
>
> +struct fsnotify_rename_data {
> +       struct dentry *moved;   /* the dentry that was renamed */
> +       struct inode *target;   /* inode overwritten by rename, or NULL *=
/
> +};
> +
>  static inline struct inode *fsnotify_data_inode(const void *data, int da=
ta_type)
>  {
>         switch (data_type) {
> @@ -348,6 +354,8 @@ static inline struct inode *fsnotify_data_inode(const=
 void *data, int data_type)
>                 return d_inode(file_range_path(data)->dentry);
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *)data)->inode;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return d_inode(((const struct fsnotify_rename_data *)data=
)->moved);
>         default:
>                 return NULL;
>         }
> @@ -363,6 +371,8 @@ static inline struct dentry *fsnotify_data_dentry(con=
st void *data, int data_typ
>                 return ((const struct path *)data)->dentry;
>         case FSNOTIFY_EVENT_FILE_RANGE:
>                 return file_range_path(data)->dentry;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return ((struct fsnotify_rename_data *)data)->moved;
>         default:
>                 return NULL;
>         }
> @@ -395,6 +405,8 @@ static inline struct super_block *fsnotify_data_sb(co=
nst void *data,
>                 return file_range_path(data)->dentry->d_sb;
>         case FSNOTIFY_EVENT_ERROR:
>                 return ((struct fs_error_report *) data)->sb;
> +       case FSNOTIFY_EVENT_RENAME:
> +               return ((const struct fsnotify_rename_data *)data)->moved=
->d_sb;
>         default:
>                 return NULL;
>         }
> @@ -430,6 +442,14 @@ static inline struct fs_error_report *fsnotify_data_=
error_report(
>         }
>  }
>
> +static inline struct inode *fsnotify_data_rename_target(const void *data=
,
> +                                                       int data_type)
> +{
> +       if (data_type =3D=3D FSNOTIFY_EVENT_RENAME)
> +               return ((const struct fsnotify_rename_data *)data)->targe=
t;
> +       return NULL;
> +}
> +
>  static inline const struct file_range *fsnotify_data_file_range(
>                                                         const void *data,
>                                                         int data_type)
>
> --
> 2.53.0
>
