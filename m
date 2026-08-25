Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B094908AB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 22:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787698686; cv=pass; b=o93+r04lrYMXqKEw2UIvpjgiUFcuZmzomdNIojJif2XFfXeKbcG1xaqfkeK8hdXkp4GvWEXKZrFvrVtVKL/bMA4ktuTLxDV1zLrIsqOQAxRkbrKOGNzuCz7g/bgoVWCjT3PN+U4iGhGp8IV5NMcoX1Yyl8Q1eEOka0eZXef5GHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787698686; c=relaxed/simple;
	bh=j18BMtk+GdI95Z5Qzr8L7RFgv8ekFnOHMxTdrsUexVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MRV0Z8LrJUXVG0ZXFdKiRTxlNxyFDV+WdpR9DliihMXno+ECyo2qXZlGvQ2B1gVLJ+oGFClQtDYuCNcGpNkZ20+ZgrhHfhSu2QlEO63s7VelZ99NA0PIepWaU8D6MaSoKxoh9QqsMCHn7H2vRMgCObpxMLTcE85EhHwtupn3u6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkLRENIj; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkLRENIj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9ecd7216cso227882a34.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 15:58:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787698683; cv=none;
        d=google.com; s=arc-20260327;
        b=kjdAgRxuxJAch+mio9ocLlyns6hj+K/3WG/AgZiAfVhAXmNpwXJHN6y9eo4sIksePS
         VL2ZFmEtUOs/1t7jni6J2cW21jquU6L/9Vyv35F/Jd509lUCbF0d0v1/GXar3iFhRLIt
         Ljg+3Vg/YGzTIu0ApO1ODlxY0RMzr58DRSvkJoTaJh9lTz5pZXp+IUtukWZ7GZpT/sCL
         6DG28tappvkTkDk3la/JvqD2e4gExkMSnuayHwTOqUFbn+9h/4+rg6zMkyJlL8LIWMkk
         q56zOKY6JkJaRB7Jzy5+VwAV1TCxkzqHqzhdYA/3ADAFqLmB6duvIOGn6zhm8OnrGrb4
         pHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j18BMtk+GdI95Z5Qzr8L7RFgv8ekFnOHMxTdrsUexVs=;
        fh=TusQfaG/emylQYokcim4SuLSR5IvmOqi7c1x/dSzwn4=;
        b=c54KmLWIfd6V6Vh93Usl86FDTkBQqzhEFLjwZsXuM73PRGVIKIoee3DkZIBHbUxr9f
         K5VAHhAnd9HXcD1/uN67sEGx0N8vp9KUqtVEZxHYJ6ZhBAVIevZS5CT9tB7pV17jS6W4
         VPQ591Qi3ySCKZcf8G+fXDwjQUD6RNHTCU3P4uS0h8DomQNoYSONUQIBdSGT/mkLOPbf
         Vch0m8p3ym4CAKpkv06eRT2qAJ/v/cwMNkbmRh3qGvbce+k0cCBdLWezZWcLrFl2v67o
         rAYZ0M6mov6tWLYnkX0QAy87Xc1XVa5qqbJBcdFNoh8lg99ArMhWJC58Umkn0J3A/+Bu
         dVoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787698683; x=1788303483; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j18BMtk+GdI95Z5Qzr8L7RFgv8ekFnOHMxTdrsUexVs=;
        b=PkLRENIjhvfrCBna0E0ACmLHuioBfuN/enAu35rUAENnND1zN5go9U8W5YlBD7pVE5
         vxkQ54TmMRZb71AhOJlxfR1PlqzetG0nWzYrAyEZTT0lunSkQunh6wrQ5rMF2xkNMv08
         n65RFcMKlKhhkXQApQ7r3NfgHSDGfF2dMzjH66sr+y0xQurs0GfW25tIE4QWqOdPgqOw
         UB3W+jONdaMUtgh4OzFLjERZFK2HHRzZaObEchVYtAkD6lR7VD/KhfSH3S5F1zJvw+i7
         uoy/fx/+pPSWXKKPDbeLBSG+eM15F1e/ptjNpEzrcleKxh8nsaz++ldr6SziNSv2F7gJ
         7ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787698683; x=1788303483;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=j18BMtk+GdI95Z5Qzr8L7RFgv8ekFnOHMxTdrsUexVs=;
        b=ibUXb1q4yyieS0jvaI0DvC9VX+vvZ7CCXqd0uDBq0ycftvPIE0JqV1CdWSpNvpw4zM
         R4+c08ZVVDcbCx5Xgi51AE0d12kv9mfKS6bzESDK2/CJeBzKF21/zIqsuHOXScbsjmri
         yGt5bTKfYmmHuagE2OnwJt2/BX65D0ThNJ33UM2mNpTS+psjRuHrn2tVuWoko9DssGtC
         stiGdk8QrRzTbXOaQvZP7HdExggNm2NQxNy8RJ5nqbvXzpP9OFZ3Iu6CHuyuy9ahTcqK
         NktSsSXFVSm3R9DiAOS7gAqW+O0kljF18Ys2YbQaI1cAhN36XCYuJ4a+CP5TYxjBoU9M
         NrIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpe6J28xWThRgKsWx6Emk8KGIddE0KDChJBVla256IT+FIantEMyR1KdTJgCZveGl26HqiS1/EUi24masQEO5rwG20=@vger.kernel.org
