Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8E33C52F
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775648610; cv=none; b=KIJwD0rUqjwrSj3L4xibjZeDJ5KLz2hB/UMzcS6CGULAB8BihGhV1g+neUptvizV51C/uihwtcWjdiKh2Oc9SPwhIFju2br7enrwtZhLM1oTAZ0uf0R34gwVMXkU8AORnSjr4wl8cbWVvT64WIzLhRCtPntnUo7/0vqx9VvwVuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775648610; c=relaxed/simple;
	bh=0Iw6mGP//V6mS3mSSxrnwZh3I5rO08ixkcyfybY2sjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YAGP9lKx7OoRn++xziVSi8eHe4G5MdO1STSZQXdm/MHYmIyBwLe3Q3LG/ge7Jg9q3OshMKytKhD5vU4/XR/buW3QrOZRNiOLGKUnrzbnvo8GnVEuN0Vdl9MbSk7Yo+vCnN/10lUJkHelPZTqVsVK6T+5wFtYvsTWCYCq9RiomW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OJVdvC9X; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OJVdvC9X"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d572f7437so87809f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775648606; x=1776253406; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sSbTciqRiCcbNgR+vjo6/IWbGCPIZk8c8UuLFG9aTok=;
        b=OJVdvC9XuwV9x7RaxABcqspbPGHjUnYsDbdVX2O18JbcLp0txdb4rxQewq/Jxj9Dii
         a46y3KSCO0xVFxemJJhLXCCEUDG04Hnd4y5pI2LW12Chh9K0m2z0IzMyhfK+WE+GzLl4
         3hw8XRYzmoI2s+tjpJuhW9kOXiDYgwltSBkFWGk0XNfx3j0esC8CD+BBg+IIbzfnY8E7
         Y0bnnHVBUsdOVfaezuNQhhyd0+xZlVRKVMLgBTmDCkSKQ+320B25VYjNPdxM+xINHpZ6
         2xI/VV4x9ybuRHmDPRZvFsvfgQgfhRX0MD/yKJZID3NFvNdPz73Jbufwd9XZcGymClaZ
         lE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775648606; x=1776253406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sSbTciqRiCcbNgR+vjo6/IWbGCPIZk8c8UuLFG9aTok=;
        b=jOFUPyQ1HzibwNkAx66gXrGC4TxfUioXsh0Dxi2eOBMhVl5Mi6nqHIz5Aqaq5WfU5r
         t9tKD1RW7T0UrEmSlK49frGUEXJFSudRkzpbPQx87ZzHvFvJdk6HP896rkSVwiRHo4+1
         YomiRi1Sq6//m84GhQgjd7rfX8YEugL3po+Jy6mhkphcF06qmSgX8PcYoXGqxCmQZANG
         gKDHoyM3i684bE093p9U8HibO202UnRspOqtEQtrsYVItOGm2reVG+LRT2IrSEBl+zt1
         XnA2xeOQtPpNffbcr+h3uNXAJxN9o3ulyg89RQvLp5ncgLGSFr5hNMf4zoiUcLha10xv
         7cFA==
X-Forwarded-Encrypted: i=1; AJvYcCVGMRhQkpe8cuxpjloVXLmmCLa9fKNxhJcbbq6s+LMgDbamxg+ki3TAp45NUqsx7HnXj9AFRhcjrFh/oY7am5M9iOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEheCp/Q6CybzAu7xrdjKRxhmjTU3xzLFasTSzIS+oeEwzbWaI
	LLDoN8YFbiqfSzKGFqVnOa9d5EApXD7eOHC2rk4YAWvCrRoxXumt1oTb59kSx9SwcnY=
