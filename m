Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA057EEAA58
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 16:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjINQmo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 12:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbjINQmo (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:42:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9251FE1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:42:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55899C433C8;
        Thu, 14 Sep 2023 16:42:38 +0000 (UTC)
Date:   Thu, 14 Sep 2023 12:42:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Bin Liu <b-liu@ti.com>, Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] usb: gadget: reduce usb gadget trace event buffer
 usage
Message-ID: <20230914124259.7bc383f8@gandalf.local.home>
In-Reply-To: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 14 Sep 2023 18:02:54 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> some trace event use an interger to to save a bit field info of gadget,
> also some trace save endpoint name in string forat, it all can be
> chagned to other way at trace event store phase.
> 
> bit field can be replace with a union interger member which include
> multiple bit fields.
> 
> ep name stringe can be replace to a interger which contaion number
> and dir info.
> 
> to allow trace output stage can get bit info from save interger,
> add DECLARE_EVENT_CLASS_PRINT_INIT() clas which allow user defined
> operation before print.
> 
> v1: https://lore.kernel.org/linux-usb/20230911042843.2711-1-quic_linyyuan@quicinc.com/
> v2: fix two compile issues that COMPILE_TEST not covered
>     https://lore.kernel.org/linux-usb/20230911112446.1791-1-quic_linyyuan@quicinc.com/
> v3: fix reviewer comments, allow bit fields work on both little and big endian
>     https://lore.kernel.org/linux-usb/20230912104455.7737-1-quic_linyyuan@quicinc.com/
> v4: add DECLARE_EVENT_CLASS_PRINT_INIT() new trace class and use it
> 

All these changes make it useless for user space. :-(

-- Steve

> Linyu Yuan (8):
>   trace: add new DECLARE_EVENT_CLASS_PRINT_INIT class type
>   usb: gadget: add anonymous definition in some struct for trace purpose
>   usb: udc: trace: reduce buffer usage of trace event
>   usb: cdns3: trace: reduce buffer usage of trace event
>   usb: dwc3: trace: reduce buffer usage of trace event
>   usb: cdns2: trace: reduce buffer usage of trace event
>   usb: mtu3: trace: reduce buffer usage of trace event
>   usb: musb: trace: reduce buffer usage of trace event
> 
>  drivers/usb/cdns3/cdns3-trace.h            | 201 ++++++++++++++-------
>  drivers/usb/cdns3/cdnsp-trace.h            | 105 +++++++----
>  drivers/usb/dwc3/trace.h                   |  99 ++++++----
>  drivers/usb/gadget/udc/cdns2/cdns2-trace.h | 175 ++++++++++++------
>  drivers/usb/gadget/udc/trace.h             | 154 +++++++---------
>  drivers/usb/mtu3/mtu3_trace.h              |  76 +++++---
>  drivers/usb/musb/musb_trace.h              |  20 +-
>  include/linux/tracepoint.h                 |  22 +++
>  include/linux/usb/gadget.h                 | 113 +++++++-----
>  include/trace/bpf_probe.h                  |   4 +
>  include/trace/perf.h                       |  43 +++++
>  include/trace/stages/stage3_trace_output.h |   3 +
>  include/trace/trace_events.h               | 118 ++++++++++++
>  13 files changed, 784 insertions(+), 349 deletions(-)
> 

