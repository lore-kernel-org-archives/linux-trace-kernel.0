Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C4C199AA
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jan 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fmOjjJ9f"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so902345e87.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704396955; x=1705001755; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TLfuV7xsXyW+hLKhxRy2JmANDmog6uIMlY97oe3vpGA=;
        b=fmOjjJ9fZ+iJn4YSNSK/eJgX9cZ3H3w62EDHYon7+YnT2lIEQFQXj/GBYZb90oAcyq
         Rzd9/CsODZ5mz/sNjJeIpk1m7ajzHI+yVSeD5RMvpH+B15IyU7SaR+WN0ofc1NK1wZfs
         0fTiHiF+RAHO64CccNJcSVTeaToCfSSAPLXG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704396955; x=1705001755;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLfuV7xsXyW+hLKhxRy2JmANDmog6uIMlY97oe3vpGA=;
        b=Iw0M7tnSmj37hkVYvWbqSMVbEzS3iIPOQ0tXUmiB7gxsYwO8/tzaxzP1XTjEUG2RzC
         VYJDqFJ8ENBbodhp6Vgu6eKNw+llX68jOivXxkIKTBlD0QmTTusnQYfQR6QMewAia9Tl
         ktTSWeXy7fGD44WQ+jfgl0YaCsbDL2VpxKi89ZYtA3qyYw9IwaDeKnHmfUnBu4HJvaLh
         qTzt5Qj+FAD98LfE60axHAXmbrnC8H23wKvdEF7IhMF26yZr/4lzWU4FfvW2RjokEW9U
         eknOLv1ZYriT7GWB8ngMCqPOpvkrN/dYhRfRHmWVj7Xh1b8UHPOIFaNnJaeOBX9m7WhK
         yXBA==
X-Gm-Message-State: AOJu0YzReIBwrWvhrnLFWgpUwY9b0yHToAFRsMOKCbsvsV/7OrfcFWpH
	WWIh/Av9btLHMyZlD0eSLUMn4iE3jrGok2TjtxH5Plb18CyFPDSA
X-Google-Smtp-Source: AGHT+IFEqdV5RkXlzEYmlDb9c8AoEzv6b2XYj0Z+lAWV46P0kaHdmeiAB+0wxINsQXpig6sit5BS4A==
X-Received: by 2002:a05:6512:2809:b0:50e:ac2a:6b77 with SMTP id cf9-20020a056512280900b0050eac2a6b77mr511050lfb.45.1704396955602;
        Thu, 04 Jan 2024 11:35:55 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 3-20020a508e03000000b0055515b40464sm62595edw.81.2024.01.04.11.35.54
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:35:54 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a29058bb2ceso32804266b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jan 2024 11:35:54 -0800 (PST)
X-Received: by 2002:a17:906:1194:b0:a28:b79a:37a0 with SMTP id
 n20-20020a170906119400b00a28b79a37a0mr367224eja.222.1704396954150; Thu, 04
 Jan 2024 11:35:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV> <20240104141517.0657b9d1@gandalf.local.home>
In-Reply-To: <20240104141517.0657b9d1@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 11:35:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
Message-ID: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:14, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> "file descriptor" - is just what maps to a specific inode.

Nope. Technically and traditionally, file descriptor is just the
integer index that is used to look up a 'struct file *'.

Except in the kernel, we really just tend to use that term (well, I
do) for the 'struct file *' itself, since the integer 'fd' is usually
not really relevant except at the system call interface.

Which is *NOT* the inode, because the 'struct file' has other things
in it (the file position, the permissions that were used at open time
etc, close-on-exec state etc etc).

> "file description" - is how the file is accessed (position in the file and
>                         flags associated to how it was opened)

That's a horrible term that shouldn't be used at all. Apparently some
people use it for what is our 'struct file *", also known as a "file
table entry".  Avoid it.

If anything, just use "fd" for the integer representation, and "file"
for the pointer to a 'struct file".

But most of the time the two are conceptually interchangeable, in that
an 'fd' just translates directly to a 'struct file *'.

Note that while there's that conceptual direct translation, there's
also very much a "time of use" issue, in that a "fd -> file"
translation happens at one particular time and in one particular user
context, and then it's *done* (so closing and possibly re-using the fd
after it's been looked up does not actually affect an existing 'struct
file *').

And while 'fd -> file' lookup is quick and common, the other way
doesn't exist, because multiple 'fd's can map to one 'struct file *'
thanks to dup() (and 'fork()', since a 'fd -> file' translation always
happens within the context of a particular user space, an 'fd' in one
process is obviously not the same as an 'fd' in another one).

               Linus
