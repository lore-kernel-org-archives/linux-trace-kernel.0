Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413C12C681
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jan 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcAgY24T"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5542a7f1f3cso1126254a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704398539; x=1705003339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jDsDfmbTpiQpvGnfOhd0ROcnisF14caf1vpRK9xqg4=;
        b=TcAgY24TVMOu9UYln9SgjwiLLt7KXvS7eV38BEAz0LiDd4c8Itbp+aRmvCzgLDsv8z
         btwA0mPop8VYEmcWhQ9S+Z/LjiG8BmIwlZkLeHhQpB6VdU9jnXdE62t18jTPZqKJsD+z
         4ZpyUNzjCDiJrE7ciRzvpBMU8+3XQB7D0qeNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398539; x=1705003339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jDsDfmbTpiQpvGnfOhd0ROcnisF14caf1vpRK9xqg4=;
        b=c/bjsmAyxyUAHOLFJDqNZCKMOSoENN1wQ+oSq4ZAT6cEwVDlVp1Vi7h6vgcxYrQ6Pe
         jharGFgoIV2NkwEfAYuRjLs0MZZYAxMYqmAQSMsszt3JdiSS1RL6naBQF29kXupUmr1X
         +J7G3i0rKd32qo7me/HvtmYZ3pX5bvx8kRH1ykZnq/xQ8i8B1hihCrTvqt+UkFw0PU4P
         2WnDAplKonH25nQGcTiIa53SUkSvu9iXtN4hfF3R47El20QMpqjp1nmnGODZtWxd9PHJ
         VJyjkjkGoaEepgKmGo8jlr2hGj8Jy2Arf4zuJo/WooJhxxsZCexlP5iGmBW3d7RuGWD1
         OHFw==
X-Gm-Message-State: AOJu0YxTP6cG5coR9PijygIEovZDlHzx7hwFE3uZqEDCIiTNFhfOJgwi
	J5TCwvq+JlNrjcNZ+9BEqOs/P3ZzidcEwljpfQ/uA2pbFySMrk6f
X-Google-Smtp-Source: AGHT+IGK4Bgng9Kp6JOMZT81kzTKTJFCnJ8iuztEeDx5B4cDG+veOcr0tdFibBCHQ1XFn663H2uMXg==
X-Received: by 2002:a17:906:5301:b0:a28:aa37:405d with SMTP id h1-20020a170906530100b00a28aa37405dmr453326ejo.104.1704398539419;
        Thu, 04 Jan 2024 12:02:19 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id j17-20020a170906255100b00a2714f1ba8asm17400ejb.160.2024.01.04.12.02.17
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:02:18 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-555bd21f9fdso1136909a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jan 2024 12:02:17 -0800 (PST)
X-Received: by 2002:a17:907:360b:b0:a1d:932f:9098 with SMTP id
 bk11-20020a170907360b00b00a1d932f9098mr716728ejc.97.1704398537679; Thu, 04
 Jan 2024 12:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV>
 <20240104141517.0657b9d1@gandalf.local.home> <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
In-Reply-To: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 12:02:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguvq7yFt3qaLrWoZK5FCK8Joizrb2wu=FN==mYM9PSbg@mail.gmail.com>
Message-ID: <CAHk-=wguvq7yFt3qaLrWoZK5FCK8Joizrb2wu=FN==mYM9PSbg@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>>
> Which is *NOT* the inode, because the 'struct file' has other things
> in it (the file position, the permissions that were used at open time
> etc, close-on-exec state etc etc).

That close-on-exec thing was a particularly bad example of things that
are in the 'struct file', because it's in fact the only thing that
*isn't* in 'struct file' and is associated directly with the 'int fd'.

But hopefully the intent was clear despite me picking a particularly
bad example.

            Linus