X-Gm-Gg: AeBDieuRVmTlGb5vcie1ezaFXUAnwEQTBxoUGU7ALhPFzcco0hdEV2+rtUdAPyBaWqw
	3v+b3OX2h3k3QWDICi6cqF6sW+sxYliFw2kJKIjBH0ndG45wyV8m6G803RwNoCVDMGIMpN6ohsO
	3L6B+P6v540ixqpn0RjQNDy5U6gzwyHYgjcSzAZmOsXyfDsC7zlIY8K+L5+L/U308rHIDZhAc4N
	QwCZWJkVDGaxDyaSkh4rQf7qc93lORjpxm/lLbD/6dlQmR7lWz631DK/apejTpUOrF7peboHrz+
	aK6g/Z8SgwPq8zHFxDODvz6ebDI+6AcVVbv1jQel9p3U0VNw0pUShtkOepQL7QqB9lfpSriUei3
	5Eg7+oWtTde0mrrXKl3YlgqRdFmQ3kaH+N0T/lqqt9jQA0fDha4LsrBSD1luR/zCLjbbya4dc5z
	yB+l5q+xo2uC3wuFcRH8izYunCnw==
X-Received: by 2002:a05:6000:2c0a:b0:43d:1bf6:930 with SMTP id ffacd0b85a97d-43d293060fdmr33267956f8f.47.1775648605887;
        Wed, 08 Apr 2026 04:43:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm58799790f8f.21.2026.04.08.04.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:43:25 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:43:22 +0200
From: Petr Mladek <pmladek@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>,
	Dylan Hatch <dylanbhatch@google.com>, jpoimboe@kernel.org,
	jikos@kernel.org, mbenes@suse.cz, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	kpsingh@kernel.org, mattbobrowski@google.com, jolsa@kernel.org,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com,
	yonghong.song@linux.dev, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] livepatch: Add "replaceable" attribute to
 klp_patch
Message-ID: <adY_WgA54CDtWBq6@pathway.suse.cz>
References: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com>
 <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz>
 <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbDG9mq1iJv5suct=cqJ+2r8VvJ-dXN=nuvMw0XYqnUjxA@mail.gmail.com>

On Wed 2026-04-08 10:40:10, Yafang Shao wrote:
> On Tue, Apr 7, 2026 at 11:08 PM Petr Mladek <pmladek@suse.com> wrote:
> >
> > On Tue 2026-04-07 17:45:31, Yafang Shao wrote:
> > > On Tue, Apr 7, 2026 at 11:16 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > On Tue, Apr 7, 2026 at 10:54 AM Song Liu <song@kernel.org> wrote:
> > > > >
> > > > > On Mon, Apr 6, 2026 at 2:12 PM Joe Lawrence <joe.lawrence@redhat.com> wrote:
> > > > > [...]
> > > > > > > > > - The regular livepatches are cumulative, have the replace flag; and
> > > > > > > > >   are replaceable.
> > > > > > > > > - The occasional "off-band" livepatches do not have the replace flag,
> > > > > > > > >   and are not replaceable.
> > > > > > > > >
> > > > > > > > > With this setup, for systems with off-band livepatches loaded, we can
> > > > > > > > > still release a cumulative livepatch to replace the previous cumulative
> > > > > > > > > livepatch. Is this the expected use case?
> > > > > > > >
> > > > > > > > That matches our expected use case.
> > > > > > >
> > > > > > > If we really want to serve use cases like this, I think we can introduce
> > > > > > > some replace tag concept: Each livepatch will have a tag, u32 number.
> > > > > > > Newly loaded livepatch will only replace existing livepatch with the
> > > > > > > same tag. We can even reuse the existing "bool replace" in klp_patch,
> > > > > > > and make it u32: replace=0 means no replace; replace > 0 are the
> > > > > > > replace tag.
> > > > > > >
> > > > > > > For current users of cumulative patches, all the livepatch will have the
> > > > > > > same tag, say 1. For your use case, you can assign each user a
> > > > > > > unique tag. Then all these users can do atomic upgrades of their
> > > > > > > own livepatches.
> > > > > > >
> > > > > > > We may also need to check whether two livepatches of different tags
> > > > > > > touch the same kernel function. When that happens, the later
> > > > > > > livepatch should fail to load.
> >
> > I still think how to make the hybrid mode more secure:
> >
> >     + The isolated sets of livepatched functions look like a good rule.
> >     + What about isolating the shadow variables/states as well?
> 
> We might consider extending the klp_shadow_* API to support the new
> livepatch tag.

