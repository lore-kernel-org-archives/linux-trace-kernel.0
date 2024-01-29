Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848EC76C80
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706550029; cv=none; b=VUV5slDDJM5RZEuKyglGBoGihnpwiX+lyzlD0hz6poteUNKx5fybBXCGyzgFpshK7WopIRUOf3BtJPCGO4v8QWTOIyiO6q+/jJbx51gDYMqFNTixtCPmh6u8oZjwcbWr9MKGzbFidv0tj87ymnYTTPQ7smaFbWtH43OYDf9HTyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706550029; c=relaxed/simple;
	bh=kkIzpH18wDHfYouguHhG1jnDHVScQ73RnQm28C2mofo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RELdMQ53oe9p2RxJxEF7uqdx/Y5mTiYU9wpqIKngXSyvtjizf5fVghNHw/yO9BsV/MuHMs7y35oPEEA0j+vFvsRVVdS10K5pYcTmXNFYTvPWfUuZId2vfDotCPeQxFYoAyXq3fIbArxPREGQ6h4WtD+IGqdbW4bqxZ1O0aGbFUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=eM40Jqqp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eM40Jqqp"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5102a2e4b7bso4437926e87.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706550025; x=1707154825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XMTUvx/6SM2X/X8eIaLRq0dCrVO/7O0bBhRFSLcgZrI=;
        b=eM40Jqqpth7AaTOlekds2v29GqXn+THHGLemssEnUNZ7n/kecprb+HO1ISZXwNAoMT
         LIC1NLbKTqCevbSlaQC1PuK2vnXQR3XEYEJ8lAWisQe9kQfjCqfOrlLNVXwzyXlVI5fH
         xytD2ZtnT9JWihwd2j/uXzQq/woLe+Mq0/EzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706550025; x=1707154825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMTUvx/6SM2X/X8eIaLRq0dCrVO/7O0bBhRFSLcgZrI=;
        b=k14FU6gipVZ9CwhFHOhVj4QAVFFA6xwBHDqaOZYoumlXOzSa7PWehaOh6FYT08wHtK
         ALoSSvajbfEbLjEvn1eUPdDCbarYaOmKs4lSqNNCnP0wGLWGOjPuRzz8ED4QaJc57BQP
         K3qIadBCawak6JoKhUJMEkiafMNiTjXwv3h6Fm5HTEKz6yvPa4i02ofxHF2+zEk8my++
         7STR5rpnznK43utP6xs2fpwcMt4wkAcqwrITilp4Q1N7HadBnK3ePfcs3DHxCWFi5Eh5
         0VaarypWiJkHRfDN4F9dhOUBmHmqUyVkw0GPRjyUmBxck24W4Qzos/HxQ9e0X5TGCu5j
         k5+Q==
X-Gm-Message-State: AOJu0YwTcSmUisTXS79jvZMBrglI2/3pFfuhzqs9DNO8Gy/4h9J+zLwY
	7D4MPjwbHNEWAOo81vJPqwDkB8B/bBnWfchJnhYmk6YK4gyczYuMZoZ9V2VKikutXGxivMtCXB0
	T12Cagg==
X-Google-Smtp-Source: AGHT+IFuCBlHSWZyBQw3qldVq18/+Ql0g99qU0tioIg1v0ITGldHPD85QGQ+HjJtRZhF+UC/0RGuEw==
X-Received: by 2002:a05:6512:ad6:b0:50e:a8c7:b2e2 with SMTP id n22-20020a0565120ad600b0050ea8c7b2e2mr4175336lfu.38.1706550025346;
        Mon, 29 Jan 2024 09:40:25 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y16-20020ac255b0000000b005101627fd2fsm1169031lfg.197.2024.01.29.09.40.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 09:40:24 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so33591991fa.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:40:24 -0800 (PST)
X-Received: by 2002:a2e:bc83:0:b0:2cf:48c9:1554 with SMTP id
 h3-20020a2ebc83000000b002cf48c91554mr5355393ljf.0.1706550024205; Mon, 29 Jan
 2024 09:40:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
 <20240129120125.605e97af@gandalf.local.home>
