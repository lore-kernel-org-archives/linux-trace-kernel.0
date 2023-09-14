Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D0EEAA56
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 14 Sep 2023 16:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjINQxz (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 14 Sep 2023 12:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjINQxz (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:53:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4152ACE
        for <linux-trace-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:53:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66406C433C8;
        Thu, 14 Sep 2023 16:53:49 +0000 (UTC)
Date:   Thu, 14 Sep 2023 12:54:10 -0400
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
Subject: Re: [PATCH 3/8] usb: udc: trace: reduce buffer usage of trace event
Message-ID: <20230914125410.432ca343@gandalf.local.home>
In-Reply-To: <20230914100302.30274-4-quic_linyyuan@quicinc.com>
References: <20230914100302.30274-1-quic_linyyuan@quicinc.com>
        <20230914100302.30274-4-quic_linyyuan@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, 14 Sep 2023 18:02:57 +0800
Linyu Yuan <quic_linyyuan@quicinc.com> wrote:

> Save u32 members into trace event ring buffer and parse it for possible
> bit fields.
> 
> Use new DECLARE_EVENT_CLASS_PRINT_INIT() class macro for output stage.
> 
> Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
> ---
>  drivers/usb/gadget/udc/trace.h | 154 +++++++++++++++------------------
>  1 file changed, 69 insertions(+), 85 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/trace.h b/drivers/usb/gadget/udc/trace.h
> index a5ed26fbc2da..e1754667f1d2 100644
> --- a/drivers/usb/gadget/udc/trace.h
> +++ b/drivers/usb/gadget/udc/trace.h
> @@ -17,7 +17,7 @@
>  #include <asm/byteorder.h>
>  #include <linux/usb/gadget.h>
>  
> -DECLARE_EVENT_CLASS(udc_log_gadget,
> +DECLARE_EVENT_CLASS_PRINT_INIT(udc_log_gadget,
>  	TP_PROTO(struct usb_gadget *g, int ret),
>  	TP_ARGS(g, ret),
>  	TP_STRUCT__entry(
> @@ -25,20 +25,7 @@ DECLARE_EVENT_CLASS(udc_log_gadget,
>  		__field(enum usb_device_speed, max_speed)
>  		__field(enum usb_device_state, state)
>  		__field(unsigned, mA)
> -		__field(unsigned, sg_supported)
> -		__field(unsigned, is_otg)
> -		__field(unsigned, is_a_peripheral)
> -		__field(unsigned, b_hnp_enable)
> -		__field(unsigned, a_hnp_support)
> -		__field(unsigned, hnp_polling_support)
> -		__field(unsigned, host_request_flag)
> -		__field(unsigned, quirk_ep_out_aligned_size)
> -		__field(unsigned, quirk_altset_not_supp)
> -		__field(unsigned, quirk_stall_not_supp)
> -		__field(unsigned, quirk_zlp_not_supp)
> -		__field(unsigned, is_selfpowered)
> -		__field(unsigned, deactivated)
> -		__field(unsigned, connected)
> +		__field(u32, gdw1)
>  		__field(int, ret)
>  	),
>  	TP_fast_assign(
> @@ -46,39 +33,35 @@ DECLARE_EVENT_CLASS(udc_log_gadget,
>  		__entry->max_speed = g->max_speed;
>  		__entry->state = g->state;
>  		__entry->mA = g->mA;
> -		__entry->sg_supported = g->sg_supported;
> -		__entry->is_otg = g->is_otg;
> -		__entry->is_a_peripheral = g->is_a_peripheral;
> -		__entry->b_hnp_enable = g->b_hnp_enable;
> -		__entry->a_hnp_support = g->a_hnp_support;
> -		__entry->hnp_polling_support = g->hnp_polling_support;
> -		__entry->host_request_flag = g->host_request_flag;
> -		__entry->quirk_ep_out_aligned_size = g->quirk_ep_out_aligned_size;
> -		__entry->quirk_altset_not_supp = g->quirk_altset_not_supp;
> -		__entry->quirk_stall_not_supp = g->quirk_stall_not_supp;
> -		__entry->quirk_zlp_not_supp = g->quirk_zlp_not_supp;
> -		__entry->is_selfpowered = g->is_selfpowered;
> -		__entry->deactivated = g->deactivated;
> -		__entry->connected = g->connected;
> +		__entry->gdw1 = g->dw1;
>  		__entry->ret = ret;
>  	),
> -	TP_printk("speed %d/%d state %d %dmA [%s%s%s%s%s%s%s%s%s%s%s%s%s%s] --> %d",
> +	TP_printk("speed %d/%d state %d %dmA [%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s] --> %d",
>  		__entry->speed, __entry->max_speed, __entry->state, __entry->mA,
> -		__entry->sg_supported ? "sg:" : "",
> -		__entry->is_otg ? "OTG:" : "",
> -		__entry->is_a_peripheral ? "a_peripheral:" : "",
> -		__entry->b_hnp_enable ? "b_hnp:" : "",
> -		__entry->a_hnp_support ? "a_hnp:" : "",
> -		__entry->hnp_polling_support ? "hnp_poll:" : "",
> -		__entry->host_request_flag ? "hostreq:" : "",
> -		__entry->quirk_ep_out_aligned_size ? "out_aligned:" : "",
> -		__entry->quirk_altset_not_supp ? "no_altset:" : "",
> -		__entry->quirk_stall_not_supp ? "no_stall:" : "",
> -		__entry->quirk_zlp_not_supp ? "no_zlp" : "",
> -		__entry->is_selfpowered ? "self-powered:" : "bus-powered:",
> -		__entry->deactivated ? "deactivated:" : "activated:",
> -		__entry->connected ? "connected" : "disconnected",
> -		__entry->ret)
> +		tg.sg_supported ? "sg:" : "",
> +		tg.is_otg ? "OTG:" : "",
> +		tg.is_a_peripheral ? "a_peripheral:" : "",
> +		tg.b_hnp_enable ? "b_hnp:" : "",
> +		tg.a_hnp_support ? "a_hnp:" : "",
> +		tg.a_alt_hnp_support ? "a_alt_hnp:" : "",
> +		tg.hnp_polling_support ? "hnp_poll:" : "",
> +		tg.host_request_flag ? "hostreq:" : "",
> +		tg.quirk_ep_out_aligned_size ? "out_aligned:" : "",
> +		tg.quirk_altset_not_supp ? "no_altset:" : "",
> +		tg.quirk_stall_not_supp ? "no_stall:" : "",
> +		tg.quirk_zlp_not_supp ? "no_zlp" : "",
> +		tg.quirk_avoids_skb_reserve ? "no_skb_reserve" : "",
> +		tg.is_selfpowered ? "self-powered:" : "bus-powered:",
> +		tg.deactivated ? "deactivated:" : "activated:",
> +		tg.connected ? "connected" : "disconnected",
> +		tg.lpm_capable ? "lpm-capable" : "",
> +		tg.wakeup_capable ? "wakeup-capable" : "",
> +		tg.wakeup_armed ? "wakeup-armed" : "",

You can accomplish the above using __print_flags(), if you make it into a
bitmask, and that make a macro for each bit.

> +		__entry->ret),
> +	TP_printk_init(
> +		struct usb_gadget tg;
> +		tg.dw1 = __entry->gdw1;
> +	)
>  );
>  
>  DEFINE_EVENT(udc_log_gadget, usb_gadget_frame_number,
> @@ -141,38 +124,36 @@ DEFINE_EVENT(udc_log_gadget, usb_gadget_activate,
>  	TP_ARGS(g, ret)
>  );
>  
> -DECLARE_EVENT_CLASS(udc_log_ep,
> +DECLARE_EVENT_CLASS_PRINT_INIT(udc_log_ep,
>  	TP_PROTO(struct usb_ep *ep, int ret),
>  	TP_ARGS(ep, ret),
>  	TP_STRUCT__entry(
> -		__string(name, ep->name)
> -		__field(unsigned, maxpacket)
> -		__field(unsigned, maxpacket_limit)
> -		__field(unsigned, max_streams)
> -		__field(unsigned, mult)
> -		__field(unsigned, maxburst)
> -		__field(u8, address)
> -		__field(bool, claimed)
> -		__field(bool, enabled)
> +		__field(u32, edw3)
> +		__field(u32, edw1)
> +		__field(u32, edw2)
>  		__field(int, ret)
>  	),
>  	TP_fast_assign(
> -		__assign_str(name, ep->name);
> -		__entry->maxpacket = ep->maxpacket;
> -		__entry->maxpacket_limit = ep->maxpacket_limit;
> -		__entry->max_streams = ep->max_streams;
> -		__entry->mult = ep->mult;
> -		__entry->maxburst = ep->maxburst;
> -		__entry->address = ep->address,
> -		__entry->claimed = ep->claimed;
> -		__entry->enabled = ep->enabled;
> +		__entry->edw3 = ep->dw3;
> +		__entry->edw1 = ep->dw1;
> +		__entry->edw2 = ep->dw2;
>  		__entry->ret = ret;
>  	),
>  	TP_printk("%s: mps %d/%d streams %d mult %d burst %d addr %02x %s%s --> %d",
> -		__get_str(name), __entry->maxpacket, __entry->maxpacket_limit,
> -		__entry->max_streams, __entry->mult, __entry->maxburst,
> -		__entry->address, __entry->claimed ? "claimed:" : "released:",
> -		__entry->enabled ? "enabled" : "disabled", ret)
> +		__s, te.maxpacket, te.maxpacket_limit,
> +		te.max_streams, te.mult, te.maxburst,
> +		te.address, te.claimed ? "claimed:" : "released:",
> +		te.enabled ? "enabled" : "disabled", ret),
> +	TP_printk_init(
> +		struct usb_ep te;
> +		char __s[9];
> +		te.dw1 = __entry->edw1;
> +		te.dw2 = __entry->edw2;
> +		te.dw3 = __entry->edw3;
> +		snprintf(__s, 9, "ep%d%s", te.address, \
> +			(te.caps.dir_in && te.caps.dir_out) ? "" : \
> +			te.caps.dir_in ? "in" : "out");

Note, there's a temp buffer trace_seq 'p' available for use as well. See
both include/trace/events/libata.h and include/trace/events/scsi.h:

  const char *libata_trace_parse_status(struct trace_seq*, unsigned char);
  #define __parse_status(s) libata_trace_parse_status(p, s)

I think that can be used instead of adding this TP_printk_init().

-- Steve


> +	)
>  );
>  
>  DEFINE_EVENT(udc_log_ep, usb_ep_set_maxpacket_limit,
> @@ -215,44 +196,47 @@ DEFINE_EVENT(udc_log_ep, usb_ep_fifo_flush,
>  	TP_ARGS(ep, ret)
>  );
>  
> -DECLARE_EVENT_CLASS(udc_log_req,
> +DECLARE_EVENT_CLASS_PRINT_INIT(udc_log_req,
>  	TP_PROTO(struct usb_ep *ep, struct usb_request *req, int ret),
>  	TP_ARGS(ep, req, ret),
>  	TP_STRUCT__entry(
> -		__string(name, ep->name)
> +		__field(u32, edw3)
>  		__field(unsigned, length)
>  		__field(unsigned, actual)
>  		__field(unsigned, num_sgs)
>  		__field(unsigned, num_mapped_sgs)
> -		__field(unsigned, stream_id)
> -		__field(unsigned, no_interrupt)
> -		__field(unsigned, zero)
> -		__field(unsigned, short_not_ok)
> +		__field(u32, rdw1)
>  		__field(int, status)
>  		__field(int, ret)
>  		__field(struct usb_request *, req)
>  	),
>  	TP_fast_assign(
> -		__assign_str(name, ep->name);
> +		__entry->edw3 = ep->dw3;
>  		__entry->length = req->length;
>  		__entry->actual = req->actual;
>  		__entry->num_sgs = req->num_sgs;
>  		__entry->num_mapped_sgs = req->num_mapped_sgs;
> -		__entry->stream_id = req->stream_id;
> -		__entry->no_interrupt = req->no_interrupt;
> -		__entry->zero = req->zero;
> -		__entry->short_not_ok = req->short_not_ok;
> +		__entry->rdw1 = req->dw1;
>  		__entry->status = req->status;
>  		__entry->ret = ret;
>  		__entry->req = req;
>  	),
>  	TP_printk("%s: req %p length %d/%d sgs %d/%d stream %d %s%s%s status %d --> %d",
> -		__get_str(name),__entry->req,  __entry->actual, __entry->length,
> -		__entry->num_mapped_sgs, __entry->num_sgs, __entry->stream_id,
> -		__entry->zero ? "Z" : "z",
> -		__entry->short_not_ok ? "S" : "s",
> -		__entry->no_interrupt ? "i" : "I",
> -		__entry->status, __entry->ret
> +		__s,__entry->req,  __entry->actual, __entry->length,
> +		__entry->num_mapped_sgs, __entry->num_sgs, tr.stream_id,
> +		tr.zero ? "Z" : "z",
> +		tr.short_not_ok ? "S" : "s",
> +		tr.no_interrupt ? "i" : "I",
> +		__entry->status, __entry->ret),
> +	TP_printk_init(
> +		struct usb_ep te;
> +		struct usb_request tr;
> +		char __s[9];
> +		te.dw3 = __entry->edw3;
> +		tr.dw1 = __entry->rdw1;
> +		snprintf(__s, 9, "ep%d%s", te.address, \
> +			(te.caps.dir_in && te.caps.dir_out) ? "" : \
> +			te.caps.dir_in ? "in" : "out");
>  	)
>  );
>  

