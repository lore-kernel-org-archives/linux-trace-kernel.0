Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.64.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793944252;
	b=2IgZ39WHIFmX911EoFSexo0H3MAs9fu1knVSSFQSxcZ08gg4/p6XRQc9MoIUl9jh5wnG
	 z74K/GAnuzEqXNY5SIA4HpF2MdueZwWS6SCQQYTb56mS0u61ik5H3cdQHDWPzaIXUf+Ty
	 hbVSQNoSgrFUC2wGZYjs0Izu3e+92NCIohf5RIzywi1apEfaBAXJxMxBdFAxfH69KCns6
	 mHXbKBja/7lHvOnWOWK257EZ2gmIvqT5ZWYQt75qzHsZ1JiJyNaVwJdioM8lSQBATbo+U
	 KSjA957hQZ9XRno4XVF+iOLKWDoZWH/0B6L0svVusKjHhg3MIi4CKdMsgLNN4rrVVRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793944252;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Flowmailer-Platform:Feedback-ID;
	bh=7gsWLOgkyNbB2pZGgAc1CDd83KlICqOTlYcR5hqj6JA=;
	b=S/hlU9Zkf0u3qTIoEFz8MujmipcpVzre8PmwJ/zPvIXnQeDEfa3Fuu2Cuz9Z2pr6lDry
	 lf3aNZ6nGmGJA70yiDT2XxoruQ4DF8cXvYZSBAs+pQbi9uH/v/NdBv7GN0K/G7zIkouLk
	 It4wNOpQNc41ogqkB6t+lIaI9ZxfZwLcDt9HQZ/Qv/wgtA6Jh8YFnpWsuc2XuMQI3oehJ
	 tUjo+aZZHmEaTZvCjpgZ8BEEOMrl3rDqWXT3TkKmgs612Xx9i8yB0IunT4lWLv17ul/8w
	 fi/n/1+dOb4FDUuTlK7sCl1Y+b8VjAUV2SaoXa27VgyDr0k48ewyb/RAqWS+X2ITf3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	arc=none smtp.remote-ip=185.136.64.227
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC299606A329
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 05:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC299606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20261106055047290e87a5190002076b
        for <linux-trace-kernel@vger.kernel.org>;
        Fri, 06 Nov 2026 06:50:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Cc:References:In-Reply-To;
 bh=7gsWLOgkyNbB2pZGgAc1CDd83KlICqOTlYcR5hqj6JA=;
 b=Vhy+fE5N/708C8u8YWz2Bor5mam+oNFzAz7pOqixsa4RCir4lKG44dr4T84YIeHZx3kpFU
 KzwXHerT3V0oQuxPMmyl6OCOXEqyk426xXAAjphnj3ikH5QPL4cLEoOFM7sE1GCy19kurF1Z
 CGcI/DJwUOCekMazOviudGBkcTYJ0sI4MVCX0MBATBOCp8dmHkK8oC22rktVi5CwBrkU2kB7
 yNZyu4jYrQljlBUZkPKJmIMwebQ98xiLpVDCGWHlgwoKmVs9DPWgr1eWFboGT7zNCdSAof5P
 7BRqwdGB8zTMBhpKbICbT1/UFdXcO54k3UnaJXbrLFXJ3lIqZgEZRp2A==;
Date: Fri, 6 Nov 2026 13:50:30 +0800
From: Ding Meng <meng.ding@siemens.com>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, florian.bezdeka@siemens.com,
 jan.kiszka@siemens.com, wq.wang@siemens.com, gerhard@engleder-embedded.com,
 Jason Xing <kerneljasonxing@gmail.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin KaFai Lau <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri
 Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor
 Solodrai <ihor.solodrai@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
Message-ID: <eqrkw7wsawjtbvjkndmpik7jryb2sau6fdsu4njw6twn2lcfp3@k67o5wav5f5m>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <Tif4BSB0H3l8O1bLzRnhCE9hUYhsz6G3MIhQAgYZImUx1_8YwnCyzy89IV6OSTsXdHDT6fFf7rEL1qfRFJC9OPDHRlhl3cgNJyyE_mVlHWM=@1g4.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Tif4BSB0H3l8O1bLzRnhCE9hUYhsz6G3MIhQAgYZImUx1_8YwnCyzy89IV6OSTsXdHDT6fFf7rEL1qfRFJC9OPDHRlhl3cgNJyyE_mVlHWM=@1g4.org>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer

