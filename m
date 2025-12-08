Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D2D3B8D7C;
	Mon,  8 Dec 2025 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200293; cv=none; b=MkRqbJsIVoIErPyaRdbEgCoh4EOBEMyjOxWvQfeIVA5g8J7BQACKrntdZiywDaxYURXuIqkdNni+ixIjiYUOwEnzWqnO0+EhEzk6edS+fP5gIcyjXg2dDbP4z0l+rgTZgsnpWzsvMFmAmo1rxg58nIwloDnrhgsopniw3xFDLvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200293; c=relaxed/simple;
	bh=R5PuPMGoKEWezcbDkRUOspKp6PzmYWlKgyJBLxEepIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqcDBfecbHPZGuA6ZmSR1bZ+gzqyntLKtDGWs0eMD/X6VtjX4+uufzAIEk1//llXdhoBSgkVeCDoA2BcGqsw2RhKF4QUP3OUmJh6VWPr16pYy9shACvAm4vYEjfoFZOiCipySH2WxerEBb5537RPSqCHQg0Ef14AGfWEsxEdtiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 500A86028F356;
	Mon, 08 Dec 2025 14:24:38 +0100 (CET)
Message-ID: <fc2e5c27-b1ea-4034-bbf4-1b494ed765c1@molgen.mpg.de>
Date: Mon, 8 Dec 2025 14:24:36 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/2] Bluetooth: hci_conn: Add tracepoints for debugging
To: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, xu.xin16@zte.com.cn,
 yang.yang29@zte.com.cn, qiu.yutan@zte.com.cn, chen.junlin@zte.com.cn,
 jiang.kun2@zte.com.cn, linux-trace-kernel@vger.kernel.org
References: <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251208203245047U3UW5v2aGUumhmvjLl96E@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Cc: +linux-trace-kernel@vger.kernel.org]

Dear Yutan,


Thank you for your patch.

Am 08.12.25 um 13:32 schrieb wang.yaxin@zte.com.cn:
> From: Qiu Yutan <qiu.yutan@zte.com.cn>
> 
> Add tracepoints for tracking hci_conn_hold, hci_conn_drop, and hci_conn_del
> to facilitate debugging and viewing call stacks.

I’d add a blank line between paragraphs.

> The existing Bluetooth debugging method, BT_DBG, cannot trace call stacks.

It’d be great if you added an example output, how to use hte new trace 
points.

> Signed-off-by: Qiu Yutan <qiu.yutan@zte.com.cn>
> Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

Please start each name with a capital letter.

> Signed-off-by: Chen Junlin <chen.junlin@zte.com.cn>
> ---
>   include/net/bluetooth/hci_core.h |  3 ++
>   include/trace/events/bluetooth.h | 80 ++++++++++++++++++++++++++++++++
>   net/bluetooth/hci_conn.c         |  4 ++
>   3 files changed, 87 insertions(+)
>   create mode 100644 include/trace/events/bluetooth.h
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 2b261e74e2c4..5e01e6c501c1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -29,6 +29,7 @@
>   #include <linux/idr.h>
>   #include <linux/leds.h>
>   #include <linux/rculist.h>
> +#include <trace/events/bluetooth.h>
> 
>   #include <net/bluetooth/hci.h>
>   #include <net/bluetooth/hci_drv.h>
> @@ -1620,6 +1621,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
> 
>   static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
>   {
> +	trace_hci_conn_hold(conn);
>   	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
> 
>   	atomic_inc(&conn->refcnt);
> @@ -1630,6 +1632,7 @@ static inline struct hci_conn *hci_conn_hold(struct hci_conn *conn)
> 
>   static inline void hci_conn_drop(struct hci_conn *conn)
>   {
> +	trace_hci_conn_drop(conn);
>   	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
> 
>   	if (atomic_dec_and_test(&conn->refcnt)) {
> diff --git a/include/trace/events/bluetooth.h b/include/trace/events/bluetooth.h
> new file mode 100644
> index 000000000000..dd6446263e83
> --- /dev/null
> +++ b/include/trace/events/bluetooth.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM bluetooth
> +
> +#if !defined(_TRACE_BLUETOOTH_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_BLUETOOTH_H
> +
> +#include <linux/tracepoint.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +TRACE_EVENT(hci_conn_hold,
> +
> +	TP_PROTO(void *conn_ptr),
> +
> +	TP_ARGS(conn_ptr),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, conn_addr)
> +		__field(int, refcnt)
> +	),
> +
> +	TP_fast_assign(
> +		struct hci_conn *conn = (struct hci_conn *)conn_ptr;
> +
> +		__entry->conn_addr = conn;
> +		__entry->refcnt = atomic_read(&conn->refcnt);
> +	),
> +
> +	TP_printk("conn_addr=%p, orig refcnt=%d",
> +			__entry->conn_addr, __entry->refcnt)
> +)
> +
> +TRACE_EVENT(hci_conn_drop,
> +
> +	TP_PROTO(void *conn_ptr),
> +
> +	TP_ARGS(conn_ptr),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, conn_addr)
> +		__field(int, refcnt)
> +	),
> +
> +	TP_fast_assign(
> +		struct hci_conn *conn = (struct hci_conn *)conn_ptr;
> +
> +		__entry->conn_addr = conn;
> +		__entry->refcnt = atomic_read(&conn->refcnt);
> +	),
> +
> +	TP_printk("conn_addr=%p, orig refcnt=%d",
> +			__entry->conn_addr, __entry->refcnt)
> +)
> +
> +TRACE_EVENT(hci_conn_del,
> +
> +	TP_PROTO(void *conn_ptr),
> +
> +	TP_ARGS(conn_ptr),
> +
> +	TP_STRUCT__entry(
> +		__field(void *, conn_addr)
> +		 __field(int, refcnt)
> +	),
> +
> +	TP_fast_assign(
> +		struct hci_conn *conn = (struct hci_conn *)conn_ptr;
> +
> +		__entry->conn_addr = conn;
> +		__entry->refcnt = atomic_read(&conn->refcnt);
> +	),
> +
> +	TP_printk("conn_addr=%p, orig refcnt=%d",
> +			__entry->conn_addr, __entry->refcnt)
> +)

All definitions look the same besides the name. Any idea, how the 
duplication can be avoided?

> +
> +#endif /* _TRACE_BLUETOOTH_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 99efeed6a766..74a02cf7ba14 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -35,6 +35,9 @@
>   #include <net/bluetooth/iso.h>
>   #include <net/bluetooth/mgmt.h>
> 
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/bluetooth.h>
> +
>   #include "smp.h"
>   #include "eir.h"
> 
> @@ -1129,6 +1132,7 @@ static void hci_conn_unlink(struct hci_conn *conn)
> 
>   void hci_conn_del(struct hci_conn *conn)
>   {
> +	trace_hci_conn_del(conn);
>   	struct hci_dev *hdev = conn->hdev;
> 
>   	BT_DBG("%s hcon %p handle %d", hdev->name, conn, conn->handle);

Thank you for working on that. I’t great to see.


Kind regards,

Paul
