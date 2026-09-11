Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3BE3A0E86;
	Fri, 11 Sep 2026 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789107387; cv=none; b=lUpIExs9xU2Hc3d5NTvnrvD4JIgpG7Ex1qw3jfJJs75O28bBFoWsDlMmbP8Qvoe2S4mOMLzXco0aZn6dnu9X789N20Ziff4cZQPTINelVwiemJ6KjVAYCOh7VfcWwXZ7uGBPEVvf85e8FmXqpdx7ZSM7WHhPWbFEyK3n0v/H9ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789107387; c=relaxed/simple;
	bh=CfOksVLUV1Ea73r0dqtEQHcC87P3L6wWw8avOJAAQGM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nT9x2RqFo03wrT9iqf0fkG9/cBNDr4eDM3KDjdwuQk4sEy4cvOq+G60ogrprOiliW4uy2UWCYhsSJipAI7ymUIZ7PKL/2rnEzLfGfCEJkEh23vVZOx7kqrWItNzLe/sIJomDX8ABH/Ex1Bh2l+fs96RFn5xPhnWo5ctj2uBC6VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAQH+gGY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAQH+gGY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 821401F000FF;
	Fri, 11 Sep 2026 06:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789107386;
	bh=FeqXMA8IIsuw3Bo3s6IikFZ8TcQWGZ07dRERboDu9wU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BAQH+gGYpy4oo9sUsyrqQnrsDNIXCE17tcvebrHtzQfPKUezQkFC8/X/WAIzoGgVn
	 jVo8N3RLvSl7dJrOY8Z2S5J015d2uIn2jMR2vG0XJjsEQkPe+PHelPoy6njvEZT3H1
	 9urmATZNGrv4PsjbT8yO+Gg6TtF1gocz9r4Mp40HiD4we7kPoOv4MbBzddNO3PS1AL
	 4R8hno71pkyYNoRubTowW0WQe+xF5hruGtZF+UtqXTWdyybOZnf813Bv16K2M5zoIH
	 oZAHsE9ZMkcOtTkeDN00c5X7FEtlx2WTasMVMjelohJoMeZTeMg5UCZZTzbvXxpd9k
	 xZgf9FOngow+Q==
Date: Fri, 11 Sep 2026 15:16:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Breno Leitao
 <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>, Douglas
 Anderson <dianders@chromium.org>, Huacai Chen <chenhuacai@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] bootconfig: Fix integer overflow in initrd size
 check
Message-Id: <20260911151621.a111896e0cd75bb3ebbe232b@kernel.org>
In-Reply-To: <CABFDxMHKQpa_WGk-RhEqQtzZoNfvZMj3J8JSYQn4-=RG+R1q6A@mail.gmail.com>
References: <178905331374.213925.295025394754459843.stgit@devnote2>
	<178905333479.213925.1358412668943562406.stgit@devnote2>
	<CABFDxMHKQpa_WGk-RhEqQtzZoNfvZMj3J8JSYQn4-=RG+R1q6A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 01:29:48 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> On Fri, Sep 11, 2026 at 12:15 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > Sashiko reported that in get_boot_config_from_initrd(), a crafted initrd
> > with a huge bootconfig size (such as 0xFFFFFFFF) can cause the pointer
> > arithmetic:
> >
> >     data = ((void *)hdr) - size;
> >
> > to wrap around on 32-bit systems (or when pointer subtraction overflows).
> > Because data wraps around, the subsequent bounds check:
> >
> >     if ((unsigned long)data < initrd_start)
> >
> > evaluates to false, bypassing the check. The kernel then calls
> > xbc_calc_checksum(data, size), which attempts to read 4GB of memory,
> > hitting unmapped pages and triggering a fatal kernel page fault during
> > early boot. Furthermore, on 64-bit systems with an initrd > 4.29 GB, an
> > unbounded 32-bit size can similarly bypass the initrd_start check.
> >
> > Fix this by:
> > 1. Ensuring the initrd is at least large enough to contain the bootconfig
> >    footer and verifying hdr is within the initrd bounds.
> > 2. Checking that size does not exceed XBC_DATA_MAX and does not exceed
> >    the available space between initrd_start and hdr before performing
> >    pointer subtraction.
> >
> > Fixes: de462e5f1071 ("bootconfig: Fix to remove bootconfig data from initrd while boot")
> > Cc: stable@vger.kernel.org
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://lore.kernel.org/all/20260910010137.EE0431F000FF@smtp.kernel.org/
> > Assisted-by: Antigravity:gemini-3.8-flash
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v4:
> >   - Accurate the error message for size > XBC_DATA_MAX in
> >     get_boot_config_from_initrd().
> >   - Remove redundant (and wrong) size >= XBC_DATA_MAX check from
> >     setup_boot_config().
> > ---
> >  init/main.c |   25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/init/main.c b/init/main.c
> > index 2613d3f9b3ce..16749bb7a219 100644
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -277,7 +277,8 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
> >         u8 *hdr;
> >         int i;
> >
> > -       if (!initrd_end)
> > +       if (!initrd_end || initrd_end < initrd_start ||
> > +           initrd_end - initrd_start < BOOTCONFIG_MAGIC_LEN + 8)
> >                 return NULL;
> 
> (nit) how about moving BOOTCONFIG_FOOTER_SIZE from tools and using it instead?

OK, that will be done in cleanup patch.

> 
> >         data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> > @@ -294,16 +295,26 @@ static void * __init get_boot_config_from_initrd(size_t *_size)
> >
> >  found:
> >         hdr = (u8 *)(data - 8);
> > +       if ((unsigned long)hdr < initrd_start)
> > +               return NULL;
> > +
> >         size = get_unaligned_le32(hdr);
> >         csum = get_unaligned_le32(hdr + 4);
> >
> > -       data = ((void *)hdr) - size;
> > -       if ((unsigned long)data < initrd_start) {
> > -               pr_err("bootconfig size %d is greater than initrd size %ld\n",
> > +       if (size > XBC_DATA_MAX) {
> > +               pr_err("bootconfig size %u is greater than max size %d\n",
> > +                       size, XBC_DATA_MAX);
> > +               return NULL;
> > +       }
> > +
> > +       if (size > ((unsigned long)hdr - initrd_start)) {
> > +               pr_err("bootconfig size %u is greater than initrd size %lu\n",
> >                         size, initrd_end - initrd_start);
> >                 return NULL;
> >         }
> >
> > +       data = ((void *)hdr) - size;
> > +
> >         if (xbc_calc_checksum(data, size) != csum) {
> >                 pr_err("bootconfig checksum failed\n");
> >                 return NULL;
> > @@ -394,12 +405,6 @@ static void __init setup_boot_config(void)
> >                 return;
> >         }
> >
> > -       if (size >= XBC_DATA_MAX) {
> > -               pr_err("bootconfig size %ld greater than max size %d\n",
> > -                       (long)size, XBC_DATA_MAX);
> > -               return;
> > -       }
> > -
> 
> Nice cleanup!
> 
> >         ret = xbc_init(data, size, &msg, &pos);
> >         if (ret < 0) {
> >                 if (pos < 0)
> >
> 
> Thanks for doing this work!
> 
> Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> 

Thanks!


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
