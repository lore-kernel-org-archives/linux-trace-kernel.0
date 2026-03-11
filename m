Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED61E30594F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234971; cv=none; b=aROYfejJUC2sJIymX4rAvAw8N/OuXpkw/ULqUG7J7b0xx6CjrN9pxf12O9D/XmcWpC2vkOVC12y9JMazk74JcOAYMCFkcjlARKfyb8ybFnD07FXRoUkLOHFjjj/vP08EMqTGemP+vipfF2yurRzKKFVl7VFDRHRt67NWt/cuyE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234971; c=relaxed/simple;
	bh=bQRlE5OR+3/41N9B/xBGXfMeOTv3hgeQ2WrY6jcTpBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fjrC5WgzOX4Q1FQASlGYMYhwefWiV/1AzMpyO2xd8Z+QU9unll77tV2lXIt4l3hYmoJbeuAvwJ9kO4jU/mKPpfBYT1Q+dDgC2DyYyHD5H3zycdNgiurXd8yPauD/Cf4ab2HYjURDC6VXBM6OJH9AnbQIgSUvd5Gk7AcR2tnzdoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56b18f05f49so2419059e0c.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 06:16:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773234969; x=1773839769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
        b=sVt68R0U6ourYfrZdbCKpraMynSN7Thkrq+Xojjgg8CbUSk4LtHaY0xsQ7kDfRBMQv
         bPzZue8YrbqWbnJb5V9bxkEKuPthfY26Gqk8b6Gpef1CZjYiGr+Nlh7ylr1BatHUIk/5
         HL98z3wOKadpmDTIZcM9ohaz0LIMpOUbugZeQfBxNmFdJRmJN3oAr6ErxRBQ2g/5wM5x
         8OYwcjO95KxBzBMvzkNz4H58iQbv2n6XjYli6EoDkmey/6I1yL7XEmXTQ9n5lI/k9VyL
         iV5pfA4x5PpYv2xuOShjHqGv6CHRNF/99qnRZy4MPI1/8xsLRTApjOrB25Q4IJuED4G0
         GuHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5Fn31Ysx8XQCK1xAtr1pPiSKrUGgGUVAge5tGRKGxPQn6mjP3+ySvusslZAtkGyPRIFmVIivceRhmBp3aj9HSIPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeLA6YCeDzeVfRLRwCEZIsL9rqmhCsuaU/4qM/qm1Ts1l+QZfs
	dWYnnryQmYK1ZlZvEyjxiyTgxAJx9HZJ2L/SNk/MpPW+MRZjF+8SgIxl1kI2dVxMmhI=
X-Gm-Gg: ATEYQzzoPK8VJhrqA4ibFhK67kB8/ErEgCbP0jkJHcoaKbGLG1x4kfq+qNtUxonGuPR
	CuoaOcDgZkaIUV6k1lZxYnwboGYs1aGQk8ArjzA/oa6knZwZijWN/cVwrdJIYjQvoSCMXmCZgmr
	RuKYTgd+xjIE6EKICkIJ8mAyg1v5vcKRCDjWt1lhklxuJCz0Jba3M9NfM4duobIoajak/aTNmhq
	flqQAF4twHCmJ/X6agKggt/LFr89k/qrZKXB3MgAMx24srbZW0FwF7NJbRNCsosJC3adF+Jr4VC
	YdIa/Bh7pQIxo1TkkMK0Y4u4HLMvLI2LewlxCeQP8CB8pNR8r8OMOPSV622jrFagcSgIJSZ44VF
	vPg65StHF5rlpf+6TqV5HZjRcSdiYhWixv8i9pFvapyW/Qg0DQgB4o2y1HMq9ED5bJ0okUMgdKs
	IvLaVeo0ot4oDBm+2akFDD0RVG5PczOZU+09DCMecksZW9BdjVEjEg8vpQtCr6QYLF
X-Received: by 2002:a05:6122:459b:b0:56a:f015:82c7 with SMTP id 71dfb90a1353d-56b4752d736mr943882e0c.9.1773234968880;
        Wed, 11 Mar 2026 06:16:08 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56b4646bdfasm925679e0c.13.2026.03.11.06.16.07
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5675d609621so11786883e0c.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 06:16:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZ81PjUGlVLZUGNW6YO/k1kVLjALqW2Gr1U3Wv0VA10bnJNavCR3cGQCB87uLFCUBEsfjv3PAtUnhsVqlq91GqwnA=@vger.kernel.org
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de> <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
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
	v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
