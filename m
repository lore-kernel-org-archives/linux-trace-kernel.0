Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8702E8B8A
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646660; cv=none; b=CxiKpVe/w3t1R7QG9uItM5eaQT7RvIIgM5TwB7aqSrElcg/dmQ0ggVdwWZZiZ9mrZ2kR7dpmSpBD2GIjilZHUK3SJdWzagD+D2lzBA4Tt+Fxr7OF7lkJMX4xYr0VJ0QBUPk/ARkKhKllUjqaajguy81vXfKopSeZLB5gxSR3DZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646660; c=relaxed/simple;
	bh=jFZjtktr1182f8BWsVbMJEHb9H4MNzz+xm/vLv4K1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcracJmxuYZ2IS3Zh8IC03t3En3J03MY3IgXX9ekO/MHJ5Qrdk8BtL+BljE6Aqq1Cewbgej8mOs3P91w1X8eW/tB38PIf8WLgyNMKMM3wmzoWXXifg16ql200Qh1uW3snUYzqDHFBrMH7LxTMJk1meC9sJ/2+SJsgvdzcVoC6ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Scmo/EJ+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Scmo/EJ+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43b87970468so4712332f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775646656; x=1776251456; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vfllRBgwiwa3h1YU32+J/3Xslzo7VJyKCR+sEXLOPdc=;
        b=Scmo/EJ+ekij29gx2CQSx27ITvBa/vg71uKIqGTyxtvEoc4ODr3I/8+pVOEglOpK5I
         SdoOTFP/ha9+eVfICmbo0AzaEr19G0QV/cuuk1hpEbANdcMkGMfbx+aWtl8hzDIW4BYr
         jh3bse40AqusVWoyFJ6OXswjb3tJ+cistJiPXnDN4VH/eeSTUcUjDVAs0thGX3gj84nM
         120ormNdhG6+CXwLNBhFFxSBrOPv6HEKau4TWb+kov0R4vstoPeApF6eKOom2WziCJXg
         hIpV6UhWkn1RNLiIwElYZdwXLNDEqIapPndFCkO97e6UYivlHNWsGpcc6NfE1DxXokHM
         bd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775646656; x=1776251456;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfllRBgwiwa3h1YU32+J/3Xslzo7VJyKCR+sEXLOPdc=;
        b=khKr2K8Mdb9gQ7MjuOWRfguohWdupOQL2/sxkLUWtCf/GnCHdhUigo0H3OuOa9W5pD
         eroeYdKtqBIqC3qqlvMcNnN2LGMTkzMIpnE8XLvSFuLJirataGYhAobq6+6PpKzZy3pc
         06/3U6rKQw4H3MTRlDgf5fDqnoBnhbOcLzMesvaftse6XhT+ea6067KEBCq1kub7FMqI
         +os/hEr3yUf0dAFMHBepYyJsr1VvG3YX+cMZxPd2A6GTQEKG6gxBT2s+diQxURP7GX9W
         lEiQDq1PHsrkhnapXhu8/3Hz+nqFIaSo1pJu4fdAT+ecaG0pFC9TLI0ot2esTWhpKTLh
         saPw==
X-Forwarded-Encrypted: i=1; AJvYcCUPB/kgU8PHO1nDi+CysdXpLO01qCcahoXwQ8CGR4s4p1Da2jymprq1ML6ljkiltwPeE/9pWeJwKTlaznItdffe/+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqkkHCFYcYhRZbcSeVIMInO3wq4S3gZj0syd25QMYy1GTxh2T8
	CnPM93D8LXmwxj1Te2eFol5wfAZhKzJLIIaSNzAGDUHfZjDlu0OPVLMLBfpCO5vOaoU=