X-Gm-Message-State: AFuF++nPTZCfH1b8Kd9NjewW/4mdXHgW2B1OBm/Rt4n1zPPmuCkX7tUc
	Hg4ro8FZ1H/mzpRXbbf00j0lqwJGjsdB/YeO5dXKdQuSZQ8ZD883QnDhIiECgLNoFsHB/aDttE8
	cJcRNzWlyoYpXLZJyFnrXP+k8QjXYXEo=
X-Gm-Gg: AR+sD10N29IMp4cF337KzQtTOzxUabsT/VO97JE1y+8qkeBalCIPAVjK8r5nBxkT3uz
	zaXBxqeFjci5XN63w4avsNv1oroUKlKBMp7ot4pJUWaEK6nF+U1aPldLJlg8013IWh/biY0hezL
	P4yqkJp/7C9OTjWRr9oW3SYYPwTMjPUlAc88JX86/E6+Y7wc/pdXEzQyawUoElkpSjz3BGQ+F3W
	OA/F9dGUqFm5JjkX7bvG2n/Cqb2mPNPOHAIHik2aR2oPEehAznNbGrL+by1YpqU0zvbYKrXwkLa
	7UBJU5cQiDPf0U32kej8SG8WufhQ8bwftNeoDUk2nDDwy6WDqAonwUYcy/gyhL6IzrAMTUfpaUw
	=
X-Received: by 2002:a05:6830:2404:b0:7e9:cd7a:7c34 with SMTP id
 46e09a7af769-7f4c50348dcmr2437348a34.10.1787698683346; Tue, 25 Aug 2026
 15:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825215727.200803-1-devnexen@gmail.com> <20260825182851.6588b274@gandalf.local.home>
In-Reply-To: <20260825182851.6588b274@gandalf.local.home>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 25 Aug 2026 23:57:52 +0100
X-Gm-Features: AcwNN1U24yoreLYFs300P1_ay1ba-KhB3Ii--L16l9emiC5Lsm2x1JkCpNgXCoc
Message-ID: <CA+XhMqyocJOUwkZM4R9WzFG_RBdCvhSsVGtRhya9a36tMV6pBg@mail.gmail.com>
Subject: Re: [PATCH] eventfs: Initialise ei->children before it can be freed
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

ah forgot to check, fair :)

Cheers.

On Tue, 25 Aug 2026 at 23:28, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 25 Aug 2026 22:57:18 +0100
> David Carlier <devnexen@gmail.com> wrote:
>
> > eventfs_create_events_dir() runs INIT_LIST_HEAD(&ei->children) only after
> > tracefs_get_inode() succeeds, but that call's failure path jumps to "fail",
> > which calls cleanup_ei() and then free_ei(). free_ei() reads the list with
> > WARN_ON_ONCE(!list_empty(&ei->children)), and alloc_root_ei() uses
> > kzalloc(), so children.next is NULL there and the WARN fires.
> >
> > The path is reachable at runtime: mkdir /sys/kernel/tracing/instances/foo
> > ends up in create_event_toplevel_files() and eventfs_create_events_dir().
> >
> > Move both INIT_LIST_HEAD() calls up to right after the allocation.
> >
> > Fixes: f0ece16ffca7 ("eventfs: Use children field for rcu head and add memory barriers")
> > Signed-off-by: David Carlier <devnexen@gmail.com>
>
> Already queued by someone else.
>
> https://patch.msgid.link/20260824144653.54044-1-kartikey406@gmail.com
>
> -- Steve