In-Reply-To: <20240129120125.605e97af@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 29 Jan 2024 09:40:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
Message-ID: <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 09:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Thanks for the analysis. I have a patch that removes the dropping of the
> mutex over the create_dir/file() calls, and lockdep hasn't complained about
> it.
>
> I was going to add that to my queue for the next merge window along with
> other clean ups but this looks like it actually fixes a real bug. I'll move
> that over to my urgent queue and start testing it.

Note that it is *not* enough to just keep the mutex.

All the *users* need to get the mutex too.

Otherwise you have this:

CPU1:

   create_dir_dentry():
      mutex locked the whole time..
        dentry = create_dir(ei, parent);
           does d_instantiate(dentry, inode);
        eventfs_post_create_dir(ei);
           dentry->d_fsdata = ei;
        mutex dropped;

but CPU2 can still come in, see the dentry immediately after the
"d_instantiate()", and do an "open()" or "stat()" on the dentry (which
will *not* cause a 'lookup()', since it's in the dentry cache), and
that will then cause either

 ->permission() -> eventfs_permission() -> set_top_events_ownership()

or

 ->get_attr() -> eventfs_get_attr() -> set_top_events_ownership()

and both of those will now do the dentry->inode->ei lookup. And
neither of them takes the mutex.

So then it doesn't even matter that you didn't drop the mutex in the
middle, because the users simply won't be serializing with it anyway.

So you'd have to make set_top_events_ownership() take the mutex around
it all too.

In fact, pretty much *any* use of "ti->private" needs the mutex.

Which is obviously a bit painful.

Honestly, I think the right model is to just make sure that the inode
is fully initialized when you do 'd_instantiate()'

The patch looks obvious, and I think this actually fixes *another*
bug, namely that the old

        ti = get_tracefs(inode);
        ti->flags |= TRACEFS_EVENT_INODE;

was buggy, because 'ti->flags' was uninitialized before.

eventfs_create_events_dir() seems to have the same bug with ti->flags,
btw, but got the ti->private initialization right.

Funnily enough, create_file() got this right. I don't even understand
why create_dir() did what it did.

IOW, I think the right fix is really just this:

  --- a/fs/tracefs/event_inode.c
  +++ b/fs/tracefs/event_inode.c
  @@ -328,7 +328,8 @@
        inode->i_ino = EVENTFS_FILE_INODE_INO;

        ti = get_tracefs(inode);
  -     ti->flags |= TRACEFS_EVENT_INODE;
  +     ti->flags = TRACEFS_EVENT_INODE;
  +     ti->private = ei;
        d_instantiate(dentry, inode);
        fsnotify_create(dentry->d_parent->d_inode, dentry);
        return eventfs_end_creating(dentry);
  @@ -513,7 +514,6 @@
   static void eventfs_post_create_dir(struct eventfs_inode *ei)
   {
        struct eventfs_inode *ei_child;
  -     struct tracefs_inode *ti;

        lockdep_assert_held(&eventfs_mutex);

  @@ -523,9 +523,6 @@
                                 srcu_read_lock_held(&eventfs_srcu)) {
                ei_child->d_parent = ei->dentry;
        }
  -
  -     ti = get_tracefs(ei->dentry->d_inode);
  -     ti->private = ei;
   }

   /**
  @@ -943,7 +940,7 @@
        INIT_LIST_HEAD(&ei->list);

        ti = get_tracefs(inode);
  -     ti->flags |= TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
  +     ti->flags = TRACEFS_EVENT_INODE | TRACEFS_EVENT_TOP_INODE;
        ti->private = ei;

        inode->i_mode = S_IFDIR | S_IRWXU | S_IRUGO | S_IXUGO;

which fixes the initialization errors with the 'ti' fields.

Now, I do agree that your locking is strange, and that should be fixed
*too*, but I think the above is the "right" fix for this particular
issue.

                Linus