On Thu, Nov 05, 2026 at 10:29:51PM +0000, Paul Moses wrote:
> 
> 
> 
> 
> On Thursday, November 5th, 2026 at 1:19 AM, Ding Meng <meng.ding@siemens.com> wrote:
> 
> > Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> > added support for deferring RX timestamp conversion to
> > ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
> > uses the skb's NAPI ID to find the device that owns the timestamp
> > cookie and invoke its callback.
> > 
> > Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
> > gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
> > when busy polling is disabled, the skb may not carry a usable NAPI ID.
> > The device lookup then fails, so the driver callback is not invoked.
> > get_timestamp() falls back to hwtstamp, which does not contain the
> > converted timestamp, resulting in an incorrect RX hardware timestamp.
> > 
> > Record skb NAPI IDs independently of busy-poll support to support
> > drivers that use deferred timestamp conversion and future driver
> > features that need to look up a device by its NAPI ID.
> > 
> > Signed-off-by: Ding Meng <meng.ding@siemens.com>
> > Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> > ---
> > In the discussion of the issue reported at
> > https://lore.kernel.org/netdev/20260630112056.885071-1-meng.ding@siemens.com/
> > this previous patch added an igc-specific fallback for configurations
> > with CONFIG_NET_RX_BUSY_POLL disabled. It populated skb's hwtstamp
> > field with a timestamp converted using the default hardware timer,
> > allowing get_timestamp() to return it without invoking ndo_get_tstamp().
> > But Jakub Kicinski noted that the proposed fix appeared to be a
> > driver-specific workaround for a generic problem. The engleder driver
> > would also be affected by the same issue.
> > 
> > This patch introduces a new configuration option to enable NAPI ID
> > bookkeeping independently of busy polling. The option is enabled
> > whenever busy polling is enabled, preserving the existing behavior.
> > It is also selected by the igc and engleder drivers, ensuring that
> > skbs carry a NAPI ID even when busy polling is disabled.
> > 
> > Another approach considered was to require drivers using deferred
> > timestamp conversion, such as igc and engleder, to enable busy polling.
> > However, this would introduce an unnecessary dependency between two
> > independent features: hardware timestamp reporting should not require
> > busy polling to be enabled.
> > 
> > Timestamping has been tested only with igc; it has not been tested
> > with engleder.
> > 
> >  Documentation/networking/timestamping.rst | 11 ++++++++---
> >  drivers/net/ethernet/engleder/Kconfig     |  1 +
> >  drivers/net/ethernet/intel/Kconfig        |  1 +
> >  include/linux/skbuff.h                    |  4 ++--
> >  include/net/busy_poll.h                   |  2 +-
> >  include/trace/events/net.h                |  2 +-
> >  net/Kconfig                               |  4 ++++
> >  net/core/filter.c                         |  2 +-
> >  net/core/skbuff.c                         |  2 +-
> >  9 files changed, 20 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
> > index 2162c4f2b28a6..dbe40a1972639 100644
> > --- a/Documentation/networking/timestamping.rst
> > +++ b/Documentation/networking/timestamping.rst
> > @@ -278,9 +278,14 @@ SOF_TIMESTAMPING_OPT_PKTINFO:
> >    packets with hardware timestamps. The message contains struct
> >    scm_ts_pktinfo, which supplies the index of the real interface which
> >    received the packet and its length at layer 2. A valid (non-zero)
> > -  interface index will be returned only if CONFIG_NET_RX_BUSY_POLL is
> > -  enabled and the driver is using NAPI. The struct contains also two
> > -  other fields, but they are reserved and undefined.
> > +  interface index will be returned only if CONFIG_SKB_MARK_NAPI_ID is
> > +  enabled and the driver is using NAPI. This hidden configuration is
> > +  selected automatically by busy-poll support and by drivers that need
> > +  skb NAPI IDs to resolve deferred hardware timestamps. Drivers that
> > +  use deferred timestamp conversion must select it so the networking
> > +  stack can find the device and call its timestamp callback even when
> > +  busy polling is disabled. The struct contains also two other fields,
> > +  but they are reserved and undefined.
> > 
> >  SOF_TIMESTAMPING_OPT_TX_SWHW:
> >    Request both hardware and software timestamps for outgoing packets
> > diff --git a/drivers/net/ethernet/engleder/Kconfig b/drivers/net/ethernet/engleder/Kconfig
> > index 3df6bf476ae7e..9700a243bea11 100644
> > --- a/drivers/net/ethernet/engleder/Kconfig
> > +++ b/drivers/net/ethernet/engleder/Kconfig
> > @@ -22,6 +22,7 @@ config TSNEP
> >  	depends on PTP_1588_CLOCK_OPTIONAL
> >  	select PHYLIB
> >  	select PAGE_POOL
> > +	select SKB_MARK_NAPI_ID
> >  	help
> >  	  Support for the Engleder TSN endpoint Ethernet MAC IP Core.
> > 
> > diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> > index 780f113986ea8..7fb63f351fc20 100644
> > --- a/drivers/net/ethernet/intel/Kconfig
> > +++ b/drivers/net/ethernet/intel/Kconfig
> > @@ -376,6 +376,7 @@ config IGC
> >  	depends on PCI
> >  	depends on PTP_1588_CLOCK_OPTIONAL
> >  	depends on ETHTOOL_NETLINK
> > +	select SKB_MARK_NAPI_ID
> >  	help
> >  	  This driver supports Intel(R) Ethernet Controller I225-LM/I225-V
> >  	  family of adapters.
> > diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > index 6787fcf6ac3e4..164c862f7a403 100644
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1059,7 +1059,7 @@ struct sk_buff {
> >  			__u16	vlan_tci;
> >  		};
> >  	};
> > -#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)
> > +#if defined(CONFIG_SKB_MARK_NAPI_ID) || defined(CONFIG_XPS)
> >  	union {
> >  		unsigned int	napi_id;
> >  		unsigned int	sender_cpu;
> > @@ -1267,7 +1267,7 @@ static inline bool skb_pkt_type_ok(u32 ptype)
> >   */
> >  static inline unsigned int skb_napi_id(const struct sk_buff *skb)
> >  {
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  	return skb->napi_id;
> >  #else
> >  	return 0;
> > diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> > index 6e172d0f6ef5f..f7c0e62c6a7d7 100644
> > --- a/include/net/busy_poll.h
> > +++ b/include/net/busy_poll.h
> > @@ -130,7 +130,7 @@ static inline void sk_busy_loop(struct sock *sk, int nonblock)
> >  static inline void __skb_mark_napi_id(struct sk_buff *skb,
> >  				      const struct gro_node *gro)
> >  {
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  	/* If the skb was already marked with a valid NAPI ID, avoid overwriting
> >  	 * it.
> >  	 */
> > diff --git a/include/trace/events/net.h b/include/trace/events/net.h
> > index dbc2c5598e35a..99ed7645242eb 100644
> > --- a/include/trace/events/net.h
> > +++ b/include/trace/events/net.h
> > @@ -208,7 +208,7 @@ DECLARE_EVENT_CLASS(net_dev_rx_verbose_template,
> > 
> >  	TP_fast_assign(
> >  		__assign_str(name);
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  		__entry->napi_id = napi_id_valid(skb->napi_id) ?
> >  				   skb->napi_id : 0;
> >  #else
> > diff --git a/net/Kconfig b/net/Kconfig
> > index 76ab44aa439a6..8fa7586dc08ca 100644
> > --- a/net/Kconfig
> > +++ b/net/Kconfig
> > @@ -346,9 +346,13 @@ config CGROUP_NET_CLASSID
> >  	  Cgroup subsystem for use as general purpose socket classid marker that is
> >  	  being used in cls_cgroup and for netfilter matching.
> > 
> > +config SKB_MARK_NAPI_ID
> > +	bool
> > +
> >  config NET_RX_BUSY_POLL
> >  	bool
> >  	default y if !PREEMPT_RT || (PREEMPT_RT && !NETCONSOLE)
> > +	select SKB_MARK_NAPI_ID
> > 
> >  config BQL
> >  	bool
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index b7ac145b68b1f..e2218c18622b8 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -10274,7 +10274,7 @@ static u32 bpf_convert_ctx_access(enum bpf_access_type type,
> >  		break;
> > 
> >  	case offsetof(struct __sk_buff, napi_id):
> > -#if defined(CONFIG_NET_RX_BUSY_POLL)
> > +#if defined(CONFIG_SKB_MARK_NAPI_ID)
> >  		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->src_reg,
> >  				      bpf_target_off(struct sk_buff, napi_id, 4,
> >  						     target_size));
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index eb9fcc4b1fd1a..386a32cdc0cc8 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -1581,7 +1581,7 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
> >  #ifdef CONFIG_NETWORK_SECMARK
> >  	CHECK_SKB_FIELD(secmark);
> >  #endif
> > -#ifdef CONFIG_NET_RX_BUSY_POLL
> > +#ifdef CONFIG_SKB_MARK_NAPI_ID
> >  	CHECK_SKB_FIELD(napi_id);
> >  #endif
> >  #ifdef CONFIG_XPS
> > 
> > base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> > --
> > 2.47.3
> > 
> > 
> 
> Are you sure this does not make the preexisting timestamp lifetime
> issue more pathological? I think it needs to be fixed now as well.
> It was the last item mentioned by Sashiko in your review if I 
> remember correctly.
> 
> Paul

The hardware timestamp lifetime issue may indeed exist,
but it is independent of this patch. Even if that issus is fixed,
we still need to obtain the netdevice from the skb, so the decoupling
configuration introduced by this patch is still necessary.

Ding Meng
