Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B831345003
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Oct 2024 03:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730170808; cv=none; b=HcJjN/zBuxTcdRN7v4P6UqgL+yt0YGtgQpJ2rPB9oSs5LSz8LcZ1jB8LawY4+KnOsvpLyTtNwTXpemtRNUydveDXTy53gIrWabkrz3UgvHpc1krRWOQdG8gKqQoHHyierSA7uNDD2RtdxurNHBnrJhyIT6dYOg2kK1FwTWh8kEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730170808; c=relaxed/simple;
	bh=VyTJt0xPH4N8n02lC7V7N8uV5NqqDi7U2Mnpgj43mds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7KZ7aCRQdx23ES08rWQHghPuG624OTGd+5aaWQQUzHlZd3XuFdimMpLjs7VY1CAF5aSPm+w3wNe++Fo5KoG0PwZTSqO1NGV5ZJ30RpwfZr6UsoP5yi8PfMn1MbhPw4pFq6yhdVyhGqqSOWerN1b8ejFwXYKPiSNjgxXMHVxZ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sxsa5VhG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sxsa5VhG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730170804;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XM3NDn8/RrcDaH2dNFMKJrRw9os6K2fG5KwyMJ9szmk=;
	b=Sxsa5VhGHJvAOSSXCKIrMold/+mhz9y0YNqu/A9joc9mcwX9KkicldvgbKWT5I0b3FYh85
	6b8jo575bAFP1mDKB6MtrMIns/N7BJd1Vf0AVzg7DKWz+ZKMaHsIFsNiwHanMSnLNEq7xF
	324m+q7aL+67mkZ+w/uMzn4/K02HbTc=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-No39kVq8MsK6f0FhpzTUhw-1; Mon, 28 Oct 2024 23:00:03 -0400
X-MC-Unique: No39kVq8MsK6f0FhpzTUhw-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f3d7d13fso17650325ab.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Oct 2024 20:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730170803; x=1730775603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XM3NDn8/RrcDaH2dNFMKJrRw9os6K2fG5KwyMJ9szmk=;
        b=GTzSLTvrAjnvor0sUhm8ECWsPF9mOfgHmEicuP5Tw8iKboZdEbQXDxuTf2/YurxMI7
         /ywthlV6twXNih1K5iWVPVeY+TUzss2uHRqeViEQ7Frwgc+TWspqT6KreHxEmRnKNz+9
         noofAUWge/xBWKBzhyxewaDdqp1Tsx/v9PWZuAvzoO6i8XEqNdOVBdCXstIV6yaBQojd
         GxYRfYyZOyIRE7jkbf6eWlHxdYxv+Yg9HbCxPVXxnz2QAw3OEKBJ6QZMTVnoFo4dgT41
         uT9wY2feyZVq3VoEnoDMvtNITUcfwIJQpEcOZtHvuP5EXagZTNaF2YjlbyAmkaV7z+/o
         vTlw==
X-Forwarded-Encrypted: i=1; AJvYcCW5ANYXwvVtTsACcvAEQ1T6TESiOWhfwe0afnxC+z9rVAoTL1QD7cVIIGutPshjgIuix5aMIFnf79W988XMUKTl5/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAB5YyNlh/Cqz1Zz/uJ//iMKsZAJupdqwaCaQfE9ziqr4Gfjt
	WrA9Dr9xiIghVvouXyxJS8o5NqD77bxvJ1lhHOclSOvNSm+xA1y52W2ehD3ak4643o+iFiPudmE
	oQ2A+fimF9fbCz0pl+0ZbW0Se8RuOXTG/puvKfUdNuTjj1vouv1IAYmtD1IxvypjHJLMoQA==
X-Received: by 2002:a05:6e02:1c0d:b0:3a4:e8cc:2a89 with SMTP id e9e14a558f8ab-3a4ed2a9d71mr95089615ab.10.1730170802626;
        Mon, 28 Oct 2024 20:00:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJe1SOujsJgAA42pQ3L9xxLdE1LSrArTcwDuo+h5DT5bavlNuHR/AF4+9mUBERX5gv6wGYQ==
X-Received: by 2002:a05:6e02:1c0d:b0:3a4:e8cc:2a89 with SMTP id e9e14a558f8ab-3a4ed2a9d71mr95089355ab.10.1730170802234;
        Mon, 28 Oct 2024 20:00:02 -0700 (PDT)
