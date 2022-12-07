Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D27C352A1
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  7 Dec 2022 05:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLGFKU (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 7 Dec 2022 00:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLGFKS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 00:10:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288354B00;
        Tue,  6 Dec 2022 21:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gmNqBY6w4AK9O4I8y3E96Tg5h7/Vhp7NSY32+7XVFbg=; b=PRXmY7eDUZPnaO0xmD5wSHn6Ni
        ak2PhljcKGOPoss6GNgxXq3Pplu9kwBBxyQH6sxlp31Gq9yzW+h6id1e7/CAZL1DhF9cilCQq8WA/
        8KmQrIdhK45DzPWbrTYe9mJPI3en1dSYcLKovFjRWU8PlwUalJuH5g7vFLJkMsk7yDrNVkgnSwcbl
        7FBFKQPXWeSESjoL6kWsAkIXEkMyeac/Ldus+mS6XzSPOp8HZmRENGk3Y7rtK8loWpqjlXyL8X9LC
        yPEK37qBsYcAUM4XPGYf2JLgXVIYsvSQNHlVu8uHaQespNdwt+7DRW4M1lbFlM33opfVffAe+qbx1
        32R5QvPA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2mh8-00BJwa-0p; Wed, 07 Dec 2022 05:10:10 +0000
Date:   Tue, 6 Dec 2022 21:10:10 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v10 05/13] kbuild: remove
 MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
Message-ID: <Y5AgMuMu75gne6Ka@bombadil.infradead.org>
References: <20221205163157.269335-1-nick.alcock@oracle.com>
 <20221205163157.269335-6-nick.alcock@oracle.com>
 <CAMuHMdVrP1sLGRS999q=2L-5JhxXwcjBLkQREdcJhDerg70OtA@mail.gmail.com>
 <87mt80l2py.fsf@esperi.org.uk>
 <5f0a5ea7-2d48-435f-aaa0-82b6ef8cfcc5@app.fastmail.com>
 <Y5AeuI4RD0tpzlp5@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5AeuI4RD0tpzlp5@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:03:52PM -0800, Luis Chamberlain wrote:
> On Tue, Dec 06, 2022 at 10:02:30PM +0100, Arnd Bergmann wrote:
> > On Tue, Dec 6, 2022, at 21:03, Nick Alcock wrote:
> > > On 6 Dec 2022, Geert Uytterhoeven uttered the following:
> > > Only MODULE_LICENSE invokes MODULE_FILE and thus ends up introducing a
> > > KBUILD_MODOBJS entry that triggers things going wrong iff not a module:
> > > so only it needs to go out (or be replaced with a variant that doesn't
> > > invoke MODULE_FILE, if you want to keep the license in too --
> > 
> > That sounds like a better alternative
> > 
> > > but if the thing is no longer a standalone entity at all I'm not sure
> > > what meaning it could possibly have).
> > 
> > As far as I can tell, the general trend is to make more things modules,
> > so there is a good chance that these come back eventually. If the
> > information in the MODULE_LICENSE field isn't wrong, I would just
> > leave it in there.
> 
> Tooling today uses it though to make a deterministic call on if something
> *can* be a module. In particular after commit 8b41fc4454e ("kbuild: create
> modules.builtin without Makefile.modbuiltin or tristate.conf") we rely on
> the module license tag to generate the modules.builtin file. This in
> turn is used to allow modprobe to *not* fail when trying to load a module
> which is built-in.
> 
> So we can't just disable the tag for when the code is built-in as *want*
> to carry it when modules are built-in, that is the point, to help
> userspace with this determination.
> 
> I don't think we want to revert 8b41fc4454e as it means we'd force Kbuild to
> traverse the source tree twice.
> 
> Geert's point was not keeping MODULE_LICENSE() but instead the other
> MODULE_*() crap for things which are not modules in case in the future
> code becomes a module...
> 
> But I don't see the point in keeping things around just in case, if we
> want to keep things simple. Just use the SPDX license tag for the license.

Or if you really want to keep it just make it an *eye-sore*, and comment it out.

I don't see why at build-time we should suffer.

  Luis