It would be nice to associate shadow variables with states so that
we could check which shadow variables are used by each livepatch.

It is partially implemented in my earlier RFC, see
https://lore.kernel.org/all/20250115082431.5550-3-pmladek@suse.com/


> > > > That sounds like a viable solution. I'll look into it and see how we
> > > > can implement it.
> > >
> > > Does the following change look good to you ?
> > >
> > > Subject: [PATCH] livepatch: Support scoped atomic replace using replace tags
> > >
> > > Extend the replace attribute from a boolean to a u32 to act as a replace
> > > tag. This introduces the following semantics:
> > >
> > >   replace = 0: Atomic replace is disabled. However, this patch remains
> > >                eligible to be superseded by others.
> > >   replace > 0: Enables tagged replace (default is 1). A newly loaded
> > >                livepatch will only replace existing patches that share the
> > >                same tag.
> > >
> > > To maintain backward compatibility, a patch with replace == 0 does not
> > > trigger an outgoing atomic replace, but remains eligible to be superseded
> > > by any incoming patch with a valid replace tag.
> > >
> > > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > > index ba9e3988c07c..417c67a17b99 100644
> > > --- a/include/linux/livepatch.h
> > > +++ b/include/linux/livepatch.h
> > > @@ -123,7 +123,11 @@ struct klp_state {
> > >   * @mod:       reference to the live patch module
> > >   * @objs:      object entries for kernel objects to be patched
> > >   * @states:    system states that can get modified
> > > - * @replace:   replace all actively used patches
> > > + * @replace:   replace tag:
> > > + *             = 0: Atomic replace is disabled; however, this patch remains
> > > + *                  eligible to be superseded by others.
> >
> > This is weird semantic. Which livepatch tag would be allowed to
> > supersede it, please?
> >
> > Do we still need this category?
> 
> It can be superseded by any livepatch that has a non-zero tag set.

And this exactly the weird thing.

A patch with the .replace flag set is supposed to obsolete all already
installed livepatches. It means that it should provide all existing
fixes and features.

Now, we want to introduce a replace flag/set which would allow to
replace/obsolete only the livepatch with the same tag/set number.
And we want to prevent conflicts by making sure that livepatches with
different tag/set number will never livepatch the same function.

Obviously, livepatches with different tag/set number could not
obsolete the same no-replace livepatch. They would need to livepatch
the same functions touched by the no-replace livepatch and would
conflict.

So, I suggest to remove the no-replace mode completely. It should
not be needed. A livepatch which should be installed in parallel
will simply use another unique tag/set number.

> This ensures backward compatibility: while a non-atomic-replace
> livepatch can be superseded by an atomic-replace one, the reverse is
> not permitted—an atomic-replace livepatch cannot be superseded by a
> non-atomic one.

IMHO, the backward compatibility would just create complexity and mess
in this case.

> > > + *             > 0: Atomic replace is enabled. Only existing patches with a
> > > + *                  matching replace tag will be superseded.
> > >   * @list:      list node for global list of actively used patches
> > >   * @kobj:      kobject for sysfs resources
> > >   * @obj_list:  dynamic list of the object entries
> > > @@ -137,7 +141,7 @@ struct klp_patch {
> > >         struct module *mod;
> > >         struct klp_object *objs;
> > >         struct klp_state *states;
> > > -       bool replace;
> > > +       unsigned int replace;
> >
> > This already breaks the backward compatibility
> 
> It doesn't break backward compatibility.

It does. Livepatches with .replace flag set would need to define:

	struct livepatch patch = {
		.replace = <number>,
	}

instead of

	struct livepatch patch = {
		.replace = true,
	}

Best Regards,
Petr
