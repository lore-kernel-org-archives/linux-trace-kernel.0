Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1007EF06
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657129; cv=none; b=M7aMw+TW0N/ByLemSr19OVcS41tQFhD1DSZtslQGN/G5GP0ms5iYky7OI0/isJuthWMmCUtKURCWt2lYfvwz1UX1IcHeWlF68yRh264Blzwf6odH60YCUjzQ53nXEZyGmo3ob98VY7Okl7AsU5quZKKsSJUsscnlafumdwis2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657129; c=relaxed/simple;
	bh=1UtYXCS2vfDZ/wH9mjGbxM9COQFwJYC4XgbeYbzWnpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpOrNckrOv2ZbaEfO0sVeF4uHgfDYrPcDFhK7mn8LaSwxJOvcJrG2T1VNsjDJvDZhMQzjRIRqlSfDbAeXw/JCT8pnvs5MlwJBu4yGm3KCTHL8qj2JIKb4obgubFbC0sHkDLpe/X0wlUpvDS+KHKL5f1Oxm+AZQReekyMy83c00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EW+aAlpU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EW+aAlpU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f082c2c92so3780104a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706657125; x=1707261925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSO2ChDnlAH86gKOgqytEYfVHkZEABWvmQ0LHebtTDM=;
        b=EW+aAlpU14rULpscwfxihdBCwFMRHB2diGRDjwNkvk5gSgJIl9cTPV4T7Z/op1/yo+
         JjluqXO5Wj2ew2MEXy0kV3Rxmh37yVcfHooCPF8SwAf6OS71uKup0hdTLQVoZdYSwjoR
         8AjIq0IdUJFlfoWamA5+ykBD67P6O2BT7kFKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657125; x=1707261925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSO2ChDnlAH86gKOgqytEYfVHkZEABWvmQ0LHebtTDM=;
        b=mthImpDkjs/Nrjc24XhI4RZ3fRqlLg7q2KTbX0M1S2sTE/I8dmpMhWuK0u0H1Z5W09
         /+vMDM984jEA5wb8+flhAVx9ztmsFnUQO70BZmTvDpBMR6FJUOlQvoSfmRVtsPmncTlG
         ckH0TbRJ5eoaau8M8HZA1697AbANK7lrOyrlAciaiNv2QWsR+DKS2aby0EPn6OajFzHW
         zqVbeROJX1U9D0V7FC63dz1grdiAApelMUUQPp7hUnhqwNMsKc80vNEqwQ7eV6pWRWTm
         f2pxgyhHK15vBYS0iNB20S5jw/eajccm/9+k5n3uHu2oZxItnWTtJnEZYZ80ZNvosn8g
         DtzA==
X-Gm-Message-State: AOJu0YyfoEgWYFKL/IN9Od3Rnf47EpRucnTWDN2tuTsoE9Cc43K2sIDT
	eYpK8DvSvRSvwKZOtcXa51giS7p8SFAvg8LF6PHktRt62+f5pUVvBw9hKyjS4vG/WR6rn06zI1Y
	ukIOuLQ==
X-Google-Smtp-Source: AGHT+IG2ft/EKVOKOv47/5s3IdtMLbswk93fNHM+anUbTeVQY5lWbg1VbQN8INbVteBV634WtaNKCw==
X-Received: by 2002:a05:6402:2792:b0:55e:f52d:97d with SMTP id b18-20020a056402279200b0055ef52d097dmr5729479ede.20.1706657125417;
        Tue, 30 Jan 2024 15:25:25 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id s4-20020a056402014400b0055f4558c602sm992552edu.67.2024.01.30.15.25.24
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 15:25:24 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f082c2c92so3780089a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:25:24 -0800 (PST)
X-Received: by 2002:aa7:c614:0:b0:55f:4bd8:499 with SMTP id
 h20-20020aa7c614000000b0055f4bd80499mr1595483edq.5.1706657124478; Tue, 30 Jan
 2024 15:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
 <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
 <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com> <20240130181057.278ac05c@gandalf.local.home>
In-Reply-To: <20240130181057.278ac05c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 15:25:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtX3aLPVLeSbyXEz7BGJGFbhXeH-788Nad=swajW72Wg@mail.gmail.com>
Message-ID: <CAHk-=wgtX3aLPVLeSbyXEz7BGJGFbhXeH-788Nad=swajW72Wg@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 15:10, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > At which point a name pointer would *just* fit in 96 bytes.
>
> Does that mean I should keep the kstrdup_const()?

You should check that my math matches reality and relevant
configurations, but yes, at 96 bytes that should fit exactly in one
slab entry on both x86-64 and arm64 (now that arm finally does sane
kmalloc sizes - for the longest time they were all 128-byte aligned
due to historical horrible DMA coherency issues).

But you might also add a comment to the eventfs_inode definition,
because if that ever changes, the math changes again. For example,
adding just one more attribute data would make it all fall apart.

If you *really* want to optimize that data structure, I think you can
make the child list be a 'hlist'. That makes the list head ('children'
becomes a 'hlist_head') smaller, even if the list entry ('list'
becomes a 'hlist_node') stays the same size.

             Linus
