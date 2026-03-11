Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254B3148CF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238345; cv=none; b=Zw2X6x7+uTPpuj9FlLndbqlHc1Vy2yM86GvVudmi0yEfBUYd9lB2NStdvHEESTcnVVfRp3WsGsUqPjvpIMEND+DvCbBCpS+U7g5X4Dm8mt7lm1h0LPNm3QvkFrNQfnTQLxtMd6ktIbbg3ZNuXtXd82QzzD8a4ZnXxbFy3sK0vio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238345; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7AJ/PdIQfB+ALHkPja23m3DovX2ILPixYaJBs6N7FkBuNlvyQy8v9mW/fJBlEhQ/dmZz6V46SfDvCDrZuOGDz48cLl1S3/Maf53kqyjITK0Ki8RKu6KH0PowRXbK89ezxfAnoF8gb3G0nxF+9FWWmCvNWLRc28WVqvgbpEEXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2113167a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 07:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238343; x=1773843143;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=AyI5OPifasa6qLcyDRLyjRVGXggQ4+NPNkJP7JT5QfPLSvpVR97LfN+9Vyo7efdK5q
         fdHy01ZxIckzOw3qsNROpxKxE8aBJ1EQRa0PoeNxEZAsn8WzfYxVWcsPKE8irHf423oS
         u4qQrFhxhKxVCPoSQ/nB2LrRPrzFdjrKcRG6krAmn8E9HhJmcdYrYXe1qEORpxFPfD/j
         GgXfAqoXxMVM350r2bljdUlytVshPr9VzFqNCO9ySN1ZCTzl3xD4qBqsvJAWrX2fNJuM
         4/5hgbLgLMJSYWSNczMLypxYrtCrSBbhKA7SDqjNyR03YZxBBk8djTa2fIWUhlMOQaaQ
         Lttg==
X-Forwarded-Encrypted: i=1; AJvYcCWhOlTeEfSt6/b8RzgeoYK67gnfeYWPsAyZe5KROfwGFdJQsDtqhixWgo9CHIljC8b4YYdwgEW+rKj402isiDl+g2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvV+QOy66aInc2JpsiIgLjH8w1EARaJN2zZy6ZSxNJWiC9W8GU
	okvnQR+iF+8IW3lB8a05g2gYqg6HU0kmFZ7gmJkDHMPVNeVcj30ICx+pYtJYTQxyzGNuig==
X-Gm-Gg: ATEYQzwas2M6uwvT+a5JV7LPDkxzyPf4Ib/KrMEgRsmV7JjBWhac0LRVvheBbC0mKlb
	PybwlpZWwCXDKooULAMRgb3v5rJYh2Rt7nnHCmdeicyInulgiOl/AGvn6xeDE+fLXF4jDR12PXS
	9YxMBiHfBP+zLs/U40iW+3JmtTlKrxMi7PTnveHjOruy4lHbIhUgPCVm99DmB7JX/d70qHDeQXm
	6DCKJ6VZKSu6ASRBBjcBDvZafUniU3fC8L2tnqkpVDr0rYuJ6N0j1Xpdsh+18tbildnTwVnhu4r
	Be4ncWZgBiPXJoFzrDcHU/OKZwsjQ7edsz38stbt0wy6XYfGipFo1QtwhMA4L63OzTDLHJNc4c+
	ivnERWbLjdPpuVg+vcVLxb7Ietd5ZYVBzS7xRDnY9gLrkRfnTEGTBLto/6xrd4nSbqCf711Nad5
	/nNxCIKQBHoppcQ2bgJgfRj12Whk7rRNxknwSeFnTd0jFeRXvobqJ4kQIxprcs
X-Received: by 2002:a05:6402:20d3:20b0:660:cec5:4188 with SMTP id 4fb4d7f45d1cf-662ba74b397mr3327216a12.14.1773238342744;
        Wed, 11 Mar 2026 07:12:22 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6631532dba5sm551680a12.31.2026.03.11.07.12.22
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:12:22 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2113135a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 07:12:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWC2ERpqITVv2+SW6SR5myY1bxfxF4/RwyleVrZqXnT26XthvZ9lyLVI+ZQT7NDQpIMBuOVv04K36GW2yHJkuNNbyo=@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
