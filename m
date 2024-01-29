Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767323C493
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706502994; cv=none; b=Ig5X1lR4cM+RajBwHid88wywkb8l0pynlKbnRWi0xBh6tC/W1LeDod1PPeqr77DQRSHK+DtYww6KZTzYjyJDmGmDjK1ncgf05nIDynOprJ7muXn9PUSrNI0r0nxVPGn/lLqRaC1uaOjGVgrhUsv52BLC1URjBrfjCqsbiQtQbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706502994; c=relaxed/simple;
	bh=Qvclxu84S/Vj00n5XJGicbf+1n9+wvgXNZJSxffCMaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOOwBygJAOBbzj/ec1vAeuICQzz9yhQM87soZvei2u1aOlIrISuaIxxFglGDibZkZdbU3x1JqkFxSxMeejhZ2JGkMG7JaiJpp85jkYKeFg2ABqGx4pd8XFKP9LIUUXAKZqJ3T/U7XQxCel5cQhlbZE/3Jw9vwr0wgw4yodfC40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ej0cPmGB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ej0cPmGB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35d0764076so22442366b.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706502990; x=1707107790; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GNrDOkLUoRhPhAZaq9nU6yW/IkHOgSVhQm/kSJS29jU=;
        b=ej0cPmGBny+KdMuseOrUhYXXVycTUu3+fxdZfL1Z2YgKqqGdUTgu1Z0Rd3E/nYABYZ
         fbBAnusZ3NgXP4YiXRr9iTodT7ygtVFbHqTiuK+gS8Dm443gpN2Ft+znUx0qOVgxc4Hy
         /oIDFQ2POU2NVLBhy1q4VjW9r8x+sOysReZns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706502990; x=1707107790;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GNrDOkLUoRhPhAZaq9nU6yW/IkHOgSVhQm/kSJS29jU=;
        b=iFBThZNKlJauwHnZNSpq7Z/Y4FSOIPzh60Y4RInl0w9mYzcTGMHbIVp/CYZG/lU0F4
         FPNoHScAPwu8BPAwyGkfZyRX5VanNPhJws/CLf/zJbLCIPR63HDgBA5sBv5VuZ0vArom
         7SeVq64soOQFP7SjOnskuEw9aV87GDQhnmGd2V33P4ArH0zhcGy3xrRzc4NfRapSTnYx
         TSGarerP+9DbKOr+fcS8SpI3PvWYPQ8RPeDm/jHlvQ5ZIOBe41KrzYj/k9hA79I+leDV
         i3JPCC3v0+Ud91hplSv03USVCj3JCJ026l9RPkEfNYaWQYBI10i9v0XQy7w4gy2lSTgH
         AHFQ==
X-Gm-Message-State: AOJu0YwiptmDFO3WiCUb3eoyVPbY62R/q2+I+VORp2IkwmBx16kPtIq1
	2HSwPKZjj1HdluJ6DsLYHxGq7bqE2Aq9nWAGWd5UbiCEn1v5tmKOj5RRQzjwNIXVQkJcMcbyppK
	DU914vg==
X-Google-Smtp-Source: AGHT+IGhCttjIJvnOCqL0kILnfPAOGkmBHgkdZsI5xHNDQhGTvIIr9a7xvKsKJUDS4fz1/MNBm8apQ==
X-Received: by 2002:a17:906:e95:b0:a35:a7ba:c642 with SMTP id p21-20020a1709060e9500b00a35a7bac642mr1493070ejf.51.1706502990522;
        Sun, 28 Jan 2024 20:36:30 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id vh5-20020a170907d38500b00a35e5c12bc3sm23600ejc.194.2024.01.28.20.36.29
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jan 2024 20:36:29 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55f1102b300so180340a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:36:29 -0800 (PST)
X-Received: by 2002:a05:6402:2709:b0:55a:813f:8802 with SMTP id
 y9-20020a056402270900b0055a813f8802mr3784740edd.25.1706502988865; Sun, 28 Jan
 2024 20:36:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com>
In-Reply-To: <202401291043.e62e89dc-oliver.sang@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Jan 2024 20:36:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
Message-ID: <CAHk-=wh0M=e8R=ZXxa4vesLTtvGmYWJ-w1VmXxW5Mva=Nimk4Q@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: kernel test robot <oliver.sang@intel.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 18:59, kernel test robot <oliver.sang@intel.com> wrote:
>
>   21:   48 8b 47 f8             mov    -0x8(%rdi),%rax
>   25:   48 85 c0                test   %rax,%rax
>   28:   74 11                   je     0x3b
>   2a:*  f6 40 78 02             testb  $0x2,0x78(%rax)          <-- trapping instruction

So this is

        struct tracefs_inode *ti = get_tracefs(inode);
        struct eventfs_inode *ei = ti->private;

        if (!ei || !ei->is_events || ..

in set_top_events_ownership(), and it's that 'ei->is_events' test that oopses.

The 'inode' is the incoming argument (in %rdi), and you don't see code
generation for the "get_tracefs(inode)" because it's just an offset
off the inode.

So the "ti->private" read is that read off "-8(%rdi)", because

  struct tracefs_inode {
        unsigned long           flags;
        void                    *private;
        struct inode            vfs_inode;
  };

so 'private' is 8 bytes below the 'struct inode' pointer.

So 'ei' isn't NULL, but it's a bad pointer, and 'ei->is_events' is
that "testb  $0x2,0x78(%rax)" and it oopses as a result.

I don't think this is directly related to that commit 852e46e239ee
("eventfs: Do not create dentries nor inodes in iterate_shared") that
the kernel test robot talks about.

It looks like some inode creation never filled in the ->private field
at all, and it's just garbage.

I note that we have code like this:

 create_dir_dentry():
        ...
        mutex_unlock(&eventfs_mutex);

        dentry = create_dir(ei, parent);

        mutex_lock(&eventfs_mutex);
        ...
        if (!ei->dentry && !ei->is_freed) {
                ei->dentry = dentry;
                eventfs_post_create_dir(ei);
                dentry->d_fsdata = ei;
        } else {

and that eventfs_post_create_dir() seems to be where it fills in that
->private pointer:

        ti = get_tracefs(ei->dentry->d_inode);
        ti->private = ei;

but notice how create_dir() has done that

        d_instantiate(dentry, inode);

which exposes the inode to lookup - long before it's actually then filled in.

IOW, what I think is going on is a very basic race, where
create_dir_dentry() will allocate the inode and attach it to the
dentry long before the inode has been fully initialized.

So if somebody comes in *immediately* after that, and does a 'stat()'
on that name that now is exposed, it will see an inode that has not
yet made it to that eventfs_post_create_dir() phase, and that in turn
explains why

        struct eventfs_inode *ei = ti->private;

just reads random garbage values.

So if I'm right (big "if" - it looks likely, but who knows) this bug
is entirely unrelated to any dentry caching or any reference counting.

It just needs just the right timing, where one CPU happens to do a
'stat()' just as another one creates the directory.

It's not a big window, so you do need some timing "luck".

End result: the d_instantiate() needs to be done *after* the inode has
been fully filled in.

Alternatively, you could

 (a) not drop the eventfs_mutex around the create_dir() call

 (b) take the eventfs_mutex around all of set_top_events_ownership()

and just fix it by having the lock protect the lack of ordering.

                 Linus
