Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53E1DA3B
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jan 2024 22:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VPfVr84I"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-556eadd5904so511989a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704320260; x=1704925060; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ggectDD1sVFfFuxF/ttgx0s4Ggo2HATlFxfh+QjmL3o=;
        b=VPfVr84IZzrtPT1hW6/cgJV12dBN02Aztgbn4YxDjma7X9S3br/mAFhYEINWPt3tif
         Dfj90hQSiMLZt37YRapLs5ntdMWw+bvvFDVF//TDW+yYpsMsgCCq5KVemQczeABlLd61
         PHxwe5FgZM5LdlytTUyabv1cVZd5CfiWuXD3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704320260; x=1704925060;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ggectDD1sVFfFuxF/ttgx0s4Ggo2HATlFxfh+QjmL3o=;
        b=Qa8Qn75FwArjQzZK9cyrMaIkUaxoj5aJ7QDfQshr/LT7OBOoJg8kd5o202MPWazlym
         gh4a3WQuksi8l3LSZ7RrxNGhr8mklCDRSrQdz+ZpjBk522yfts2roo2Bd0XlItWKt2PL
         ZKyep7zPlZr0KdA1czPx4IOfWNWdVfw/zAdvppyvS1kgHAMw+XLUpXf2NDcTsSVk13eF
         OuGRnjufTFwnD9spTDsETmw8ki+3zChSs61bSAAgAOXfy0d76C5FJpxTPUUlVRGr3F48
         Y6O/g527ck5uoh5p9SR5wTCseVSy3/BC9TWEBd/p2tcInF7vl8zhWjojq0csWpeBfIVr
         89zg==
X-Gm-Message-State: AOJu0YxFRny3KF1Gena9xDtozcjS9ltJbgVXL+XFFFidnq/IEvICarTN
	qFTBVU502EAIkavzElupbbs6JCasKNcTbQo92UKTKSfFRuywVK85
X-Google-Smtp-Source: AGHT+IGGI8d+Iiay7OPoOjaYwK8W1FBdkBmVecZHB7EzLXy3BL6eHzS+LgkvFRhMffXgyBr3APqAJg==
X-Received: by 2002:a50:d483:0:b0:555:5a24:7f21 with SMTP id s3-20020a50d483000000b005555a247f21mr3569929edi.52.1704320260613;
        Wed, 03 Jan 2024 14:17:40 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id dh23-20020a0564021d3700b00554f876a324sm12463657edb.48.2024.01.03.14.17.40
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 14:17:40 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a279ce3aab9so494782266b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jan 2024 14:17:40 -0800 (PST)
X-Received: by 2002:a17:906:73c9:b0:a27:db5c:8a4a with SMTP id
 n9-20020a17090673c900b00a27db5c8a4amr1618752ejl.213.1704320259797; Wed, 03
 Jan 2024 14:17:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103102553.17a19cea@gandalf.local.home> <CAHk-=whrRobm82kcjwj625bZrdK+vvEo0B5PBzP+hVaBcHUkJA@mail.gmail.com>
 <CAHk-=wjVdGkjDXBbvLn2wbZnqP4UsH46E3gqJ9m7UG6DpX2+WA@mail.gmail.com>
 <20240103145306.51f8a4cd@gandalf.local.home> <CAHk-=wg=tnnsTjnzTs8xRQOBLvw4ceKe7=yxfzNtx4Z9gb-xJw@mail.gmail.com>
 <CAHk-=wh5kkk2+JAv_D1fm8t1SOpTQyb4n7zuMuVSBG094HH7gA@mail.gmail.com> <20240103221444.GM1674809@ZenIV>
In-Reply-To: <20240103221444.GM1674809@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jan 2024 14:17:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgHEyd2z-KvaV6ndKSqGjkisE0MBEXsFkkxeicHTUy-Xg@mail.gmail.com>
Message-ID: <CAHk-=wgHEyd2z-KvaV6ndKSqGjkisE0MBEXsFkkxeicHTUy-Xg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Stop using dcache_readdir() for getdents()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:14, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jan 03, 2024 at 01:54:36PM -0800, Linus Torvalds wrote:
>
> > Again: UNTESTED, and meant as a "this is another way to avoid messing
> > with the dentry tree manually, and just using the VFS interfaces we
> > already have"
>
> That would break chown(), though.

Right,. That's why I had that note about

   So take this as a "this might work", but it probably needs a bit more
   work - eventfs_set_attr() should set some bit in the inode to say
   "these have been set manually", and then revalidate would say "I'll
   not touch inodes that have that bit set".

and how my example patch overrides things a bit *too* aggressively.

That said, I think the patch that Steven just sent out is the right
direction to go regardless. The d_revalidate() thing was literally
just a "we can do this many different ways".

                     Linus