Received: from [10.0.0.71] ([65.128.110.20])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a4e6df5919sm19338285ab.41.2024.10.28.20.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 20:00:01 -0700 (PDT)
Message-ID: <bbbbaa42-444f-4973-b749-7c56b937ae5f@redhat.com>
Date: Mon, 28 Oct 2024 22:00:00 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tracing: Fix tracefs gid mount option
To: Kalesh Singh <kaleshsingh@google.com>, dhowells@redhat.com,
 rostedt@goodmis.org, mhiramat@kernel.org
Cc: surenb@google.com, jyescas@google.com, kernel-team@android.com,
 android-mm@google.com, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Ali Zahraee <ahzahraee@gmail.com>,
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241028214550.2099923-1-kaleshsingh@google.com>
 <20241028214550.2099923-4-kaleshsingh@google.com>
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20241028214550.2099923-4-kaleshsingh@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/24 4:43 PM, Kalesh Singh wrote:
> Commit 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> tracefs to use the new mount APIs caused mounting with the gid=<gid>
> option to not take effect.

Or any other mount options. I'm sure this isn't unique to gid, right?
So, might want to fix the commit title.

> The tracefs superblock can be updated from multiple paths:
>     - on fs_initcall() to init_trace_printk_function_export()
>     - form a work queue to initialize eventfs
>       tracer_init_tracefs_work_func()
>     - fsconfig() syscall to mount of remount sysfs
> 
> The tracefs super block root inode gets created early on in
> init_trace_printk_function_export().
> 
> With the new mount API tracefs effectively uses get_tree_single() instead
> of the old API mount_single().
> 
> Previously, mount_single() ensured that the options are alway applied to
> the superblock root inode:
>     (1) If the root inode didn't exist, called fill_super() to create it
>         and apply the options.
>     (2) If the root inode exists, called reconfigure_single() which
>         effectively called tracefs_apply_options() to parse and apply
>         options to the subperblock's fs_info and inode and remount
>         eventfs (if necessary)
> 
> On the other hand, get_tree_single() effectively calls vfs_get_super()
> which:
>     (3) If the root inode doesn't exists calls fill_super() to create it
>         and apply the options.
>     (4) If the root inode already exists, updates the fs_context root
>         with the superblock's root inode.

I'm honestly a little lost here, but given the differences between mount_single()
and get_tree_single() - are other get_tree_single() users similarly broken?

Should get_tree_single() just be calling reconfigure_single() internally like
mount_single() did? The comment in reconfigure_single() confuses me.

> (4) above is always the case for tracefs mounts, since the super block's
> root inode will already be created by init_trace_printk_function_export().

this reminds me a little of 

commit a6097180d884ddab769fb25588ea8598589c218c
Author: NeilBrown <neilb@suse.de>
Date:   Mon Jan 17 09:07:26 2022 +1100

    devtmpfs regression fix: reconfigure on each mount

> This means that the gid mount option gets ignored:
>     - Since it isn't applied to the super block's root inode, it doesn't
>       get inherited by the children.
>     - Since eventfs is initialized from form a separate work queue and
>       before call to mount with the options, and it doesn't get remounted
>       for mount.
> 
> Ensure that the mount options are applied to the super block and eventfs
> is remounted to respect the new mount options.
> 
> [1] https://lore.kernel.org/r/536e99d3-345c-448b-adee-a21389d7ab4b@redhat.com/
> 
> Fixes: 78ff64081949 ("vfs: Convert tracefs to use the new mount API")
> Cc: David Howells <dhowells@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> ---
>  fs/tracefs/inode.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 1748dff58c3b..cfc614c638da 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -392,6 +392,9 @@ static int tracefs_reconfigure(struct fs_context *fc)
>  	struct tracefs_fs_info *sb_opts = sb->s_fs_info;
>  	struct tracefs_fs_info *new_opts = fc->s_fs_info;
>  
> +	if (!new_opts)
> +		return 0;

Can this really happen?

> +
>  	sync_filesystem(sb);
>  	/* structure copy of new mount options to sb */
>  	*sb_opts = *new_opts;

FWIW doing this as a structure copy was probably a terrible choice on my part. :(

> @@ -478,14 +481,17 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	sb->s_op = &tracefs_super_operations;
>  	sb->s_d_op = &tracefs_dentry_operations;
>  
> -	tracefs_apply_options(sb, false);
> -
>  	return 0;
>  }
>  
>  static int tracefs_get_tree(struct fs_context *fc)
>  {
> -	return get_tree_single(fc, tracefs_fill_super);
> +	int err = get_tree_single(fc, tracefs_fill_super);
> +
> +	if (err)
> +		return err;
> +
> +	return tracefs_reconfigure(fc);
>  }
>  
>  static void tracefs_free_fc(struct fs_context *fc)

