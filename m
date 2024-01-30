Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35B7EEE5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706655386; cv=none; b=F9uNqpwoRZlSgBsr11HA49o8/9I3oByQd3LNVwBlqlSxEloMS4UpMzTdiHJ6Oaa7lQwVkWrKl7+z6aXr0QZxlXqOkCrp2NKMf22imn6/0eCGzFAbMDtsqE7p7st0IMPQ1y2chuE3eL9sCdZjZuVklbBISzkQoNRdNyxabUs/7Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706655386; c=relaxed/simple;
	bh=Cj4XOejVbe8op4QcSEepOhz4IYD/CrlYwEM8OfVbQIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB5y2AsFoMKVYSaUVZfY7UfYRHD2jjqB+zOmNWvkhWwjVE8D67KhZj8EJiZCg2FKEDZUdy+JioSs3U7OYrYrXRqQyhkfdn9dIpoO4hcdH9jmwZLwzypAHenvEJw5u/AkeDDvn+9fOKYz1af8HSwV3hwAKZ9u3i5UaNBp6hWz9bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KAmyefcQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KAmyefcQ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55f15762840so2601249a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706655383; x=1707260183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0/wk9TZxLvwAGmQGfbb+2jVKtz8EYTBjx8fsmhuikXo=;
        b=KAmyefcQ9jp9/RwJsD23sQBiEcQK1XvTN48Qou1uHSCp9aKGOvbJBAr6xk0xHcX/S1
         CnEB1C8UQCEMnhpx4C7uTEawIlwe2YouOw4L/R8O7UrRxZiRAxzoYRmWbctvhF1ssuGw
         xOaX82+NZNax1KOnXA+auLzkycsyQTCa9KMBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706655383; x=1707260183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/wk9TZxLvwAGmQGfbb+2jVKtz8EYTBjx8fsmhuikXo=;
        b=fvCkrD9WpTC4rneiqJlpbMINtDWdn32cXmM+8cSWwOklFOCNX/E7N3BTJQITUTv5Q2
         gZRr32zNkPFreZgxh6djqXqWm9q6vf+MycMC2XIaK707dKNTmb6M5S0Zm2O6PL6xWb9B
         0CVbco+TMyagt039kTpPoRUMmQIzK86FU1v+tR/148D+R51kAAt6Y16bztfPY6wUAstF
         9ftDnv3PwFN+3ihlp27vdxApIfAAWSVSoMDxE1q291rubhHiKF68xIakNG9ZLHtjNdiV
         R64kad8J3HOOSjG6Pk6JLt6lOO0GpxdCnCgzRjyQzqfJ3tsKSk3OZYUcDNHB5n41xfhG
         FfCQ==
X-Gm-Message-State: AOJu0YxQ/X+un4SUd6fbasAjQuZjUu1UsAIu99MAjTA+cQCGim/ToToP
	RRE1E2WbYs71m9k39vnRHH3YyFxnB2aDqwRli6J66SjrVek5czbN+ZY6hb6km0YJ+DCPvgAaHkp
	9fTsLjw==
X-Google-Smtp-Source: AGHT+IEaz7CSZtnPYqHRGcXBG5diVmtgyzZhfxv1PycBCDUlayyPLLNl1HuvelAW5SQcZE+y60zemQ==
X-Received: by 2002:a17:906:f204:b0:a36:4af0:2f1d with SMTP id gt4-20020a170906f20400b00a364af02f1dmr1141308ejb.54.1706655382697;
        Tue, 30 Jan 2024 14:56:22 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id qt11-20020a170906eceb00b00a358f659989sm3338178ejb.113.2024.01.30.14.56.22
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 14:56:22 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f13b682d4so3481576a12.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 14:56:22 -0800 (PST)
X-Received: by 2002:a05:6402:348c:b0:55e:f37f:7fc5 with SMTP id
 v12-20020a056402348c00b0055ef37f7fc5mr5872728edc.14.1706655381670; Tue, 30
 Jan 2024 14:56:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
In-Reply-To: <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 14:56:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
Message-ID: <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 13:52, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Btw, you can look at name lengths in tracefs with something stupid like this:
>
>     find . | sed 's:^.*/::' | tr -c '\n' . | sort | uniq -c

Actually, since only directories have these 'ei' fields, that find
should have "-type d", and then the stats change.

Most directory filenames there are indeed longer than 8 bytes (16
bytes seems to be the most common length).

That means that whether it wins or loses in allocation size tends to
be mostly about the kmalloc sizes and the size of that structure.

And it turns out that the real memory savings there would be this patch

  --- a/fs/tracefs/internal.h
  +++ b/fs/tracefs/internal.h
  @@ -55,15 +55,6 @@ struct eventfs_inode {
        unsigned int                    is_events:1;
        unsigned int                    nr_entries:30;
        unsigned int                    ino;
  -     /*
  -      * Union - used for deletion
  -      * @llist:      for calling dput() if needed after RCU
  -      * @rcu:        eventfs_inode to delete in RCU
  -      */
  -     union {
  -             struct llist_node       llist;
  -             struct rcu_head         rcu;
  -     };
        const char name[];
   };

since with all the other cleanups, neither of those fields are actually used.

With that, the base size of 'struct eventfs_inode' actually becomes 96
bytes for me.

And at least on x86-64, the kmalloc sizes are 96 and then 128 bytes.

But that means that

 - with the added name pointer, the eventfs_inode would grow to 104
bytes, and grow to that next allocation size (128)

 - with the embedded name, the size is 96+strlen+1, and will also need
at least a 128 byte allocation, but any name that is shorter than 32
bytes is free

so it ends up being a wash. You're going to allocate 128 bytes
regardless. But the deallocation is simpler.

                  Linus