X-Gm-Gg: AeBDieuEaE5i9LE81M8CFVcWpuUrlai9FcNHilTnC5NwrspMMwqgHeZESf53xVBNAuv
	xan08Pyfrx8LcKdhL1hddkJ7QPzAzmGo+bUMSNvqbpCQXjsQVclR4ZllV6/iHhgwUaHNp/AWPZ6
	fmLIcRvuOg3iK+pvfnx+m1kKP6RH9vECy/+nvFkHQo/dt91csY8jAXOGEi3e9PkGxPdSy4BHinK
	/Bu5Ms+/CdS0jajkuCwNcRiZ7G2/qAM2cX9zHrJuneQnLB1D/h72jbrvGc+qA1MNW3fox0SIS2c
	PyBWjHBQ+YhtYOIEmBJObisP06Xyh5zFalnWYHWQ5mhIVRYL7+Kc+Eo6GuFbZ04IscgAekoC9Wk
	+X+9sn4tKgCwiyPOg97ULdV3yyf/aji/b9fo9srLW3FPpuy3fQ7fqcEn0PFFIxOcM81m+VEz+8N
	IoZlqnCiZ11xP35CF8NcTyhZvv6w==
X-Received: by 2002:a05:6000:2282:b0:43b:54c9:85f4 with SMTP id ffacd0b85a97d-43d292df407mr31359155f8f.39.1775646656473;
        Wed, 08 Apr 2026 04:10:56 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a6f73sm61649889f8f.8.2026.04.08.04.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:10:55 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:10:53 +0200
From: Petr Mladek <pmladek@suse.com>
To: Song Liu <song@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Joe Lawrence <joe.lawrence@redhat.com>,
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
Message-ID: <adY3vej2kt5joAg4@pathway.suse.cz>
References: <CADBMgpy3e25EH5xbKMN5GeOK47jE6uzviknbt35V49_Y7zFj8A@mail.gmail.com>
 <CAPhsuW6p3YOv3_M_c0ThMcrNqNjT=7i46ekJBrWO_oGzQkxrxA@mail.gmail.com>
 <CALOAHbCbcw2jpjk9JD9yyf+SMpQ-s9FAonSaz7Gs4XUeP+w+2g@mail.gmail.com>
 <CAPhsuW4B00-grg9XJa+AO3xgGwM_u8FC+GH3JrkYZOJx4PuV8Q@mail.gmail.com>
 <adQhpBC2W9I6QW-g@redhat.com>
 <CAPhsuW66tuF+QZ0pVheWb5sC4NQ-9CXikq=zMrPBXTHcsVPjdg@mail.gmail.com>
 <CALOAHbDN_t-ZRO0g9_sQFCv0J6SPDFfwJCcwSzd4ww5XRkU0QA@mail.gmail.com>
 <CALOAHbCxPA0dtsx7L2kYn8wwBdM=krZyOpfRTBiDW9qfA_zmzQ@mail.gmail.com>
 <adUd0Mojbtrwmeod@pathway.suse.cz>
 <CAPhsuW7JhtbniZHFWGMrzeqdS=-EjCySFPgiOBv0zKJNRwzONA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW7JhtbniZHFWGMrzeqdS=-EjCySFPgiOBv0zKJNRwzONA@mail.gmail.com>

On Tue 2026-04-07 16:09:39, Song Liu wrote:
> On Tue, Apr 7, 2026 at 8:08 AM Petr Mladek <pmladek@suse.com> wrote:
> [...]
> > > + * @replace:   replace tag:
> > > + *             = 0: Atomic replace is disabled; however, this patch remains
> > > + *                  eligible to be superseded by others.
> >
> > This is weird semantic. Which livepatch tag would be allowed to
> > supersede it, please?
> >
> > Do we still need this category?
> >
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
> > This already breaks the backward compatibility by changing the type
> > and semantic of this field.
> 
> I was thinking if replace=0 means no replace, it is still backward
> compatible. Did I miss something?

IMHO, the semantic of the no-replace mode would be strange if
we introduce the hybrid mode. Especially, it would be strange when
it can be replaced by any livepatch with random replace tag/set.
Also it would just complicate the definition and detection of conflicts.

I am going to provide more details in the reply to Yafang.

Best Regards,
Petr
