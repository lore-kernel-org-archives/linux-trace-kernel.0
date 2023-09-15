Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1E7EDE9B8
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 15 Sep 2023 01:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjIOByZ (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 21:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjIOByQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 21:54:16 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B3F1C7D8B
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 18:51:20 -0700 (PDT)
Received: (qmail 1019565 invoked by uid 1000); 14 Sep 2023 21:51:19 -0400
Date:   Thu, 14 Sep 2023 21:51:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] usb: gadget: add anonymous definition in some struct
 for trace purpose
Message-ID: <eae2be47-f489-4f1b-91c7-f2f81304bfdb@rowland.harvard.edu>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
 <20230914100302.30274-3-quic_linyyuan@quicinc.com>
 <073cbfb2-2f18-4bf7-a313-b16bbcefa8e0@rowland.harvard.edu>
 <0c2ba115-826e-40d6-73ac-7ed67302c8eb@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2ba115-826e-40d6-73ac-7ed67302c8eb@quicinc.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 09:02:48AM +0800, Linyu Yuan wrote:
> 
> On 9/14/2023 10:54 PM, Alan Stern wrote:
> > You didn't include the version number in the Subject: line.  Undoubtedly
> > Greg's automatic error checker will warn you about this.  Unless the
> > version number is clearly marked for each patch, it's difficult for his
> > programs to tell which email message contains the most recent version.
> > 
> > On Thu, Sep 14, 2023 at 06:02:56PM +0800, Linyu Yuan wrote:
> > > Some UDC trace event will save usb udc information, but it use one int
> > > size buffer to save one bit information of usb udc, it is wast trace
> > > buffer.
> > > 
> > > Add anonymous union which have one u32 member can be used by trace event
> > > during fast assign stage to save more entries with same trace ring buffer
> > > size.
> > > 
> > > Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> > > ---
> > And you didn't include the version change information here, below the
> > "---" line.
> > 
> > Apart from that, this is a _lot_ better than before!  I don't know if
> > Greg will think this change is worth merging, but at least now it's
> > possible to read the code and understand what's going on.
> 
> 
> according Steven's comment, maybe will always save data in little endian at
> trace event
> 
> fast assign stage.
> 
> it will add definition of bit field back.

Yes, that would be even better because you wouldn't have to change the 
definition of struct usb_gadget or struct usb_endpoint at all.  The fast 
assign stage can simply do:

	__entry->dw1 = (g->sg_supported << 0) |
			(g->is_otg << 1) |
			...

and then you can easily access the individual bits in __entry.  It 
wouldn't be as fast but it would still save a lot of space.

Alan Stern
