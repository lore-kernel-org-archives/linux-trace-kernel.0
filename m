Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1219C352A1
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  7 Dec 2022 08:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiLGIVo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 7 Dec 2022 03:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiLGIVo (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:21:44 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADB728736;
        Wed,  7 Dec 2022 00:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3OfGGPupC9tBN51sttNXgzfuwcivEPZHKhGmzzh2++E=; b=AoTGkfDIaAEZS8sOQiaNQ45zW/
        UE19xUUmI9Fk7s1Ot9LsXdY/F/GsZvXvVbCIP70RgXXTmGxoxeHxXn0wlAs3IjlvPJtHszAHoSkJ+
        5mPuXMOEWOwakJAwK5fKvfhrZ//WgU4J8BmQ7wYp/BspqasOZd1/DBgaW+ZmX3YkHffVkCBHe4Jqb
        GccHT19MBSXv7/Z24SPc5JQH+siLuNL9rIjUWIJ+XYANXrUz1XlVLyuQqXzppd6kN1jBVEiFlQiuJ
        h+7xrhHHPi3nggNeG50gpNEBoH9Ksk81TN7x0rsLgQQGh44DSChEllaWalAFBtdc+94gW96pxFRB1
        HpXD1Jrw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2pgH-00Exf3-P1; Wed, 07 Dec 2022 08:21:29 +0000
Date:   Wed, 7 Dec 2022 00:21:29 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nick Alcock <nick.alcock@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-modules@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        eugene.loh@oracle.com, kris.van.hees@oracle.com
Subject: Re: [PATCH v10 05/13] kbuild: remove
 MODULE_LICENSE/AUTHOR/DESCRIPTION in non-modules
Message-ID: <Y5BNCbFyvNA1Xp/X@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 09:03:52PM -0800, Luis Chamberlain wrote:
> But I don't see the point in keeping things around just in case, if we
> want to keep things simple. Just use the SPDX license tag for the license.

It would be very helpful if we could just autogenerate the module
license information from the SPDX tags..
